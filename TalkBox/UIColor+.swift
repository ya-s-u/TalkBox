import UIKit

extension UIColor {
    
    class func rgb(r r: Int, g: Int, b: Int, alpha: CGFloat) -> UIColor {
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: alpha)
    }
    
    class func hex (var hexStr : String, let alpha : CGFloat) -> UIColor {
        hexStr = hexStr.stringByReplacingOccurrencesOfString("#", withString: "")
        
        if hexStr.characters.count == 3 {
            var newHexStr = ""
            for c in hexStr.characters {
                newHexStr += "\(c)\(c)"
            }
            hexStr = newHexStr
        }
        
        let scanner = NSScanner(string: hexStr as String)
        var color: UInt32 = 0
        if scanner.scanHexInt(&color) {
            let r = CGFloat((color & 0xFF0000) >> 16) / 255.0
            let g = CGFloat((color & 0x00FF00) >> 8) / 255.0
            let b = CGFloat(color & 0x0000FF) / 255.0
            return UIColor(red:r,green:g,blue:b,alpha:alpha)
        } else {
            return UIColor.whiteColor()
        }
    }
}