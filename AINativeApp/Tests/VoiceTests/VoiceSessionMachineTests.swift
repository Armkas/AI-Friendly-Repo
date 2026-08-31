import XCTest
@testable import AINativeApp

/// Exercises the pure `VoiceSessionMachine` — the home of Invariants V3, V4, V7, V8.
/// No concurrency, no I/O: every test is (state, event) -> (state, effects).
final class VoiceSessionMachineTests: XCTestCase {

    private func started() -> VoiceSessionMachine {
        var m = VoiceSessionMachine(config: .default)
        _ = m.handle(.startRequested)
        return m
    }

    func test_start_movesToListeningAndArmsSilenceTimer() {
        var m = VoiceSessionMachine()
        let effects = m.handle(.startRequested)
        XCTAssertEqual(m.state, .listening)
        XCTAssertTrue(effects.contains(.startCapture))
        XCTAssertTrue(effects.contains(.armSilenceTimer))
    }

    // Invariant V3
    func test_silenceBeyondTimeout_endsSession() {
        var m = started()
        let effects = m.handle(.silenceElapsed)
        XCTAssertEqual(m.state, .idle)
        XCTAssertTrue(effects.contains(.stopCapture))
    }

    func test_audioActivity_resetsSilenceTimer() {
        var m = started()
        let effects = m.handle(.audioActivity(rms: 0.5, at: 1))
        XCTAssertTrue(effects.contains(.armSilenceTimer))
        XCTAssertEqual(m.state, .listening)
    }

    // Invariant V4 / V7
    func test_highRiskCommand_requiresConfirmation() {
        var m = started()
        _ = m.handle(.finalTranscript(.final("take me home")))
        let effects = m.handle(.interpreted(.navigate(to: .search("home"))))
        XCTAssertEqual(m.state, .confirming(.navigate(to: .search("home"))))
        XCTAssertFalse(effects.contains(.emitCommandForExecution(.navigate(to: .search("home")))),
                       "V7: high-risk command must NOT be emitted before confirmation")
    }

    func test_lowRiskCommand_executesWithoutConfirmation() {
        var m = started()
        _ = m.handle(.finalTranscript(.final("how far")))
        let effects = m.handle(.interpreted(.query(.distanceRemaining)))
        XCTAssertEqual(m.state, .executing(.query(.distanceRemaining)))
        XCTAssertTrue(effects.contains(.emitCommandForExecution(.query(.distanceRemaining))))
    }

    func test_userConfirmsHighRiskCommand_thenItIsEmitted() {
        var m = started()
        _ = m.handle(.finalTranscript(.final("cancel trip")))
        _ = m.handle(.interpreted(.cancelTrip))
        let effects = m.handle(.userConfirmed(.cancelTrip))
        XCTAssertEqual(m.state, .executing(.cancelTrip))
        XCTAssertTrue(effects.contains(.emitCommandForExecution(.cancelTrip)))
    }

    func test_userRejectsCommand_returnsToListening() {
        var m = started()
        _ = m.handle(.finalTranscript(.final("navigate somewhere")))
        _ = m.handle(.interpreted(.navigate(to: .search("somewhere"))))
        _ = m.handle(.userRejected)
        XCTAssertEqual(m.state, .listening)
    }

    func test_lowConfidenceFinalTranscript_staysListening() {
        var m = started()
        _ = m.handle(.finalTranscript(.final("mumble", confidence: 0.1)))
        XCTAssertEqual(m.state, .listening)
    }

    // Invariant V8
    func test_fatalError_returnsToIdle() {
        var m = started()
        _ = m.handle(.fatal(.recognitionUnavailable))
        XCTAssertEqual(m.state, .failed(.recognitionUnavailable))
        m.acknowledgeFailureAndReset()
        XCTAssertEqual(m.state, .idle)
    }

    func test_stopRequestedFromAnyState_returnsToIdle() {
        var m = started()
        _ = m.handle(.partialTranscript("half a sen"))
        _ = m.handle(.stopRequested)
        XCTAssertEqual(m.state, .idle)
    }
}
