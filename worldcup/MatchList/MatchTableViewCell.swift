import UIKit

class MatchTableViewCell: UITableViewCell {

    @IBOutlet weak var resultLabel: UILabel!
    var match: Match? {
        get { return self.match }
        set {
            guard let result = newValue else {
                return
            }
            self.match = result
            let text = "\(result.homeResult.team) \(result.homeResult.nGoals) - \(result.awayResult.nGoals) \(result.awayResult.team)"
            self.resultLabel.text = text
        }
    }
}
