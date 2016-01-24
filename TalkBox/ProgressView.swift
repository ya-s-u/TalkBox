import UIKit

class ProgressView: UIView {
    @IBOutlet weak var progress: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: "Progress", bundle: bundle)
        let view = nib.instantiateWithOwner(self, options: nil).first as! UIView
        view.frame = frame
        addSubview(view)
        
        
//        let view = NSBundle.mainBundle().loadNibNamed("Progress", owner: self, options: nil).first as! ProgressView
//        view.frame = frame
//        view.autoresizingMask = [.FlexibleHeight, .FlexibleWidth]
//        addSubview(view)
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
//        let aaa = self.subviews.first as! ProgressView
//        aaa.progress.text = "\(percentage)%"
//        self.setNeedsDisplay()
//        self.subviews.first?.setNeedsDisplay()
//        aaa.setNeedsDisplay()
//        aaa.progress.setNeedsDisplay()
        
//        progress.text? = "100000"
//        progress.text = "\(percentage)%"
    }
}
 