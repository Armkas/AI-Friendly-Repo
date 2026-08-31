import Foundation

/// 语音处理服务协议 (Interface)
/// Contract:
/// - 必须负责将本地临时录音转化为文本。
/// - 不暴露具体的第三方识别提供商错误 (如 Apple, OpenAI 等)，抛出统一定义的 VoiceError。
/// - 如果网络失败，应该内部处理兜底方案，外部无需关心。
protocol VoiceServiceProtocol {
    func transcribe(audioFileURL: URL) async throws -> String
}
