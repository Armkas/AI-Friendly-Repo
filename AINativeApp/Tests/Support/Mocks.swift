import Foundation
@testable import AINativeApp

// Shared fakes for unit tests. Named `Mock*` per AI/CONVENTIONS.md. No network,
// no hardware — everything is deterministic and caller-controlled.

/// Emits a scripted list of transcripts, then optionally keeps the stream open
/// (to model a live transport) or finishes it (to model a dropped connection).
final class MockSpeechRecognizer: SpeechRecognizer, @unchecked Sendable {
    let scripted: [Transcript]
    let finishesAfterScript: Bool
    private(set) var transcribeCallCount = 0

    init(scripted: [Transcript], finishesAfterScript: Bool) {
        self.scripted = scripted
        self.finishesAfterScript = finishesAfterScript
    }

    func transcribe(_ audio: AsyncStream<AudioBuffer>) -> AsyncStream<Transcript> {
        transcribeCallCount += 1
        return AsyncStream { continuation in
            for t in scripted { continuation.yield(t) }
            if finishesAfterScript { continuation.finish() }
        }
    }
}

final class MockNetworkMonitor: NetworkMonitor, @unchecked Sendable {
    var _status: NetworkStatus
    init(_ status: NetworkStatus) { self._status = status }
    var status: NetworkStatus { get async { _status } }
    var statuses: AsyncStream<NetworkStatus> { AsyncStream { $0.yield(self._status) } }
}

final class MockVoiceCommandService: VoiceCommandService, @unchecked Sendable {
    enum Outcome { case command(VoiceCommand), throwsError(VoiceError) }
    var outcome: Outcome
    private(set) var received: [Transcript] = []
    init(_ outcome: Outcome) { self.outcome = outcome }

    func command(from transcript: Transcript, context: VoiceCommandContext) async throws -> VoiceCommand {
        received.append(transcript)
        switch outcome {
        case .command(let c): return c
        case .throwsError(let e): throw e
        }
    }
}

final class MockAccountService: AccountService, @unchecked Sendable {
    var places: [String: SavedPlace]
    var entitled: Bool
    init(places: [String: SavedPlace] = [:], entitled: Bool = false) {
        self.places = places; self.entitled = entitled
    }
    var currentUser: User? { get async { nil } }
    func savedPlace(named name: String) async throws -> SavedPlace {
        guard let p = places[name.lowercased()] else { throw AccountError.notFound }
        return p
    }
    func isEntitled(to entitlement: Entitlement) async -> Bool { entitled }
}

final class MockHTTPClient: HTTPClient, @unchecked Sendable {
    var responder: (HTTPRequest) throws -> Data
    init(responder: @escaping (HTTPRequest) throws -> Data) { self.responder = responder }
    func send<Response: Decodable>(_ request: HTTPRequest, as type: Response.Type) async throws -> Response {
        try JSONDecoder().decode(Response.self, from: try responder(request))
    }
    func sendRaw(_ request: HTTPRequest) async throws -> Data { try responder(request) }
}

extension Transcript {
    static func partial(_ text: String) -> Transcript {
        Transcript(text: text, isFinal: false, confidence: 1, source: .onDevice)
    }
    static func final(_ text: String, confidence: Double = 1) -> Transcript {
        Transcript(text: text, isFinal: true, confidence: confidence, source: .onDevice)
    }
}
