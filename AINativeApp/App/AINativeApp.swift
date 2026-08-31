import SwiftUI

/// App entry point. Builds the dependency graph once and hands it to `RootView`.
/// No business logic here — see `AI/PROJECT_MAP.md` → "Entry points".
@main
struct AINativeApp: App {

    @State private var dependencies = AppDependencies.live()

    var body: some Scene {
        WindowGroup {
            RootView()
                .environment(\.voiceSession, dependencies.voiceSession)
                .environment(\.navigationService, dependencies.navigationService)
                .environment(\.mapRoutes, dependencies.mapRoutes)
        }
    }
}
