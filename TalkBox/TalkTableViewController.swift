import UIKit
import Async
import SwiftDate

class TalkTableViewController: UITableViewController, UINavigationControllerDelegate {
    var messages: [String: [Message]] = [:]
    
    var talk: Talk? {
        didSet {
            self.title = talk?.title
            
            for message in (talk?.messages)! {
                let date = message.created.toString(DateFormat.Custom("YYYY年MM月dd日"))
                if messages[date!] == nil {
                    messages[date!] = [message]
                } else {
                    messages[date!]?.append(message)
                }
            }
        }
    }
    
    override func viewDidLoad() {
        self.tableView.registerNib(UINib(nibName: "MessageCell", bundle: nil), forCellReuseIdentifier: "MessageCell")
        
        self.tableView.estimatedRowHeight = 90
        self.tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return messages.count
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return Array(messages.keys)[section]
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages[Array(messages.keys)[section]]!.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MessageCell") as! MessageCellView
        cell.body.text = "\(messages[Array(messages.keys)[indexPath.section]]![indexPath.row].text)"
//        cell.body.text = "\((talk?.messages[indexPath.row].text)!)"
        return cell
    }
    
    override func tableView(table: UITableView, didSelectRowAtIndexPath indexPath:NSIndexPath) {
        print(indexPath.row)
    }
    
}