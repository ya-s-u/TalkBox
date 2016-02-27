import UIKit

extension UIAlertController {
    class func importCompleteAlert(callback: (Void->Void)) -> UIAlertController {
        let alertCtl = UIAlertController(
            title: "完了しました!",
            message: "トークのインポートが完了しました。",
            preferredStyle: .Alert
        )
        alertCtl.addAction(
            UIAlertAction(
                title: "OK",
                style: .Default,
                handler: { (alertView) -> Void in
                    callback()
            })
        )
        return alertCtl
    }
}