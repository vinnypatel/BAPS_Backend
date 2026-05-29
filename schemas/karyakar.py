from pydantic import BaseModel, ConfigDict
from pydantic.alias_generators import to_camel
from typing import Optional, List
from schemas.mandal import MandalResponse
from schemas.xetra import XetraResponse


class KaryakarBase(BaseModel):
    model_config = ConfigDict(alias_generator=to_camel, populate_by_name=True)
    id: str
    karyakar_number: str
    name: str
    role: str
    username: str
    avatar: Optional[str] = None
    phone: str
    email: str
    parent_karyakar_id: Optional[str] = None
    birthday: Optional[str] = None
    joined_at: str
    wing: Optional[str] = None
    xetra: Optional[str] = None
    status: str = "active"
    mfa_enabled: Optional[bool] = False
    mfa_secret: Optional[str] = None
class KaryakarCreate(KaryakarBase):
    password: str
    xetra_ids: List[str] = []
    mandal_ids: List[str] = []

class KaryakarUpdate(BaseModel):
    model_config = ConfigDict(alias_generator=to_camel, populate_by_name=True)
    name: Optional[str] = None
    role: Optional[str] = None
    username: Optional[str] = None
    password: Optional[str] = None
    karyakar_number: Optional[str] = None
    avatar: Optional[str] = None
    phone: Optional[str] = None
    email: Optional[str] = None
    parent_karyakar_id: Optional[str] = None
    birthday: Optional[str] = None
    joined_at: Optional[str] = None
    wing: Optional[str] = None
    mandal_ids: Optional[List[str]] = None
    xetra_ids: Optional[List[str]] = None
    status: Optional[str] = None
    mfa_enabled: Optional[bool] = None
    mfa_secret: Optional[str] = None
class KaryakarProfileUpdate(BaseModel):
    model_config = ConfigDict(alias_generator=to_camel, populate_by_name=True)
    password: Optional[str] = None
    phone: Optional[str] = None
    email: Optional[str] = None
    avatar: Optional[str] = None
    mfa_enabled: Optional[bool] = None
    mfa_secret: Optional[str] = None

class KaryakarResponse(KaryakarBase):
    model_config = ConfigDict(from_attributes=True)
    xetra_ids: List[str]
    mandal_ids: List[str]
    mandals: List[MandalResponse]
    xetras: List[XetraResponse]

