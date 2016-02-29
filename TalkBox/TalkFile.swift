import Foundation
import Regex
import SwiftFilePath

@objc protocol TalkFileDelegate {
    optional func didChangeProgress(percentage: Int)
}

class TalkFile {

    // MARK: - Properties
    weak var delegate: TalkFileDelegate?
    
    var path = NSURL()
    var progress = 0
    var size = 0
    let talk = Talk.create()
    var contents = String()

    // MARK: - Publics
    init(path: NSURL) {
        do {
            self.path = path
            self.contents = try NSString(contentsOfURL: path, encoding: NSUTF8StringEncoding) as String
            self.size = contents.lines.count
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
        var currentDate = ""

        for (i, line) in contents.lines.enumerate() {
            updateProgress(i)

            switch line {

            // Title
            case Regex("^\\[LINE\\] (.+?)トーク履歴"):
                if let title = Regex.lastMatch?.captures[0] {
                    talk.title = "\(title)トーク"
                }

            // Date
            case Regex("^(\\d{4}\\/\\d{2}\\/\\d{2})\\(.{1}\\)"):
                if let date = Regex.lastMatch?.captures[0] {
                    currentDate = date
                }

            // Multiline Message
            case Regex("^(\\d{2}:\\d{2})\\t(.+)\\t\"(.+)"):
                multiline(i, currentDate: currentDate)

            // Message
            case Regex("^(\\d{2}:\\d{2})\\t(.+)\\t(.+)"):
                let message = Message.create()
                if let user = Regex.lastMatch?.captures[1] {
                    message.user = user
                }
                if let text = Regex.lastMatch?.captures[2] {
                    message.text = text
                }
                if let time = Regex.lastMatch?.captures[0] {
                    message.createdAt(currentDate, time: time)
                }
                talk.add(message)

            // System Message
            case Regex("^(\\d{2}:\\d{2})\\t(.+)"):
                let message = Message.create()
                message.user = ""
                if let text = Regex.lastMatch?.captures[1] {
                    message.text = text
                }
                if let time = Regex.lastMatch?.captures[0] {
                    message.createdAt(currentDate, time: time)
                }
                talk.add(message)

            default:
                break
            }
        }

        talk.save()
        return talk
    }

    // MARK: - Privates
    private func updateProgress(current: Int) {
        let percent = Int(Float(current)/Float(size)*100)
        if percent != progress {
            progress = percent
            self.delegate?.didChangeProgress!(progress)
        }
    }

    private func multiline(var i: Int, currentDate: String) {
        let message = Message.create()

        // first
        if let line = Regex("^(\\d{2}:\\d{2})\\t(.+)\\t\"(.+)").match(contents.lines[i++]) {
            if let user = line.captures[1] {
                message.user = user
            }
            if let text = line.captures[2] {
                message.text = text
            }
            if let time = line.captures[0] {
                message.createdAt(currentDate, time: time)
            }
        }

        lines: while(true) {
            switch contents.lines[i++] {

            // last
            case Regex("^(.*)\""):
                if let text = Regex.lastMatch?.captures[0] {
                    message.text += text
                }
                break lines

            // continue
            case Regex("^(.*)"):
                if let text = Regex.lastMatch?.captures[0] {
                    message.text += "\(text)\n"
                }

            default:
                break
            }
        }

        talk.add(message)
    }
}