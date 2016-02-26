import RealmSwift

class Talk: Object {
    static let realm = try! Realm()

    dynamic var title = ""
    dynamic var owner = ""
    dynamic var count = 0
    let messages = List<Message>()
    dynamic var metas = "{}"
    dynamic var created = NSDate()
    dynamic var updated = NSDate()

    static func create() -> Talk {
        return Talk()
    }

    static func findAll() -> [Talk] {
        let talks = realm.objects(Talk).sorted("updated", ascending: false)
        return talks.map { $0 }
    }

    func save() {
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