import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let talk = TalkParser.parse("group")
        print(talk.title)
    }

}

