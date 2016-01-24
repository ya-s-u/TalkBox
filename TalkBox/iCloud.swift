import Foundation

class iCloud {
    class func available() -> Bool {
        if let _ = NSFileManager.defaultManager().ubiquityIdentityToken {
            return true
        }
        return false
    }
}