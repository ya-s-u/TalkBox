import UIKit
import Async

class ImportViewController : UIViewController, TalkParserDelegate {
    var path = NSURL()
    var parser: TalkParser!
    var progressView: ProgressView!
    
    override func viewDidLoad() {
        parser = TalkParser(path: self.path)
        print(parser.fileName())
        
        parser.delegate = self
        
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
            self.parser.parse()
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
            action in self.dismissViewControllerAnimated(true, completion: nil)
        }
        alertController.addAction(defaultAction)
        presentViewController(alertController, animated: true, completion: nil)
    }
}