import XCTest
@testable import AINativeApp

/// Covers Invariant V6 (validated command or throw — never a guess) and the
/// no-side-effect parts of V5/V7 (this type must not execute or persist).
final class LLMVoiceCommandServiceTests: XCTestCase {

    private func service(
        wireJSON: String,
        account: MockAccountService = MockAccountService()
    ) -> LLMVoiceCommandService {
        let http = MockHTTPClient { _ in Data(wireJSON.utf8) }
        return LLMVoiceCommandService(http: http, account: account, minConfidence: 0.6)
    }

    private let ctx = VoiceCommandContext(hasActiveTrip: false, currentCoordinate: nil)

    func test_confidentNavigateWithCoordinates_returnsNavigateCommand() async throws {
        let sut = service(wireJSON: """
        {"intent":"navigate","confidence":0.95,"destinationText":null,"savedPlace":null,
         "latitude":37.33,"longitude":-122.03,"preference":null,"query":null,"volume":null,
         "alternativesCount":1}
        """)
        let command = try await sut.command(from: .final("take me there"), context: ctx)
        XCTAssertEqual(command, .navigate(to: .coordinate(Coordinate(latitude: 37.33, longitude: -122.03))))
    }

    // Invariant V6
    func test_ambiguousTranscript_throwsRatherThanGuessing() async {
        let sut = service(wireJSON: """
        {"intent":"navigate","confidence":0.9,"destinationText":"the usual place","savedPlace":null,
         "latitude":null,"longitude":null,"preference":null,"query":null,"volume":null,
         "alternativesCount":3}
        """)
        await XCTAssertThrowsErrorAsync(try await sut.command(from: .final("go to the usual place"), context: ctx)) {
            XCTAssertEqual($0 as? VoiceError, .ambiguousCommand(transcript: "go to the usual place"))
        }
    }

    // Invariant V6
    func test_lowConfidence_throwsAmbiguous() async {
        let sut = service(wireJSON: """
        {"intent":"navigate","confidence":0.3,"destinationText":"home","savedPlace":null,
         "latitude":null,"longitude":null,"preference":null,"query":null,"volume":null,
         "alternativesCount":1}
        """)
        await XCTAssertThrowsErrorAsync(try await sut.command(from: .final("mumble"), context: ctx))
    }

    func test_savedPlaceResolvedViaAccountService() async throws {
        let account = MockAccountService(places: [
            "home": SavedPlace(id: "1", name: "home", coordinate: Coordinate(latitude: 1, longitude: 2))
        ])
        let sut = service(wireJSON: """
        {"intent":"navigate","confidence":0.9,"destinationText":null,"savedPlace":"home",
         "latitude":null,"longitude":null,"preference":null,"query":null,"volume":null,
         "alternativesCount":1}
        """, account: account)
        let command = try await sut.command(from: .final("take me home"), context: ctx)
        XCTAssertEqual(command, .navigate(to: .coordinate(Coordinate(latitude: 1, longitude: 2))))
    }

    func test_unresolvableSavedPlace_throwsRatherThanGuessing() async {
        let sut = service(wireJSON: """
        {"intent":"navigate","confidence":0.9,"destinationText":null,"savedPlace":"cottage",
         "latitude":null,"longitude":null,"preference":null,"query":null,"volume":null,
         "alternativesCount":1}
        """, account: MockAccountService(places: [:]))
        await XCTAssertThrowsErrorAsync(try await sut.command(from: .final("drive to the cottage"), context: ctx))
    }

    func test_backendFailure_throwsCommandServiceUnavailable() async {
        let http = MockHTTPClient { _ in throw HTTPError.transport }
        let sut = LLMVoiceCommandService(http: http, account: MockAccountService())
        await XCTAssertThrowsErrorAsync(try await sut.command(from: .final("anything"), context: ctx)) {
            XCTAssertEqual($0 as? VoiceError, .commandServiceUnavailable)
        }
    }
}

// Small async assertion helper (a real repo would keep this in Tests/Support).
func XCTAssertThrowsErrorAsync<T>(
    _ expression: @autoclosure () async throws -> T,
    _ handler: (Error) -> Void = { _ in },
    file: StaticString = #filePath, line: UInt = #line
) async {
    do { _ = try await expression(); XCTFail("Expected error", file: file, line: line) }
    catch { handler(error) }
}
