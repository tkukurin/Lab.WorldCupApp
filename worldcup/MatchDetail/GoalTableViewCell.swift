import UIKit

class GoalTableViewCell: UITableViewCell {
    @IBOutlet weak var minuteLabel: UILabel!
    @IBOutlet weak var playerLabel: UILabel!
    var goal: Goal? {
        get { return self.goal }
        set {
            guard let result = newValue else {
                return
            }
            self.goal = result
            self.minuteLabel.text = String(result.minute)
            self.playerLabel.text = result.player
        }
    }
}
