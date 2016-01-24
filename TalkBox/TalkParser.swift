import Foundation
import Regex
import SwiftDate
import RealmSwift

@objc protocol TalkParserDelegate {
    optional func didChangeProgress(percentage: Int)
}

class TalkParser {
    var path = NSURL()
    var contents = String()
    
    weak var delegate: TalkParserDelegate?
    
    init(path: NSURL) {
        do {
            self.path = path
            self.contents = try NSString(contentsOfURL: path, encoding: NSUTF8StringEncoding) as String
        } catch {
            print("file open error occured")
        }
    }
    
    func fileName() -> String {
        let file = self.path.URLByDeletingPathExtension?.lastPathComponent
        if let matches = Regex("^\\[LINE\\] (.+)トーク(.*)").match(file!)?.captures {
            return "\(matches[0])トーク"
        }
        return ""
    }
    
    func saveAsNew() {
        
    }
    
    func saveAsAdd() {
        
    }
    
    func parse() -> Talk {
        let talk = Talk()
        
        var currentDate = ""
        var multipleLine = false
        let multipleMessage = Message()
        
        var i = 0
        let size = self.contents.lines.count
        var progress = 0
        
        for (_, line) in self.contents.lines.enumerate() {
            // progress
            let current = Int(Float(i++)/Float(size)*100)
            if current != progress {
                progress = current
                self.delegate?.didChangeProgress!(progress)
                print("\(progress)%")
            }
            
            // start multiple lines
            if let matches = Regex("^(\\d{2}:\\d{2})\\t(.+)\\t\"(.+)").match(line)?.captures {
                multipleLine = true
                multipleMessage.created = "\(currentDate) \(matches[0])".toDate(DateFormat.Custom("yyyy/MM/dd HH:mm"))!
                multipleMessage.user = matches[1]
                multipleMessage.text = (matches[2]+"\n")
                continue
            }
            
            // multiple lines
            if multipleLine {
                // finish
                if let matches = Regex("^(.*)\"").match(line)?.captures {
                    multipleLine = false
                    multipleMessage.text += matches[0]
                    talk.messages.append(multipleMessage)
                    continue
                }
                
                // continue
                if let matches = Regex("^(.*)").match(line)?.captures {
                    multipleMessage.text += (matches[0]+"\n")
                    continue
                }
            }
            
            // title
            if let matches = Regex("^\\[LINE\\] (.+?)のトーク履歴").match(line)?.captures {
                talk.title = matches[0]
                continue
            }
            
            // date
            if let matches = Regex("^(\\d{4}\\/\\d{2}\\/\\d{2})\\(.{1}\\)").match(line)?.captures {
                currentDate = matches[0]
                continue
            }
            
            // message
            if let matches = Regex("^(\\d{2}:\\d{2})\\t(.+)\\t(.+)").match(line)?.captures {
                let datetime = "\(currentDate) \(matches[0])".toDate(DateFormat.Custom("yyyy/MM/dd HH:mm"))!
                let message = Message(value: ["user": matches[1], "text": matches[2], "created": datetime])
                talk.messages.append(message)
                continue
            }
            
            // system message
            if let matches = Regex("^(\\d{2}:\\d{2})\\t(.+)").match(line)?.captures {
                let datetime = "\(currentDate) \(matches[0])".toDate(DateFormat.Custom("yyyy/MM/dd HH:mm"))!
                let message = Message(value: ["user": "", "text": matches[1], "created": datetime])
                talk.messages.append(message)
                continue
            }
        }
        
        // write
//        let realm = try! Realm()
//        talk.count = talk.messages.count
//        try! realm.write {
//            realm.add(talk)
//        }
        
        return talk
    }
}