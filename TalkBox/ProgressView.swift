import UIKit
import Async

class ProgressView: UIView {
    @IBOutlet weak private var progress: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let view = NSBundle.mainBundle().loadNibNamed("Progress", owner: self, options: nil).first
        if let view = view as? ProgressView {
            view.frame = frame
            view.autoresizingMask = [.FlexibleHeight, .FlexibleWidth]
            addSubview(view)
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    convenience init() {
        self.init(frame: CGRectZero)
    }
    
    override func awakeFromNib() {
    }
    
    func updateProgress(percentage: Int) {
        Async.main {
            let progressView = self.subviews.first as! ProgressView
            progressView.progress.text = "\(percentage)%"
            self.setNeedsDisplay()
        }
    }
}
 