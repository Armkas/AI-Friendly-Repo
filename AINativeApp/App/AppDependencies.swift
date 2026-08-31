import SwiftUI

/// THE single composition root. The only file allowed to name concrete
/// implementation types (ADR-003). Swap an implementation here (tests, debug
/// builds, on-device-only mode) and nothing else changes.
@MainActor
struct AppDependencies {

    let voiceSession: any VoiceSession
    let navigationService: any NavigationService
    /// A stream of the current route, fed to `MapScreenModel`. Wiring Voice →
    /// Navigation → Map lives here, NOT inside any feature (see AI/DOMAIN_MAP.md).
    let mapRoutes: AsyncStream<Route?>

    static func live() -> AppDependencies {
        // --- Core ---
        let http: HTTPClient = URLSessionHTTPClient(baseURL: AppConfig.apiBaseURL)
        let network: NetworkMonitor = PathNetworkMonitor()
        let location: LocationProvider = CoreLocationProvider()
        let store: KeyValueStore = UserDefaultsKeyValueStore()

        // --- Account ---
        let account: AccountService = DefaultAccountService(http: http, store: store)

        // --- Navigation ---
        let navigation: any NavigationService = DefaultNavigationService(
            http: http, location: location, network: network, store: store
        )

        // --- Voice: speech transport ladder (ADR-002) ---
        let recognizer: SpeechRecognizer = DegradingSpeechRecognizer(
            webSocket: WebSocketSpeechRecognizer(makeChannel: { URLSessionWebSocketChannel(url: AppConfig.speechSocketURL) }),
            restChunked: RESTChunkedSpeechRecognizer(http: http),
            onDevice: OnDeviceSpeechRecognizer(),
            network: network
        )
        let commandService: VoiceCommandService = LLMVoiceCommandService(http: http, account: account)

        let session = LiveVoiceSession(
            microphone: AVAudioEngineMicrophone(),
            recognizer: recognizer,
            commandService: commandService,
            context: { VoiceCommandContext(hasActiveTrip: false, currentCoordinate: nil) }
        )

        // --- Cross-feature wiring: confirmed VoiceCommand -> route -> Map ---
        let (routes, routesContinuation) = AsyncStream<Route?>.makeStream()
        Task {
            for await command in session.commands {
                guard let request = RouteRequest(command: command) else { continue }
                if let route = try? await navigation.route(for: request) {
                    routesContinuation.yield(route)
                }
            }
        }

        return AppDependencies(
            voiceSession: session,
            navigationService: navigation,
            mapRoutes: routes
        )
    }
}

// MARK: - SwiftUI Environment plumbing

private struct VoiceSessionKey: EnvironmentKey {
    static let defaultValue: any VoiceSession = PreviewVoiceSessionFallback()
}
private struct NavigationServiceKey: EnvironmentKey {
    static let defaultValue: any NavigationService = NoopNavigationService()
}
private struct MapRoutesKey: EnvironmentKey {
    static let defaultValue: AsyncStream<Route?> = AsyncStream { $0.finish() }
}

extension EnvironmentValues {
    var voiceSession: any VoiceSession {
        get { self[VoiceSessionKey.self] } set { self[VoiceSessionKey.self] = newValue }
    }
    var navigationService: any NavigationService {
        get { self[NavigationServiceKey.self] } set { self[NavigationServiceKey.self] = newValue }
    }
    var mapRoutes: AsyncStream<Route?> {
        get { self[MapRoutesKey.self] } set { self[MapRoutesKey.self] = newValue }
    }
}

/// Maps a confirmed `VoiceCommand` to a `RouteRequest`. This is the ONLY place
/// Voice's vocabulary is translated into Navigation's — kept in App so neither
/// feature imports the other's DTOs.
extension RouteRequest {
    init?(command: VoiceCommand) {
        switch command {
        case .navigate(let destination):
            let origin = Coordinate(latitude: 0, longitude: 0) // App supplies real origin from LocationProvider
            switch destination {
            case .coordinate(let c): self.init(origin: origin, destination: .coordinate(c))
            case .search(let s):     self.init(origin: origin, destination: .search(s))
            case .savedPlace:        return nil // already resolved to a coordinate before confirmation
            }
        case .reroute, .query, .cancelTrip, .setVolume:
            return nil
        }
    }
}
