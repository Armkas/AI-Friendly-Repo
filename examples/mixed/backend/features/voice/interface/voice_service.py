from typing import Protocol, AsyncGenerator
from .schemas import AudioChunk, VoiceIntent

class VoiceService(Protocol):
    """
    Backend service responsible for processing streaming audio into intents.
    
    **Invariants & Rules:**
    - Must never save `AudioChunk` raw bytes to disk (Privacy Invariant from docs/domains/voice.md).
    - Must support both WebSocket streaming (ideal) and REST chunked uploads (degraded).
    """
    
    async def process_websocket_stream(self, stream: AsyncGenerator[AudioChunk, None]) -> AsyncGenerator[VoiceIntent, None]:
        """Handles continuous WebSocket audio stream and yields intents."""
        ...
        
    async def process_rest_chunk(self, chunk: AudioChunk) -> VoiceIntent:
        """Handles a single audio chunk uploaded via REST fallback."""
        ...
