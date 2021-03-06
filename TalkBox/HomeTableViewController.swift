import UIKit
import Async

class HomeTableViewController: UITableViewController, UINavigationControllerDelegate, NotificationDelegate {

    // MARK: - Outlets
    @IBOutlet weak private var settingBtn: UIBarButtonItem!

    @IBOutlet weak private var backupBtn: UIBarButtonItem! {
        didSet {
            backupBtn.enabled = iCloud.available() ? true : false
        }
    }

    // MARK: - Properties
    private var talks: [Talk] = []

    // MARK: - View life cycle
    override func viewDidLoad() {
        Notification.shared.delegate = self
        refreshHome()
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        switch segue.destinationViewController {
        case let viewCtl as TalkViewController:
            if let cell = sender as?TalkCellView {
                viewCtl.talk = cell.talk
            }
        default:
            break
        }
    }

    // MARK: - Publics
    func refreshHome() {
        talks = Talk.findAll()
        tableView.reloadData()
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
}

extension HomeTableViewController {
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return talks.count ?? 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Talk", forIndexPath: indexPath)
        if let cell = cell as? TalkCellView {
            cell.textLabel?.text = "\(talks[indexPath.row].title)"
            cell.talk = talks[indexPath.row]
        }
        return cell
    }
    
    override func tableView(table: UITableView, didSelectRowAtIndexPath indexPath:NSIndexPath) {
        let cell = table.cellForRowAtIndexPath(indexPath)
        if let cell = cell as? TalkCellView {
            performSegueWithIdentifier("showTalk", sender: cell)
        }
    }
}