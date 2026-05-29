from fastapi import HTTPException, status
from sqlalchemy.ext.asyncio import AsyncSession
from repositories.haribhakt_repo import HaribhaktRepository
from models.haribhakt import Haribhakt
from models.karyakar import Karyakar

class HaribhaktService:
    def __init__(self, db: AsyncSession):
        self.db = db
        self.repo = HaribhaktRepository(db)

    def calculate_satsang_grade(self, haribhakt_data: dict, family_members: list[dict]) -> str:
        """
        S = More than 1 person doing all (or 1 person if family size is 1)
        S1 = Exactly 1 person doing all (if family size > 1), or Bal/Balika karyakar present
        G = Otherwise
        """
        # If any member of the family has the override flag set, we respect their override.
        # Wait, the grade should be synced. We'll handle sync in create/update.
        # Here we just calculate the base system grade.
        
        all_members = family_members + [haribhakt_data]
        
        def is_perfect(m):
            return (
                m.get("kanthi") == "Yes" and
                (m.get("daily_pooja") is True or m.get("daily_pooja") == "Yes") and
                m.get("ravisabha_regularity") == "Regular" and
                m.get("parasabha_regularity") == "Regular" and
                m.get("ghar_mandir") in ("Only BAPS", "BAPS only", "BAPS Only") and
                m.get("arati") not in (None, "", "No") and 
                m.get("thal") not in (None, "", "No") and
                m.get("daily_vachnamrut") in ("niyamit", "Regular") and
                (m.get("daily_swami_vato") is True or m.get("daily_swami_vato") in ("Yes", "Regular"))
            )

        perfect_count = sum(1 for m in all_members if is_perfect(m))
        
        # Check for Bal/Balika registered karyakar
        def is_bal_karyakar(m):
            designation = m.get("satsang_karyakar")
            if designation in ("Bal Mandal Sanchalak", "Balika Mandal Sanchalak"):
                return True
            
            bal_designations = {
                "Vyavasthapak", "Sah ayojak", "Sayojak", "Sah sanyojak", 
                "Nirdeshak", "Sah nirdeshak", "Nirixak", "Mandal sanchalak", "Sah sanchalak"
            }
            balika_designations = {
                "Balika coordinator", "Vyavasthapak", "Sah ayojak", "Sayojak", "Sah sanyojak", 
                "Nirdeshak", "Sah nirdeshak", "Nirixak", "Mandal sanchalak", "Sah sanchalak"
            }
            if designation in bal_designations or designation in balika_designations:
                return True

            wing = (m.get("wing") or "").lower()
            if wing in ("bal", "balika"):
                if designation not in (None, "", "No") or m.get("karyakar_id"):
                    return True
            return False

        has_bal_karyakar = any(is_bal_karyakar(m) for m in all_members)
        
        if len(all_members) == 1:
            if perfect_count == 1:
                return "S"
            if has_bal_karyakar:
                return "S1"
            return "G"
            
        if perfect_count > 1:
            return "S"
            
        if perfect_count == 1 or has_bal_karyakar:
            return "S1"
            
        return "G"

    async def get_all(self, actor: Karyakar, filters: dict = None) -> list[Haribhakt]:
        if not filters:
            filters = {}
            
        # Restriction: Only Sant Nirdeshak can see inactive members
        if actor.role != "sant_nirdeshak":
            filters['status'] = 'active'

        # Optimize: pass base filters to repo
        if filters.get('all'):
            pass # Global access, skip role scoping
        elif actor.role == "sant_nirdeshak":
            pass # See all
        elif actor.role == "sanyojak":
            # Sanyojak sees all for now as they are global in this project
            pass
        elif actor.role == "nirdeshak":
            # Nirdeshak is xetra-specific.
            filters['xetra_id'] = actor.xetra_ids if actor.xetra_ids else ["NONE"]
        elif actor.role in ["sah_nirdeshak", "mandal_sanchalak", "nirikshak"]:
            filters['mandal_id'] = actor.mandal_ids if actor.mandal_ids else ["NONE"]
        elif actor.role == "sampark_karyakar":
            filters['sampark_karyakar_id'] = actor.id


        # Transfer visibility: 
        # By default, only see 'accepted' members in normal list.
        # But for 'pending' transfers, the destination mandal sanchalak should see them.
        if filters.get('view') == 'incoming_transfers':
            if actor.role not in ['mandal_sanchalak', 'nirikshak']:
                raise HTTPException(status_code=403, detail="You are not authorized to view incoming transfers")
            filters['transfer_status'] = 'pending'
            # mandal_id is already filtered above by role for sanchalak/nirikshak
        elif 'transfer_status' not in filters:
            filters['transfer_status'] = 'accepted'
            
        return await self.repo.get_all(filters)

    async def get_by_id(self, haribhakt_id: str, actor: Karyakar = None) -> Haribhakt:
        haribhakt = await self.repo.get_by_id(haribhakt_id)
        if not haribhakt:
            raise HTTPException(status_code=404, detail="Haribhakt not found")
        
        # Restriction: Only Sant Nirdeshak can access inactive members
        if haribhakt.status == "inactive" and (not actor or actor.role != "sant_nirdeshak"):
            raise HTTPException(status_code=403, detail="Inactive Haribhakt profile can only be accessed by Sant Nirdeshak")
            
        return haribhakt

    async def create(self, haribhakt_data, actor: Karyakar) -> Haribhakt:
        # Restriction: Only allowed roles can create
        allowed_roles = ['sant_nirdeshak', 'mandal_sanchalak', 'nirikshak', 'sampark_karyakar']
        if actor.role not in allowed_roles:
            raise HTTPException(status_code=403, detail="You do not have permission to add new families")

        data = haribhakt_data.model_dump()
        
        # Clean up empty strings to None for optional foreign keys/IDs
        for field in ['sampark_karyakar_id', 'personal_mandal_id', 'family_id']:
            if field in data and not data[field]:
                data[field] = None

        
        # Scope validation: can they create in this xetra/mandal?
        if actor.role not in ['sant_nirdeshak', 'sanyojak']:
            mandal_id = data.get('mandal_id')
            xetra_id = data.get('xetra_id')
            
            if actor.role == 'nirdeshak':
                if xetra_id not in actor.xetra_ids:
                    raise HTTPException(status_code=403, detail="You can only create Haribhakts in your assigned Xetra")
            elif actor.role in ['sah_nirdeshak', 'mandal_sanchalak', 'nirikshak']:
                if mandal_id not in actor.mandal_ids:
                    raise HTTPException(status_code=403, detail="You can only create Haribhakts in your assigned Mandal")
            elif actor.role == 'sampark_karyakar':
                if data.get('sampark_karyakar_id') != actor.id:
                    raise HTTPException(status_code=403, detail="You can only create Haribhakts assigned to yourself")

        # Generate missing system fields
        if not data.get('person_id'):
            import time
            # Use milliseconds for better uniqueness
            data['person_id'] = f"P{int(time.time() * 1000)}"
        if not data.get('form_id'):
            data['form_id'] = f"F{data.get('id', 'NEW').replace('hb_', '')}"

        # Logic to link with existing family if needed
        family_id = data.get('family_id')
        if family_id:
            # If we're adding a member to an existing family or creating one,
            # ensure that if any existing member has NO family_id, we link them.
            # This is critical for the UI to show the connection.
            # (Note: In a more complex system, we'd handle this via a Family model)
            pass

        # Fetch family members to calculate grade
        family_members = []
        if family_id:
            members = await self.repo.get_by_family_id(family_id)
            family_members = [m.__dict__ for m in members]
            
        is_overridden = data.get('satsang_grade_is_overridden', False) or any(m.get('satsang_grade_is_overridden') for m in family_members)
        
        if not is_overridden:
            new_grade = self.calculate_satsang_grade(data, family_members)
            data['satsang_grade'] = new_grade
            
            if family_id:
                for member_model in members:
                    member_model.satsang_grade = new_grade
                    await self.repo.update(member_model)
        elif not data.get('satsang_grade'):
            # Inherit from family if overridden
            existing_grade = next((m.get('satsang_grade') for m in family_members if m.get('satsang_grade')), "G")
            data['satsang_grade'] = existing_grade
            
        data['last_updated_by'] = actor.name
        
        haribhakt = Haribhakt(**data)
        return await self.repo.create(haribhakt)
    async def update(self, haribhakt_id: str, update_data, actor: Karyakar) -> Haribhakt:
        # Restriction: Only allowed roles can update profile
        allowed_roles = ['sant_nirdeshak', 'mandal_sanchalak', 'nirikshak', 'sampark_karyakar']
        if actor.role not in allowed_roles:
            raise HTTPException(status_code=403, detail="You do not have permission to edit profiles")

        haribhakt = await self.get_by_id(haribhakt_id, actor)
        
        # Scope validation for existing haribhakt
        if actor.role not in ['sant_nirdeshak', 'sanyojak']:
            if actor.role == 'nirdeshak':
                if haribhakt.xetra_id not in actor.xetra_ids:
                    raise HTTPException(status_code=403, detail="You can only update Haribhakts in your assigned Xetra")
            elif actor.role in ['sah_nirdeshak', 'mandal_sanchalak', 'nirikshak']:
                if haribhakt.mandal_id not in actor.mandal_ids:
                    raise HTTPException(status_code=403, detail="You can only update Haribhakts in your assigned Mandal")
            elif actor.role == 'sampark_karyakar':
                if haribhakt.sampark_karyakar_id != actor.id:
                    raise HTTPException(status_code=403, detail="You can only update Haribhakts assigned to yourself")

        old_sampark_karyakar_id = haribhakt.sampark_karyakar_id
        old_mandal_id = haribhakt.mandal_id

        data = update_data.model_dump(exclude_unset=True)
        
        # Clean up empty strings to None for optional foreign keys/IDs
        for field in ['sampark_karyakar_id', 'personal_mandal_id', 'family_id']:
            if field in data and not data[field]:
                data[field] = None
                
        if 'family_id' in data and data['family_id'] != haribhakt.family_id:
            new_family_id = data['family_id']
            if new_family_id:
                new_family_members = await self.repo.get_by_family_id(new_family_id)
                if new_family_members:
                    ref = new_family_members[0]
                    haribhakt.xetra_id = ref.xetra_id
                    haribhakt.mandal_id = ref.mandal_id
                    haribhakt.wing = ref.wing
                    haribhakt.sampark_karyakar_id = ref.sampark_karyakar_id
                    haribhakt.ghar_number = ref.ghar_number
                    haribhakt.society_name = ref.society_name
                    haribhakt.landmark = ref.landmark
                    haribhakt.area = ref.area
                    haribhakt.pin_code = ref.pin_code
                    haribhakt.country = ref.country
                    haribhakt.state = ref.state
                    haribhakt.city = ref.city
                    haribhakt.ghar_mandir = ref.ghar_mandir
                    haribhakt.akshar_purushottam_in_ghar_mandir = ref.akshar_purushottam_in_ghar_mandir
                    haribhakt.thal = ref.thal
                    haribhakt.arati = ref.arati
                    haribhakt.swaminarayan_prakash = ref.swaminarayan_prakash
                    haribhakt.premvati = ref.premvati
                    haribhakt.bal_prakash = ref.bal_prakash
                    haribhakt.bliss = ref.bliss
                    haribhakt.ghar_sabha = ref.ghar_sabha

        for key, value in data.items():
            setattr(haribhakt, key, value)

        family_members = []
        if haribhakt.family_id:
            members = await self.repo.get_by_family_id(haribhakt.family_id)
            family_members = [m.__dict__ for m in members if m.id != haribhakt.id]
            
        # Check if the override flag is set on any member of the family
        is_overridden = haribhakt.satsang_grade_is_overridden or any(m.get('satsang_grade_is_overridden') for m in family_members)
        
        # If the incoming data explicitly changes the grade, we assume it's a manual override
        if 'satsang_grade' in data:
            if data['satsang_grade'] != "Select":
                haribhakt.satsang_grade_is_overridden = True
                is_overridden = True
                if haribhakt.family_id:
                    for member_model in members:
                        if member_model.id != haribhakt.id:
                            member_model.satsang_grade = data['satsang_grade']
                            member_model.satsang_grade_is_overridden = True
                            await self.repo.update(member_model)
            else:
                haribhakt.satsang_grade_is_overridden = False
                is_overridden = False
                if haribhakt.family_id:
                    for member_model in members:
                        member_model.satsang_grade_is_overridden = False
                        await self.repo.update(member_model)

        if not is_overridden:
            new_grade = self.calculate_satsang_grade(haribhakt.__dict__, family_members)
            haribhakt.satsang_grade = new_grade
            
            # Sync to other family members if we calculated it
            if haribhakt.family_id:
                for member_model in members:
                    if member_model.id != haribhakt.id:
                        member_model.satsang_grade = new_grade
                        await self.repo.update(member_model)

        # Check for changes and generate announcements
        new_sampark_karyakar_id = haribhakt.sampark_karyakar_id
        new_mandal_id = haribhakt.mandal_id

        import uuid
        from models.announcement import Announcement
        from sqlalchemy import select

        if old_sampark_karyakar_id != new_sampark_karyakar_id:
            karyakar_name = "None"
            if new_sampark_karyakar_id:
                result = await self.db.execute(select(Karyakar).where(Karyakar.id == new_sampark_karyakar_id))
                k = result.scalars().first()
                if k:
                    karyakar_name = f"{k.name} ({k.karyakar_number})"
            
            old_karyakar_name = "None"
            if old_sampark_karyakar_id:
                result = await self.db.execute(select(Karyakar).where(Karyakar.id == old_sampark_karyakar_id))
                k = result.scalars().first()
                if k:
                    old_karyakar_name = f"{k.name} ({k.karyakar_number})"

            # 1. Notify the new Sampark Karyakar directly
            if new_sampark_karyakar_id:
                ann = Announcement(
                    id=f"ann_{uuid.uuid4().hex}",
                    title="New Haribhakt Assigned",
                    content=f"Haribhakt {haribhakt.full_name} has been assigned to you for sampark.",
                    target_karyakar_id=new_sampark_karyakar_id
                )
                self.db.add(ann)

            # 2. Notify the old Sampark Karyakar directly
            if old_sampark_karyakar_id:
                ann = Announcement(
                    id=f"ann_{uuid.uuid4().hex}",
                    title="Haribhakt Deassigned",
                    content=f"Haribhakt {haribhakt.full_name} has been deassigned from you.",
                    target_karyakar_id=old_sampark_karyakar_id
                )
                self.db.add(ann)

            # 3. Notify the Mandal sanchalaks and nirikshaks
            ann = Announcement(
                id=f"ann_{uuid.uuid4().hex}",
                title="Haribhakt Assignment Changed",
                content=f"Haribhakt {haribhakt.full_name} in your Mandal has been reassigned from Sampark Karyakar {old_karyakar_name} to {karyakar_name}.",
                target_mandal_id=haribhakt.mandal_id,
                target_wing=haribhakt.wing,
                target_roles="mandal_sanchalak,nirikshak"
            )
            self.db.add(ann)

        if old_mandal_id != new_mandal_id:
            from models.mandal import Mandal
            mandal_name = "None"
            if new_mandal_id:
                result = await self.db.execute(select(Mandal).where(Mandal.id == new_mandal_id))
                m = result.scalars().first()
                if m:
                    mandal_name = m.name
            
            old_mandal_name = "None"
            if old_mandal_id:
                result = await self.db.execute(select(Mandal).where(Mandal.id == old_mandal_id))
                m = result.scalars().first()
                if m:
                    old_mandal_name = m.name

            # 1. Notify the new Mandal sanchalaks and nirikshaks
            if new_mandal_id:
                ann = Announcement(
                    id=f"ann_{uuid.uuid4().hex}",
                    title="Haribhakt Transferred In",
                    content=f"Haribhakt {haribhakt.full_name} has been transferred to your Mandal from Mandal {old_mandal_name}.",
                    target_mandal_id=new_mandal_id,
                    target_wing=haribhakt.wing,
                    target_roles="mandal_sanchalak,nirikshak"
                )
                self.db.add(ann)

            # 2. Notify the old Mandal sanchalaks and nirikshaks
            if old_mandal_id:
                ann = Announcement(
                    id=f"ann_{uuid.uuid4().hex}",
                    title="Haribhakt Transferred Out",
                    content=f"Haribhakt {haribhakt.full_name} has been transferred out of your Mandal to Mandal {mandal_name}.",
                    target_mandal_id=old_mandal_id,
                    target_wing=haribhakt.wing,
                    target_roles="mandal_sanchalak,nirikshak"
                )
                self.db.add(ann)

            # 3. Notify the assigned Sampark Karyakar
            if haribhakt.sampark_karyakar_id:
                ann = Announcement(
                    id=f"ann_{uuid.uuid4().hex}",
                    title="Assigned Haribhakt Mandal Changed",
                    content=f"Your assigned Haribhakt {haribhakt.full_name}'s mandal has been changed from Mandal {old_mandal_name} to Mandal {mandal_name}.",
                    target_karyakar_id=haribhakt.sampark_karyakar_id
                )
                self.db.add(ann)

        haribhakt.last_updated_by = actor.name
        
        return await self.repo.update(haribhakt)

    async def toggle_status(self, haribhakt_id: str, actor: Karyakar) -> Haribhakt:
        haribhakt = await self.get_by_id(haribhakt_id, actor)
        
        # Scope validation
        if actor.role not in ['sant_nirdeshak', 'sanyojak']:
            if actor.role == 'nirdeshak':
                if haribhakt.xetra_id not in actor.xetra_ids:
                    raise HTTPException(status_code=403, detail="You can only manage Haribhakts in your assigned Xetra")
            elif actor.role in ['sah_nirdeshak', 'mandal_sanchalak', 'nirikshak']:
                if haribhakt.mandal_id not in actor.mandal_ids:
                    raise HTTPException(status_code=403, detail="You can only manage Haribhakts in your assigned Mandal")
            elif actor.role == 'sampark_karyakar':
                if haribhakt.sampark_karyakar_id != actor.id:
                    raise HTTPException(status_code=403, detail="You can only manage Haribhakts assigned to yourself")

        haribhakt.status = "inactive" if haribhakt.status == "active" else "active"
        haribhakt.last_updated_by = actor.name
        return await self.repo.update(haribhakt)

    async def handle_family_action(self, family_id: str, action: str, actor: Karyakar, extra_data: dict = None) -> int:
        members = await self.repo.get_by_family_id(family_id)
        
        # Restriction: Only Sant Nirdeshak can interact with inactive members
        if actor.role != "sant_nirdeshak":
            members = [m for m in members if m.status == "active"]

        if not members:
            raise HTTPException(status_code=404, detail="Family not found, empty, or you don't have access to its inactive members")

        # Basic role check for bulk actions
        if actor.role == "sampark_karyakar":
             # Optional: Check if all members are assigned to them
             if any(m.sampark_karyakar_id != actor.id for m in members):
                 raise HTTPException(status_code=403, detail="You can only manage families fully assigned to yourself")

        count = 0
        for m in members:
            if action == "mark_inactive":
                m.status = "inactive"
                if extra_data:
                    m.status_reason = extra_data.get('status_reason')
                    m.status_note = extra_data.get('status_note')
            elif action == "mark_foreign":
                import uuid
                from models.haribhakt import Haribhakt as HaribhaktModel
                
                # Clone as NRI/Foreign active member
                cloned = HaribhaktModel(
                    id=f"hb_foreign_{uuid.uuid4().hex[:10]}",
                    family_id=m.family_id,
                    member_id=m.member_id,
                    person_id=f"{m.person_id}_F",
                    form_id=m.form_id,
                    full_name=m.full_name,
                    father_name=m.father_name,
                    surname=m.surname,
                    avatar=m.avatar,
                    mobile=m.mobile,
                    whatsapp=m.whatsapp,
                    alternate_number=m.alternate_number,
                    alternate_whatsapp=m.alternate_whatsapp,
                    email=m.email,
                    area=m.area,
                    city=m.city,
                    pin_code=m.pin_code,
                    dob=m.dob,
                    wing=m.wing,
                    gender=m.gender,
                    blood_group=m.blood_group,
                    occupation=m.occupation,
                    occupation_type=m.occupation_type,
                    designation=m.designation,
                    business_description=m.business_description,
                    education=m.education,
                    education_type=m.education_type,
                    education_info=m.education_info,
                    talent=m.talent,
                    skill=m.skill,
                    vehicle=m.vehicle,
                    can_give_vehicle_in_seva=m.can_give_vehicle_in_seva,
                    resident="Foreign",
                    foreign_address=extra_data.get('foreign_address') if extra_data else m.foreign_address,
                    dharmada_id=m.dharmada_id,
                    dharmada_status=m.dharmada_status,
                    satsang_karyakar=m.satsang_karyakar,
                    satsang_since=m.satsang_since,
                    every_ekadashi=m.every_ekadashi,
                    last_satsang_exam=m.last_satsang_exam,
                    karyakar_id=m.karyakar_id,
                    mandal_type=m.mandal_type,
                    ghar_number=extra_data.get('ghar_number') if extra_data and 'ghar_number' in extra_data else m.ghar_number,
                    society_name=extra_data.get('society_name') if extra_data and 'society_name' in extra_data else m.society_name,
                    landmark=extra_data.get('landmark') if extra_data and 'landmark' in extra_data else m.landmark,
                    state=extra_data.get('state') if extra_data and 'state' in extra_data else m.state,
                    country=extra_data.get('country') if extra_data and 'country' in extra_data else m.country,
                    ghar_mandir=extra_data.get('ghar_mandir') if extra_data and 'ghar_mandir' in extra_data else m.ghar_mandir,
                    akshar_purushottam_in_ghar_mandir=m.akshar_purushottam_in_ghar_mandir,
                    arati=m.arati,
                    thal=m.thal,
                    swaminarayan_prakash=extra_data.get('swaminarayan_prakash') if extra_data and 'swaminarayan_prakash' in extra_data else m.swaminarayan_prakash,
                    premvati=extra_data.get('premvati') if extra_data and 'premvati' in extra_data else m.premvati,
                    bal_prakash=extra_data.get('bal_prakash') if extra_data and 'bal_prakash' in extra_data else m.bal_prakash,
                    bliss=extra_data.get('bliss') if extra_data and 'bliss' in extra_data else m.bliss,
                    relation=m.relation,
                    daily_vachnamrut=m.daily_vachnamrut,
                    daily_swami_vato=m.daily_swami_vato,
                    ghar_sabha=extra_data.get('ghar_sabha') if extra_data and 'ghar_sabha' in extra_data else m.ghar_sabha,
                    ghar_sabha_regularity=m.ghar_sabha_regularity,
                    ghar_sabha_days=m.ghar_sabha_days,
                    daily_arati=m.daily_arati,
                    daily_tilak=m.daily_tilak,
                    ravisabha=m.ravisabha,
                    ravisabha_regularity=m.ravisabha_regularity,
                    parasabha=m.parasabha,
                    parasabha_regularity=m.parasabha_regularity,
                    daily_pooja=m.daily_pooja,
                    ghar_sabha_present=m.ghar_sabha_present,
                    daily_arati_regularity=m.daily_arati_regularity,
                    daily_arati_times=m.daily_arati_times,
                    ashtak=m.ashtak,
                    ashtak_times=m.ashtak_times,
                    watching_cinema=m.watching_cinema,
                    eating_onion_garlic=m.eating_onion_garlic,
                    eating_hing=m.eating_hing,
                    eating_outside=m.eating_outside,
                    chesta=m.chesta,
                    kanthi=m.kanthi,
                    mandal_id=m.mandal_id,
                    personal_mandal_id=m.personal_mandal_id,
                    xetra_id=m.xetra_id,
                    sampark_karyakar_id=m.sampark_karyakar_id,
                    s_grade=m.s_grade,
                    is_nri=True,
                    status="active",
                    ssp_passing_year=m.ssp_passing_year,
                    satsang_grade=m.satsang_grade,
                    ssp_number=m.ssp_number,
                    special_note=m.special_note,
                    satsang_grade_is_overridden=m.satsang_grade_is_overridden,
                    transfer_status=m.transfer_status,
                    last_updated_by=actor.name
                )
                
                # Update original as Inactive
                m.status = "inactive"
                m.status_reason = "relocated_foreign"
                m.status_note = f"Marked as Foreign Family by {actor.name}. Relocated to foreign country."
                
                self.db.add(cloned)
            elif action == "move_mandal" and extra_data:
                old_mandal_id = m.mandal_id
                new_mandal_id = extra_data.get('mandal_id')
                m.mandal_id = new_mandal_id
                m.xetra_id = extra_data.get('xetra_id')
                m.transfer_status = "pending"
                
                if old_mandal_id != new_mandal_id:
                    from models.mandal import Mandal
                    from sqlalchemy import select
                    import uuid
                    from models.announcement import Announcement
                    
                    mandal_name = "None"
                    if new_mandal_id:
                        result = await self.db.execute(select(Mandal).where(Mandal.id == new_mandal_id))
                        mandal_obj = result.scalars().first()
                        if mandal_obj:
                            mandal_name = mandal_obj.name
                    
                    old_mandal_name = "None"
                    if old_mandal_id:
                        result = await self.db.execute(select(Mandal).where(Mandal.id == old_mandal_id))
                        mandal_obj = result.scalars().first()
                        if mandal_obj:
                            old_mandal_name = mandal_obj.name

                    # 1. Notify the new Mandal sanchalaks and nirikshaks
                    if new_mandal_id:
                        ann = Announcement(
                            id=f"ann_{uuid.uuid4().hex}",
                            title="Haribhakt Family Transferred In",
                            content=f"Haribhakt {m.full_name}'s family is being transferred to your Mandal from Mandal {old_mandal_name} (Transfer Pending).",
                            target_mandal_id=new_mandal_id,
                            target_wing=m.wing,
                            target_roles="mandal_sanchalak,nirikshak"
                        )
                        self.db.add(ann)

                    # 2. Notify the old Mandal sanchalaks and nirikshaks
                    if old_mandal_id:
                        ann = Announcement(
                            id=f"ann_{uuid.uuid4().hex}",
                            title="Haribhakt Family Transferred Out",
                            content=f"Haribhakt {m.full_name}'s family is being transferred out of your Mandal to Mandal {mandal_name} (Transfer Pending).",
                            target_mandal_id=old_mandal_id,
                            target_wing=m.wing,
                            target_roles="mandal_sanchalak,nirikshak"
                        )
                        self.db.add(ann)

                    # 3. Notify the assigned Sampark Karyakar
                    if m.sampark_karyakar_id:
                        ann = Announcement(
                            id=f"ann_{uuid.uuid4().hex}",
                            title="Assigned Haribhakt Family Transfer",
                            content=f"Your assigned Haribhakt {m.full_name}'s family is being transferred from Mandal {old_mandal_name} to Mandal {mandal_name} (Transfer Pending).",
                            target_karyakar_id=m.sampark_karyakar_id
                        )
                        self.db.add(ann)
            elif action == "accept_transfer":
                m.transfer_status = "accepted"
                if extra_data and 'sampark_karyakar_id' in extra_data:
                    m.sampark_karyakar_id = extra_data.get('sampark_karyakar_id')
            elif action == "separate_family" and extra_data:
                import uuid
                # Generate new family ID and clear relation to make them Mukhya
                new_family_id = f"fam_{uuid.uuid4().hex[:10]}"
                m.family_id = new_family_id
                m.relation = None
                
                # Update family level details
                m.ghar_number = extra_data.get('ghar_number') if 'ghar_number' in extra_data else m.ghar_number
                m.society_name = extra_data.get('society_name') if 'society_name' in extra_data else m.society_name
                m.landmark = extra_data.get('landmark') if 'landmark' in extra_data else m.landmark
                m.area = extra_data.get('area') if 'area' in extra_data else m.area
                m.pin_code = extra_data.get('pin_code') if 'pin_code' in extra_data else m.pin_code
                m.taluka = extra_data.get('taluka') if 'taluka' in extra_data else m.taluka
                m.country = extra_data.get('country') if 'country' in extra_data else m.country
                m.state = extra_data.get('state') if 'state' in extra_data else m.state
                m.city = extra_data.get('city') if 'city' in extra_data else m.city
                m.ghar_mandir = extra_data.get('ghar_mandir') if 'ghar_mandir' in extra_data else m.ghar_mandir
                m.arati = extra_data.get('arati') if 'arati' in extra_data else m.arati
                m.swaminarayan_prakash = extra_data.get('swaminarayan_prakash') if 'swaminarayan_prakash' in extra_data else m.swaminarayan_prakash
                m.premvati = extra_data.get('premvati') if 'premvati' in extra_data else m.premvati
                m.bal_prakash = extra_data.get('bal_prakash') if 'bal_prakash' in extra_data else m.bal_prakash
                m.bliss = extra_data.get('bliss') if 'bliss' in extra_data else m.bliss
                m.ghar_sabha = extra_data.get('ghar_sabha') if 'ghar_sabha' in extra_data else m.ghar_sabha
            elif action == "delete":
                # Soft delete with reason
                m.status = "deleted"
                if extra_data:
                    m.status_reason = extra_data.get('status_reason')
                    m.status_note = extra_data.get('status_note')
            
            m.last_updated_by = actor.name
            await self.repo.update(m)
            count += 1
        
        return count
    async def delete(self, haribhakt_id: str, actor: Karyakar) -> bool:
        haribhakt = await self.get_by_id(haribhakt_id, actor)
        
        # Scope validation
        if actor.role not in ['sant_nirdeshak', 'sanyojak']:
            if actor.role == 'nirdeshak':
                if haribhakt.xetra_id not in actor.xetra_ids:
                    raise HTTPException(status_code=403, detail="You can only delete Haribhakts in your assigned Xetra")
            elif actor.role in ['sah_nirdeshak', 'mandal_sanchalak', 'nirikshak']:
                if haribhakt.mandal_id not in actor.mandal_ids:
                    raise HTTPException(status_code=403, detail="You can only delete Haribhakts in your assigned Mandal")
            elif actor.role == 'sampark_karyakar':
                if haribhakt.sampark_karyakar_id != actor.id:
                    raise HTTPException(status_code=403, detail="You can only delete Haribhakts assigned to yourself")

        return await self.repo.delete(haribhakt_id)
