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