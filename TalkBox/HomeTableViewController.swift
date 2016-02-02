import UIKit
import Async
import RealmSwift

class HomeTableViewController: UITableViewController, UINavigationControllerDelegate, NotificationDelegate {
    @IBOutlet weak var settingBtn: UIBarButtonItem!
    @IBOutlet weak var backupBtn: UIBarButtonItem!
    
    let realm = try! Realm()
    var talks: [Talk] = []
    
    override func viewDidLoad() {
        Notification.shared.delegate = self
        refreshHome()
        
        // backup button
        if !iCloud.available() { backupBtn.enabled = false }
    }
    
    func refreshHome() {
        let results = realm.objects(Talk).sorted("updated", ascending: false)
        talks = results.map { $0 }
        self.tableView.reloadData()
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
            let cell = sender as! TalkCellView
            let vc = segue.destinationViewController as! TalkTableViewController
            vc.talk = cell.talk
        default:
            break
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return talks.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Talk", forIndexPath: indexPath) as! TalkCellView
        cell.textLabel?.text = "\(talks[indexPath.row].title)"
        cell.talk = talks[indexPath.row]
        return cell
    }
    
    override func tableView(table: UITableView, didSelectRowAtIndexPath indexPath:NSIndexPath) {
        let cell = table.cellForRowAtIndexPath(indexPath)! as! TalkCellView
        performSegueWithIdentifier("showTalk", sender: cell)
    }

    
}