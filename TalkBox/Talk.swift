import RealmSwift

class Talk: Object {

    dynamic var title = ""
    dynamic var owner = ""
    dynamic var count = 0
    let messages = List<Message>()
    dynamic var metas = "{}"
    dynamic var created = NSDate()
    dynamic var updated = NSDate()

//    var users: [String: Int] = [:]

    static func create() -> Talk {
        return Talk()
    }

    static func findAll() -> [Talk] {
        let realm = try! Realm()
        let talks = realm.objects(Talk).sorted("updated", ascending: false)
        return talks.map { $0 }
    }

    func add(message: Message) {
        messages.append(message)
        if message.user != "" {
            count++

//            if var user = users[message.user] {
//                user++
//            } else {
//                users[message.user] = 0
//            }
        }
    }

    func save() {
//        owner = users.first!.0

        let realm = try! Realm()
        try! realm.write {
            realm.add(self)
        }
    }

    func update(method: (() -> Void)) {
        let realm = try! Realm()
        try! realm.write {
            method()
        }
    }
}