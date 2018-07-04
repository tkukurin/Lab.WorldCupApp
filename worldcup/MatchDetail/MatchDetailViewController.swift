import UIKit

struct MatchDetailViewModel {
    let matchDescription: String
    let goals: [Goal]
    var count: Int { get {
        return goals.count
    }}
    
    init(match: Match) {
        self.goals = (match.homeResult.goals + match.awayResult.goals).sorted(
            by: {$0.minute > $1.minute})
        let result = match
        self.matchDescription = "\(result.homeResult.team) \(result.homeResult.nGoals) - \(result.awayResult.nGoals) \(result.awayResult.team)"
    }
    
    func goal(atIndex: Int) -> Goal {
        return goals[atIndex]
    }
}

class MatchDetailViewController: UIViewController {
    static let cellReuseIdentifier = "MatchCell"

    @IBOutlet weak var scorerTableView: UITableView!
    @IBOutlet weak var matchResultLabel: UILabel!

    var viewModel: MatchDetailViewModel!

    convenience init(match: Match) {
        self.init()
        self.viewModel = MatchDetailViewModel(match: match)
    }
    
    override func viewDidLoad() {
        self.matchResultLabel.text = viewModel.matchDescription
        
        scorerTableView.register(
            UINib(nibName: "MatchTableViewCell", bundle: nil),
            forCellReuseIdentifier: ListViewController.cellReuseIdentifier)
        scorerTableView.delegate = self
        scorerTableView.dataSource = self
        scorerTableView.separatorStyle = .none
    }
}

extension MatchDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Scorers"
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension MatchDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: MatchDetailViewController.cellReuseIdentifier,
            for: indexPath) as! GoalTableViewCell
        
        let goal = viewModel.goal(atIndex: indexPath.row)
        cell.goal = goal
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.count
    }
}

