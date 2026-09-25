import Foundation

/// Voice Processing Service Protocol (Interface)
/// Contract:
/// - Must be responsible for converting local temporary recordings into text.
/// - Does not expose specific third-party provider errors (e.g., Apple, OpenAI). Throws a uniformly defined VoiceError.
/// - If the network fails, it should handle fallback internally; external callers shouldn't care.
protocol VoiceServiceProtocol {
    func transcribe(audioFileURL: URL) async throws -> String
}
