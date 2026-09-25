# DOMAIN: Voice

## Responsibilities
Responsible for all capabilities related to voice recording, recognition, and synthesis. It is the core of the app's voice interaction with users.

## Key Workflows
- Record -> Speech-to-Text (STT) -> Intent Recognition (can be delegated to Navigation)

## Strong Constraints (Invariants)
- **Silence Detection**: If there is no voice input for 20 consecutive seconds, automatically exit continuous dialogue mode.
- **Fallback Strategy**: When the network fails, it must fall back to local STT for basic recognition.
- **Persistence**: It is strictly forbidden to permanently save user's raw audio files locally. They are only allowed in temporary directories and must be deleted immediately after processing.

## Mappings
- **Code Implementation Location**: `ios/Features/Voice/`
- **Main Protocol**: `VoiceServiceProtocol`
