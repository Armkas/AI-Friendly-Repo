import Foundation

/// VoiceService 具体实现 (Implementation)
/// AI 在未遇到 Bug 或无相关任务时，无需深入阅读此类。
class VoiceService: VoiceServiceProtocol {
    func transcribe(audioFileURL: URL) async throws -> String {
        // TODO: 具体识别逻辑实现
        return "Dummy Transcription"
    }
}
