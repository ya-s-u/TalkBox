import UIKit
import Async

class ImportViewController : UIViewController, TalkFileDelegate {
    var path = NSURL()
    var file: TalkFile!
    var progressView: ProgressView!
    
    override func viewDidLoad() {
        file = TalkFile(path: self.path)
        file.delegate = self
        
        progressView = ProgressView(frame: self.view.frame)
        progressView.hidden = true
        self.view.addSubview(progressView)
    }
    
    @IBAction func close(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func action(sender: AnyObject) {
        progressView.hidden = false
        
        Async.background {
            self.file.parse()
        }.main {
            self.progressView.hidden = true
            self.showCompleteAlert()
        }
    }
    
    func didChangeProgress(percentage: Int) {
        self.progressView.updateProgress(percentage)
    }
    
    func showCompleteAlert() {
        let alertController = UIAlertController(title: "完了しました!", message: "トークのインポートが完了しました。", preferredStyle: .Alert)
        let defaultAction = UIAlertAction(title: "OK", style: .Default) {
            action in
                self.dismissViewControllerAnimated(true, completion: nil)
                Notification.shared.refreshHome()
        }
        alertController.addAction(defaultAction)
        presentViewController(alertController, animated: true, completion: nil)
    }
}