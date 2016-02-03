import UIKit

@objc protocol ScrollIndicatorViewDelegate {
    func touchUpInside()
}

class ScrollIndicatorView: UILabel {
    weak var delegate: ScrollIndicatorViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.frame.size.width = 80
        self.frame.size.height = 80
        self.text = "Drag!"
        self.textAlignment = NSTextAlignment.Center
        self.backgroundColor = UIColor.redColor()
        self.layer.masksToBounds = true
        self.frame.origin.x = 100
        self.frame.origin.y = 100
        self.layer.cornerRadius = 40.0
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    convenience init() {
        self.init(frame: CGRectZero)
    }
    
    override func awakeFromNib() {
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        // Labelアニメーション.
        UIView.animateWithDuration(0.06,
            // アニメーション中の処理.
            animations: { () -> Void in
                // 縮小用アフィン行列を作成する.
                self.transform = CGAffineTransformMakeScale(0.9, 0.9)
            })
            { (Bool) -> Void in
        }
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        // タッチイベントを取得.
        let aTouch = touches.first! as UITouch
        
        // 移動した先の座標を取得.
        let location = aTouch.locationInView(self)
        
        // 移動する前の座標を取得.
        let prevLocation = aTouch.previousLocationInView(self)
        
        // CGRect生成.
        var myFrame: CGRect = self.frame
        
        // ドラッグで移動したx, y距離をとる.
        let deltaX: CGFloat = location.x - prevLocation.x
        let deltaY: CGFloat = location.y - prevLocation.y
        
        // 移動した分の距離をmyFrameの座標にプラスする.
        myFrame.origin.x += deltaX
        myFrame.origin.y += deltaY
        
        // frameにmyFrameを追加.
        self.frame = myFrame
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        // Labelアニメーション.
        UIView.animateWithDuration(0.1,
            
            // アニメーション中の処理.
            animations: { () -> Void in
                // 拡大用アフィン行列を作成する.
                self.transform = CGAffineTransformMakeScale(0.4, 0.4)
                // 縮小用アフィン行列を作成する.
                self.transform = CGAffineTransformMakeScale(1.0, 1.0)
            })
            { (Bool) -> Void in
                
        }
    }
    
    override func touchesCancelled(touches: Set<UITouch>!, withEvent event: UIEvent?) {
        // stuff
    }
    
    func touchUpInside() {
        self.delegate?.touchUpInside()
    }
    
}