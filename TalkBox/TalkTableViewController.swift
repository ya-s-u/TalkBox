import UIKit
import Async

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
    }
    
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