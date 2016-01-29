import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        if iCloud.available() {
            print("You have iCloud!")
        } else {
            print("iCloud is not available")
        }
        
        return true
    }
    
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
        if sourceApplication == "jp.naver.line" {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let destination = storyboard.instantiateViewControllerWithIdentifier("Import") as! ImportViewController
            destination.path = url
            self.window!.rootViewController!.presentViewController(destination, animated: true, completion: nil)
        } else {
            print("applications that do not support")
        }

        return true
    }

    func applicationWillResignActive(application: UIApplication) {
    }

    func applicationDidEnterBackground(application: UIApplication) {
    }

    func applicationWillEnterForeground(application: UIApplication) {
    }

    func applicationDidBecomeActive(application: UIApplication) {
    }

    func applicationWillTerminate(application: UIApplication) {
    }

}

