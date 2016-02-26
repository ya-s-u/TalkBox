import RealmSwift
import SwiftDate

class Message: Object {
    static let realm = try! Realm()

    dynamic var user = ""
    dynamic var text = ""
    dynamic var favorited = false
    dynamic var created = NSDate()

    static func create() -> Message {
        return Message()
    }

    func createdAt(date: String, time: String) {
        created = "\(date) \(time)".toDate(DateFormat.Custom("yyyy/MM/dd HH:mm"))!
    }
}
