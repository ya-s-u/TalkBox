import UIKit
import Regex

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let filePath = NSBundle.mainBundle().pathForResource("log1", ofType: "txt") {
            do {
                let file = try NSString(contentsOfFile: filePath, encoding: NSUTF8StringEncoding) as String
                
                var idx = 1
                file.enumerateLines { (line, stop) -> () in
                    
                    if let title = Regex("\\[LINE\\] (.+)とのトーク履歴").match(line)?.captures[0] {
                        print("\(title)")
                    }
                    idx++
//                    print("\(idx++) : \(line)")
                }
            } catch {
                // error handling
            }
        }

    }

}

