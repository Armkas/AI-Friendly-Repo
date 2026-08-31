# DOMAIN: Voice (Cross-Platform)

## Responsibilities
Handles real-time continuous voice processing, speech-to-text (STT), and voice-driven command routing across all client platforms (iOS, Android, Web) and the backend API.

## Core Invariants (MUST NOT BE BROKEN)
- **Silence Timeout**: If the client detects 20 seconds of continuous silence, it must automatically terminate the voice session to save resources.
- **Network Degradation Fallback (The "Connectivity Rule")**:
  - **Ideal state**: Clients stream audio chunks via WebSocket to the Backend.
  - **Degraded state**: If the WebSocket drops or latency exceeds 500ms, clients MUST fallback to REST chunked uploading.
  - **Disconnected state**: If REST fails, mobile clients (iOS/Android) MUST fallback to On-Device STT.
- **Data Privacy**: The backend must never persist raw audio files to disk permanently; they must be processed in memory and discarded.

## Architecture
- **Clients (iOS/Android/Web)**: Responsible for capturing audio, detecting silence, and managing the connection state machine (WebSocket -> REST -> On-Device).
- **Backend (FastAPI)**: Responsible for receiving WebSocket streams/REST chunks, passing them to the STT provider, and returning parsed intents.

## Related Code Directories
- iOS: `ios/Features/Voice/`
- Android: `android/app/src/main/java/com/example/features/voice/`
- Web: `web/src/features/voice/`
- Backend: `backend/features/voice/`
