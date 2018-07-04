import UIKit

struct ListViewModel {
    let matches: [Match]
    var count: Int { get {
        return matches.count
        }}
    
    init(matches: [Match]) {
        self.matches = matches
    }
    
    func match(atIndex: Int) -> Match {
        return self.matches[atIndex]
    }
}

class ListViewController: UIViewController {
    static let cellReuseIdentifier = "ListCell"
    
    @IBOutlet weak var tableView: UITableView!
    var viewModel: ListViewModel?
    
    //    convenience init(viewModel: ListViewModel) {
    //        self.init()
    //        self.viewModel = viewModel
    //    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(
            UINib(nibName: "MatchTableViewCell", bundle: nil),
            forCellReuseIdentifier: ListViewController.cellReuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        WorldCupService().getMatches(onSuccess: populate, onFailure: alert)
    }
    
    func populate(matches: [Match]) {
        self.viewModel = ListViewModel(matches: matches)
    }
    
    func alert(error: Error) {
        self.present(AlertUtil.serviceAlert(error: error), animated: true, completion: nil)
    }
}

extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Latest matches"
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let match = viewModel!.match(atIndex: indexPath.row)
        
        let matchDetailViewController = MatchDetailViewController(
            match: match)
        self.navigationController?.pushViewController(
            matchDetailViewController, animated: true)
    }
}

extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: ListViewController.cellReuseIdentifier,
            for: indexPath) as! MatchTableViewCell
        
        let match = viewModel?.match(atIndex: indexPath.row)
        cell.match = match
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.count ?? 0
    }
}
