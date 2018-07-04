import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions:
        [UIApplicationLaunchOptionsKey : Any]? = nil)
        -> Bool {
            window = UIWindow.init(frame: UIScreen.main.bounds)
            let vc = ListViewController(
                nibName: "ListViewController", bundle: nil)
            let nvc = UINavigationController(rootViewController: vc)
            nvc.navigationBar.isTranslucent = false
            window!.rootViewController = nvc
            window!.makeKeyAndVisible()
            return true
    }
}

