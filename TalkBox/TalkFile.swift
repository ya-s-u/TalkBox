import Foundation
import Regex
import SwiftFilePath

@objc protocol TalkFileDelegate {
    optional func didChangeProgress(percentage: Int)
}

class TalkFile {
    weak var delegate: TalkFileDelegate?
    
    var path = NSURL()
    var contents = String()
    
    init(path: NSURL) {
        do {
            self.path = path
            self.contents = try NSString(contentsOfURL: path, encoding: NSUTF8StringEncoding) as String
        } catch {
            print("file open error occured")
        }
    }
    
    func name() -> String {
        let file = self.path.URLByDeletingPathExtension?.lastPathComponent
        if let matches = Regex("^\\[LINE\\] (.+)トーク(.*)").match(file!)?.captures {
            return "\(matches[0])トーク"
        }
        return ""
    }
    
    func parse() -> Talk {
        let talk = Talk.create()
        
        var users: [String: Int] = [:]
        
        var currentDate = ""
        var multipleLine = false
        var multipleMessage = Message.create()
        
        var i = 0
        let size = self.contents.lines.count
        var progress = 0
        
        for (_, line) in self.contents.lines.enumerate() {
            
            // progress
            let current = Int(Float(i++)/Float(size)*100)
            if current != progress {
                progress = current
                self.delegate?.didChangeProgress!(progress)
            }
            
            // start multiple lines
            if let matches = Regex("^(\\d{2}:\\d{2})\\t(.+)\\t\"(.+)").match(line)?.captures {
                multipleLine = true
                multipleMessage = Message.create()
                multipleMessage.user = matches[1]!
                multipleMessage.text = (matches[2]!+"\n")
                multipleMessage.createdAt(currentDate, time: matches[0]!)
                continue
            }
            
            // multiple lines
            if multipleLine {
                // finish
                if let matches = Regex("^(.*)\"").match(line)?.captures {
                    multipleLine = false
                    multipleMessage.text += matches[0]!
                    talk.messages.append(multipleMessage)
                    talk.count++
                    if users[multipleMessage.user] == nil {
                        users[multipleMessage.user] = 0
                    } else {
                        users[multipleMessage.user] = users[multipleMessage.user]! + 1
                    }
                    continue
                }
                
                // continue
                if let matches = Regex("^(.*)").match(line)?.captures {
                    multipleMessage.text += (matches[0]!+"\n")
                    continue
                }
            }
            
            // title
            if let matches = Regex("^\\[LINE\\] (.+?)トーク履歴").match(line)?.captures {
                talk.title = "\(matches[0]!)トーク"
                continue
            }
            
            // date
            if let matches = Regex("^(\\d{4}\\/\\d{2}\\/\\d{2})\\(.{1}\\)").match(line)?.captures {
                currentDate = matches[0]!
                continue
            }
            
            // message
            if let matches = Regex("^(\\d{2}:\\d{2})\\t(.+)\\t(.+)").match(line)?.captures {
                let message = Message.create()
                message.user = matches[1]!
                message.text = matches[2]!
                message.createdAt(currentDate, time: matches[0]!)
                talk.messages.append(message)
                talk.count++
                if users[message.user] == nil {
                    users[message.user] = 0
                } else {
                    users[message.user] = users[message.user]! + 1
                }
                continue
            }
            
            // system message
            if let matches = Regex("^(\\d{2}:\\d{2})\\t(.+)").match(line)?.captures {
                let message = Message.create()
                message.user = ""
                message.text = matches[1]!
                message.createdAt(currentDate, time: matches[0]!)
                talk.messages.append(message)
                continue
            }
        }
        
        // owner
        talk.owner = users.first!.0
        
        // metas
        // TODO:
        
        // write
        talk.save()
        
        return talk
    }
}