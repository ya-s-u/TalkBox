import UIKit
import Async
import SwiftDate

class TalkTableViewController: UITableViewController, UINavigationControllerDelegate {
    
    var talk: Talk? {
        didSet {
            self.title = talk?.title
        }
    }
    
    override func viewDidLoad() {
        self.tableView.registerNib(UINib(nibName: "MessageCell", bundle: nil), forCellReuseIdentifier: "MessageCell")
        self.tableView.estimatedRowHeight = 90
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.showsVerticalScrollIndicator = false
        
//        let progressView = ScrollIndicatorView(frame: self.view.frame)
//        self.view.addSubview(progressView)
        
        let slider = UISlider()
        slider.frame = CGRectMake(10, 10, 10, self.tableView.frame.size.height)
//        slider.transform = CGAffineTransformMakeRotation(CGFloat(M_PI/2.0))
        slider.minimumValue = 0.0
        slider.maximumValue = Float(self.tableView.frame.size.height)
        slider.value = Float(self.tableView.contentOffset.y)
        slider.backgroundColor = UIColor.redColor()
        
        self.navigationController?.view.addSubview(slider)
    }
    
    override func viewWillAppear(animated: Bool) {
        let row = self.tableView.numberOfRowsInSection(0) - 1
        let indexPath = NSIndexPath(forRow: row, inSection: 0)
        self.tableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: .Bottom, animated: false)
    }
    
}

extension TalkTableViewController {
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (talk?.messages.count)!
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MessageCell") as! MessageCellView
        cell.body.text = "\((talk?.messages[indexPath.row].text)!)"
        return cell
    }
    
    override func tableView(table: UITableView, didSelectRowAtIndexPath indexPath:NSIndexPath) {
        print(indexPath.row)
    }

}