import UIKit

class ImportViewController : UIViewController, TalkParserDelegate {
    var path = NSURL()
    var parser: TalkParser!
    var progressViewController: ProgressViewController!
    
    override func viewDidLoad() {
        parser = TalkParser(path: self.path)
        print(parser.fileName())
        
        parser.delegate = self
        
        progressViewController = storyboard?.instantiateViewControllerWithIdentifier("Progress") as! ProgressViewController
        self.addChildViewController(progressViewController)
        progressViewController.view.frame = self.view.frame
        view.addSubview(progressViewController.view)
        progressViewController.view.hidden = true
    }
    
    @IBAction func close(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func action(sender: AnyObject) {
        progressViewController.view.hidden = false
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), {
            let _ = self.parser.parse()
            dispatch_async(dispatch_get_main_queue(), {
                self.progressViewController.view.hidden = true
            })
        })
    }
    
    func didChangeProgress(percentage: Int) {
        dispatch_async(dispatch_get_main_queue(), {
            self.progressViewController.progress.text = "\(percentage)%"
            self.view.setNeedsDisplay()
        })
    }
}