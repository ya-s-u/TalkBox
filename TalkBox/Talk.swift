import RealmSwift

class Talk: Object {
    dynamic var title = ""
    let messages = List<Message>()
    dynamic var count = 0
    dynamic var owner = ""
    dynamic var metas = "{}"
    dynamic var created = NSDate()
    dynamic var updated = NSDate()
}