import Foundation

func CFArrayAsArrayOfStrings (array: CFArray) -> [String] {
  var swiftArray: [String] = []
  
  if CFArrayGetCount(array) > 0 {
    for i in 0...(CFArrayGetCount(array) - 1) {
      let str = unsafeBitCast(CFArrayGetValueAtIndex(array, i), CFStringRef.self) as String
      swiftArray.append(str)
    }
  }

  return swiftArray
}

struct UrlManager {
  var handlers: [String] = []
  let scheme: String
  
  func setHandler (handler : String) -> OSStatus {
    return LSSetDefaultHandlerForURLScheme(scheme, handler)
  }
  
  func isValidHandler (handler: String) -> Bool {
    return handlers.contains(handler)
  }
  
  var currentHandler: String? {
    get {
      return LSCopyDefaultHandlerForURLScheme(scheme)?.takeRetainedValue() as String?
    }
  }
  
  init(scheme : String) {
    let availableHandlers = LSCopyAllHandlersForURLScheme(scheme)?.takeRetainedValue()
    self.handlers = CFArrayAsArrayOfStrings(availableHandlers!)
    self.scheme = scheme
  }
}