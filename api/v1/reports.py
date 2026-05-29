from fastapi import APIRouter, Depends, HTTPException, Query
from sqlalchemy.ext.asyncio import AsyncSession
from typing import List, Optional

from db.session import get_db
from models.karyakar import Karyakar
from api.v1.auth import get_current_user
from services.report_service import ReportService

router = APIRouter(prefix="/reports", tags=["Reports"])

@router.get("/project-summary")
async def get_project_summary(
    group_by: str = Query(..., description="Aggregation level: xetra, mandal, sampark_karyakar, family"),
    filter_id: Optional[str] = Query(None, description="Optional ID to filter by (e.g. xetra_id when grouping by mandal)"),
    db: AsyncSession = Depends(get_db),
    current_user: Karyakar = Depends(get_current_user)
):
    """
    Get project summary statistics based on user role and requested aggregation level.
    """
    service = ReportService(db)
    try:
        data = await service.get_project_summary(current_user, group_by, filter_id)
        return data
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

@router.get("/data-summary")
async def get_data_summary(
    group_by: str = Query(..., description="Aggregation level: xetra, mandal, sampark_karyakar, family"),
    filter_id: Optional[str] = Query(None, description="Optional ID to filter by"),
    db: AsyncSession = Depends(get_db),
    current_user: Karyakar = Depends(get_current_user)
):
    """
    Get niyam-based data summary statistics based on user role and requested aggregation level.
    """
    service = ReportService(db)
    try:
        data = await service.get_data_summary(current_user, group_by, filter_id)
        return data
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
