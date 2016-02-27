import UIKit
import Async
import SwiftDate

class TalkViewController: UIViewController, UINavigationControllerDelegate, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {

    // MARK: - Outlets
    @IBOutlet weak private var tableView: UITableView!

    // MARK: - Properties
    private var slider = UISlider()

    var talk: Talk? {
        didSet {
            self.title = talk?.title
        }
    }

    // MARK: - View life cycle
    override func viewDidLoad() {
        setupTableView()
        setupSlider()
    }

    deinit {
        tableView.delegate = nil
    }
    
    override func viewWillAppear(animated: Bool) {
        let row = self.tableView.numberOfRowsInSection(0) - 1
        let indexPath = NSIndexPath(forRow: row, inSection: 0)
        self.tableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: .Bottom, animated: false)
    }

    // MARK: - Publics
    func scrollViewDidScroll(scrollView: UIScrollView) {
        slider.value = Float((scrollView.contentOffset.y+64) / (tableView.contentSize.height-tableView.frame.height+64))
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return talk?.messages.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MessageCell", forIndexPath: indexPath)
        if let cell = cell as? MessageCellView {
            cell.message = talk?.messages[indexPath.row]
            cell.isOwner = talk?.messages[indexPath.row].user == talk?.owner ? true : false
        }
        return cell
    }
    
    func tableView(table: UITableView, didSelectRowAtIndexPath indexPath:NSIndexPath) {
        print(indexPath.row)
    }

    // MARK: - Privates
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.registerNib(UINib(nibName: "MessageCell", bundle: nil), forCellReuseIdentifier: "MessageCell")
        tableView.estimatedRowHeight = 90
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.showsVerticalScrollIndicator = false
    }

    private func setupSlider() {
//        let _ = (self.navigationController?.navigationBar.frame.height)! + UIApplication.sharedApplication().statusBarFrame.height

        let width: CGFloat = self.view.frame.size.height-100
        let height: CGFloat = 30
        let x: CGFloat = (self.view.frame.size.width-width)/2
        let y: CGFloat = self.view.frame.size.height/2

        slider.frame = CGRectMake(x, y, width, height)
        slider.transform = CGAffineTransformMakeRotation(CGFloat(M_PI/2.0))
        slider.backgroundColor = UIColor.redColor()
        slider.minimumValue = 0.0
        slider.maximumValue = 1.0
        slider.value = slider.maximumValue
        slider.addTarget(self, action: "onChangeValueMySlider:", forControlEvents: UIControlEvents.ValueChanged)
        view.addSubview(slider)
    }

    private func onChangeValueMySlider(sender: UISlider){
        tableView.contentOffset.y = (tableView.contentSize.height-tableView.frame.height+64) * CGFloat(sender.value) - 64
    }
}