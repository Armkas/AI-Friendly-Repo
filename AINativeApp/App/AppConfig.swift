import Foundation

/// Build-time configuration. Real projects read these from an xcconfig / Info.plist
/// per scheme; hard-coded here for the template.
enum AppConfig {
    static let apiBaseURL = URL(string: "https://api.ainative.app")!
    static let speechSocketURL = URL(string: "wss://api.ainative.app/v1/speech/stream")!
}
