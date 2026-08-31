import XCTest
@testable import VoiceFeature

/// Executable knowledge for the Voice feature.
///
/// Notice how the tests are named by behavior (Invariant), not just function names.
/// The AI agent can read these tests to understand how the system is *expected* to handle failures.
final class VoiceClientTests: XCTestCase {
    
    func testNetworkFailureFallsBackToLocalRecognition() async throws {
        // Given a VoiceClient connected to a mocked failing network
        let client = VoiceClient(networkStrategy: .alwaysFail)
        
        // When we start listening
        try await client.startListening()
        
        // Then the client should automatically switch to local fallback mode
        XCTAssertTrue(client.isUsingLocalFallback, "Client must fall back to local recognition upon network failure.")
    }
    
    func testTwentySecondsOfSilenceEndsSession() async throws {
        // Given an active voice session
        let client = VoiceClient()
        try await client.startListening()
        
        // When 20 seconds of silence is simulated
        await client.simulateSilence(seconds: 20)
        
        // Then the session should be automatically stopped
        XCTAssertFalse(client.isRecording, "Client must stop listening after prolonged silence.")
    }
}
