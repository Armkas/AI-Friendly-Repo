import Foundation

/// A minimal skeleton of the voice client implementation.
///
/// Notice how this implementation focuses solely on fulfilling the `VoiceClientProtocol`
/// contract and respecting the invariants defined in the architecture layer.
public class VoiceClient: VoiceClientProtocol {
    
    private var isRecording: Bool = false
    
    public init() {
        // Implementation specifics like setting up audio sessions
        // should be contained here and abstracted from the domain.
    }
    
    public func startListening() async throws {
        guard !isRecording else { return }
        
        // 1. Establish connection (WebSocket first, fallback to REST)
        // 2. Start capturing audio
        isRecording = true
    }
    
    public func stopListening() async {
        guard isRecording else { return }
        
        // 1. Stop capturing audio
        // 2. Tear down connection
        isRecording = false
    }
    
    // Additional private implementation methods for handling networking,
    // retries, and audio chunking go here.
}
