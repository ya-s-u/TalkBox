import RealmSwift

class Talk: Object {
    dynamic var title = ""
    dynamic var owner = ""
    dynamic var count = 0
    let messages = List<Message>()
    dynamic var metas = "{}"
    dynamic var created = NSDate()
    dynamic var updated = NSDate()
}