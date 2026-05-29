from pydantic import BaseModel, ConfigDict
from datetime import datetime
from typing import Optional

class AnnouncementBase(BaseModel):
    title: str
    content: str
    target_karyakar_id: Optional[str] = None
    target_mandal_id: Optional[str] = None
    target_wing: Optional[str] = None
    target_roles: Optional[str] = None

class AnnouncementCreate(AnnouncementBase):
    id: str

class AnnouncementResponse(AnnouncementBase):
    model_config = ConfigDict(from_attributes=True)
    id: str
    created_at: datetime
