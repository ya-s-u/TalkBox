import UIKit
import Async

class HomeTableViewController: UITableViewController, UINavigationControllerDelegate {
    
    override func viewDidLoad() {
        
        // backup button
        let rightBtn = UIBarButtonItem(title: "アップロード", style: .Plain, target: self, action: "backup:")
        self.navigationItem.rightBarButtonItem = rightBtn
    }
    
    func backup(sender: UIBarButtonItem) {
        iCloud.upload()
        self.navigationItem.rightBarButtonItem?.enabled = false
        self.navigationItem.rightBarButtonItem?.title = "・・・"
        
        Async.main(after: 3) {
            self.navigationItem.rightBarButtonItem?.enabled = true
            self.navigationItem.rightBarButtonItem?.title = "アップロード"
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "Talk")
        cell.textLabel?.text = "\(indexPath.row)"
        return cell
    }
    
    override func tableView(table: UITableView, didSelectRowAtIndexPath indexPath:NSIndexPath) {
        print(indexPath.row)
    }

    
}