import Foundation
import SwiftFilePath

class iCloud {
    
    class func available() -> Bool {
        if let _ = NSFileManager.defaultManager().ubiquityIdentityToken {
            return true
        }
        return false
    }
    
    class func path() -> String {
        return (NSFileManager.defaultManager().URLForUbiquityContainerIdentifier(nil)?.path)!
    }
    
    class func dir() -> Path {
        return Path("\((self.path() as NSString).stringByReplacingOccurrencesOfString("/private/", withString: "/").stringByReplacingOccurrencesOfString("%20", withString: " "))/Documents")
    }
    
    class func upload() {
        let file = "default.realm"
        let result = Path.documentsDir[file].copyTo(self.dir()[file])
//        if result.isFailure { print(result.error) }
        self.removeInbox()
    }
    
    class func download() {
        let file = "default.realm"
        let result = self.dir()[file].copyTo(Path.documentsDir[file])
//        if result.isFailure { print(result.error) }
    }
    
    private class func removeInbox() {
        let result = Path.documentsDir["Inbox"].remove()
//        if result.isFailure { print(result.error) }
    }
}