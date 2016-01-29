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
    
    class func path() -> String {
        return (NSFileManager.defaultManager().URLForUbiquityContainerIdentifier(nil)?.absoluteString)!
    }
    
    class func sync() {
        // iCloudを許可していないユーザーもいるので、.realmファイルは通常のDocumentsフォルダに入れておく
        // iCloudを許可しているユーザーのみ、適宜DocumentsフォルダをiCloudフォルダにコピーする
        // TODO: DocumentsフォルダをiCloud/Documentsフォルダにコピーする
    }
    
    class func test() {
        // must call
        let iCloudPath = NSFileManager.defaultManager().URLForUbiquityContainerIdentifier(nil)
        let iCloudDir = Path("\(((iCloudPath?.absoluteString)! as NSString).substringFromIndex(15).stringByReplacingOccurrencesOfString("%20", withString: " "))Documents")
        
        let realmFile = Path.documentsDir["default.realm"]
        realmFile.copyTo( iCloudDir["default.realm"] )
        
        for content:Path in Path.documentsDir {
            print("\(content)")
        }
    }
}