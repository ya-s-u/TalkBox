import RealmSwift

class Talk: Object {
    static let realm = try! Realm()

    dynamic var id = ""
    dynamic var title = ""
    dynamic var owner = ""
    dynamic var count = 0
    let messages = List<Message>()
    dynamic var metas = "{}"
    dynamic var created = NSDate()
    dynamic var updated = NSDate()

    override static func primaryKey() -> String? {
        return "id"
    }

    static func find(id: String) -> Talk {
        let predicate = NSPredicate(format: "id = %@", id)
        return realm.objects(Talk).filter(predicate).first!
    }

    static func create() -> Talk {
        let talk = Talk()
        talk.id = NSUUID().UUIDString
        return talk
    }

    static func findAll() -> [Talk] {
        let talks = realm.objects(Talk).sorted("updated", ascending: false)
        return talks.map { $0 }
    }

    func save() {
//        try! Talk.realm.write {
//            Talk.realm.add(self)
//        }
//        let realm = try! Realm()
        if let realm = realm {
            try! realm.write {
                realm.add(self)
            }
        }
    }

    func update(method: (() -> Void)) {
        try! Talk.realm.write {
            method()
        }
    }
}