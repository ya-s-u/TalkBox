import UIKit
import Regex
import SwiftDate

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let filePath = NSBundle.mainBundle().pathForResource("log1", ofType: "txt") {
            do {
                let file = try NSString(contentsOfFile: filePath, encoding: NSUTF8StringEncoding) as String
                
                var idx = 1
                file.enumerateLines { (line, stop) -> () in
                    if idx == 1 {
                        if let title = Regex("^\\[LINE\\] (.+)とのトーク履歴").match(line)?.captures[0] {
                            print("title: \(title)")
                        }
                    }
                    
                    else if Regex("^\\d{4}\\/\\d{2}\\/\\d{2}(.{1})").matches(line) {
                        let date = (line as NSString).substringToIndex(10).toDate(DateFormat.Custom("yyyy/MM/dd"))
                        print(date!)
                    }
                    
                    idx++
                }
            } catch {
                // error handling
            }
        }

    }

}

