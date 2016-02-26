import UIKit
import Eureka

class SettingViewController: FormViewController {

    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        form +++ Section("Custom cells")
            
            <<< TextRow("TextFiled"){
                $0.title = "テキスト入力"
                $0.placeholder = "ここに書いてね"
            }
    }

    // MARK: - Publics
    @IBAction func close(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}