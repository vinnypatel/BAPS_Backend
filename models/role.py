from enum import Enum


class RoleEnum(str, Enum):
    sant_nirdeshak = "sant_nirdeshak"
    sanyojak = "sanyojak"
    nirdeshak = "nirdeshak"
    sah_nirdeshak = "sah_nirdeshak"
    nirikshak = "nirikshak"
    mandal_sanchalak = "mandal_sanchalak"
    sampark_karyakar = "sampark_karyakar"


ROLE_RANK: dict[RoleEnum, int] = {
    RoleEnum.sant_nirdeshak: 7,
    RoleEnum.sanyojak: 6,
    RoleEnum.nirdeshak: 5,
    RoleEnum.sah_nirdeshak: 4,
    RoleEnum.nirikshak: 3,
    RoleEnum.mandal_sanchalak: 3,
    RoleEnum.sampark_karyakar: 1,
}
