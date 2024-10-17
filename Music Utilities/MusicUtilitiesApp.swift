import SwiftUI

struct Constants {
    static let MAX_OCTAVE: Int = 8
    static let MIN_OCTAVE: Int = 0
    static let FREQ_DISTANCE: Float = pow(2, 1/12)
}

@main
struct MusicUtilitiesApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
