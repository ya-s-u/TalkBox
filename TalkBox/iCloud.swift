import Foundation
import SwiftFilePath

class iCloud {
    
    class func available() -> Bool {
        if let _ = NSFileManager.defaultManager().ubiquityIdentityToken {
            self.test()
            return true
        }
        return false
    }
    
    class func test() {
        // must call
        let iCloudPath = NSFileManager.defaultManager().URLForUbiquityContainerIdentifier(nil)
        let iCloudDir = Path("\(((iCloudPath?.absoluteString)! as NSString).substringFromIndex(15).stringByReplacingOccurrencesOfString("%20", withString: " "))Documents")
        
        let realmFile = Path.documentsDir["default.realm"]
        realmFile.copyTo( iCloudDir["default.realm"] )
        
        for content:Path in iCloudDir {
            print("\(content)")
        }
    }
}