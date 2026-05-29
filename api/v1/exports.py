from datetime import datetime
from fastapi import APIRouter, Depends, Query, Response
from sqlalchemy.ext.asyncio import AsyncSession
from core.dependencies import get_db, get_current_karyakar
from services.export_service import ExportService
from models.karyakar import Karyakar

router = APIRouter(prefix="/exports", tags=["exports"])

@router.get("/haribhakts")
async def export_haribhakts(
    status: str | None = Query(None),
    birthday_filter: str | None = Query(None),
    current_user: Karyakar = Depends(get_current_karyakar),
    db: AsyncSession = Depends(get_db)
):
    service = ExportService(db)
    filters = {}
    if status:
        filters['status'] = status
    if birthday_filter:
        filters['birthday_filter'] = birthday_filter
        
    output = await service.export_haribhakts(current_user, filters)
    
    filename = f"haribhakts_export_{datetime.now().strftime('%Y%m%d_%H%M%S')}.csv"
    
    return Response(
        content=output.getvalue(),
        media_type="text/csv",
        headers={"Content-Disposition": f"attachment; filename={filename}"}
    )

@router.get("/mandal-summary")
async def export_mandal_summary(
    current_user: Karyakar = Depends(get_current_karyakar),
    db: AsyncSession = Depends(get_db)
):
    service = ExportService(db)
    output = await service.export_mandal_summary(current_user)
    
    filename = f"mandal_summary_{datetime.now().strftime('%Y%m%d_%H%M%S')}.csv"
    
    return Response(
        content=output.getvalue(),
        media_type="text/csv",
        headers={"Content-Disposition": f"attachment; filename={filename}"}
    )
