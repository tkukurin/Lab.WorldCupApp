import UIKit

class MatchTableViewCell: UITableViewCell {

    @IBOutlet weak var resultLabel: UILabel!
    var match: Match? {
        didSet {
            let result = self.match!
            let text = "\(result.homeResult.team) \(result.homeResult.nGoals) - \(result.awayResult.nGoals) \(result.awayResult.team)"
            self.resultLabel.text = text
        }
    }
}
