import UIKit
import Eureka

class SettingViewController: FormViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        form +++ Section("Custom cells")
            
            <<< TextRow("TextFiled"){
                $0.title = "テキスト入力"
                $0.placeholder = "ここに書いてね"
            }
    }
    
    @IBAction func close(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}