import asyncio
import os
from sqlalchemy import text
from sqlalchemy.ext.asyncio import create_async_engine

DATABASE_URL = "postgresql+asyncpg://postgres:baps123@localhost:5432/baps_parivar_db"

async def check_and_fix():
    engine = create_async_engine(DATABASE_URL)
    try:
        async with engine.begin() as conn:
            # List of columns to check and add (column_name, data_type)
            columns_to_add = [
                ('akshar_purushottam_in_ghar_mandir', 'VARCHAR(10)'),
                ('designation', 'VARCHAR(100)'),
                ('occupation_type', 'VARCHAR(50)'),
                ('education_type', 'VARCHAR(50)'),
                ('alternate_whatsapp', 'VARCHAR(10)'),
                ('member_id', 'VARCHAR(50)'),
                ('family_id', 'VARCHAR(50)'),
                ('business_description', 'TEXT'),
                ('education_info', 'TEXT'),
                ('talent', 'TEXT'),
                ('skill', 'JSON'),
                ('vehicle', 'JSON'),
                ('dharmada_id', 'VARCHAR(50)'),
                ('dharmada_status', 'VARCHAR(20)'),
                ('mandal_type', 'VARCHAR(50)'),
                ('ghar_number', 'VARCHAR(50)'),
                ('society_name', 'VARCHAR(200)'),
                ('landmark', 'TEXT'),
                ('state', 'VARCHAR(100)'),
                ('country', 'VARCHAR(100)'),
                ('ghar_mandir', 'VARCHAR(10)'),
                ('arati', 'VARCHAR(50)'),
                ('thal', 'VARCHAR(50)'),
                ('relation', 'VARCHAR(50)'),
                ('daily_vachnamrut', 'VARCHAR(20)'),
                ('ghar_sabha_regularity', 'VARCHAR(20)'),
                ('ghar_sabha_days', 'VARCHAR(10)'),
                ('ravisabha_regularity', 'VARCHAR(20)'),
                ('parasabha_regularity', 'VARCHAR(20)'),
                ('ghar_sabha_present', 'VARCHAR(10)'),
                ('daily_arati_regularity', 'VARCHAR(20)'),
                ('daily_arati_times', 'VARCHAR(20)'),
                ('ashtak', 'VARCHAR(20)'),
                ('ashtak_times', 'VARCHAR(20)'),
                ('watching_cinema', 'VARCHAR(10)'),
                ('eating_onion_garlic', 'VARCHAR(10)'),
                ('eating_hing', 'VARCHAR(10)'),
                ('eating_outside', 'VARCHAR(10)'),
                ('chesta', 'VARCHAR(20)'),
                ('kanthi', 'VARCHAR(5)'),
                ('personal_mandal_id', 'VARCHAR(50)'),
                ('status_reason', 'VARCHAR(50)'),
                ('status_note', 'TEXT'),
                ('ssp_passing_year', 'VARCHAR(20)'),
                ('satsang_grade', 'VARCHAR(10)'),
                ('ssp_number', 'VARCHAR(50)'),
                ('special_note', 'TEXT'),
                ('last_updated_by', 'VARCHAR(200)'),
                ('is_out_of_city', 'BOOLEAN DEFAULT FALSE'),
                ('is_nri', 'BOOLEAN DEFAULT FALSE'),
                ('satsang_grade_is_overridden', 'BOOLEAN DEFAULT FALSE'),
                ('transfer_status', 'VARCHAR(20) DEFAULT \'accepted\''),
                ('swaminarayan_prakash', 'BOOLEAN DEFAULT FALSE'),
                ('premvati', 'BOOLEAN DEFAULT FALSE'),
                ('bal_prakash', 'BOOLEAN DEFAULT FALSE'),
                ('bliss', 'BOOLEAN DEFAULT FALSE'),
                ('daily_swami_vato', 'BOOLEAN DEFAULT FALSE'),
                ('ghar_sabha', 'BOOLEAN DEFAULT FALSE'),
                ('daily_arati', 'BOOLEAN DEFAULT FALSE'),
                ('daily_tilak', 'BOOLEAN DEFAULT FALSE'),
                ('ravisabha', 'BOOLEAN DEFAULT FALSE'),
                ('parasabha', 'BOOLEAN DEFAULT FALSE'),
                ('daily_pooja', 'BOOLEAN DEFAULT FALSE'),
            ]

            for col_name, col_type in columns_to_add:
                print(f"Checking for column '{col_name}' in table 'haribhakts'...")
                result = await conn.execute(text(f"""
                    SELECT column_name 
                    FROM information_schema.columns 
                    WHERE table_name='haribhakts' AND column_name='{col_name}';
                """))
                column = result.fetchone()
                
                if not column:
                    print(f"Column '{col_name}' missing. Adding it...")
                    await conn.execute(text(f"ALTER TABLE haribhakts ADD COLUMN {col_name} {col_type};"))
                    print(f"Column '{col_name}' added successfully.")
                else:
                    print(f"Column '{col_name}' already exists.")
            
            print("\nDatabase schema check completed.")
    except Exception as e:
        print(f"Error during database fix: {e}")
            
    await engine.dispose()

if __name__ == "__main__":
    asyncio.run(check_and_fix())
