import UIKit

class MessageCellView: UITableViewCell {

    @IBOutlet weak private var ballonView: UIImageView!
    @IBOutlet weak private var body: UILabel!

    var message: Message? {
        didSet {
            body.text = message?.text
        }
    }
    
    var isOwner = false {
        didSet {
            if isOwner {
                ballonView.tintColor = UIColor.hex("FF877A", alpha: 1)
            } else {
                ballonView.tintColor = UIColor.whiteColor()
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .None
        backgroundColor = UIColor.clearColor()
        ballonView.image = UIImage(named: "img_balloon")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}