import UIKit
import Async
import SwiftFilePath

class TalkTableViewController: UITableViewController, UINavigationControllerDelegate {
    
    var name: String? {
        didSet {
            self.title = name
        }
    }
    
    override func viewDidLoad() {
        
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (Path.documentsDir.contents?.count)!
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "Message")
        cell.textLabel?.text = "\(Path.documentsDir.contents![indexPath.row].basename)"
        return cell
    }
    
    override func tableView(table: UITableView, didSelectRowAtIndexPath indexPath:NSIndexPath) {
        print(indexPath.row)
    }
    
}