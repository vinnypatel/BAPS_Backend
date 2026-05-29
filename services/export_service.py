import csv
import io
from datetime import datetime
from sqlalchemy.ext.asyncio import AsyncSession
from repositories.haribhakt_repo import HaribhaktRepository
from repositories.mandal_repo import MandalRepository
from models.karyakar import Karyakar

class ExportService:
    def __init__(self, db: AsyncSession):
        self.db = db
        self.hb_repo = HaribhaktRepository(db)
        self.m_repo = MandalRepository(db)

    async def export_haribhakts(self, actor: Karyakar, filters: dict = None) -> io.StringIO:
        # Re-use scoping logic from HaribhaktService
        from services.haribhakt_service import HaribhaktService
        hb_service = HaribhaktService(self.db)
        
        # birthday_filter can be passed via filters dict
        birthday_filter = filters.pop('birthday_filter', None) if filters else None
        
        haribhakts = await hb_service.get_all(actor, filters)
        
        if birthday_filter:
            filtered_hbs = []
            now = datetime.now()
            today_month = now.month
            today_date = now.day
            
            # Week calc
            curr = now
            first = curr.day - curr.weekday() # Monday as start of week
            try:
                week_start = curr.replace(day=max(1, first), hour=0, minute=0, second=0)
                # Approximation for week end
                import timedelta
                from datetime import timedelta
                week_end = week_start + timedelta(days=6)
            except ValueError:
                # Handle end of month edge cases roughly
                from datetime import timedelta
                week_start = curr - timedelta(days=curr.weekday())
                week_end = week_start + timedelta(days=6)

            for h in haribhakts:
                if not h.dob: continue
                try:
                    d = datetime.strptime(h.dob, "%Y-%m-%d")
                    b_month = d.month
                    b_date = d.day
                    
                    if birthday_filter == "today":
                        if b_month == today_month and b_date == today_date:
                            filtered_hbs.append(h)
                    elif birthday_filter == "month":
                        if b_month == today_month:
                            filtered_hbs.append(h)
                    elif birthday_filter == "week":
                        # Create a date object for their birthday THIS year
                        try:
                            b_this_year = datetime(now.year, b_month, b_date)
                            if week_start <= b_this_year <= week_end:
                                filtered_hbs.append(h)
                        except ValueError:
                            # Leap year leap day handling
                            if b_month == 2 and b_date == 29:
                                b_this_year = datetime(now.year, 2, 28)
                                if week_start <= b_this_year <= week_end:
                                    filtered_hbs.append(h)
                except ValueError:
                    pass
            haribhakts = filtered_hbs

        
        output = io.StringIO()
        writer = csv.writer(output)
        
        # Header
        writer.writerow([
            "ID", "Full Name", "Father Name", "Surname", "Mobile", "Email", 
            "Mandal", "Xetra", "Satsang Grade", "Seva Grade", "Status",
            "Area", "City", "DOB", "Gender", "Blood Group", "Education",
            "Occupation", "Dharmada ID", "Satsang Since"
        ])
        
        # We need mandals and xetras for names
        mandals = await self.m_repo.get_all()
        mandal_map = {m.id: m.name for m in mandals}
        
        for h in haribhakts:
            writer.writerow([
                h.person_id, h.full_name, h.father_name, h.surname, h.mobile, h.email,
                mandal_map.get(h.mandal_id, h.mandal_id), h.xetra_id,
                h.satsang_grade, h.s_grade, h.status,
                h.area, h.city, h.dob, h.gender, h.blood_group, h.education,
                h.occupation, h.dharmada_id, h.satsang_since
            ])
            
        output.seek(0)
        return output

    async def export_mandal_summary(self, actor: Karyakar) -> io.StringIO:
        # Implement mandal summary logic
        haribhakts = await self.hb_repo.get_all()
        mandals = await self.m_repo.get_all()
        
        output = io.StringIO()
        writer = csv.writer(output)
        writer.writerow(["Mandal Name", "Wing", "Total Haribhakts", "S Grade", "S1 Grade", "G Grade"])
        
        for m in mandals:
            m_hbs = [h for h in haribhakts if h.mandal_id == m.id]
            s_count = sum(1 for h in m_hbs if h.satsang_grade == "S")
            s1_count = sum(1 for h in m_hbs if h.satsang_grade == "S1")
            g_count = sum(1 for h in m_hbs if h.satsang_grade == "G")
            
            writer.writerow([m.name, m.wing, len(m_hbs), s_count, s1_count, g_count])
            
        output.seek(0)
        return output
