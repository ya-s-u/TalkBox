import UIKit

class ImportViewController : UIViewController, TalkParserDelegate {
    var path = NSURL()
    var parser: TalkParser!
    var progress: ProgressView!
    
    override func viewDidLoad() {
        parser = TalkParser(path: self.path)
        print(parser.fileName())
        
        progress = ProgressView(frame: self.view.frame)
        progress.hidden = true
        self.view.addSubview(progress)
    }
    
    @IBAction func close(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func action(sender: AnyObject) {
        progress.hidden = false
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), {
            let _ = self.parser.parse()
            dispatch_async(dispatch_get_main_queue(), {
                print("finish")
            })
        })
        
//        let _ = parser.parse()
    }
    
    func didChangeProgress(percentage: Int) {
        progress.updateProgress(percentage)
        print(percentage);
        
//        if percentage >= 99 {
//            progress.hidden = true
//        }
    }
}