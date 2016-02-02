import Foundation

@objc protocol NotificationDelegate {
    optional func refreshHome()
}

class Notification {
    static let shared = Notification()
    weak var delegate: NotificationDelegate!
    
    private init() {}
    
    private func refreshHome() {
        self.delegate.refreshHome!()
    }
}