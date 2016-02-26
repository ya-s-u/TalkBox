import UIKit
import Async

class HomeTableViewController: UITableViewController, UINavigationControllerDelegate, NotificationDelegate {
    @IBOutlet weak private var settingBtn: UIBarButtonItem!
    @IBOutlet weak private var backupBtn: UIBarButtonItem!

    private var talks: [Talk] = []
    
    override func viewDidLoad() {
        Notification.shared.delegate = self
        refreshHome()

        if !iCloud.available() { backupBtn.enabled = false }
    }

    func refreshHome() {
        talks = Talk.findAll()
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
            let vc = segue.destinationViewController as! TalkViewController
            vc.talk = cell.talk
        default:
            break
        }
    }
    
}

extension HomeTableViewController {
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return talks.count ?? 0
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