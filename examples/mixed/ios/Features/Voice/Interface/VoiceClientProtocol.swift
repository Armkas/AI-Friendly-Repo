import Foundation

/// Defines the contract for the iOS Voice Client.
/// 
/// **Invariants & Rules:**
/// - Must observe the network connectivity state.
/// - Implements the Network Degradation Fallback rule defined in `docs/domains/voice.md`.
/// - Must switch from WebSocket -> REST -> On-Device STT depending on network latency and availability.
protocol VoiceClientProtocol {
    /// Starts a continuous voice session.
    func startContinuousSession() async throws
    
    /// Ends the current voice session and cleans up temporary audio buffers.
    func endSession() async
    
    /// Called internally when network state changes to trigger the fallback state machine.
    func handleNetworkDegradation(currentLatencyMs: Int) async
}
