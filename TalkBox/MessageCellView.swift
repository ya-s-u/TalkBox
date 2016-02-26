import UIKit

class MessageCellView: UITableViewCell {
    @IBOutlet private weak var body: UILabel!
    
    var message: Message? {
        didSet {
            body.text = message?.text
        }
    }
    
    var isOwner = false {
        didSet {
            if isOwner {
                backgroundColor = UIColor.blueColor()
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .None
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}