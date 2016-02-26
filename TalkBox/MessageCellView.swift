import UIKit

class MessageCellView: UITableViewCell {
    @IBOutlet private weak var body: UILabel!
    
    var message: Message? {
        didSet {
            body.text = message?.text
        }
    }
    
    var is_owner = false {
        didSet {
            if is_owner {
                backgroundColor = UIColor.blueColor()
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .None
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}