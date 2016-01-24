import UIKit

class ProgressView: UIView {
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var progress: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let view = NSBundle.mainBundle().loadNibNamed("Progress", owner: self, options: nil).first as! ProgressView
        view.frame = frame
        view.autoresizingMask = [.FlexibleHeight, .FlexibleWidth]
        addSubview(view)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    convenience init() {
        self.init(frame: CGRectZero)
    }
    
    override func awakeFromNib() {
        indicator.activityIndicatorViewStyle = .WhiteLarge
        indicator.startAnimating()
    }
    
    func updateProgress(percentage: Int) {
        print(percentage)
        progress.text = "\(percentage)%"
    }
}
 