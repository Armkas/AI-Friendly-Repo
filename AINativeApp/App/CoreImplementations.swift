import Foundation

// Concrete Core/Account implementations wired by AppDependencies. In a full
// project these would live in Core/*/Infrastructure and Features/Account/
// Infrastructure; kept together here so the template's dependency graph resolves.
// The simple ones are real; the hardware/network ones are honest stubs marked TODO.

// MARK: - HTTP

struct URLSessionHTTPClient: HTTPClient {
    let baseURL: URL
    private let session = URLSession(configuration: .ephemeral)

    func send<Response: Decodable>(_ request: HTTPRequest, as type: Response.Type) async throws -> Response {
        let data = try await sendRaw(request)
        do { return try JSONDecoder().decode(Response.self, from: data) }
        catch { throw HTTPError.decoding }
    }

    func sendRaw(_ request: HTTPRequest) async throws -> Data {
        var urlRequest = URLRequest(url: baseURL.appendingPathComponent(request.path))
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.httpBody = request.body
        request.headers.forEach { urlRequest.setValue($1, forHTTPHeaderField: $0) }
        do {
            let (data, response) = try await session.data(for: urlRequest)
            guard let http = response as? HTTPURLResponse else { throw HTTPError.transport }
            guard (200..<300).contains(http.statusCode) else {
                throw HTTPError.status(code: http.statusCode, data: data)
            }
            return data
        } catch let error as HTTPError {
            throw error
        } catch {
            throw HTTPError.transport   // never leak URLError (Contract)
        }
    }
}

// MARK: - Storage

struct UserDefaultsKeyValueStore: KeyValueStore {
    private let defaults = UserDefaults.standard
    func string(forKey key: String) -> String? { defaults.string(forKey: key) }
    func data(forKey key: String) -> Data? { defaults.data(forKey: key) }
    func set(_ value: String?, forKey key: String) { defaults.set(value, forKey: key) }
    func set(_ value: Data?, forKey key: String) { defaults.set(value, forKey: key) }
}

// MARK: - Stubs (TODO: implement against Network.framework / CoreLocation / AVFoundation / Keychain)

struct PathNetworkMonitor: NetworkMonitor {
    var status: NetworkStatus { get async { .satisfied(lowLatency: true) } }
    var statuses: AsyncStream<NetworkStatus> { AsyncStream { $0.yield(.satisfied(lowLatency: true)) } }
}

struct CoreLocationProvider: LocationProvider {
    var current: LocationFix? { get async { nil } }
    var fixes: AsyncStream<LocationFix> { AsyncStream { $0.finish() } }
    var authorization: LocationAuthorization { get async { .notDetermined } }
    func requestWhenInUseAuthorization() async {}
}

struct DefaultAccountService: AccountService {
    let http: HTTPClient
    let store: KeyValueStore
    var currentUser: User? { get async { nil } }
    func savedPlace(named name: String) async throws -> SavedPlace { throw AccountError.notFound }
    func isEntitled(to entitlement: Entitlement) async -> Bool { false }   // A1: fail closed
}

final class URLSessionWebSocketChannel: WebSocketChannel {
    private let url: URL
    init(url: URL) { self.url = url }
    func connect() async throws { throw WebSocketError.handshakeFailed }
    func send(_ frame: WebSocketFrame) async throws { throw WebSocketError.closed }
    var messages: AsyncStream<WebSocketFrame> { AsyncStream { $0.finish() } }
    func close() async {}
}

final class AVAudioEngineMicrophone: MicrophoneCapturing {
    func start() -> AsyncStream<AudioBuffer> { AsyncStream { $0.finish() } }
    func stop() {}
}

final class NoopNavigationService: NavigationService {
    func route(for request: RouteRequest) async throws -> Route { throw NavigationError.noRouteFound }
    func startNavigation(_ route: Route) -> AsyncStream<NavProgress> { AsyncStream { $0.finish() } }
    func stop() async {}
}

@MainActor
final class PreviewVoiceSessionFallback: VoiceSession {
    let state: VoiceSessionState = .idle
    let states: AsyncStream<VoiceSessionState> = AsyncStream { $0.yield(.idle) }
    let commands: AsyncStream<VoiceCommand> = AsyncStream { $0.finish() }
    func start() {}
    func stop() {}
    func confirm(_ command: VoiceCommand) {}
    func reject() {}
}
