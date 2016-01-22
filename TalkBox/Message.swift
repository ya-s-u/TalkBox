import RealmSwift

class Message: Object {
    dynamic var user = ""
    dynamic var text = ""
    dynamic var favorited = false
    dynamic var created = NSDate()
}