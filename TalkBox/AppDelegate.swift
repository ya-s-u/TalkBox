import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        if isIcloudAvailable() == false {
            print("iCloud is not available")
        } else {
            print("You have iCloud!")
        }
        
        return true
    }
    
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
        if sourceApplication == "jp.naver.line" {
            let talk = TalkParser.parse(url)
            print(talk.title)
        } else {
            print("applications that do not support")
        }
        
        return true
    }
    
    func isIcloudAvailable() -> Bool {
        if let _ = NSFileManager.defaultManager().ubiquityIdentityToken {
            return true
        } else {
            return false
        }
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

