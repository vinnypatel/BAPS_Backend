from pydantic import BaseModel, ConfigDict
from typing import Optional, List, Dict
from datetime import datetime
from pydantic.alias_generators import to_camel

class HaribhaktBase(BaseModel):
    model_config = ConfigDict(alias_generator=to_camel, populate_by_name=True)
    id: str
    family_id: Optional[str] = None
    member_id: Optional[str] = None
    person_id: Optional[str] = None
    form_id: Optional[str] = None
    full_name: str
    father_name: Optional[str] = None
    surname: Optional[str] = None
    avatar: Optional[str] = None
    mobile: str
    whatsapp: Optional[str] = None
    alternate_number: Optional[str] = None
    alternate_whatsapp: Optional[str] = None
    email: Optional[str] = None
    area: Optional[str] = None
    city: Optional[str] = None
    pin_code: Optional[str] = None
    dob: Optional[str] = None
    wing: Optional[str] = None
    gender: Optional[str] = None
    blood_group: Optional[str] = None
    occupation: Optional[str] = None
    occupation_type: Optional[str] = None
    designation: Optional[str] = None
    business_description: Optional[str] = None
    education: Optional[str] = None
    education_type: Optional[str] = None
    education_info: Optional[str] = None
    talent: Optional[str] = None
    skill: Optional[List[str]] = None
    vehicle: Optional[Dict[str, int]] = None
    can_give_vehicle_in_seva: bool = False
    is_out_of_city: bool = False
    is_nri: bool = False
    dharmada_id: Optional[str] = None
    dharmada_status: Optional[str] = None
    satsang_karyakar: Optional[str] = None
    satsang_since: Optional[str] = None
    every_ekadashi: Optional[str] = None
    last_satsang_exam: Optional[str] = None
    karyakar_id: Optional[str] = None
    mandal_type: Optional[str] = None
    ghar_number: Optional[str] = None
    society_name: Optional[str] = None
    landmark: Optional[str] = None
    state: Optional[str] = None
    country: Optional[str] = None
    ghar_mandir: Optional[str] = None
    akshar_purushottam_in_ghar_mandir: Optional[str] = None
    arati: Optional[str] = None
    thal: Optional[str] = None
    swaminarayan_prakash: bool = False
    premvati: bool = False
    bal_prakash: bool = False
    bliss: bool = False
    relation: Optional[str] = None
    daily_vachnamrut: Optional[str] = None
    daily_swami_vato: bool = False
    ghar_sabha: bool = False
    ghar_sabha_present: Optional[str] = None
    ghar_sabha_regularity: Optional[str] = None
    ghar_sabha_days: Optional[str] = None
    daily_arati: bool = False
    daily_arati_regularity: Optional[str] = None
    daily_arati_times: Optional[str] = None
    ashtak: Optional[str] = None
    ashtak_times: Optional[str] = None
    watching_cinema: Optional[str] = None
    eating_onion_garlic: Optional[str] = None
    eating_hing: Optional[str] = None
    eating_outside: Optional[str] = None
    chesta: Optional[str] = None
    daily_tilak: bool = False
    ravisabha: bool = False
    ravisabha_regularity: Optional[str] = None
    parasabha: bool = False
    parasabha_regularity: Optional[str] = None
    daily_pooja: bool = False
    kanthi: Optional[str] = None
    mandal_id: str
    personal_mandal_id: Optional[str] = None
    xetra_id: str
    sampark_karyakar_id: Optional[str] = None
    s_grade: str = "Select"
    satsang_grade: str = "Select"
    status: str = "active"
    status_reason: Optional[str] = None
    status_note: Optional[str] = None
    transfer_status: str = "accepted"
    last_updated_by: Optional[str] = None

class HaribhaktCreate(HaribhaktBase):
    pass

class HaribhaktUpdate(BaseModel):
    model_config = ConfigDict(alias_generator=to_camel, populate_by_name=True)
    full_name: Optional[str] = None
    father_name: Optional[str] = None
    surname: Optional[str] = None
    avatar: Optional[str] = None
    mobile: Optional[str] = None
    whatsapp: Optional[str] = None
    alternate_number: Optional[str] = None
    alternate_whatsapp: Optional[str] = None
    email: Optional[str] = None
    area: Optional[str] = None
    city: Optional[str] = None
    pin_code: Optional[str] = None
    dob: Optional[str] = None
    wing: Optional[str] = None
    gender: Optional[str] = None
    blood_group: Optional[str] = None
    occupation: Optional[str] = None
    occupation_type: Optional[str] = None
    designation: Optional[str] = None
    business_description: Optional[str] = None
    education: Optional[str] = None
    education_type: Optional[str] = None
    education_info: Optional[str] = None
    talent: Optional[str] = None
    skill: Optional[List[str]] = None
    vehicle: Optional[Dict[str, int]] = None
    can_give_vehicle_in_seva: Optional[bool] = None
    is_out_of_city: Optional[bool] = None
    is_nri: Optional[bool] = None
    dharmada_id: Optional[str] = None
    dharmada_status: Optional[str] = None
    satsang_karyakar: Optional[str] = None
    satsang_since: Optional[str] = None
    every_ekadashi: Optional[str] = None
    last_satsang_exam: Optional[str] = None
    karyakar_id: Optional[str] = None
    mandal_type: Optional[str] = None
    ghar_number: Optional[str] = None
    society_name: Optional[str] = None
    landmark: Optional[str] = None
    state: Optional[str] = None
    country: Optional[str] = None
    ghar_mandir: Optional[str] = None
    akshar_purushottam_in_ghar_mandir: Optional[str] = None
    arati: Optional[str] = None
    thal: Optional[str] = None
    swaminarayan_prakash: Optional[bool] = None
    premvati: Optional[bool] = None
    bal_prakash: Optional[bool] = None
    bliss: Optional[bool] = None
    relation: Optional[str] = None
    daily_vachnamrut: Optional[str] = None
    daily_swami_vato: Optional[bool] = None
    ghar_sabha: Optional[bool] = None
    ghar_sabha_present: Optional[str] = None
    ghar_sabha_regularity: Optional[str] = None
    ghar_sabha_days: Optional[str] = None
    daily_arati: Optional[bool] = None
    daily_arati_regularity: Optional[str] = None
    daily_arati_times: Optional[str] = None
    ashtak: Optional[str] = None
    ashtak_times: Optional[str] = None
    watching_cinema: Optional[str] = None
    eating_onion_garlic: Optional[str] = None
    eating_hing: Optional[str] = None
    eating_outside: Optional[str] = None
    chesta: Optional[str] = None
    daily_tilak: Optional[bool] = None
    ravisabha: Optional[bool] = None
    ravisabha_regularity: Optional[str] = None
    parasabha: Optional[bool] = None
    parasabha_regularity: Optional[str] = None
    daily_pooja: Optional[bool] = None
    kanthi: Optional[str] = None
    mandal_id: Optional[str] = None
    personal_mandal_id: Optional[str] = None
    xetra_id: Optional[str] = None
    sampark_karyakar_id: Optional[str] = None
    family_id: Optional[str] = None
    s_grade: Optional[str] = None
    satsang_grade: Optional[str] = None
    status: Optional[str] = None
    status_reason: Optional[str] = None
    status_note: Optional[str] = None
    transfer_status: Optional[str] = None
    last_updated_by: Optional[str] = None

class HaribhaktResponse(HaribhaktBase):
    model_config = ConfigDict(from_attributes=True)
    created_at: datetime
    last_updated_at: Optional[datetime] = None
