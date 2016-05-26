import Foundation

struct console {
  static let stderr = NSFileHandle.fileHandleWithStandardError()
  static let stdout = NSFileHandle.fileHandleWithStandardOutput()
  
  private static func write (str: String, to handler: NSFileHandle) {
    let strWithNewline = str.characters.last != "\n" ? str + "\n" : str
    
    if let data = strWithNewline.dataUsingEncoding(NSUTF8StringEncoding) {
      handler.writeData(data)
    }
  }
  
  static func log (str: String) {
    write(str, to: stdout)
  }

  static func error (str: String) {
    write(str, to: stderr)
  }
}