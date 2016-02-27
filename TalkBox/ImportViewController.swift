import UIKit
import Async

class ImportViewController : UIViewController, TalkFileDelegate {

    // MARK: - Properties
    var path: NSURL? {
        didSet {
            guard let path = path else { return }
            file = TalkFile(path: path)
            file?.delegate = self
        }
    }

    private var file: TalkFile?
    private var progressView: ProgressView!

    // MARK: - View life cycle
    override func viewDidLoad() {
        setupProgressView()
    }

    // MARK: - Publics
    @IBAction func close(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func action(sender: AnyObject) {
        progressView.hidden = false
        
        Async.background {
            self.file?.parse()
        }.main {
            self.progressView?.hidden = true
            self.showCompleteAlert()
        }
    }
    
    func didChangeProgress(percentage: Int) {
        progressView.updateProgress(percentage)
    }

    // MARK: - Privates
    private func setupProgressView() {
        progressView = ProgressView(frame: view.frame)
        progressView.hidden = true
        view.addSubview(progressView)
    }

    private func showCompleteAlert() {
        let alert = UIAlertController.importCompleteAlert({
            self.dismissViewControllerAnimated(true, completion: nil)
            Notification.shared.refreshHome()
        })
        presentViewController(alert, animated: true, completion: nil)
    }
}