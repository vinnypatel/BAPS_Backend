from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy import select, func, and_, desc
from models.haribhakt import Haribhakt
from models.mandal import Mandal
from models.xetra import Xetra
from models.karyakar import Karyakar
from typing import List, Dict, Any
from datetime import datetime, timedelta

class ReportService:
    def __init__(self, db: AsyncSession):
        self.db = db

    async def get_project_summary(self, actor: Karyakar, group_by: str = None, filter_id: str = None):
        """
        Generates project summary statistics based on user role and group_by criteria.
        group_by can be 'xetra', 'mandal', 'sampark_karyakar', or 'family'.
        """
        
        # Base query for haribhakts
        # We need to filter by actor's scope
        query = select(Haribhakt)
        
        if actor.role in ["sant_nirdeshak", "sanyojak", "admin"]:
            # No scope restriction, but can filter by xetra_id if group_by is mandal
            if group_by == "mandal" and filter_id:
                query = query.where(Haribhakt.xetra_id == filter_id)
        elif actor.role == "nirdeshak":
            query = query.where(Haribhakt.xetra_id.in_(actor.xetra_ids))
            if group_by == "sampark_karyakar" and filter_id:
                query = query.where(Haribhakt.mandal_id == filter_id)
        elif actor.role in ["sah_nirdeshak", "mandal_sanchalak", "nirikshak"]:
            query = query.where(Haribhakt.mandal_id.in_(actor.mandal_ids))
            if group_by == "family" and filter_id:
                query = query.where(Haribhakt.sampark_karyakar_id == filter_id)
        elif actor.role == "sampark_karyakar":
            query = query.where(Haribhakt.sampark_karyakar_id == actor.id)
            group_by = "family" # Force family view for sampark karyakar
            
        result = await self.db.execute(query)
        haribhakts = result.scalars().all()
        
        # Now aggregate the data based on group_by
        summary = {}
        
        # Identify "New" members (e.g. joined in last 30 days)
        new_cutoff = datetime.utcnow() - timedelta(days=30)
        
        for h in haribhakts:
            # Determine the key for grouping
            key = "Unknown"
            key_name = "Unknown"
            contact = None
            
            if group_by == "xetra":
                key = h.xetra_id
            elif group_by == "mandal":
                key = h.mandal_id
            elif group_by == "sampark_karyakar":
                key = h.sampark_karyakar_id or "Unassigned"
            elif group_by == "family":
                # For family view, we only care about the family head (relation is null)
                # But we aggregate stats for the WHOLE family
                key = h.family_id
            
            if key not in summary:
                summary[key] = {
                    "id": key,
                    "name": "Loading...",
                    "total_families": set(),
                    "s_count": 0,
                    "s1_count": 0,
                    "g_count": 0,
                    "male_count": 0,
                    "female_count": 0,
                    "total_members": 0,
                    "new_count": 0,
                    "contact": None
                }
            
            s = summary[key]
            
            # Aggregate stats
            s["total_members"] += 1
            if h.gender == "Male": s["male_count"] += 1
            elif h.gender == "Female": s["female_count"] += 1
            
            if h.created_at and h.created_at >= new_cutoff:
                s["new_count"] += 1
                
            # Family related stats (grades are per family)
            if h.family_id:
                if h.family_id not in s["total_families"]:
                    s["total_families"].add(h.family_id)
                    # Count grades only once per family (usually from the head or sync'd)
                    if h.satsang_grade == "S": s["s_count"] += 1
                    elif h.satsang_grade == "S1": s["s1_count"] += 1
                    elif h.satsang_grade == "G": s["g_count"] += 1
                    
            # For family view, set the name to the head's name
            if group_by == "family" and (not h.relation):
                s["name"] = f"{h.full_name} {h.surname}"
                s["contact"] = {"mobile": h.mobile, "whatsapp": h.whatsapp}

        # Resolve names for groups
        final_list = []
        for key, s in summary.items():
            s["total_families"] = len(s["total_families"])
            
            if group_by == "xetra":
                x_res = await self.db.get(Xetra, key)
                s["name"] = x_res.name if x_res else f"Xetra {key}"
            elif group_by == "mandal":
                m_res = await self.db.get(Mandal, key)
                s["name"] = m_res.name if m_res else f"Mandal {key}"
            elif group_by == "sampark_karyakar":
                if key == "Unassigned":
                    s["name"] = "Unassigned"
                else:
                    k_res = await self.db.get(Karyakar, key)
                    s["name"] = k_res.name if k_res else f"Karyakar {key}"
                    if k_res:
                        s["contact"] = {"mobile": k_res.phone, "whatsapp": k_res.phone} # Assuming phone is used for both
            
            final_list.append(s)
            
        return final_list

    async def get_data_summary(self, actor: Karyakar, group_by: str = None, filter_id: str = None):
        """
        Generates niyam-based data summary statistics (Gharmandir, Arati, Thal) based on user role.
        """
        query = select(Haribhakt)
        
        if actor.role in ["sant_nirdeshak", "sanyojak", "admin"]:
            if group_by == "mandal" and filter_id:
                query = query.where(Haribhakt.xetra_id == filter_id)
        elif actor.role == "nirdeshak":
            query = query.where(Haribhakt.xetra_id.in_(actor.xetra_ids))
            if group_by == "sampark_karyakar" and filter_id:
                query = query.where(Haribhakt.mandal_id == filter_id)
        elif actor.role in ["sah_nirdeshak", "mandal_sanchalak", "nirikshak"]:
            query = query.where(Haribhakt.mandal_id.in_(actor.mandal_ids))
            if group_by == "family" and filter_id:
                query = query.where(Haribhakt.sampark_karyakar_id == filter_id)
        elif actor.role == "sampark_karyakar":
            query = query.where(Haribhakt.sampark_karyakar_id == actor.id)
            group_by = "family"
            
        result = await self.db.execute(query)
        haribhakts = result.scalars().all()
        
        summary = {}
        
        for h in haribhakts:
            key = "Unknown"
            if group_by == "xetra": key = h.xetra_id
            elif group_by == "mandal": key = h.mandal_id
            elif group_by == "sampark_karyakar": key = h.sampark_karyakar_id or "Unassigned"
            elif group_by == "family": key = h.family_id
            
            if key not in summary:
                summary[key] = {
                    "id": key,
                    "name": "Loading...",
                    "processed_families": set(),
                    "total_families": 0,
                    "gm_yes": 0, "gm_no": 0,
                    "gm_type_baps": 0, "gm_type_baps_other": 0, "gm_type_other_baps": 0,
                    "arati_yes": 0, "arati_no": 0, "arati_1": 0, "arati_2": 0, "arati_3": 0,
                    "thal_yes": 0, "thal_no": 0, "thal_1": 0, "thal_2": 0, "thal_3": 0,
                    "contact": None
                }
            
            s = summary[key]
            
            if h.family_id and h.family_id not in s["processed_families"]:
                s["processed_families"].add(h.family_id)
                s["total_families"] += 1
                
                # Gharmandir
                if h.ghar_mandir == "No": s["gm_no"] += 1
                else: 
                    s["gm_yes"] += 1
                    if h.ghar_mandir == "Only BAPS": s["gm_type_baps"] += 1
                    elif h.ghar_mandir == "BAPS in Center + Other": s["gm_type_baps_other"] += 1
                    elif h.ghar_mandir == "Other in Center + BAPS": s["gm_type_other_baps"] += 1
                
                # Arati
                if h.arati == "No" or not h.arati: s["arati_no"] += 1
                else:
                    s["arati_yes"] += 1
                    if h.arati == "Morning" or h.arati == "Evening": s["arati_1"] += 1
                    elif h.arati == "Morning & Evening": s["arati_2"] += 1
                
                # Thal
                if h.thal == "No" or not h.thal: s["thal_no"] += 1
                else:
                    s["thal_yes"] += 1
                    if h.thal == "1": s["thal_1"] += 1
                    elif h.thal == "2": s["thal_2"] += 1
                    elif h.thal == "3": s["thal_3"] += 1
                    elif h.thal == "Yes": s["thal_1"] += 1

            if group_by == "family" and (not h.relation):
                s["name"] = f"{h.full_name} {h.surname}"
                s["contact"] = {"mobile": h.mobile, "whatsapp": h.whatsapp}

        final_list = []
        for key, s in summary.items():
            if "processed_families" in s: del s["processed_families"]
            
            if group_by == "xetra":
                x_res = await self.db.get(Xetra, key)
                s["name"] = x_res.name if x_res else f"Xetra {key}"
            elif group_by == "mandal":
                m_res = await self.db.get(Mandal, key)
                s["name"] = m_res.name if m_res else f"Mandal {key}"
            elif group_by == "sampark_karyakar":
                if key == "Unassigned": s["name"] = "Unassigned"
                else:
                    k_res = await self.db.get(Karyakar, key)
                    s["name"] = k_res.name if k_res else f"Karyakar {key}"
                    if k_res: s["contact"] = {"mobile": k_res.phone, "whatsapp": k_res.phone}
            
            final_list.append(s)
            
        return final_list
