import UIKit

class GoalTableViewCell: UITableViewCell {
    @IBOutlet weak var minuteLabel: UILabel!
    @IBOutlet weak var playerLabel: UILabel!
    var goal: Goal? {
        didSet {
            self.minuteLabel.text = String(self.goal!.minute)
            self.playerLabel.text = self.goal!.player
        }
    }
}
