from fastapi import APIRouter
from api.v1 import auth, karyakars, haribhakts, mandals, xetras, announcements, exports, reports

router = APIRouter()

router.include_router(auth.router)
router.include_router(karyakars.router)
router.include_router(haribhakts.router)
router.include_router(mandals.router)
router.include_router(xetras.router)
router.include_router(announcements.router)
router.include_router(exports.router)
router.include_router(reports.router)
