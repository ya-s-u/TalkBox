import UIKit
import Async
import SwiftFilePath

class HomeTableViewController: UITableViewController, UINavigationControllerDelegate {
    @IBOutlet weak var settingBtn: UIBarButtonItem!
    @IBOutlet weak var backupBtn: UIBarButtonItem!
    
    override func viewDidLoad() {
        
        // backup button
        if !iCloud.available() { backupBtn.enabled = false }
    }
    
    @IBAction func setting(sender: AnyObject) {
        performSegueWithIdentifier("showSetting", sender: self)
    }
    
    @IBAction func backup(sender: AnyObject) {
        iCloud.upload()
        backupBtn.enabled = false
        backupBtn.title = "・・・"
        
        Async.main(after: 3) {
            self.backupBtn.enabled = true
            self.backupBtn.title = "アップロード"
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        switch segue.identifier! {
        case "showTalk":
            let cell = sender as! UITableViewCell
            let vc = segue.destinationViewController as! TalkTableViewController
            vc.title = cell.textLabel?.text
        default:
            break
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (Path.documentsDir.contents?.count)!
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "Talk")
        cell.textLabel?.text = "\(Path.documentsDir.contents![indexPath.row].basename)"
        return cell
    }
    
    override func tableView(table: UITableView, didSelectRowAtIndexPath indexPath:NSIndexPath) {
        print(indexPath.row)
        let cell = table.cellForRowAtIndexPath(indexPath)! as UITableViewCell
        performSegueWithIdentifier("showTalk", sender: cell)
    }

    
}