from pydantic import BaseModel, ConfigDict
from pydantic.alias_generators import to_camel
from typing import Optional

class MandalBase(BaseModel):
    model_config = ConfigDict(alias_generator=to_camel, populate_by_name=True)
    id: str
    name: str
    xetra_id: str
    wing: str

class MandalCreate(MandalBase):
    pass

class MandalUpdate(BaseModel):
    model_config = ConfigDict(alias_generator=to_camel, populate_by_name=True)
    name: Optional[str] = None
    xetra_id: Optional[str] = None

class MandalResponse(MandalBase):
    model_config = ConfigDict(from_attributes=True)

