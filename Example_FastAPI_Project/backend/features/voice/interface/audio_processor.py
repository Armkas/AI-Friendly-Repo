from typing import Protocol
from .schemas import AudioProcessRequest, SummaryResponse

class AudioProcessor(Protocol):
    """
    Convert an uploaded audio recording into a validated summary.
    
    Contract:
    - Must not persist raw audio permanently.
    - Must validate transcription before summarization.
    - Must raise ProcessingError for unrecoverable failures.
    - Must not expose provider-specific exceptions.
    """
    async def process(self, request: AudioProcessRequest) -> SummaryResponse:
        ...
