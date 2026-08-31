from pydantic import BaseModel

class AudioChunk(BaseModel):
    session_id: str
    sequence_number: int
    payload: bytes
    
class VoiceIntent(BaseModel):
    session_id: str
    intent_name: str
    confidence: float
    parameters: dict
