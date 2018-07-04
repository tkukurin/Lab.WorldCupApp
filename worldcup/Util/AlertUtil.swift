import Foundation
import UIKit

class AlertUtil {
    private init() {}
    
    static func serviceAlert(error: Error) -> UIAlertController {
        let alert = UIAlertController(
            title: "Error calling service",
            message: error.localizedDescription,
            preferredStyle: .alert)
        alert.addAction(UIAlertAction(
            title: "OK", style: UIAlertActionStyle.default,handler: nil))
        return alert
    }
}
