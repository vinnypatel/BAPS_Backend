from pydantic import BaseModel, ConfigDict
from pydantic.alias_generators import to_camel

from typing import Optional

class XetraBase(BaseModel):
    model_config = ConfigDict(alias_generator=to_camel, populate_by_name=True)
    id: str
    name: str

class XetraCreate(XetraBase):
    pass

class XetraUpdate(BaseModel):
    model_config = ConfigDict(alias_generator=to_camel, populate_by_name=True)
    name: Optional[str] = None

class XetraResponse(XetraBase):
    model_config = ConfigDict(from_attributes=True)

