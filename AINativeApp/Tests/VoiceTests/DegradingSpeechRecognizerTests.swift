import XCTest
@testable import AINativeApp

/// Covers Invariants V1 (transport failure degrades, never ends the session) and
/// V2 (no network ⇒ on-device).
final class DegradingSpeechRecognizerTests: XCTestCase {

    private func audio() -> AsyncStream<AudioBuffer> {
        AsyncStream { cont in
            cont.yield(AudioBuffer(samples: [1, 2, 3], sampleRate: 16000, channelCount: 1, timestamp: 0))
            cont.finish()
        }
    }

    private func collect(_ stream: AsyncStream<Transcript>) async -> [Transcript] {
        var out: [Transcript] = []
        for await t in stream { out.append(t) }
        return out
    }

    // Invariant V2
    func test_networkUnavailable_usesOnDevice() async {
        let ws = MockSpeechRecognizer(scripted: [], finishesAfterScript: true)
        let rest = MockSpeechRecognizer(scripted: [], finishesAfterScript: true)
        let onDevice = MockSpeechRecognizer(scripted: [.final("home")], finishesAfterScript: true)

        let sut = DegradingSpeechRecognizer(
            webSocket: ws, restChunked: rest, onDevice: onDevice,
            network: MockNetworkMonitor(.unsatisfied)
        )

        let result = await collect(sut.transcribe(audio()))
        XCTAssertEqual(ws.transcribeCallCount, 0)
        XCTAssertEqual(rest.transcribeCallCount, 0)
        XCTAssertEqual(onDevice.transcribeCallCount, 1)
        XCTAssertEqual(result.map(\.text), ["home"])
    }

    // Invariant V1
    func test_transportFailure_fallsBackWithoutEndingStream() async {
        // webSocket "drops" immediately (finishes with nothing); rest then succeeds.
        let ws = MockSpeechRecognizer(scripted: [], finishesAfterScript: true)
        let rest = MockSpeechRecognizer(scripted: [.partial("take me"), .final("take me home")],
                                        finishesAfterScript: true)
        let onDevice = MockSpeechRecognizer(scripted: [], finishesAfterScript: true)

        let sut = DegradingSpeechRecognizer(
            webSocket: ws, restChunked: rest, onDevice: onDevice,
            network: MockNetworkMonitor(.satisfied(lowLatency: true))
        )

        let result = await collect(sut.transcribe(audio()))
        XCTAssertEqual(ws.transcribeCallCount, 1)
        XCTAssertEqual(rest.transcribeCallCount, 1, "should have degraded to REST")
        XCTAssertEqual(result.last?.text, "take me home",
                       "session kept producing transcripts across the fallback")
    }

    func test_allTransportsExhausted_streamFinishesForCallerToTreatAsFatal() async {
        let empty = { MockSpeechRecognizer(scripted: [], finishesAfterScript: true) }
        let sut = DegradingSpeechRecognizer(
            webSocket: empty(), restChunked: empty(), onDevice: empty(),
            network: MockNetworkMonitor(.satisfied(lowLatency: true))
        )
        let result = await collect(sut.transcribe(audio()))
        XCTAssertTrue(result.isEmpty)  // caller's silence timer / fatal handling takes over (V8)
    }
}
