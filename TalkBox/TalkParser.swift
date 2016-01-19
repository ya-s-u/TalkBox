import Foundation
import Regex
import SwiftDate

class TalkParser {

    class func parse(url: NSURL) -> Talk {
        var talk = Talk(title: "", messages: [])
        
        do {
            let file = try NSString(contentsOfURL: url, encoding: NSUTF8StringEncoding) as String
            
            var currentDate = ""
            var multipleLine = false
            var multipleMessage = Message()
            
            var i = 0
            let size = file.lines.count
            var progress = 0
            
            for (_, line) in file.lines.enumerate() {
                // progress
                let current = Int(Float(i++)/Float(size)*100)
                if current != progress {
                    progress = current
                    print("\(progress)%")
                }
                
                // start multiple lines
                if let matches = Regex("^(\\d{2}:\\d{2})\\t(.+)\\t\"(.+)").match(line)?.captures {
                    multipleLine = true
                    multipleMessage.datetime = "\(currentDate) \(matches[0])".toDate(DateFormat.Custom("yyyy/MM/dd HH:mm"))!
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
                    let message = Message(datetime: datetime, user: matches[1], text: matches[2])
                    talk.messages.append(message)
                    continue
                }
                
                // system message
                if let matches = Regex("^(\\d{2}:\\d{2})\\t(.+)").match(line)?.captures {
                    let datetime = "\(currentDate) \(matches[0])".toDate(DateFormat.Custom("yyyy/MM/dd HH:mm"))!
                    let message = Message(datetime: datetime, user: "system", text: matches[1])
                    talk.messages.append(message)
                    continue
                }
            }
        } catch {
            print("file open error occured")
        }
        
        return talk
    }
}