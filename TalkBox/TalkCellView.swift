import UIKit

class TalkCellView: UITableViewCell {
    
    var talk: Talk? {
        didSet {
//            print(talk)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}