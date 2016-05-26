import Foundation

enum Command {
  case Browser(String)
  case QueryAvailable(String)
  case QueryCurrent
  case Toggle
  
  init (_ input: String?) {
    self = .Toggle

    if let input = input {
      if (UrlManager(scheme: "https").isValidHandler(input)) {
        self = .Browser(input)
      } else if ["http", "https"].contains(input) {
        self = .QueryAvailable(input)
      } else if input == "current" {
        self = .QueryCurrent
      }
    }
  }
}

let handlers = [
  UrlManager(scheme: "http"),
  UrlManager(scheme: "https")
]

func setDefaultBrowser (browser: String) {
  for handler in handlers {
    let status = handler.setHandler(browser)
    if status > 0 {
      console.error("Could not set \(handler.scheme) handler to \(browser) (\(status.description))")
      exit(1)
    }
  }
}

switch Command(Process.arguments.last) {
case .Browser(let browser):
  console.log("Setting handler to \(browser)")
  setDefaultBrowser(browser)
  
case .QueryAvailable:
  console.log("Available browsers are:")
  handlers[0].handlers.forEach { console.log("-- \($0)") }

case .QueryCurrent:
  console.log("Current http protocol handler is \(handlers[0].currentHandler!)")

case .Toggle:
  let browser = handlers[0].currentHandler!.lowercaseString == "com.google.Chrome".lowercaseString
    ? "com.apple.safaritechnologypreview"
    : "com.google.Chrome"
  
  console.log("Setting default browser to \(browser)")
  setDefaultBrowser(browser)
}
