import SwiftUI

/// Root screen: the map with the voice overlay on top. Composition only.
struct RootView: View {
    @Environment(\.voiceSession) private var voiceSession
    @Environment(\.mapRoutes) private var mapRoutes

    var body: some View {
        ZStack {
            MapScreen(model: MapScreenModel(routes: mapRoutes))
                .ignoresSafeArea()
            VoiceOverlayView(model: VoiceOverlayModel(session: voiceSession))
        }
    }
}
