--
-- PostgreSQL database dump
--

\restrict KUhZ1LkhRK3KDvK3AYQ4qo0QfX5KY1HPybB2XAtgizVLa0C8NOSR2nxsoOKoCbD

-- Dumped from database version 16.13
-- Dumped by pg_dump version 16.13

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: announcements; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.announcements (
    id character varying(50) NOT NULL,
    title character varying(200) NOT NULL,
    content text NOT NULL,
    created_at timestamp without time zone DEFAULT now(),
    target_karyakar_id character varying(50),
    target_mandal_id character varying(20),
    target_wing character varying(20),
    target_roles character varying(100)
);


ALTER TABLE public.announcements OWNER TO postgres;

--
-- Name: haribhakts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.haribhakts (
    id character varying(50) NOT NULL,
    family_id character varying(50),
    member_id character varying(50),
    person_id character varying(20) NOT NULL,
    form_id character varying(20) NOT NULL,
    full_name character varying(200) NOT NULL,
    father_name character varying(100) NOT NULL,
    surname character varying(100) NOT NULL,
    avatar text,
    mobile character varying(20) NOT NULL,
    whatsapp character varying(20) NOT NULL,
    alternate_number character varying(20),
    alternate_whatsapp character varying(10),
    email character varying(150) NOT NULL,
    area character varying(100) NOT NULL,
    city character varying(100) NOT NULL,
    pin_code character varying(10) NOT NULL,
    dob character varying(20) NOT NULL,
    wing character varying(20),
    gender character varying(10),
    blood_group character varying(5),
    occupation character varying(100),
    occupation_type character varying(50),
    designation character varying(100),
    business_description text,
    education character varying(100),
    education_type character varying(50),
    education_info text,
    talent text,
    skill json,
    vehicle json,
    can_give_vehicle_in_seva boolean NOT NULL,
    is_out_of_city boolean NOT NULL,
    resident character varying(100),
    foreign_address text,
    dharmada_id character varying(50),
    dharmada_status character varying(20),
    satsang_karyakar character varying(100),
    satsang_since character varying(20),
    every_ekadashi character varying(10),
    last_satsang_exam character varying(50),
    karyakar_id character varying(50),
    mandal_type character varying(50),
    ghar_number character varying(50),
    society_name character varying(200),
    landmark text,
    state character varying(100),
    country character varying(100),
    ghar_mandir character varying(10),
    akshar_purushottam_in_ghar_mandir character varying(10),
    arati character varying(50),
    thal character varying(50),
    swaminarayan_prakash boolean NOT NULL,
    premvati boolean NOT NULL,
    bal_prakash boolean NOT NULL,
    bliss boolean NOT NULL,
    relation character varying(50),
    daily_vachnamrut character varying(20),
    daily_swami_vato boolean NOT NULL,
    ghar_sabha boolean NOT NULL,
    ghar_sabha_regularity character varying(20),
    ghar_sabha_days character varying(10),
    daily_arati boolean NOT NULL,
    daily_tilak boolean NOT NULL,
    ravisabha boolean NOT NULL,
    ravisabha_regularity character varying(20),
    parasabha boolean NOT NULL,
    parasabha_regularity character varying(20),
    daily_pooja boolean NOT NULL,
    ghar_sabha_present character varying(10),
    daily_arati_regularity character varying(20),
    daily_arati_times character varying(20),
    ashtak character varying(20),
    ashtak_times character varying(20),
    watching_cinema character varying(10),
    eating_onion_garlic character varying(10),
    eating_hing character varying(10),
    eating_outside character varying(10),
    chesta character varying(20),
    kanthi character varying(5),
    mandal_id character varying(20) NOT NULL,
    personal_mandal_id character varying(50),
    xetra_id character varying(10) NOT NULL,
    sampark_karyakar_id character varying(50),
    s_grade character varying(10) NOT NULL,
    is_nri boolean NOT NULL,
    status character varying(10) NOT NULL,
    status_reason character varying(50),
    status_note text,
    ssp_passing_year character varying(20),
    satsang_grade character varying(10),
    ssp_number character varying(50),
    special_note text,
    satsang_grade_is_overridden boolean NOT NULL,
    transfer_status character varying(20) NOT NULL,
    last_updated_by character varying(200),
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    last_updated_at timestamp without time zone
);


ALTER TABLE public.haribhakts OWNER TO postgres;

--
-- Name: karyakar_mandals; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.karyakar_mandals (
    karyakar_id character varying(50) NOT NULL,
    mandal_id character varying(20) NOT NULL
);


ALTER TABLE public.karyakar_mandals OWNER TO postgres;

--
-- Name: karyakar_xetras; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.karyakar_xetras (
    karyakar_id character varying(50) NOT NULL,
    xetra_id character varying(10) NOT NULL
);


ALTER TABLE public.karyakar_xetras OWNER TO postgres;

--
-- Name: karyakars; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.karyakars (
    id character varying(50) NOT NULL,
    karyakar_number character varying(20) NOT NULL,
    name character varying(150) NOT NULL,
    role character varying(30) NOT NULL,
    username character varying(100) NOT NULL,
    password_hash character varying(255) NOT NULL,
    avatar text,
    phone character varying(20) NOT NULL,
    email character varying(150) NOT NULL,
    parent_karyakar_id character varying(50),
    birthday character varying(20),
    joined_at character varying(20) NOT NULL,
    wing character varying(20),
    status character varying(10) DEFAULT 'active'::character varying NOT NULL
);


ALTER TABLE public.karyakars OWNER TO postgres;

--
-- Name: mandals; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.mandals (
    id character varying(20) NOT NULL,
    xetra_id character varying(10) NOT NULL,
    name character varying(100) NOT NULL,
    wing character varying(20) NOT NULL
);


ALTER TABLE public.mandals OWNER TO postgres;

--
-- Name: xetras; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.xetras (
    id character varying(10) NOT NULL,
    name character varying(50) NOT NULL
);


ALTER TABLE public.xetras OWNER TO postgres;

--
-- Data for Name: announcements; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.announcements (id, title, content, created_at, target_karyakar_id, target_mandal_id, target_wing, target_roles) FROM stdin;
ann_fac6993ab4294456abcc0af5acee3a9f	New Haribhakt Assigned	Haribhakt MockHead 1 has been assigned to you for sampark.	2026-05-23 04:57:21.444312	k_1779512167068	\N	\N	\N
ann_ead4ecec1f7c4d5492b791176794be75	Haribhakt Assignment Changed	Haribhakt MockHead 1 in your Mandal has been reassigned from Sampark Karyakar None to Suresh (Sk-284).	2026-05-23 04:57:21.444312	\N	m_0083	sanyukt	mandal_sanchalak,nirikshak
ann_bc5e97863de3496c9ebaaec371b0145c	New Haribhakt Assigned	Haribhakt MockHead 3 has been assigned to you for sampark.	2026-05-23 04:57:24.313958	k_1779512167068	\N	\N	\N
ann_020ebc5514be459ea9ae18d788fe1a65	Haribhakt Assignment Changed	Haribhakt MockHead 3 in your Mandal has been reassigned from Sampark Karyakar None to Suresh (Sk-284).	2026-05-23 04:57:24.313958	\N	m_0083	sanyukt	mandal_sanchalak,nirikshak
ann_916dfad3da5643a9b5fb38338758978f	New Haribhakt Assigned	Haribhakt MockSon 6 has been assigned to you for sampark.	2026-05-23 05:10:17.603686	demo_sk_m1_0	\N	\N	\N
ann_bf3be0f5d5924434925a39601477f50d	Haribhakt Assignment Changed	Haribhakt MockSon 6 in your Mandal has been reassigned from Sampark Karyakar None to Sampark Karyakar 1 (DEMO-SK_M1_0).	2026-05-23 05:10:17.603686	\N	m_0083	yuvak	mandal_sanchalak,nirikshak
ann_f8b6d020da874c19be104d2bbdbea76b	New Haribhakt Assigned	Haribhakt MockHead 7 has been assigned to you for sampark.	2026-05-23 05:10:19.381866	demo_sk_m1_0	\N	\N	\N
ann_fd756ae4a4d541678a09ae8281ae540c	Haribhakt Assignment Changed	Haribhakt MockHead 7 in your Mandal has been reassigned from Sampark Karyakar None to Sampark Karyakar 1 (DEMO-SK_M1_0).	2026-05-23 05:10:19.381866	\N	m_0083	sanyukt	mandal_sanchalak,nirikshak
ann_fc60482537d14c41b5708bfd44b3a2ac	New Haribhakt Assigned	Haribhakt MockHead 10 has been assigned to you for sampark.	2026-05-23 05:10:22.284494	demo_sk_m1_0	\N	\N	\N
ann_e736485be2f84a1a8b9f34ec3cb9aafe	Haribhakt Assignment Changed	Haribhakt MockHead 10 in your Mandal has been reassigned from Sampark Karyakar None to Sampark Karyakar 1 (DEMO-SK_M1_0).	2026-05-23 05:10:22.284494	\N	m_0083	sanyukt	mandal_sanchalak,nirikshak
\.


--
-- Data for Name: haribhakts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.haribhakts (id, family_id, member_id, person_id, form_id, full_name, father_name, surname, avatar, mobile, whatsapp, alternate_number, alternate_whatsapp, email, area, city, pin_code, dob, wing, gender, blood_group, occupation, occupation_type, designation, business_description, education, education_type, education_info, talent, skill, vehicle, can_give_vehicle_in_seva, is_out_of_city, resident, foreign_address, dharmada_id, dharmada_status, satsang_karyakar, satsang_since, every_ekadashi, last_satsang_exam, karyakar_id, mandal_type, ghar_number, society_name, landmark, state, country, ghar_mandir, akshar_purushottam_in_ghar_mandir, arati, thal, swaminarayan_prakash, premvati, bal_prakash, bliss, relation, daily_vachnamrut, daily_swami_vato, ghar_sabha, ghar_sabha_regularity, ghar_sabha_days, daily_arati, daily_tilak, ravisabha, ravisabha_regularity, parasabha, parasabha_regularity, daily_pooja, ghar_sabha_present, daily_arati_regularity, daily_arati_times, ashtak, ashtak_times, watching_cinema, eating_onion_garlic, eating_hing, eating_outside, chesta, kanthi, mandal_id, personal_mandal_id, xetra_id, sampark_karyakar_id, s_grade, is_nri, status, status_reason, status_note, ssp_passing_year, satsang_grade, ssp_number, special_note, satsang_grade_is_overridden, transfer_status, last_updated_by, created_at, last_updated_at) FROM stdin;
hb_2	\N	M-00002	PID-00002	FORM-00002	Mahesh	Father	Mehta	\N	9876500002	9876500002	\N	\N	hb2@baps.org	Atladra	Vadodara	390001	1990-01-01	sanyukt	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0084	\N	x1	k_5	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_3	\N	M-00003	PID-00003	FORM-00003	Rajesh	Father	Desai	\N	9876500003	9876500003	\N	\N	hb3@baps.org	Kalali	Vadodara	390001	1990-01-01	sanyukt	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0085	\N	x1	k_7	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_4	\N	M-00004	PID-00004	FORM-00004	Dinesh	Father	Joshi	\N	9876500004	9876500004	\N	\N	hb4@baps.org	Narayanwadi	Vadodara	390001	1990-01-01	sanyukt	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0086	\N	x1	k_9	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_5	\N	M-00005	PID-00005	FORM-00005	Bhavesh	Father	Dave	\N	9876500005	9876500005	\N	\N	hb5@baps.org	Niramay	Vadodara	390001	1990-01-01	sanyukt	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0087	\N	x1	k_11	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_6	\N	M-00006	PID-00006	FORM-00006	Jayesh	Father	Trivedi	\N	9876500006	9876500006	\N	\N	hb6@baps.org	P.Sw.Nagar	Vadodara	390001	1990-01-01	sanyukt	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0088	\N	x1	k_13	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_7	\N	M-00007	PID-00007	FORM-00007	Nilesh	Father	Bhatt	\N	9876500007	9876500007	\N	\N	hb7@baps.org	Racecourse - 1	Vadodara	390001	1990-01-01	sanyukt	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0089	\N	x1	k_15	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_8	\N	M-00008	PID-00008	FORM-00008	Hitesh	Father	Pandya	\N	9876500008	9876500008	\N	\N	hb8@baps.org	Racecourse - 2	Vadodara	390001	1990-01-01	sanyukt	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0090	\N	x1	k_17	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_9	\N	M-00009	PID-00009	FORM-00009	Paresh	Father	Amin	\N	9876500009	9876500009	\N	\N	hb9@baps.org	Samta	Vadodara	390001	1990-01-01	sanyukt	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0091	\N	x1	k_19	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_10	\N	M-00010	PID-00010	FORM-00010	Mukesh	Father	Patel	\N	9876500010	9876500010	\N	\N	hb10@baps.org	Shyamvilla	Vadodara	390001	1990-01-01	sanyukt	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0092	\N	x1	k_21	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_11	\N	M-00011	PID-00011	FORM-00011	Alpesh	Father	Shah	\N	9876500011	9876500011	\N	\N	hb11@baps.org	Vadsar	Vadodara	390001	1990-01-01	sanyukt	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0093	\N	x1	k_23	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_12	\N	M-00012	PID-00012	FORM-00012	Kiran	Father	Mehta	\N	9876500012	9876500012	\N	\N	hb12@baps.org	Danteshwar	Vadodara	390001	1990-01-01	sanyukt	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0094	\N	x2	k_26	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_13	\N	M-00013	PID-00013	FORM-00013	Meena	Father	Desai	\N	9876500013	9876500013	\N	\N	hb13@baps.org	Gayatrinagar	Vadodara	390001	1990-01-01	sanyukt	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0095	\N	x2	k_28	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_14	\N	M-00014	PID-00014	FORM-00014	Sunita	Father	Joshi	\N	9876500014	9876500014	\N	\N	hb14@baps.org	Indrapuri - 1	Vadodara	390001	1990-01-01	sanyukt	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0096	\N	x2	k_30	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_15	\N	M-00015	PID-00015	FORM-00015	Hetal	Father	Dave	\N	9876500015	9876500015	\N	\N	hb15@baps.org	Indrapuri - 2	Vadodara	390001	1990-01-01	sanyukt	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0097	\N	x2	k_32	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_16	\N	M-00016	PID-00016	FORM-00016	Nisha	Father	Trivedi	\N	9876500016	9876500016	\N	\N	hb16@baps.org	Makarpura	Vadodara	390001	1990-01-01	sanyukt	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0098	\N	x2	k_34	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_17	\N	M-00017	PID-00017	FORM-00017	Priya	Father	Bhatt	\N	9876500017	9876500017	\N	\N	hb17@baps.org	Maneja	Vadodara	390001	1990-01-01	sanyukt	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0099	\N	x2	k_36	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_18	\N	M-00018	PID-00018	FORM-00018	Kavita	Father	Pandya	\N	9876500018	9876500018	\N	\N	hb18@baps.org	Manjalpur - 1	Vadodara	390001	1990-01-01	sanyukt	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0100	\N	x2	k_38	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_19	\N	M-00019	PID-00019	FORM-00019	Rekha	Father	Amin	\N	9876500019	9876500019	\N	\N	hb19@baps.org	Manjalpur - 2	Vadodara	390001	1990-01-01	sanyukt	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0101	\N	x2	k_40	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_20	\N	M-00020	PID-00020	FORM-00020	Sonal	Father	Patel	\N	9876500020	9876500020	\N	\N	hb20@baps.org	Shiyabaug	Vadodara	390001	1990-01-01	sanyukt	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0102	\N	x2	k_42	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_21	\N	M-00021	PID-00021	FORM-00021	Jyoti	Father	Shah	\N	9876500021	9876500021	\N	\N	hb21@baps.org	Tarsali	Vadodara	390001	1990-01-01	sanyukt	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0103	\N	x2	k_44	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_22	\N	M-00022	PID-00022	FORM-00022	Asha	Father	Mehta	\N	9876500022	9876500022	\N	\N	hb22@baps.org	Wadi	Vadodara	390001	1990-01-01	sanyukt	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0104	\N	x2	k_46	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_23	\N	M-00023	PID-00023	FORM-00023	Mina	Father	Desai	\N	9876500023	9876500023	\N	\N	hb23@baps.org	Bajwa	Vadodara	390001	1990-01-01	sanyukt	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0105	\N	x3	k_49	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_24	\N	M-00024	PID-00024	FORM-00024	Ramesh	Father	Joshi	\N	9876500024	9876500024	\N	\N	hb24@baps.org	Chhani Jakatnaka - 1	Vadodara	390001	1990-01-01	sanyukt	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0106	\N	x3	k_51	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_25	\N	M-00025	PID-00025	FORM-00025	Suresh	Father	Dave	\N	9876500025	9876500025	\N	\N	hb25@baps.org	Chhani Jakatnaka - 2	Vadodara	390001	1990-01-01	sanyukt	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0107	\N	x3	k_53	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_26	\N	M-00026	PID-00026	FORM-00026	Mahesh	Father	Trivedi	\N	9876500026	9876500026	\N	\N	hb26@baps.org	Chhanigam	Vadodara	390001	1990-01-01	sanyukt	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0108	\N	x3	k_55	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_27	\N	M-00027	PID-00027	FORM-00027	Rajesh	Father	Bhatt	\N	9876500027	9876500027	\N	\N	hb27@baps.org	Gorwa	Vadodara	390001	1990-01-01	sanyukt	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0109	\N	x3	k_57	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_28	\N	M-00028	PID-00028	FORM-00028	Dinesh	Father	Pandya	\N	9876500028	9876500028	\N	\N	hb28@baps.org	Gotri	Vadodara	390001	1990-01-01	sanyukt	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0110	\N	x3	k_59	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_29	\N	M-00029	PID-00029	FORM-00029	Bhavesh	Father	Amin	\N	9876500029	9876500029	\N	\N	hb29@baps.org	Karelibaug - 1	Vadodara	390001	1990-01-01	sanyukt	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0111	\N	x3	k_61	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_30	\N	M-00030	PID-00030	FORM-00030	Jayesh	Father	Patel	\N	9876500030	9876500030	\N	\N	hb30@baps.org	Karelibaug - 2	Vadodara	390001	1990-01-01	sanyukt	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0112	\N	x3	k_63	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_31	\N	M-00031	PID-00031	FORM-00031	Nilesh	Father	Shah	\N	9876500031	9876500031	\N	\N	hb31@baps.org	Panchvati	Vadodara	390001	1990-01-01	sanyukt	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0113	\N	x3	k_65	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_32	\N	M-00032	PID-00032	FORM-00032	Hitesh	Father	Mehta	\N	9876500032	9876500032	\N	\N	hb32@baps.org	Sama	Vadodara	390001	1990-01-01	sanyukt	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0114	\N	x3	k_67	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_33	\N	M-00033	PID-00033	FORM-00033	Paresh	Father	Desai	\N	9876500033	9876500033	\N	\N	hb33@baps.org	Sardarnagar	Vadodara	390001	1990-01-01	sanyukt	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0115	\N	x3	k_69	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_34	\N	M-00034	PID-00034	FORM-00034	Mukesh	Father	Joshi	\N	9876500034	9876500034	\N	\N	hb34@baps.org	Sevasi	Vadodara	390001	1990-01-01	sanyukt	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0116	\N	x3	k_71	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_35	\N	M-00035	PID-00035	FORM-00035	Alpesh	Father	Dave	\N	9876500035	9876500035	\N	\N	hb35@baps.org	Racecourse	Vadodara	390001	1990-01-01	yuvak	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0117	\N	x1	k_74	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_36	\N	M-00036	PID-00036	FORM-00036	Kiran	Father	Trivedi	\N	9876500036	9876500036	\N	\N	hb36@baps.org	Samta	Vadodara	390001	1990-01-01	yuvak	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0118	\N	x1	k_76	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_37	\N	M-00037	PID-00037	FORM-00037	Meena	Father	Bhatt	\N	9876500037	9876500037	\N	\N	hb37@baps.org	Niramay	Vadodara	390001	1990-01-01	yuvak	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0119	\N	x1	k_78	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_38	\N	M-00038	PID-00038	FORM-00038	Sunita	Father	Pandya	\N	9876500038	9876500038	\N	\N	hb38@baps.org	Narayanwadi	Vadodara	390001	1990-01-01	yuvak	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0120	\N	x1	k_80	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_39	\N	M-00039	PID-00039	FORM-00039	Hetal	Father	Amin	\N	9876500039	9876500039	\N	\N	hb39@baps.org	Atladara	Vadodara	390001	1990-01-01	yuvak	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0121	\N	x1	k_82	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_40	\N	M-00040	PID-00040	FORM-00040	Nisha	Father	Patel	\N	9876500040	9876500040	\N	\N	hb40@baps.org	P.Sw.Nagar	Vadodara	390001	1990-01-01	yuvak	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0122	\N	x1	k_84	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_41	\N	M-00041	PID-00041	FORM-00041	Priya	Father	Shah	\N	9876500041	9876500041	\N	\N	hb41@baps.org	Vadsar	Vadodara	390001	1990-01-01	yuvak	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0123	\N	x1	k_86	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_42	\N	M-00042	PID-00042	FORM-00042	Kavita	Father	Mehta	\N	9876500042	9876500042	\N	\N	hb42@baps.org	Manjalpur	Vadodara	390001	1990-01-01	yuvak	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0124	\N	x2	k_89	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_43	\N	M-00043	PID-00043	FORM-00043	Rekha	Father	Desai	\N	9876500043	9876500043	\N	\N	hb43@baps.org	Indrapuri	Vadodara	390001	1990-01-01	yuvak	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0125	\N	x2	k_91	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_44	\N	M-00044	PID-00044	FORM-00044	Sonal	Father	Joshi	\N	9876500044	9876500044	\N	\N	hb44@baps.org	Danteshwar	Vadodara	390001	1990-01-01	yuvak	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0126	\N	x2	k_93	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_45	\N	M-00045	PID-00045	FORM-00045	Jyoti	Father	Dave	\N	9876500045	9876500045	\N	\N	hb45@baps.org	Makarpura	Vadodara	390001	1990-01-01	yuvak	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0127	\N	x2	k_95	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_46	\N	M-00046	PID-00046	FORM-00046	Asha	Father	Trivedi	\N	9876500046	9876500046	\N	\N	hb46@baps.org	Tarsali	Vadodara	390001	1990-01-01	yuvak	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0128	\N	x2	k_97	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_47	\N	M-00047	PID-00047	FORM-00047	Mina	Father	Bhatt	\N	9876500047	9876500047	\N	\N	hb47@baps.org	Maneja	Vadodara	390001	1990-01-01	yuvak	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0129	\N	x2	k_99	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_48	\N	M-00048	PID-00048	FORM-00048	Ramesh	Father	Pandya	\N	9876500048	9876500048	\N	\N	hb48@baps.org	Shiyabaug	Vadodara	390001	1990-01-01	yuvak	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0130	\N	x2	k_101	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_49	\N	M-00049	PID-00049	FORM-00049	Suresh	Father	Amin	\N	9876500049	9876500049	\N	\N	hb49@baps.org	Wadi	Vadodara	390001	1990-01-01	yuvak	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0131	\N	x2	k_103	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_50	\N	M-00050	PID-00050	FORM-00050	Mahesh	Father	Patel	\N	9876500050	9876500050	\N	\N	hb50@baps.org	Gorwa	Vadodara	390001	1990-01-01	yuvak	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0132	\N	x3	k_106	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_51	\N	M-00051	PID-00051	FORM-00051	Rajesh	Father	Shah	\N	9876500051	9876500051	\N	\N	hb51@baps.org	Gotri	Vadodara	390001	1990-01-01	yuvak	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0133	\N	x3	k_108	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_52	\N	M-00052	PID-00052	FORM-00052	Dinesh	Father	Mehta	\N	9876500052	9876500052	\N	\N	hb52@baps.org	Karelibaug	Vadodara	390001	1990-01-01	yuvak	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0134	\N	x3	k_110	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_53	\N	M-00053	PID-00053	FORM-00053	Bhavesh	Father	Desai	\N	9876500053	9876500053	\N	\N	hb53@baps.org	Sama	Vadodara	390001	1990-01-01	yuvak	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0135	\N	x3	k_112	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_54	\N	M-00054	PID-00054	FORM-00054	Jayesh	Father	Joshi	\N	9876500054	9876500054	\N	\N	hb54@baps.org	Chhanigam	Vadodara	390001	1990-01-01	yuvak	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0136	\N	x3	k_114	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_55	\N	M-00055	PID-00055	FORM-00055	Nilesh	Father	Dave	\N	9876500055	9876500055	\N	\N	hb55@baps.org	Sardarnagar	Vadodara	390001	1990-01-01	yuvak	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0137	\N	x3	k_116	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_56	\N	M-00056	PID-00056	FORM-00056	Hitesh	Father	Trivedi	\N	9876500056	9876500056	\N	\N	hb56@baps.org	Chhani Jakatnaka	Vadodara	390001	1990-01-01	yuvak	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0138	\N	x3	k_118	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_57	\N	M-00057	PID-00057	FORM-00057	Paresh	Father	Bhatt	\N	9876500057	9876500057	\N	\N	hb57@baps.org	Atladara	Vadodara	390001	1990-01-01	yuvati	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0139	\N	x1	k_121	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_58	\N	M-00058	PID-00058	FORM-00058	Mukesh	Father	Pandya	\N	9876500058	9876500058	\N	\N	hb58@baps.org	Kalali - PR	Vadodara	390001	1990-01-01	yuvati	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0140	\N	x1	k_123	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_59	\N	M-00059	PID-00059	FORM-00059	Alpesh	Father	Amin	\N	9876500059	9876500059	\N	\N	hb59@baps.org	Niramay	Vadodara	390001	1990-01-01	yuvati	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0141	\N	x1	k_125	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_60	\N	M-00060	PID-00060	FORM-00060	Kiran	Father	Patel	\N	9876500060	9876500060	\N	\N	hb60@baps.org	P.Sw.Nagar	Vadodara	390001	1990-01-01	yuvati	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0142	\N	x1	k_127	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_61	\N	M-00061	PID-00061	FORM-00061	Meena	Father	Shah	\N	9876500061	9876500061	\N	\N	hb61@baps.org	Racecourse	Vadodara	390001	1990-01-01	yuvati	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0143	\N	x1	k_129	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_62	\N	M-00062	PID-00062	FORM-00062	Sunita	Father	Mehta	\N	9876500062	9876500062	\N	\N	hb62@baps.org	Samta	Vadodara	390001	1990-01-01	yuvati	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0144	\N	x1	k_131	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_63	\N	M-00063	PID-00063	FORM-00063	Hetal	Father	Desai	\N	9876500063	9876500063	\N	\N	hb63@baps.org	Shyamvilla	Vadodara	390001	1990-01-01	yuvati	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0145	\N	x1	k_133	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_64	\N	M-00064	PID-00064	FORM-00064	Nisha	Father	Joshi	\N	9876500064	9876500064	\N	\N	hb64@baps.org	Vadsar	Vadodara	390001	1990-01-01	yuvati	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0146	\N	x1	k_135	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_65	\N	M-00065	PID-00065	FORM-00065	Priya	Father	Dave	\N	9876500065	9876500065	\N	\N	hb65@baps.org	Gayatrinagar	Vadodara	390001	1990-01-01	yuvati	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0147	\N	x2	k_138	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_66	\N	M-00066	PID-00066	FORM-00066	Kavita	Father	Trivedi	\N	9876500066	9876500066	\N	\N	hb66@baps.org	Indrapuri - 1	Vadodara	390001	1990-01-01	yuvati	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0148	\N	x2	k_140	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_67	\N	M-00067	PID-00067	FORM-00067	Rekha	Father	Bhatt	\N	9876500067	9876500067	\N	\N	hb67@baps.org	Indrapuri - 3	Vadodara	390001	1990-01-01	yuvati	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0149	\N	x2	k_142	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_68	\N	M-00068	PID-00068	FORM-00068	Sonal	Father	Pandya	\N	9876500068	9876500068	\N	\N	hb68@baps.org	Makarpura - 1	Vadodara	390001	1990-01-01	yuvati	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0150	\N	x2	k_144	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_69	\N	M-00069	PID-00069	FORM-00069	Jyoti	Father	Amin	\N	9876500069	9876500069	\N	\N	hb69@baps.org	Makarpura - 2	Vadodara	390001	1990-01-01	yuvati	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0151	\N	x2	k_146	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_70	\N	M-00070	PID-00070	FORM-00070	Asha	Father	Patel	\N	9876500070	9876500070	\N	\N	hb70@baps.org	Maneja	Vadodara	390001	1990-01-01	yuvati	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0152	\N	x2	k_148	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_71	\N	M-00071	PID-00071	FORM-00071	Mina	Father	Shah	\N	9876500071	9876500071	\N	\N	hb71@baps.org	Manjalpur - 1	Vadodara	390001	1990-01-01	yuvati	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0153	\N	x2	k_150	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_72	\N	M-00072	PID-00072	FORM-00072	Ramesh	Father	Mehta	\N	9876500072	9876500072	\N	\N	hb72@baps.org	Manjalpur - 2	Vadodara	390001	1990-01-01	yuvati	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0154	\N	x2	k_152	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_73	\N	M-00073	PID-00073	FORM-00073	Suresh	Father	Desai	\N	9876500073	9876500073	\N	\N	hb73@baps.org	Manjalpur - 3	Vadodara	390001	1990-01-01	yuvati	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0155	\N	x2	k_154	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_74	\N	M-00074	PID-00074	FORM-00074	Mahesh	Father	Joshi	\N	9876500074	9876500074	\N	\N	hb74@baps.org	Shiyabaug	Vadodara	390001	1990-01-01	yuvati	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0156	\N	x2	k_156	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_75	\N	M-00075	PID-00075	FORM-00075	Rajesh	Father	Dave	\N	9876500075	9876500075	\N	\N	hb75@baps.org	Tarsali	Vadodara	390001	1990-01-01	yuvati	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0157	\N	x2	k_158	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_76	\N	M-00076	PID-00076	FORM-00076	Dinesh	Father	Trivedi	\N	9876500076	9876500076	\N	\N	hb76@baps.org	Wadi - 1	Vadodara	390001	1990-01-01	yuvati	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0158	\N	x2	k_160	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_77	\N	M-00077	PID-00077	FORM-00077	Bhavesh	Father	Bhatt	\N	9876500077	9876500077	\N	\N	hb77@baps.org	Danteshwar	Vadodara	390001	1990-01-01	yuvati	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0159	\N	x2	k_162	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_78	\N	M-00078	PID-00078	FORM-00078	Jayesh	Father	Pandya	\N	9876500078	9876500078	\N	\N	hb78@baps.org	Karelibaug	Vadodara	390001	1990-01-01	yuvati	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0160	\N	x3	k_165	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_79	\N	M-00079	PID-00079	FORM-00079	Nilesh	Father	Amin	\N	9876500079	9876500079	\N	\N	hb79@baps.org	Sama	Vadodara	390001	1990-01-01	yuvati	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0161	\N	x3	k_167	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_80	\N	M-00080	PID-00080	FORM-00080	Hitesh	Father	Patel	\N	9876500080	9876500080	\N	\N	hb80@baps.org	Sardarnagar	Vadodara	390001	1990-01-01	yuvati	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0162	\N	x3	k_169	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_81	\N	M-00081	PID-00081	FORM-00081	Paresh	Father	Shah	\N	9876500081	9876500081	\N	\N	hb81@baps.org	Chhani Jakatnaka	Vadodara	390001	1990-01-01	yuvati	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0163	\N	x3	k_171	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_82	\N	M-00082	PID-00082	FORM-00082	Mukesh	Father	Mehta	\N	9876500082	9876500082	\N	\N	hb82@baps.org	Chhanigam	Vadodara	390001	1990-01-01	yuvati	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0164	\N	x3	k_173	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_83	\N	M-00083	PID-00083	FORM-00083	Alpesh	Father	Desai	\N	9876500083	9876500083	\N	\N	hb83@baps.org	Gorwa	Vadodara	390001	1990-01-01	yuvati	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0165	\N	x3	k_175	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_84	\N	M-00084	PID-00084	FORM-00084	Kiran	Father	Joshi	\N	9876500084	9876500084	\N	\N	hb84@baps.org	Gotri - 1	Vadodara	390001	1990-01-01	yuvati	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0166	\N	x3	k_177	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_85	\N	M-00085	PID-00085	FORM-00085	Meena	Father	Dave	\N	9876500085	9876500085	\N	\N	hb85@baps.org	Gotri - 2	Vadodara	390001	1990-01-01	yuvati	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0167	\N	x3	k_179	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_86	\N	M-00086	PID-00086	FORM-00086	Sunita	Father	Trivedi	\N	9876500086	9876500086	\N	\N	hb86@baps.org	P.Sw.Nagar - 1	Vadodara	390001	1990-01-01	mahila	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0001	\N	x1	k_182	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_87	\N	M-00087	PID-00087	FORM-00087	Hetal	Father	Bhatt	\N	9876500087	9876500087	\N	\N	hb87@baps.org	P.Sw.Nagar - 2	Vadodara	390001	1990-01-01	mahila	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0002	\N	x1	k_184	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_88	\N	M-00088	PID-00088	FORM-00088	Nisha	Father	Pandya	\N	9876500088	9876500088	\N	\N	hb88@baps.org	Niramay - 1	Vadodara	390001	1990-01-01	mahila	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0003	\N	x1	k_186	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_89	\N	M-00089	PID-00089	FORM-00089	Priya	Father	Amin	\N	9876500089	9876500089	\N	\N	hb89@baps.org	Niramay - 2	Vadodara	390001	1990-01-01	mahila	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0004	\N	x1	k_188	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_90	\N	M-00090	PID-00090	FORM-00090	Kavita	Father	Patel	\N	9876500090	9876500090	\N	\N	hb90@baps.org	Kalali - 1	Vadodara	390001	1990-01-01	mahila	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0005	\N	x1	k_190	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_91	\N	M-00091	PID-00091	FORM-00091	Rekha	Father	Shah	\N	9876500091	9876500091	\N	\N	hb91@baps.org	Kalali - 2	Vadodara	390001	1990-01-01	mahila	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0006	\N	x1	k_192	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_92	\N	M-00092	PID-00092	FORM-00092	Sonal	Father	Mehta	\N	9876500092	9876500092	\N	\N	hb92@baps.org	Vishwamitri Township	Vadodara	390001	1990-01-01	mahila	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0007	\N	x1	k_194	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_93	\N	M-00093	PID-00093	FORM-00093	Jyoti	Father	Desai	\N	9876500093	9876500093	\N	\N	hb93@baps.org	Racecourse - 1	Vadodara	390001	1990-01-01	mahila	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0008	\N	x1	k_196	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_94	\N	M-00094	PID-00094	FORM-00094	Asha	Father	Joshi	\N	9876500094	9876500094	\N	\N	hb94@baps.org	Racecourse - 2	Vadodara	390001	1990-01-01	mahila	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0009	\N	x1	k_198	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_95	\N	M-00095	PID-00095	FORM-00095	Mina	Father	Dave	\N	9876500095	9876500095	\N	\N	hb95@baps.org	Racecourse - 3	Vadodara	390001	1990-01-01	mahila	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0010	\N	x1	k_200	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_96	\N	M-00096	PID-00096	FORM-00096	Ramesh	Father	Trivedi	\N	9876500096	9876500096	\N	\N	hb96@baps.org	Racecourse - 4	Vadodara	390001	1990-01-01	mahila	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0011	\N	x1	k_202	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_97	\N	M-00097	PID-00097	FORM-00097	Suresh	Father	Bhatt	\N	9876500097	9876500097	\N	\N	hb97@baps.org	Racecourse - 5	Vadodara	390001	1990-01-01	mahila	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0012	\N	x1	k_204	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_98	\N	M-00098	PID-00098	FORM-00098	Mahesh	Father	Pandya	\N	9876500098	9876500098	\N	\N	hb98@baps.org	Samta	Vadodara	390001	1990-01-01	mahila	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0013	\N	x1	k_206	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_99	\N	M-00099	PID-00099	FORM-00099	Rajesh	Father	Amin	\N	9876500099	9876500099	\N	\N	hb99@baps.org	Harani	Vadodara	390001	1990-01-01	mahila	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0014	\N	x1	k_208	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_100	\N	M-00100	PID-00100	FORM-00100	Dinesh	Father	Patel	\N	9876500100	9876500100	\N	\N	hb100@baps.org	Atladara - 1	Vadodara	390001	1990-01-01	mahila	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0015	\N	x1	k_210	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_101	\N	M-00101	PID-00101	FORM-00101	Bhavesh	Father	Shah	\N	9876500101	9876500101	\N	\N	hb101@baps.org	Atladara - 2	Vadodara	390001	1990-01-01	mahila	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0016	\N	x1	k_212	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_102	\N	M-00102	PID-00102	FORM-00102	Jayesh	Father	Mehta	\N	9876500102	9876500102	\N	\N	hb102@baps.org	Atladara - 3	Vadodara	390001	1990-01-01	mahila	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0017	\N	x1	k_214	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_103	\N	M-00103	PID-00103	FORM-00103	Nilesh	Father	Desai	\N	9876500103	9876500103	\N	\N	hb103@baps.org	Ramlaxman - 1	Vadodara	390001	1990-01-01	mahila	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0018	\N	x1	k_216	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_104	\N	M-00104	PID-00104	FORM-00104	Hitesh	Father	Joshi	\N	9876500104	9876500104	\N	\N	hb104@baps.org	Ramlaxman - 2	Vadodara	390001	1990-01-01	mahila	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0019	\N	x1	k_218	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_105	\N	M-00105	PID-00105	FORM-00105	Paresh	Father	Dave	\N	9876500105	9876500105	\N	\N	hb105@baps.org	Vadsar	Vadodara	390001	1990-01-01	mahila	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0020	\N	x1	k_220	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_106	\N	M-00106	PID-00106	FORM-00106	Mukesh	Father	Trivedi	\N	9876500106	9876500106	\N	\N	hb106@baps.org	AvadhUpavan	Vadodara	390001	1990-01-01	mahila	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0021	\N	x1	k_222	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_107	\N	M-00107	PID-00107	FORM-00107	Alpesh	Father	Bhatt	\N	9876500107	9876500107	\N	\N	hb107@baps.org	Vrajdham	Vadodara	390001	1990-01-01	mahila	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0022	\N	x1	k_224	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_108	\N	M-00108	PID-00108	FORM-00108	Kiran	Father	Pandya	\N	9876500108	9876500108	\N	\N	hb108@baps.org	Vrundavan	Vadodara	390001	1990-01-01	mahila	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0023	\N	x1	k_226	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_109	\N	M-00109	PID-00109	FORM-00109	Meena	Father	Amin	\N	9876500109	9876500109	\N	\N	hb109@baps.org	Krishna Darshan	Vadodara	390001	1990-01-01	mahila	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0024	\N	x1	k_228	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_110	\N	M-00110	PID-00110	FORM-00110	Sunita	Father	Patel	\N	9876500110	9876500110	\N	\N	hb110@baps.org	Indrapuri - 1	Vadodara	390001	1990-01-01	mahila	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0025	\N	x2	k_231	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_111	\N	M-00111	PID-00111	FORM-00111	Hetal	Father	Shah	\N	9876500111	9876500111	\N	\N	hb111@baps.org	Indrapuri - 2	Vadodara	390001	1990-01-01	mahila	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0026	\N	x2	k_233	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_112	\N	M-00112	PID-00112	FORM-00112	Nisha	Father	Mehta	\N	9876500112	9876500112	\N	\N	hb112@baps.org	Indrapuri - 3	Vadodara	390001	1990-01-01	mahila	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0027	\N	x2	k_235	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_113	\N	M-00113	PID-00113	FORM-00113	Priya	Father	Desai	\N	9876500113	9876500113	\N	\N	hb113@baps.org	Indrapuri - 4	Vadodara	390001	1990-01-01	mahila	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0028	\N	x2	k_237	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_114	\N	M-00114	PID-00114	FORM-00114	Kavita	Father	Joshi	\N	9876500114	9876500114	\N	\N	hb114@baps.org	Kapurai	Vadodara	390001	1990-01-01	mahila	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0029	\N	x2	k_239	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_115	\N	M-00115	PID-00115	FORM-00115	Rekha	Father	Dave	\N	9876500115	9876500115	\N	\N	hb115@baps.org	Sayajipura	Vadodara	390001	1990-01-01	mahila	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0030	\N	x2	k_241	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_116	\N	M-00116	PID-00116	FORM-00116	Sonal	Father	Trivedi	\N	9876500116	9876500116	\N	\N	hb116@baps.org	Maneja	Vadodara	390001	1990-01-01	mahila	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0031	\N	x2	k_243	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_117	\N	M-00117	PID-00117	FORM-00117	Jyoti	Father	Bhatt	\N	9876500117	9876500117	\N	\N	hb117@baps.org	Manjalpur - 1	Vadodara	390001	1990-01-01	mahila	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0032	\N	x2	k_245	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_118	\N	M-00118	PID-00118	FORM-00118	Asha	Father	Pandya	\N	9876500118	9876500118	\N	\N	hb118@baps.org	Manjalpur - 2	Vadodara	390001	1990-01-01	mahila	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0033	\N	x2	k_247	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_119	\N	M-00119	PID-00119	FORM-00119	Mina	Father	Amin	\N	9876500119	9876500119	\N	\N	hb119@baps.org	Manjalpur - 3	Vadodara	390001	1990-01-01	mahila	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0034	\N	x2	k_249	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_120	\N	M-00120	PID-00120	FORM-00120	Ramesh	Father	Patel	\N	9876500120	9876500120	\N	\N	hb120@baps.org	Manjalpur - 4	Vadodara	390001	1990-01-01	mahila	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0035	\N	x2	k_251	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_121	\N	M-00121	PID-00121	FORM-00121	Suresh	Father	Shah	\N	9876500121	9876500121	\N	\N	hb121@baps.org	Manjalpur - 5	Vadodara	390001	1990-01-01	mahila	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0036	\N	x2	k_253	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_122	\N	M-00122	PID-00122	FORM-00122	Mahesh	Father	Mehta	\N	9876500122	9876500122	\N	\N	hb122@baps.org	GIDC - 1	Vadodara	390001	1990-01-01	mahila	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0037	\N	x2	k_255	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_123	\N	M-00123	PID-00123	FORM-00123	Rajesh	Father	Desai	\N	9876500123	9876500123	\N	\N	hb123@baps.org	GIDC - 2	Vadodara	390001	1990-01-01	mahila	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0038	\N	x2	k_257	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_124	\N	M-00124	PID-00124	FORM-00124	Dinesh	Father	Joshi	\N	9876500124	9876500124	\N	\N	hb124@baps.org	GIDC - 3	Vadodara	390001	1990-01-01	mahila	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0039	\N	x2	k_259	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_125	\N	M-00125	PID-00125	FORM-00125	Bhavesh	Father	Dave	\N	9876500125	9876500125	\N	\N	hb125@baps.org	GIDC - 4	Vadodara	390001	1990-01-01	mahila	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0040	\N	x2	k_261	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_126	\N	M-00126	PID-00126	FORM-00126	Jayesh	Father	Trivedi	\N	9876500126	9876500126	\N	\N	hb126@baps.org	Wadi - 1	Vadodara	390001	1990-01-01	mahila	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0041	\N	x2	k_263	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_127	\N	M-00127	PID-00127	FORM-00127	Nilesh	Father	Bhatt	\N	9876500127	9876500127	\N	\N	hb127@baps.org	Wadi - 2	Vadodara	390001	1990-01-01	mahila	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0042	\N	x2	k_265	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_128	\N	M-00128	PID-00128	FORM-00128	Hitesh	Father	Pandya	\N	9876500128	9876500128	\N	\N	hb128@baps.org	Shiyabaug - 1	Vadodara	390001	1990-01-01	mahila	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0043	\N	x2	k_267	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_129	\N	M-00129	PID-00129	FORM-00129	Paresh	Father	Amin	\N	9876500129	9876500129	\N	\N	hb129@baps.org	Shiyabaug - 2	Vadodara	390001	1990-01-01	mahila	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0044	\N	x2	k_269	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_130	\N	M-00130	PID-00130	FORM-00130	Mukesh	Father	Patel	\N	9876500130	9876500130	\N	\N	hb130@baps.org	Shiyabaug - 3	Vadodara	390001	1990-01-01	mahila	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0045	\N	x2	k_271	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_131	\N	M-00131	PID-00131	FORM-00131	Alpesh	Father	Shah	\N	9876500131	9876500131	\N	\N	hb131@baps.org	Shiyabaug - 4	Vadodara	390001	1990-01-01	mahila	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0046	\N	x2	k_273	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_132	\N	M-00132	PID-00132	FORM-00132	Kiran	Father	Mehta	\N	9876500132	9876500132	\N	\N	hb132@baps.org	Shiyabaug - 5	Vadodara	390001	1990-01-01	mahila	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0047	\N	x2	k_275	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_133	\N	M-00133	PID-00133	FORM-00133	Meena	Father	Desai	\N	9876500133	9876500133	\N	\N	hb133@baps.org	Danteshwar - 1	Vadodara	390001	1990-01-01	mahila	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0048	\N	x2	k_277	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_134	\N	M-00134	PID-00134	FORM-00134	Sunita	Father	Joshi	\N	9876500134	9876500134	\N	\N	hb134@baps.org	Danteshwar - 2	Vadodara	390001	1990-01-01	mahila	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0049	\N	x2	k_279	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_135	\N	M-00135	PID-00135	FORM-00135	Hetal	Father	Dave	\N	9876500135	9876500135	\N	\N	hb135@baps.org	Tarsali - 1	Vadodara	390001	1990-01-01	mahila	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0050	\N	x2	k_281	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_136	\N	M-00136	PID-00136	FORM-00136	Nisha	Father	Trivedi	\N	9876500136	9876500136	\N	\N	hb136@baps.org	Tarsali - 2	Vadodara	390001	1990-01-01	mahila	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0051	\N	x2	k_283	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_137	\N	M-00137	PID-00137	FORM-00137	Priya	Father	Bhatt	\N	9876500137	9876500137	\N	\N	hb137@baps.org	Makarpura - 1	Vadodara	390001	1990-01-01	mahila	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0052	\N	x2	k_285	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_138	\N	M-00138	PID-00138	FORM-00138	Kavita	Father	Pandya	\N	9876500138	9876500138	\N	\N	hb138@baps.org	Makarpura - 2	Vadodara	390001	1990-01-01	mahila	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0053	\N	x2	k_287	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_139	\N	M-00139	PID-00139	FORM-00139	Rekha	Father	Amin	\N	9876500139	9876500139	\N	\N	hb139@baps.org	Makarpura - 3	Vadodara	390001	1990-01-01	mahila	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0054	\N	x2	k_289	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_140	\N	M-00140	PID-00140	FORM-00140	Sonal	Father	Patel	\N	9876500140	9876500140	\N	\N	hb140@baps.org	Makarpura - 4	Vadodara	390001	1990-01-01	mahila	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0055	\N	x2	k_291	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_141	\N	M-00141	PID-00141	FORM-00141	Jyoti	Father	Shah	\N	9876500141	9876500141	\N	\N	hb141@baps.org	Gayatrinagar	Vadodara	390001	1990-01-01	mahila	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0056	\N	x2	k_293	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_142	\N	M-00142	PID-00142	FORM-00142	Asha	Father	Mehta	\N	9876500142	9876500142	\N	\N	hb142@baps.org	Sevasi - 1	Vadodara	390001	1990-01-01	mahila	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0057	\N	x3	k_296	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_143	\N	M-00143	PID-00143	FORM-00143	Mina	Father	Desai	\N	9876500143	9876500143	\N	\N	hb143@baps.org	Sevasi - 2	Vadodara	390001	1990-01-01	mahila	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0058	\N	x3	k_298	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_144	\N	M-00144	PID-00144	FORM-00144	Ramesh	Father	Joshi	\N	9876500144	9876500144	\N	\N	hb144@baps.org	Gotri - 1	Vadodara	390001	1990-01-01	mahila	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0059	\N	x3	k_300	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_145	\N	M-00145	PID-00145	FORM-00145	Suresh	Father	Dave	\N	9876500145	9876500145	\N	\N	hb145@baps.org	Gotri - 2	Vadodara	390001	1990-01-01	mahila	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0060	\N	x3	k_302	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_146	\N	M-00146	PID-00146	FORM-00146	Mahesh	Father	Trivedi	\N	9876500146	9876500146	\N	\N	hb146@baps.org	Gotri - 3	Vadodara	390001	1990-01-01	mahila	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0061	\N	x3	k_304	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_147	\N	M-00147	PID-00147	FORM-00147	Rajesh	Father	Bhatt	\N	9876500147	9876500147	\N	\N	hb147@baps.org	Gotri - 4	Vadodara	390001	1990-01-01	mahila	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0062	\N	x3	k_306	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_148	\N	M-00148	PID-00148	FORM-00148	Dinesh	Father	Pandya	\N	9876500148	9876500148	\N	\N	hb148@baps.org	Gotri - 5	Vadodara	390001	1990-01-01	mahila	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0063	\N	x3	k_308	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_149	\N	M-00149	PID-00149	FORM-00149	Bhavesh	Father	Amin	\N	9876500149	9876500149	\N	\N	hb149@baps.org	Chhani Jakatnaka - 1	Vadodara	390001	1990-01-01	mahila	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0064	\N	x3	k_310	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_150	\N	M-00150	PID-00150	FORM-00150	Jayesh	Father	Patel	\N	9876500150	9876500150	\N	\N	hb150@baps.org	Chhani Jakatnaka - 2	Vadodara	390001	1990-01-01	mahila	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0065	\N	x3	k_312	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_151	\N	M-00151	PID-00151	FORM-00151	Nilesh	Father	Shah	\N	9876500151	9876500151	\N	\N	hb151@baps.org	Chhani Jakatnaka - 3	Vadodara	390001	1990-01-01	mahila	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0066	\N	x3	k_314	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_152	\N	M-00152	PID-00152	FORM-00152	Hitesh	Father	Mehta	\N	9876500152	9876500152	\N	\N	hb152@baps.org	Chhanigam - 1	Vadodara	390001	1990-01-01	mahila	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0067	\N	x3	k_316	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_153	\N	M-00153	PID-00153	FORM-00153	Paresh	Father	Desai	\N	9876500153	9876500153	\N	\N	hb153@baps.org	Chhanigam - 2	Vadodara	390001	1990-01-01	mahila	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0068	\N	x3	k_318	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_154	\N	M-00154	PID-00154	FORM-00154	Mukesh	Father	Joshi	\N	9876500154	9876500154	\N	\N	hb154@baps.org	Karelibaug - 1	Vadodara	390001	1990-01-01	mahila	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0069	\N	x3	k_320	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_155	\N	M-00155	PID-00155	FORM-00155	Alpesh	Father	Dave	\N	9876500155	9876500155	\N	\N	hb155@baps.org	Karelibaug - 2	Vadodara	390001	1990-01-01	mahila	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0070	\N	x3	k_322	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_156	\N	M-00156	PID-00156	FORM-00156	Kiran	Father	Trivedi	\N	9876500156	9876500156	\N	\N	hb156@baps.org	Sama	Vadodara	390001	1990-01-01	mahila	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0071	\N	x3	k_324	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_157	\N	M-00157	PID-00157	FORM-00157	Meena	Father	Bhatt	\N	9876500157	9876500157	\N	\N	hb157@baps.org	Vemali	Vadodara	390001	1990-01-01	mahila	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0072	\N	x3	k_326	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_158	\N	M-00158	PID-00158	FORM-00158	Sunita	Father	Pandya	\N	9876500158	9876500158	\N	\N	hb158@baps.org	Motnath	Vadodara	390001	1990-01-01	mahila	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0073	\N	x3	k_328	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_159	\N	M-00159	PID-00159	FORM-00159	Hetal	Father	Amin	\N	9876500159	9876500159	\N	\N	hb159@baps.org	Lileriya	Vadodara	390001	1990-01-01	mahila	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0074	\N	x3	k_330	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_160	\N	M-00160	PID-00160	FORM-00160	Nisha	Father	Patel	\N	9876500160	9876500160	\N	\N	hb160@baps.org	Sardarnagar	Vadodara	390001	1990-01-01	mahila	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0075	\N	x3	k_332	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_161	\N	M-00161	PID-00161	FORM-00161	Priya	Father	Shah	\N	9876500161	9876500161	\N	\N	hb161@baps.org	Gorwa - 1	Vadodara	390001	1990-01-01	mahila	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0076	\N	x3	k_334	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_162	\N	M-00162	PID-00162	FORM-00162	Kavita	Father	Mehta	\N	9876500162	9876500162	\N	\N	hb162@baps.org	Gorwa - 2	Vadodara	390001	1990-01-01	mahila	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0077	\N	x3	k_336	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_163	\N	M-00163	PID-00163	FORM-00163	Rekha	Father	Desai	\N	9876500163	9876500163	\N	\N	hb163@baps.org	Gorwa - 3	Vadodara	390001	1990-01-01	mahila	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0078	\N	x3	k_338	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_164	\N	M-00164	PID-00164	FORM-00164	Sonal	Father	Joshi	\N	9876500164	9876500164	\N	\N	hb164@baps.org	Gorwa - 4	Vadodara	390001	1990-01-01	mahila	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0079	\N	x3	k_340	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_165	\N	M-00165	PID-00165	FORM-00165	Jyoti	Father	Dave	\N	9876500165	9876500165	\N	\N	hb165@baps.org	Bajwa	Vadodara	390001	1990-01-01	mahila	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0080	\N	x3	k_342	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_166	\N	M-00166	PID-00166	FORM-00166	Asha	Father	Trivedi	\N	9876500166	9876500166	\N	\N	hb166@baps.org	Karachiya	Vadodara	390001	1990-01-01	mahila	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0081	\N	x3	k_344	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_167	\N	M-00167	PID-00167	FORM-00167	Mina	Father	Bhatt	\N	9876500167	9876500167	\N	\N	hb167@baps.org	Lakshmipura	Vadodara	390001	1990-01-01	mahila	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0082	\N	x3	k_346	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_168	\N	M-00168	PID-00168	FORM-00168	Ramesh	Father	Pandya	\N	9876500168	9876500168	\N	\N	hb168@baps.org	Labh Bal	Vadodara	390001	1990-01-01	bal	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0168	\N	x1	k_349	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_169	\N	M-00169	PID-00169	FORM-00169	Suresh	Father	Amin	\N	9876500169	9876500169	\N	\N	hb169@baps.org	Labh Shishu	Vadodara	390001	1990-01-01	bal	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0169	\N	x1	k_351	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_170	\N	M-00170	PID-00170	FORM-00170	Mahesh	Father	Patel	\N	9876500170	9876500170	\N	\N	hb170@baps.org	Nilkanth Bal	Vadodara	390001	1990-01-01	bal	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0170	\N	x1	k_353	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_171	\N	M-00171	PID-00171	FORM-00171	Rajesh	Father	Shah	\N	9876500171	9876500171	\N	\N	hb171@baps.org	Nilkanth Shishu	Vadodara	390001	1990-01-01	bal	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0171	\N	x1	k_355	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_172	\N	M-00172	PID-00172	FORM-00172	Dinesh	Father	Mehta	\N	9876500172	9876500172	\N	\N	hb172@baps.org	Sun Pharma Bal	Vadodara	390001	1990-01-01	bal	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0172	\N	x1	k_357	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_173	\N	M-00173	PID-00173	FORM-00173	Bhavesh	Father	Desai	\N	9876500173	9876500173	\N	\N	hb173@baps.org	Akshar Green Shishu	Vadodara	390001	1990-01-01	bal	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0173	\N	x1	k_359	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_174	\N	M-00174	PID-00174	FORM-00174	Jayesh	Father	Joshi	\N	9876500174	9876500174	\N	\N	hb174@baps.org	Atladara Bal	Vadodara	390001	1990-01-01	bal	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0174	\N	x1	k_361	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_175	\N	M-00175	PID-00175	FORM-00175	Nilesh	Father	Dave	\N	9876500175	9876500175	\N	\N	hb175@baps.org	Atladara Shishu	Vadodara	390001	1990-01-01	bal	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0175	\N	x1	k_363	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_176	\N	M-00176	PID-00176	FORM-00176	Hitesh	Father	Trivedi	\N	9876500176	9876500176	\N	\N	hb176@baps.org	Pramukh Swami Nagar Bal	Vadodara	390001	1990-01-01	bal	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0176	\N	x1	k_365	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_177	\N	M-00177	PID-00177	FORM-00177	Paresh	Father	Bhatt	\N	9876500177	9876500177	\N	\N	hb177@baps.org	Hiranagar Bal	Vadodara	390001	1990-01-01	bal	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0177	\N	x1	k_367	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_178	\N	M-00178	PID-00178	FORM-00178	Mukesh	Father	Pandya	\N	9876500178	9876500178	\N	\N	hb178@baps.org	Hiranagar Shishu	Vadodara	390001	1990-01-01	bal	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0178	\N	x1	k_369	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_179	\N	M-00179	PID-00179	FORM-00179	Alpesh	Father	Amin	\N	9876500179	9876500179	\N	\N	hb179@baps.org	Vidyut Nagar Bal	Vadodara	390001	1990-01-01	bal	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0179	\N	x1	k_371	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_180	\N	M-00180	PID-00180	FORM-00180	Kiran	Father	Patel	\N	9876500180	9876500180	\N	\N	hb180@baps.org	Kalali Bal	Vadodara	390001	1990-01-01	bal	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0180	\N	x1	k_373	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_181	\N	M-00181	PID-00181	FORM-00181	Meena	Father	Shah	\N	9876500181	9876500181	\N	\N	hb181@baps.org	Atladara Gam Bal	Vadodara	390001	1990-01-01	bal	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0181	\N	x1	k_375	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_182	\N	M-00182	PID-00182	FORM-00182	Sunita	Father	Mehta	\N	9876500182	9876500182	\N	\N	hb182@baps.org	Atladara Gam 2 Bal	Vadodara	390001	1990-01-01	bal	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0182	\N	x1	k_377	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_183	\N	M-00183	PID-00183	FORM-00183	Hetal	Father	Desai	\N	9876500183	9876500183	\N	\N	hb183@baps.org	Gunatitdham Bal	Vadodara	390001	1990-01-01	bal	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0183	\N	x1	k_379	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_274	\N	M-00274	PID-00274	FORM-00274	Mukesh	Father	Joshi	\N	9876500274	9876500274	\N	\N	hb274@baps.org	Shreeji	Vadodara	390001	1990-01-01	balika	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0274	\N	x1	k_564	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_184	\N	M-00184	PID-00184	FORM-00184	Nisha	Father	Joshi	\N	9876500184	9876500184	\N	\N	hb184@baps.org	Gunatitdham Shishu	Vadodara	390001	1990-01-01	bal	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0184	\N	x1	k_381	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_185	\N	M-00185	PID-00185	FORM-00185	Priya	Father	Dave	\N	9876500185	9876500185	\N	\N	hb185@baps.org	Sairang Bal	Vadodara	390001	1990-01-01	bal	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0185	\N	x1	k_383	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_186	\N	M-00186	PID-00186	FORM-00186	Kavita	Father	Trivedi	\N	9876500186	9876500186	\N	\N	hb186@baps.org	Avadh Upavan Bal	Vadodara	390001	1990-01-01	bal	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0186	\N	x1	k_385	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_187	\N	M-00187	PID-00187	FORM-00187	Rekha	Father	Bhatt	\N	9876500187	9876500187	\N	\N	hb187@baps.org	Avadh Upavan Shishu	Vadodara	390001	1990-01-01	bal	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0187	\N	x1	k_387	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_188	\N	M-00188	PID-00188	FORM-00188	Sonal	Father	Pandya	\N	9876500188	9876500188	\N	\N	hb188@baps.org	Akshar Paradise Bal	Vadodara	390001	1990-01-01	bal	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0188	\N	x1	k_389	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_189	\N	M-00189	PID-00189	FORM-00189	Jyoti	Father	Amin	\N	9876500189	9876500189	\N	\N	hb189@baps.org	Indravilla Bal	Vadodara	390001	1990-01-01	bal	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0189	\N	x1	k_391	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_190	\N	M-00190	PID-00190	FORM-00190	Asha	Father	Patel	\N	9876500190	9876500190	\N	\N	hb190@baps.org	Anant Swagatam Bal	Vadodara	390001	1990-01-01	bal	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0190	\N	x1	k_393	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_191	\N	M-00191	PID-00191	FORM-00191	Mina	Father	Shah	\N	9876500191	9876500191	\N	\N	hb191@baps.org	Param Krisht Bal	Vadodara	390001	1990-01-01	bal	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0191	\N	x1	k_395	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_192	\N	M-00192	PID-00192	FORM-00192	Ramesh	Father	Mehta	\N	9876500192	9876500192	\N	\N	hb192@baps.org	Arya Empire Bal	Vadodara	390001	1990-01-01	bal	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0192	\N	x1	k_397	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_193	\N	M-00193	PID-00193	FORM-00193	Suresh	Father	Desai	\N	9876500193	9876500193	\N	\N	hb193@baps.org	Green Yard Bal	Vadodara	390001	1990-01-01	bal	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0193	\N	x1	k_399	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_194	\N	M-00194	PID-00194	FORM-00194	Mahesh	Father	Joshi	\N	9876500194	9876500194	\N	\N	hb194@baps.org	Kishan Glory Bal	Vadodara	390001	1990-01-01	bal	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0194	\N	x1	k_401	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_195	\N	M-00195	PID-00195	FORM-00195	Rajesh	Father	Dave	\N	9876500195	9876500195	\N	\N	hb195@baps.org	Pramukh Swami Villa Bal	Vadodara	390001	1990-01-01	bal	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0195	\N	x1	k_403	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_196	\N	M-00196	PID-00196	FORM-00196	Dinesh	Father	Trivedi	\N	9876500196	9876500196	\N	\N	hb196@baps.org	Yoginagar Bal	Vadodara	390001	1990-01-01	bal	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0196	\N	x1	k_405	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_197	\N	M-00197	PID-00197	FORM-00197	Bhavesh	Father	Bhatt	\N	9876500197	9876500197	\N	\N	hb197@baps.org	Vrundavan Shishu	Vadodara	390001	1990-01-01	bal	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0197	\N	x1	k_407	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_198	\N	M-00198	PID-00198	FORM-00198	Jayesh	Father	Pandya	\N	9876500198	9876500198	\N	\N	hb198@baps.org	Pramukh Swami Tirth Bal	Vadodara	390001	1990-01-01	bal	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0198	\N	x1	k_409	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_199	\N	M-00199	PID-00199	FORM-00199	Nilesh	Father	Amin	\N	9876500199	9876500199	\N	\N	hb199@baps.org	Indrapuri Bal	Vadodara	390001	1990-01-01	bal	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0199	\N	x2	k_412	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_200	\N	M-00200	PID-00200	FORM-00200	Hitesh	Father	Patel	\N	9876500200	9876500200	\N	\N	hb200@baps.org	Nathiba Nagar Bal	Vadodara	390001	1990-01-01	bal	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0200	\N	x2	k_414	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_201	\N	M-00201	PID-00201	FORM-00201	Paresh	Father	Shah	\N	9876500201	9876500201	\N	\N	hb201@baps.org	Vaikunth Bal	Vadodara	390001	1990-01-01	bal	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0201	\N	x2	k_416	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_202	\N	M-00202	PID-00202	FORM-00202	Mukesh	Father	Mehta	\N	9876500202	9876500202	\N	\N	hb202@baps.org	Kamlanagar Bal	Vadodara	390001	1990-01-01	bal	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0202	\N	x2	k_418	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_203	\N	M-00203	PID-00203	FORM-00203	Alpesh	Father	Desai	\N	9876500203	9876500203	\N	\N	hb203@baps.org	Seva Kunj Bal	Vadodara	390001	1990-01-01	bal	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0203	\N	x2	k_420	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_204	\N	M-00204	PID-00204	FORM-00204	Kiran	Father	Joshi	\N	9876500204	9876500204	\N	\N	hb204@baps.org	Pancham Villa Bal	Vadodara	390001	1990-01-01	bal	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0204	\N	x2	k_422	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_205	\N	M-00205	PID-00205	FORM-00205	Meena	Father	Dave	\N	9876500205	9876500205	\N	\N	hb205@baps.org	Sugam Park Bal	Vadodara	390001	1990-01-01	bal	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0205	\N	x2	k_424	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_206	\N	M-00206	PID-00206	FORM-00206	Sunita	Father	Trivedi	\N	9876500206	9876500206	\N	\N	hb206@baps.org	Shri Hari Township Bal	Vadodara	390001	1990-01-01	bal	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0206	\N	x2	k_426	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_207	\N	M-00207	PID-00207	FORM-00207	Hetal	Father	Bhatt	\N	9876500207	9876500207	\N	\N	hb207@baps.org	Ambika Darshan 2 Bal	Vadodara	390001	1990-01-01	bal	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0207	\N	x2	k_428	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_208	\N	M-00208	PID-00208	FORM-00208	Nisha	Father	Pandya	\N	9876500208	9876500208	\N	\N	hb208@baps.org	Harikrishna Township Bal	Vadodara	390001	1990-01-01	bal	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0208	\N	x2	k_430	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_209	\N	M-00209	PID-00209	FORM-00209	Priya	Father	Amin	\N	9876500209	9876500209	\N	\N	hb209@baps.org	Parimal 3 Bal	Vadodara	390001	1990-01-01	bal	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0209	\N	x2	k_432	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_210	\N	M-00210	PID-00210	FORM-00210	Kavita	Father	Patel	\N	9876500210	9876500210	\N	\N	hb210@baps.org	Sayajinagar Bal	Vadodara	390001	1990-01-01	bal	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0210	\N	x2	k_434	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_211	\N	M-00211	PID-00211	FORM-00211	Rekha	Father	Shah	\N	9876500211	9876500211	\N	\N	hb211@baps.org	Kishanwadi Bal	Vadodara	390001	1990-01-01	bal	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0211	\N	x2	k_436	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_212	\N	M-00212	PID-00212	FORM-00212	Sonal	Father	Mehta	\N	9876500212	9876500212	\N	\N	hb212@baps.org	Satadhar Bal	Vadodara	390001	1990-01-01	bal	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0212	\N	x2	k_438	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_213	\N	M-00213	PID-00213	FORM-00213	Jyoti	Father	Desai	\N	9876500213	9876500213	\N	\N	hb213@baps.org	Bhailalbhai Park Bal	Vadodara	390001	1990-01-01	bal	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0213	\N	x2	k_440	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_214	\N	M-00214	PID-00214	FORM-00214	Asha	Father	Joshi	\N	9876500214	9876500214	\N	\N	hb214@baps.org	Indrapuri Shishu	Vadodara	390001	1990-01-01	bal	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0214	\N	x2	k_442	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_215	\N	M-00215	PID-00215	FORM-00215	Mina	Father	Dave	\N	9876500215	9876500215	\N	\N	hb215@baps.org	Danteshwar Bal	Vadodara	390001	1990-01-01	bal	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0215	\N	x2	k_444	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_216	\N	M-00216	PID-00216	FORM-00216	Ramesh	Father	Trivedi	\N	9876500216	9876500216	\N	\N	hb216@baps.org	Anupam Nagar Bal	Vadodara	390001	1990-01-01	bal	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0216	\N	x2	k_446	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_217	\N	M-00217	PID-00217	FORM-00217	Suresh	Father	Bhatt	\N	9876500217	9876500217	\N	\N	hb217@baps.org	Zillion Bal	Vadodara	390001	1990-01-01	bal	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0217	\N	x2	k_448	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_218	\N	M-00218	PID-00218	FORM-00218	Mahesh	Father	Pandya	\N	9876500218	9876500218	\N	\N	hb218@baps.org	Tarsali Bal	Vadodara	390001	1990-01-01	bal	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0218	\N	x2	k_450	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_219	\N	M-00219	PID-00219	FORM-00219	Rajesh	Father	Amin	\N	9876500219	9876500219	\N	\N	hb219@baps.org	Vallabh Duplex Bal	Vadodara	390001	1990-01-01	bal	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0219	\N	x2	k_452	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_220	\N	M-00220	PID-00220	FORM-00220	Dinesh	Father	Patel	\N	9876500220	9876500220	\N	\N	hb220@baps.org	Gold City Bal	Vadodara	390001	1990-01-01	bal	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0220	\N	x2	k_454	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_221	\N	M-00221	PID-00221	FORM-00221	Bhavesh	Father	Shah	\N	9876500221	9876500221	\N	\N	hb221@baps.org	Tuljanagar Bal	Vadodara	390001	1990-01-01	bal	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0221	\N	x2	k_456	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_222	\N	M-00222	PID-00222	FORM-00222	Jayesh	Father	Mehta	\N	9876500222	9876500222	\N	\N	hb222@baps.org	Makarpura Bal	Vadodara	390001	1990-01-01	bal	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0222	\N	x2	k_458	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_223	\N	M-00223	PID-00223	FORM-00223	Nilesh	Father	Desai	\N	9876500223	9876500223	\N	\N	hb223@baps.org	Akruti Duplex Bal	Vadodara	390001	1990-01-01	bal	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0223	\N	x2	k_460	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_224	\N	M-00224	PID-00224	FORM-00224	Hitesh	Father	Joshi	\N	9876500224	9876500224	\N	\N	hb224@baps.org	Maneja Bal	Vadodara	390001	1990-01-01	bal	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0224	\N	x2	k_462	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_225	\N	M-00225	PID-00225	FORM-00225	Paresh	Father	Dave	\N	9876500225	9876500225	\N	\N	hb225@baps.org	Gayatrinagar Bal	Vadodara	390001	1990-01-01	bal	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0225	\N	x2	k_464	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_226	\N	M-00226	PID-00226	FORM-00226	Mukesh	Father	Trivedi	\N	9876500226	9876500226	\N	\N	hb226@baps.org	Danteshwar Shishu	Vadodara	390001	1990-01-01	bal	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0226	\N	x2	k_466	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_227	\N	M-00227	PID-00227	FORM-00227	Alpesh	Father	Bhatt	\N	9876500227	9876500227	\N	\N	hb227@baps.org	Sharadnagar Shishu	Vadodara	390001	1990-01-01	bal	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0227	\N	x2	k_468	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_228	\N	M-00228	PID-00228	FORM-00228	Kiran	Father	Pandya	\N	9876500228	9876500228	\N	\N	hb228@baps.org	Gayatrinagar Shishu	Vadodara	390001	1990-01-01	bal	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0228	\N	x2	k_470	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_229	\N	M-00229	PID-00229	FORM-00229	Meena	Father	Amin	\N	9876500229	9876500229	\N	\N	hb229@baps.org	Shiyabaug Bal	Vadodara	390001	1990-01-01	bal	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0229	\N	x2	k_472	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_230	\N	M-00230	PID-00230	FORM-00230	Sunita	Father	Patel	\N	9876500230	9876500230	\N	\N	hb230@baps.org	Nyaymandir Bal	Vadodara	390001	1990-01-01	bal	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0230	\N	x2	k_474	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_231	\N	M-00231	PID-00231	FORM-00231	Hetal	Father	Shah	\N	9876500231	9876500231	\N	\N	hb231@baps.org	Wadi Bal	Vadodara	390001	1990-01-01	bal	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0231	\N	x2	k_476	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_232	\N	M-00232	PID-00232	FORM-00232	Nisha	Father	Mehta	\N	9876500232	9876500232	\N	\N	hb232@baps.org	Akshar Tenament Bal	Vadodara	390001	1990-01-01	bal	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0232	\N	x2	k_478	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_233	\N	M-00233	PID-00233	FORM-00233	Priya	Father	Desai	\N	9876500233	9876500233	\N	\N	hb233@baps.org	Vaishnav Park Bal	Vadodara	390001	1990-01-01	bal	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0233	\N	x2	k_480	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_234	\N	M-00234	PID-00234	FORM-00234	Kavita	Father	Joshi	\N	9876500234	9876500234	\N	\N	hb234@baps.org	Yogi Raday Bal	Vadodara	390001	1990-01-01	bal	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0234	\N	x2	k_482	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_235	\N	M-00235	PID-00235	FORM-00235	Rekha	Father	Dave	\N	9876500235	9876500235	\N	\N	hb235@baps.org	Shivam Bal	Vadodara	390001	1990-01-01	bal	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0235	\N	x2	k_484	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_236	\N	M-00236	PID-00236	FORM-00236	Sonal	Father	Trivedi	\N	9876500236	9876500236	\N	\N	hb236@baps.org	Soles Bal	Vadodara	390001	1990-01-01	bal	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0236	\N	x2	k_486	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_237	\N	M-00237	PID-00237	FORM-00237	Jyoti	Father	Bhatt	\N	9876500237	9876500237	\N	\N	hb237@baps.org	Darshanam Green Bal	Vadodara	390001	1990-01-01	bal	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0237	\N	x2	k_488	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_238	\N	M-00238	PID-00238	FORM-00238	Asha	Father	Pandya	\N	9876500238	9876500238	\N	\N	hb238@baps.org	Jalaram Nagar Bal	Vadodara	390001	1990-01-01	bal	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0238	\N	x2	k_490	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_239	\N	M-00239	PID-00239	FORM-00239	Mina	Father	Amin	\N	9876500239	9876500239	\N	\N	hb239@baps.org	D Mart Bal	Vadodara	390001	1990-01-01	bal	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0239	\N	x2	k_492	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_240	\N	M-00240	PID-00240	FORM-00240	Ramesh	Father	Patel	\N	9876500240	9876500240	\N	\N	hb240@baps.org	Dhanlaxmi Tenament Bal	Vadodara	390001	1990-01-01	bal	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0240	\N	x2	k_494	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_241	\N	M-00241	PID-00241	FORM-00241	Suresh	Father	Shah	\N	9876500241	9876500241	\N	\N	hb241@baps.org	Manjalpur Bal	Vadodara	390001	1990-01-01	bal	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0241	\N	x2	k_496	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_242	\N	M-00242	PID-00242	FORM-00242	Mahesh	Father	Mehta	\N	9876500242	9876500242	\N	\N	hb242@baps.org	Surabhipark Bal	Vadodara	390001	1990-01-01	bal	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0242	\N	x2	k_498	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_243	\N	M-00243	PID-00243	FORM-00243	Rajesh	Father	Desai	\N	9876500243	9876500243	\N	\N	hb243@baps.org	Pujan Bal	Vadodara	390001	1990-01-01	bal	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0243	\N	x2	k_500	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_244	\N	M-00244	PID-00244	FORM-00244	Dinesh	Father	Joshi	\N	9876500244	9876500244	\N	\N	hb244@baps.org	Vaibhav Vatika Bal	Vadodara	390001	1990-01-01	bal	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0244	\N	x2	k_502	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_245	\N	M-00245	PID-00245	FORM-00245	Bhavesh	Father	Dave	\N	9876500245	9876500245	\N	\N	hb245@baps.org	Kedardham Bal	Vadodara	390001	1990-01-01	bal	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0245	\N	x2	k_504	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_246	\N	M-00246	PID-00246	FORM-00246	Jayesh	Father	Trivedi	\N	9876500246	9876500246	\N	\N	hb246@baps.org	Kamleshwar Nagar Bal	Vadodara	390001	1990-01-01	bal	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0246	\N	x2	k_506	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_247	\N	M-00247	PID-00247	FORM-00247	Nilesh	Father	Bhatt	\N	9876500247	9876500247	\N	\N	hb247@baps.org	Gayatri Krupa Bal	Vadodara	390001	1990-01-01	bal	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0247	\N	x2	k_508	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_248	\N	M-00248	PID-00248	FORM-00248	Hitesh	Father	Pandya	\N	9876500248	9876500248	\N	\N	hb248@baps.org	Parthbhumi Bal	Vadodara	390001	1990-01-01	bal	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0248	\N	x2	k_510	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_249	\N	M-00249	PID-00249	FORM-00249	Paresh	Father	Amin	\N	9876500249	9876500249	\N	\N	hb249@baps.org	Vadsar Bal	Vadodara	390001	1990-01-01	bal	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0249	\N	x2	k_512	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_250	\N	M-00250	PID-00250	FORM-00250	Mukesh	Father	Patel	\N	9876500250	9876500250	\N	\N	hb250@baps.org	Sama Bal	Vadodara	390001	1990-01-01	bal	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0250	\N	x3	k_515	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_251	\N	M-00251	PID-00251	FORM-00251	Alpesh	Father	Shah	\N	9876500251	9876500251	\N	\N	hb251@baps.org	Vemali Bal	Vadodara	390001	1990-01-01	bal	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0251	\N	x3	k_517	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_252	\N	M-00252	PID-00252	FORM-00252	Kiran	Father	Mehta	\N	9876500252	9876500252	\N	\N	hb252@baps.org	Vemali Gam Sanskar Kendra	Vadodara	390001	1990-01-01	bal	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0252	\N	x3	k_519	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_253	\N	M-00253	PID-00253	FORM-00253	Meena	Father	Desai	\N	9876500253	9876500253	\N	\N	hb253@baps.org	Karelibaug Bal	Vadodara	390001	1990-01-01	bal	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0253	\N	x3	k_521	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_254	\N	M-00254	PID-00254	FORM-00254	Sunita	Father	Joshi	\N	9876500254	9876500254	\N	\N	hb254@baps.org	Pramukh Preet Bal	Vadodara	390001	1990-01-01	bal	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0254	\N	x3	k_523	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_255	\N	M-00255	PID-00255	FORM-00255	Hetal	Father	Dave	\N	9876500255	9876500255	\N	\N	hb255@baps.org	Airport Bal	Vadodara	390001	1990-01-01	bal	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0255	\N	x3	k_525	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_256	\N	M-00256	PID-00256	FORM-00256	Nisha	Father	Trivedi	\N	9876500256	9876500256	\N	\N	hb256@baps.org	Khodiyar Nagar Bal	Vadodara	390001	1990-01-01	bal	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0256	\N	x3	k_527	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_257	\N	M-00257	PID-00257	FORM-00257	Priya	Father	Bhatt	\N	9876500257	9876500257	\N	\N	hb257@baps.org	Vrundavan Bal	Vadodara	390001	1990-01-01	bal	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0257	\N	x3	k_529	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_258	\N	M-00258	PID-00258	FORM-00258	Kavita	Father	Pandya	\N	9876500258	9876500258	\N	\N	hb258@baps.org	Siddharth Bungalow Sanskar Kendra	Vadodara	390001	1990-01-01	bal	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0258	\N	x3	k_531	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_259	\N	M-00259	PID-00259	FORM-00259	Rekha	Father	Amin	\N	9876500259	9876500259	\N	\N	hb259@baps.org	Motnath Residency Sanskar Kendra	Vadodara	390001	1990-01-01	bal	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0259	\N	x3	k_533	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_260	\N	M-00260	PID-00260	FORM-00260	Sonal	Father	Patel	\N	9876500260	9876500260	\N	\N	hb260@baps.org	Chhani Jakatnaka Bal	Vadodara	390001	1990-01-01	bal	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0260	\N	x3	k_535	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_261	\N	M-00261	PID-00261	FORM-00261	Jyoti	Father	Shah	\N	9876500261	9876500261	\N	\N	hb261@baps.org	Nakshatra Bal	Vadodara	390001	1990-01-01	bal	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0261	\N	x3	k_537	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_262	\N	M-00262	PID-00262	FORM-00262	Asha	Father	Mehta	\N	9876500262	9876500262	\N	\N	hb262@baps.org	Satyanarayan Bal	Vadodara	390001	1990-01-01	bal	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0262	\N	x3	k_539	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_263	\N	M-00263	PID-00263	FORM-00263	Mina	Father	Desai	\N	9876500263	9876500263	\N	\N	hb263@baps.org	Sardarnagar Bal	Vadodara	390001	1990-01-01	bal	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0263	\N	x3	k_541	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_264	\N	M-00264	PID-00264	FORM-00264	Ramesh	Father	Joshi	\N	9876500264	9876500264	\N	\N	hb264@baps.org	Chhanigam Bal	Vadodara	390001	1990-01-01	bal	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0264	\N	x3	k_543	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_265	\N	M-00265	PID-00265	FORM-00265	Suresh	Father	Dave	\N	9876500265	9876500265	\N	\N	hb265@baps.org	Marutinandan Sanskar Kendra	Vadodara	390001	1990-01-01	bal	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0265	\N	x3	k_545	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_266	\N	M-00266	PID-00266	FORM-00266	Mahesh	Father	Trivedi	\N	9876500266	9876500266	\N	\N	hb266@baps.org	Karelibaug Shishu	Vadodara	390001	1990-01-01	bal	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0266	\N	x3	k_547	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_267	\N	M-00267	PID-00267	FORM-00267	Rajesh	Father	Bhatt	\N	9876500267	9876500267	\N	\N	hb267@baps.org	Sama Shishu	Vadodara	390001	1990-01-01	bal	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0267	\N	x3	k_549	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_268	\N	M-00268	PID-00268	FORM-00268	Dinesh	Father	Pandya	\N	9876500268	9876500268	\N	\N	hb268@baps.org	Chhani Jakatnaka Shishu	Vadodara	390001	1990-01-01	bal	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0268	\N	x3	k_551	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_269	\N	M-00269	PID-00269	FORM-00269	Bhavesh	Father	Amin	\N	9876500269	9876500269	\N	\N	hb269@baps.org	Pushpam	Vadodara	390001	1990-01-01	balika	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0269	\N	x1	k_554	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_270	\N	M-00270	PID-00270	FORM-00270	Jayesh	Father	Patel	\N	9876500270	9876500270	\N	\N	hb270@baps.org	Harinagar	Vadodara	390001	1990-01-01	balika	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0270	\N	x1	k_556	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_271	\N	M-00271	PID-00271	FORM-00271	Nilesh	Father	Shah	\N	9876500271	9876500271	\N	\N	hb271@baps.org	Harinagar Shishu	Vadodara	390001	1990-01-01	balika	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0271	\N	x1	k_558	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_272	\N	M-00272	PID-00272	FORM-00272	Hitesh	Father	Mehta	\N	9876500272	9876500272	\N	\N	hb272@baps.org	Chandranagar	Vadodara	390001	1990-01-01	balika	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0272	\N	x1	k_560	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_273	\N	M-00273	PID-00273	FORM-00273	Paresh	Father	Desai	\N	9876500273	9876500273	\N	\N	hb273@baps.org	Jay Ambe	Vadodara	390001	1990-01-01	balika	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0273	\N	x1	k_562	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_275	\N	M-00275	PID-00275	FORM-00275	Alpesh	Father	Dave	\N	9876500275	9876500275	\N	\N	hb275@baps.org	Vaikunth	Vadodara	390001	1990-01-01	balika	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0275	\N	x1	k_566	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_276	\N	M-00276	PID-00276	FORM-00276	Kiran	Father	Trivedi	\N	9876500276	9876500276	\N	\N	hb276@baps.org	Samta Balika	Vadodara	390001	1990-01-01	balika	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0276	\N	x1	k_568	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_277	\N	M-00277	PID-00277	FORM-00277	Meena	Father	Bhatt	\N	9876500277	9876500277	\N	\N	hb277@baps.org	Gokulnagar	Vadodara	390001	1990-01-01	balika	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0277	\N	x3	k_571	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_278	\N	M-00278	PID-00278	FORM-00278	Sunita	Father	Pandya	\N	9876500278	9876500278	\N	\N	hb278@baps.org	Jaladarshan	Vadodara	390001	1990-01-01	balika	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0278	\N	x3	k_573	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_279	\N	M-00279	PID-00279	FORM-00279	Hetal	Father	Amin	\N	9876500279	9876500279	\N	\N	hb279@baps.org	Gotri Balika	Vadodara	390001	1990-01-01	balika	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0279	\N	x3	k_575	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_280	\N	M-00280	PID-00280	FORM-00280	Nisha	Father	Patel	\N	9876500280	9876500280	\N	\N	hb280@baps.org	Yagnapurush	Vadodara	390001	1990-01-01	balika	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0280	\N	x3	k_577	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_281	\N	M-00281	PID-00281	FORM-00281	Priya	Father	Shah	\N	9876500281	9876500281	\N	\N	hb281@baps.org	Life Arena	Vadodara	390001	1990-01-01	balika	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0281	\N	x3	k_579	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_282	\N	M-00282	PID-00282	FORM-00282	Kavita	Father	Mehta	\N	9876500282	9876500282	\N	\N	hb282@baps.org	Khanpur	Vadodara	390001	1990-01-01	balika	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0282	\N	x3	k_581	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	\N
hb_1	\N	M-00001	PID-00001	FORM-00001	Suresh	Father	Shah	\N	9876500001	9876500001	\N	\N	hb1@baps.org	Akota	Vadodara	390001	1990-01-01	sanyukt	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0083	\N	x1	k_3	A	f	active	\N	\N	\N	G	\N	\N	f	accepted	\N	2026-05-21 06:02:46.944381	2026-05-21 06:10:21.732015
hb_1779343821253	hb_1	MEM_hb_1_1779343821253	P1779343821753	F1779343821253	wegwegw	gwgwegwg	Shah	\N	1234567890	No	\N	No		Akota	Vadodara	390001		bal	Male	\N	\N	\N			\N	\N		\N	["No"]	{}	f	f	\N	\N	\N	No	No	\N	No	No	\N	Sanyukt	\N	\N	\N	Gujarat	India	\N	No			f	f	f	f	Son	No	f	f			f	f	f	No	f	No	f	No	No		No		No	No	No	No	No	No	m_0083	m_0174	x1	k_3	Select	f	active	\N	\N	\N	G	\N	\N	f	accepted	Mandal Sanchalak	2026-05-21 06:10:21.732015	\N
hb_1779504532732	FAM_1779504532732	MEM_FAM_1779504532732_1779504532732	P1779504532941	F1779504532732	zxcvbn	qdwaefsgrdhgm	sdfzdbfxcngvmn	\N	1234567890	Yes	\N	No		adsfdgfhgjh,jn	Vadodara	123456		bal	Male	\N	\N	\N			\N	\N		\N	["No"]	{}	f	f	\N	\N	\N	No	No	\N	No	No	\N	\N	erstrdtfgkyhjk.	adsfzdgfxcgjvkb,kn./	safdgfhm,jb	Gujarat	India	\N	No			f	f	f	f	\N	No	f	f			f	f	f	No	f	No	f	No	No		No		No	No	No	No	No	No	m_0176	\N	x1	\N	Select	f	active	\N	\N	\N	G	\N	\N	f	accepted	Pujya Sant Nirdeshak	2026-05-23 02:48:52.915728	\N
hb_akota_d3ec649b	FAM_AKOTA_2_420bf439	MEM_FAM_AKOTA_2_420bf439_1	PID_AKOTA_2_1	FORM_AKOTA_2_1	MockHead 2	MockFather	Patel	\N	9999900002	9999900002	\N	\N	mockhead2@example.com	Akota	Vadodara	390001	1990-01-01	sanyukt	Male	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0083	\N	x1	\N	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-23 03:11:47.86051	\N
hb_akota_bf1608f4	FAM_AKOTA_2_420bf439	MEM_FAM_AKOTA_2_420bf439_2	PID_AKOTA_2_2	FORM_AKOTA_2_2	MockWife 2	MockFather	Patel	\N	9999900102	9999900102	\N	\N	mockwife2@example.com	Akota	Vadodara	390001	1990-01-01	mahila	Female	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	Wife	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0083	\N	x1	\N	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-23 03:11:47.86051	\N
hb_akota_5f13543e	FAM_AKOTA_4_70f9e992	MEM_FAM_AKOTA_4_70f9e992_1	PID_AKOTA_4_1	FORM_AKOTA_4_1	MockHead 4	MockFather	Patel	\N	9999900004	9999900004	\N	\N	mockhead4@example.com	Akota	Vadodara	390001	1990-01-01	sanyukt	Male	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0083	\N	x1	\N	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-23 03:11:47.86051	\N
hb_akota_4ee305e7	FAM_AKOTA_4_70f9e992	MEM_FAM_AKOTA_4_70f9e992_2	PID_AKOTA_4_2	FORM_AKOTA_4_2	MockWife 4	MockFather	Patel	\N	9999900104	9999900104	\N	\N	mockwife4@example.com	Akota	Vadodara	390001	1990-01-01	mahila	Female	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	Wife	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0083	\N	x1	\N	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-23 03:11:47.86051	\N
hb_akota_16e96628	FAM_AKOTA_5_1ef66661	MEM_FAM_AKOTA_5_1ef66661_1	PID_AKOTA_5_1	FORM_AKOTA_5_1	MockHead 5	MockFather	Patel	\N	9999900005	9999900005	\N	\N	mockhead5@example.com	Akota	Vadodara	390001	1990-01-01	sanyukt	Male	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0083	\N	x1	\N	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-23 03:11:47.86051	\N
hb_akota_d9ca4513	FAM_AKOTA_5_1ef66661	MEM_FAM_AKOTA_5_1ef66661_3	PID_AKOTA_5_3	FORM_AKOTA_5_3	MockSon 5	MockFather	Patel	\N	9999900205	9999900205	\N	\N	mockson5@example.com	Akota	Vadodara	390001	1990-01-01	yuvak	Male	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	No	\N	f	f	f	f	Son	no	f	f	\N	\N	f	f	f	\N	f	\N	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0083	\N	x1	\N	A	t	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-23 03:11:47.86051	\N
hb_akota_fbe20ac7	FAM_AKOTA_8_89e531d9	MEM_FAM_AKOTA_8_89e531d9_1	PID_AKOTA_8_1	FORM_AKOTA_8_1	MockHead 8	MockFather	Patel	\N	9999900008	9999900008	\N	\N	mockhead8@example.com	Akota	Vadodara	390001	1990-01-01	sanyukt	Male	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0083	\N	x1	\N	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-23 03:11:47.86051	\N
hb_akota_e5c9708b	FAM_AKOTA_3_7b3b847f	MEM_FAM_AKOTA_3_7b3b847f_2	PID_AKOTA_3_2	FORM_AKOTA_3_2	MockWife 3	MockFather	Patel	\N	9999900103	9999900103	\N	\N	mockwife3@example.com	Akota	Vadodara	390001	1990-01-01	mahila	Female	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	Wife	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0083	\N	x1	\N	A	f	active	\N	\N	\N	G	\N	\N	f	accepted	\N	2026-05-23 03:11:47.86051	2026-05-23 04:57:24.313958
hb_akota_2d84ea10	FAM_AKOTA_6_25f73f2d	MEM_FAM_AKOTA_6_25f73f2d_1	PID_AKOTA_6_1	FORM_AKOTA_6_1	MockHead 6	MockFather	Patel	\N	9999900006	9999900006	\N	\N	mockhead6@example.com	Akota	Vadodara	390001	1990-01-01	sanyukt	Male	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0083	\N	x1	\N	A	f	active	\N	\N	\N	G	\N	\N	f	accepted	\N	2026-05-23 03:11:47.86051	2026-05-23 05:10:17.603686
hb_akota_11926cfb	FAM_AKOTA_6_25f73f2d	MEM_FAM_AKOTA_6_25f73f2d_3	PID_AKOTA_6_3	FORM_AKOTA_6_3	MockSon 6	MockFather	Patel	\N	9999900206	9999900206	\N	\N	mockson6@example.com	Akota	Vadodara	390001	1990-01-01	yuvak	Male	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	No	\N	f	f	f	f	Son	no	f	f	\N	\N	f	f	f	\N	f	\N	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0083	\N	x1	demo_sk_m1_0	A	t	active	\N	\N	\N	G	\N	\N	f	accepted	Nirikshak V1	2026-05-23 03:11:47.86051	2026-05-23 05:10:17.603686
hb_akota_46f53036	FAM_AKOTA_7_8c7ea639	MEM_FAM_AKOTA_7_8c7ea639_1	PID_AKOTA_7_1	FORM_AKOTA_7_1	Nishit	Rambhai	Patel	\N	9999900007	Yes	1234567890	\N	mockhead7@example.com	Akota	Vadodara	390001	1990-01-01	sanyukt	Male	\N	\N	\N		\N	\N	\N	\N	\N	\N	{}	f	f	\N	\N	\N	\N	No	2006	Farali	Pravin		\N	\N	\N	\N	\N	\N	S	\N	Yes		f	f	f	f	\N	Regular	t	f	\N	\N	f	f	t	Regular	t	No	t	\N	Regular	3 times	Regular	3 times	Yes	Yes	Yes	Yes	Regular	Yes	m_0083	\N	x1	demo_sk_m1_0	A	f	active	\N	\N	\N	G	\N	\N	t	accepted	Sampark Karyakar 1	2026-05-23 03:11:47.86051	2026-05-23 05:24:04.889171
hb_akota_42c37463	FAM_AKOTA_9_90f4ccb3	MEM_FAM_AKOTA_9_90f4ccb3_1	PID_AKOTA_9_1	FORM_AKOTA_9_1	MockHead 9	MockFather	Patel	\N	9999900009	9999900009	\N	\N	mockhead9@example.com	Akota	Vadodara	390001	1990-01-01	sanyukt	Male	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0083	\N	x1	\N	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-23 03:11:47.86051	\N
hb_akota_d57183ae	FAM_AKOTA_10_ebef90d0	MEM_FAM_AKOTA_10_ebef90d0_1	PID_AKOTA_10_1	FORM_AKOTA_10_1	MockHead 10	MockFather	Patel	\N	9999900010	9999900010	\N	\N	mockhead10@example.com	Akota	Vadodara	390001	1990-01-01	sanyukt	Male	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0083	\N	x1	\N	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-23 03:11:47.86051	\N
hb_akota_d6e66b36	FAM_AKOTA_1_efbaadfb	MEM_FAM_AKOTA_1_efbaadfb_1	PID_AKOTA_1_1_d9ed	FORM_AKOTA_1_1_91b2	MockHead 1	MockFather	Patel	\N	9999900001	9999900001	\N	\N	mockhead1@example.com	Akota	Vadodara	390001	1990-01-01	sanyukt	Male	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0083	\N	x1	\N	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-23 03:29:26.492056	\N
hb_akota_d7eb9fe3	FAM_AKOTA_1_efbaadfb	MEM_FAM_AKOTA_1_efbaadfb_2	PID_AKOTA_1_2_ec2e	FORM_AKOTA_1_2_3882	MockWife 1	MockFather	Patel	\N	9999900101	9999900101	\N	\N	mockwife1@example.com	Akota	Vadodara	390001	1990-01-01	mahila	Female	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	Wife	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0083	\N	x1	\N	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-23 03:29:26.492056	\N
hb_akota_6041f513	FAM_AKOTA_2_2d39897d	MEM_FAM_AKOTA_2_2d39897d_1	PID_AKOTA_2_1_282d	FORM_AKOTA_2_1_58fc	MockHead 2	MockFather	Patel	\N	9999900002	9999900002	\N	\N	mockhead2@example.com	Akota	Vadodara	390001	1990-01-01	sanyukt	Male	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0083	\N	x1	\N	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-23 03:29:26.492056	\N
hb_akota_339c9914	FAM_AKOTA_2_2d39897d	MEM_FAM_AKOTA_2_2d39897d_2	PID_AKOTA_2_2_bb5f	FORM_AKOTA_2_2_fb20	MockWife 2	MockFather	Patel	\N	9999900102	9999900102	\N	\N	mockwife2@example.com	Akota	Vadodara	390001	1990-01-01	mahila	Female	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	Wife	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0083	\N	x1	\N	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-23 03:29:26.492056	\N
hb_akota_e83e9e9a	FAM_AKOTA_3_afe225f8	MEM_FAM_AKOTA_3_afe225f8_1	PID_AKOTA_3_1_5e5f	FORM_AKOTA_3_1_3142	MockHead 3	MockFather	Patel	\N	9999900003	9999900003	\N	\N	mockhead3@example.com	Akota	Vadodara	390001	1990-01-01	sanyukt	Male	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0083	\N	x1	\N	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-23 03:29:26.492056	\N
hb_akota_df5df2d7	FAM_AKOTA_3_afe225f8	MEM_FAM_AKOTA_3_afe225f8_2	PID_AKOTA_3_2_136d	FORM_AKOTA_3_2_21fd	MockWife 3	MockFather	Patel	\N	9999900103	9999900103	\N	\N	mockwife3@example.com	Akota	Vadodara	390001	1990-01-01	mahila	Female	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	Wife	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0083	\N	x1	\N	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-23 03:29:26.492056	\N
hb_akota_be6b6a46	FAM_AKOTA_4_3f865acb	MEM_FAM_AKOTA_4_3f865acb_1	PID_AKOTA_4_1_a2ac	FORM_AKOTA_4_1_80db	MockHead 4	MockFather	Patel	\N	9999900004	9999900004	\N	\N	mockhead4@example.com	Akota	Vadodara	390001	1990-01-01	sanyukt	Male	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0083	\N	x1	\N	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-23 03:29:26.492056	\N
hb_akota_c5532dc9	FAM_AKOTA_4_3f865acb	MEM_FAM_AKOTA_4_3f865acb_2	PID_AKOTA_4_2_19bc	FORM_AKOTA_4_2_59a8	MockWife 4	MockFather	Patel	\N	9999900104	9999900104	\N	\N	mockwife4@example.com	Akota	Vadodara	390001	1990-01-01	mahila	Female	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	Wife	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0083	\N	x1	\N	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-23 03:29:26.492056	\N
hb_akota_f26e31ee	FAM_AKOTA_5_f2df3ca3	MEM_FAM_AKOTA_5_f2df3ca3_1	PID_AKOTA_5_1_fe69	FORM_AKOTA_5_1_8ce9	MockHead 5	MockFather	Patel	\N	9999900005	9999900005	\N	\N	mockhead5@example.com	Akota	Vadodara	390001	1990-01-01	sanyukt	Male	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0083	\N	x1	\N	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-23 03:29:26.492056	\N
hb_akota_6b36289d	FAM_AKOTA_5_f2df3ca3	MEM_FAM_AKOTA_5_f2df3ca3_3	PID_AKOTA_5_3_f1b2	FORM_AKOTA_5_3_5909	MockSon 5	MockFather	Patel	\N	9999900205	9999900205	\N	\N	mockson5@example.com	Akota	Vadodara	390001	1990-01-01	yuvak	Male	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	No	\N	f	f	f	f	Son	no	f	f	\N	\N	f	f	f	\N	f	\N	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0083	\N	x1	\N	A	t	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-23 03:29:26.492056	\N
hb_akota_bfe7b719	FAM_AKOTA_6_43a01a70	MEM_FAM_AKOTA_6_43a01a70_1	PID_AKOTA_6_1_863b	FORM_AKOTA_6_1_5f98	MockHead 6	MockFather	Patel	\N	9999900006	9999900006	\N	\N	mockhead6@example.com	Akota	Vadodara	390001	1990-01-01	sanyukt	Male	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0083	\N	x1	\N	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-23 03:29:26.492056	\N
hb_akota_2cb740a2	FAM_AKOTA_6_43a01a70	MEM_FAM_AKOTA_6_43a01a70_3	PID_AKOTA_6_3_f1ce	FORM_AKOTA_6_3_6ef6	MockSon 6	MockFather	Patel	\N	9999900206	9999900206	\N	\N	mockson6@example.com	Akota	Vadodara	390001	1990-01-01	yuvak	Male	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	No	\N	f	f	f	f	Son	no	f	f	\N	\N	f	f	f	\N	f	\N	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0083	\N	x1	\N	A	t	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-23 03:29:26.492056	\N
hb_akota_6f9745d9	FAM_AKOTA_7_b0310f7f	MEM_FAM_AKOTA_7_b0310f7f_1	PID_AKOTA_7_1_01a9	FORM_AKOTA_7_1_735f	MockHead 7	MockFather	Patel	\N	9999900007	9999900007	\N	\N	mockhead7@example.com	Akota	Vadodara	390001	1990-01-01	sanyukt	Male	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0083	\N	x1	\N	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-23 03:29:26.492056	\N
hb_akota_3f7156b6	FAM_AKOTA_8_5b5d0952	MEM_FAM_AKOTA_8_5b5d0952_1	PID_AKOTA_8_1_74bc	FORM_AKOTA_8_1_a030	MockHead 8	MockFather	Patel	\N	9999900008	9999900008	\N	\N	mockhead8@example.com	Akota	Vadodara	390001	1990-01-01	sanyukt	Male	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0083	\N	x1	\N	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-23 03:29:26.492056	\N
hb_akota_6281e97e	FAM_AKOTA_9_2ee12dad	MEM_FAM_AKOTA_9_2ee12dad_1	PID_AKOTA_9_1_2715	FORM_AKOTA_9_1_751e	MockHead 9	MockFather	Patel	\N	9999900009	9999900009	\N	\N	mockhead9@example.com	Akota	Vadodara	390001	1990-01-01	sanyukt	Male	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0083	\N	x1	\N	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-23 03:29:26.492056	\N
hb_akota_84b538c3	FAM_AKOTA_1_a4b72220	MEM_FAM_AKOTA_1_a4b72220_1	PID_AKOTA_1_1_8c06	FORM_AKOTA_1_1_cef2	MockHead 1	MockFather	Patel	\N	9999900001	9999900001	\N	\N	mockhead1@example.com	Akota	Vadodara	390001	1990-01-01	sanyukt	Male	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0083	\N	x1	\N	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-23 03:30:08.625334	\N
hb_akota_f346a127	FAM_AKOTA_1_a4b72220	MEM_FAM_AKOTA_1_a4b72220_2	PID_AKOTA_1_2_a53f	FORM_AKOTA_1_2_562c	MockWife 1	MockFather	Patel	\N	9999900101	9999900101	\N	\N	mockwife1@example.com	Akota	Vadodara	390001	1990-01-01	mahila	Female	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	Wife	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0083	\N	x1	\N	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-23 03:30:08.625334	\N
hb_akota_1d908055	FAM_AKOTA_2_fee5d076	MEM_FAM_AKOTA_2_fee5d076_1	PID_AKOTA_2_1_4285	FORM_AKOTA_2_1_626d	MockHead 2	MockFather	Patel	\N	9999900002	9999900002	\N	\N	mockhead2@example.com	Akota	Vadodara	390001	1990-01-01	sanyukt	Male	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0083	\N	x1	\N	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-23 03:30:08.625334	\N
hb_akota_950cfcf9	FAM_AKOTA_2_fee5d076	MEM_FAM_AKOTA_2_fee5d076_2	PID_AKOTA_2_2_b868	FORM_AKOTA_2_2_62bb	MockWife 2	MockFather	Patel	\N	9999900102	9999900102	\N	\N	mockwife2@example.com	Akota	Vadodara	390001	1990-01-01	mahila	Female	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	Wife	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0083	\N	x1	\N	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-23 03:30:08.625334	\N
hb_akota_5dce5f75	FAM_AKOTA_3_9e32292a	MEM_FAM_AKOTA_3_9e32292a_1	PID_AKOTA_3_1_362b	FORM_AKOTA_3_1_1825	MockHead 3	MockFather	Patel	\N	9999900003	9999900003	\N	\N	mockhead3@example.com	Akota	Vadodara	390001	1990-01-01	sanyukt	Male	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0083	\N	x1	\N	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-23 03:30:08.625334	\N
hb_akota_3cb5bdf7	FAM_AKOTA_3_9e32292a	MEM_FAM_AKOTA_3_9e32292a_2	PID_AKOTA_3_2_46f5	FORM_AKOTA_3_2_59ef	MockWife 3	MockFather	Patel	\N	9999900103	9999900103	\N	\N	mockwife3@example.com	Akota	Vadodara	390001	1990-01-01	mahila	Female	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	Wife	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0083	\N	x1	\N	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-23 03:30:08.625334	\N
hb_akota_6847aa24	FAM_AKOTA_4_b6d3ec0a	MEM_FAM_AKOTA_4_b6d3ec0a_1	PID_AKOTA_4_1_73a6	FORM_AKOTA_4_1_ad14	MockHead 4	MockFather	Patel	\N	9999900004	9999900004	\N	\N	mockhead4@example.com	Akota	Vadodara	390001	1990-01-01	sanyukt	Male	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0083	\N	x1	\N	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-23 03:30:08.625334	\N
hb_akota_4618621e	FAM_AKOTA_4_b6d3ec0a	MEM_FAM_AKOTA_4_b6d3ec0a_2	PID_AKOTA_4_2_3929	FORM_AKOTA_4_2_7953	MockWife 4	MockFather	Patel	\N	9999900104	9999900104	\N	\N	mockwife4@example.com	Akota	Vadodara	390001	1990-01-01	mahila	Female	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	Wife	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0083	\N	x1	\N	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-23 03:30:08.625334	\N
hb_akota_172d4450	FAM_AKOTA_5_69c97001	MEM_FAM_AKOTA_5_69c97001_1	PID_AKOTA_5_1_f3ae	FORM_AKOTA_5_1_19bd	MockHead 5	MockFather	Patel	\N	9999900005	9999900005	\N	\N	mockhead5@example.com	Akota	Vadodara	390001	1990-01-01	sanyukt	Male	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0083	\N	x1	\N	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-23 03:30:08.625334	\N
hb_akota_79434138	FAM_AKOTA_5_69c97001	MEM_FAM_AKOTA_5_69c97001_3	PID_AKOTA_5_3_17a8	FORM_AKOTA_5_3_89f3	MockSon 5	MockFather	Patel	\N	9999900205	9999900205	\N	\N	mockson5@example.com	Akota	Vadodara	390001	1990-01-01	yuvak	Male	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	No	\N	f	f	f	f	Son	no	f	f	\N	\N	f	f	f	\N	f	\N	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0083	\N	x1	\N	A	t	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-23 03:30:08.625334	\N
hb_akota_b789fbcf	FAM_AKOTA_6_e1220cd4	MEM_FAM_AKOTA_6_e1220cd4_1	PID_AKOTA_6_1_904c	FORM_AKOTA_6_1_78cf	MockHead 6	MockFather	Patel	\N	9999900006	9999900006	\N	\N	mockhead6@example.com	Akota	Vadodara	390001	1990-01-01	sanyukt	Male	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0083	\N	x1	\N	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-23 03:30:08.625334	\N
hb_akota_f42f9f4b	FAM_AKOTA_6_e1220cd4	MEM_FAM_AKOTA_6_e1220cd4_3	PID_AKOTA_6_3_52ab	FORM_AKOTA_6_3_f20a	MockSon 6	MockFather	Patel	\N	9999900206	9999900206	\N	\N	mockson6@example.com	Akota	Vadodara	390001	1990-01-01	yuvak	Male	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	No	\N	f	f	f	f	Son	no	f	f	\N	\N	f	f	f	\N	f	\N	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0083	\N	x1	\N	A	t	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-23 03:30:08.625334	\N
hb_akota_85316cd1	FAM_AKOTA_7_8c88960c	MEM_FAM_AKOTA_7_8c88960c_1	PID_AKOTA_7_1_4d8c	FORM_AKOTA_7_1_8866	MockHead 7	MockFather	Patel	\N	9999900007	9999900007	\N	\N	mockhead7@example.com	Akota	Vadodara	390001	1990-01-01	sanyukt	Male	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0083	\N	x1	\N	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-23 03:30:08.625334	\N
hb_akota_977bb4a5	FAM_AKOTA_8_dd03ab01	MEM_FAM_AKOTA_8_dd03ab01_1	PID_AKOTA_8_1_570c	FORM_AKOTA_8_1_2fbc	MockHead 8	MockFather	Patel	\N	9999900008	9999900008	\N	\N	mockhead8@example.com	Akota	Vadodara	390001	1990-01-01	sanyukt	Male	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0083	\N	x1	\N	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-23 03:30:08.625334	\N
hb_akota_4c249503	FAM_AKOTA_9_191bd887	MEM_FAM_AKOTA_9_191bd887_1	PID_AKOTA_9_1_1e52	FORM_AKOTA_9_1_5875	MockHead 9	MockFather	Patel	\N	9999900009	9999900009	\N	\N	mockhead9@example.com	Akota	Vadodara	390001	1990-01-01	sanyukt	Male	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0083	\N	x1	\N	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-23 03:30:08.625334	\N
hb_akota_7dd46185	FAM_AKOTA_10_ec59cff6	MEM_FAM_AKOTA_10_ec59cff6_1	PID_AKOTA_10_1_c909	FORM_AKOTA_10_1_4e0f	MockHead 10	MockFather	Patel	\N	9999900010	9999900010	\N	\N	mockhead10@example.com	Akota	Vadodara	390001	1990-01-01	sanyukt	Male	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0083	\N	x1	\N	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-23 03:30:08.625334	\N
hb_akota_eb3fed6e	FAM_AKOTA_1_16cf5ccd	MEM_FAM_AKOTA_1_16cf5ccd_1	PID_AKOTA_1_1_0abd	FORM_AKOTA_1_1_c91b	MockHead 1	MockFather	Patel	\N	9999900001	9999900001	\N	\N	mockhead1@example.com	Akota	Vadodara	390001	1990-01-01	sanyukt	Male	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0083	\N	x1	\N	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-23 03:30:15.852343	\N
hb_akota_b4d94005	FAM_AKOTA_1_16cf5ccd	MEM_FAM_AKOTA_1_16cf5ccd_2	PID_AKOTA_1_2_1c13	FORM_AKOTA_1_2_9141	MockWife 1	MockFather	Patel	\N	9999900101	9999900101	\N	\N	mockwife1@example.com	Akota	Vadodara	390001	1990-01-01	mahila	Female	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	Wife	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0083	\N	x1	\N	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-23 03:30:15.852343	\N
hb_akota_973978c3	FAM_AKOTA_2_bcf58630	MEM_FAM_AKOTA_2_bcf58630_1	PID_AKOTA_2_1_fb1d	FORM_AKOTA_2_1_98aa	MockHead 2	MockFather	Patel	\N	9999900002	9999900002	\N	\N	mockhead2@example.com	Akota	Vadodara	390001	1990-01-01	sanyukt	Male	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0083	\N	x1	\N	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-23 03:30:15.852343	\N
hb_akota_95053b34	FAM_AKOTA_2_bcf58630	MEM_FAM_AKOTA_2_bcf58630_2	PID_AKOTA_2_2_9143	FORM_AKOTA_2_2_5b65	MockWife 2	MockFather	Patel	\N	9999900102	9999900102	\N	\N	mockwife2@example.com	Akota	Vadodara	390001	1990-01-01	mahila	Female	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	Wife	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0083	\N	x1	\N	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-23 03:30:15.852343	\N
hb_akota_d593d4ee	FAM_AKOTA_3_794d1ad6	MEM_FAM_AKOTA_3_794d1ad6_1	PID_AKOTA_3_1_cb9c	FORM_AKOTA_3_1_02b3	MockHead 3	MockFather	Patel	\N	9999900003	9999900003	\N	\N	mockhead3@example.com	Akota	Vadodara	390001	1990-01-01	sanyukt	Male	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0083	\N	x1	\N	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-23 03:30:15.852343	\N
hb_akota_abef4a33	FAM_AKOTA_3_794d1ad6	MEM_FAM_AKOTA_3_794d1ad6_2	PID_AKOTA_3_2_ea03	FORM_AKOTA_3_2_2407	MockWife 3	MockFather	Patel	\N	9999900103	9999900103	\N	\N	mockwife3@example.com	Akota	Vadodara	390001	1990-01-01	mahila	Female	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	Wife	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0083	\N	x1	\N	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-23 03:30:15.852343	\N
hb_akota_b2c5f2f1	FAM_AKOTA_4_e65599e7	MEM_FAM_AKOTA_4_e65599e7_1	PID_AKOTA_4_1_751d	FORM_AKOTA_4_1_1fa4	MockHead 4	MockFather	Patel	\N	9999900004	9999900004	\N	\N	mockhead4@example.com	Akota	Vadodara	390001	1990-01-01	sanyukt	Male	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0083	\N	x1	\N	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-23 03:30:15.852343	\N
hb_akota_e7e5c486	FAM_AKOTA_4_e65599e7	MEM_FAM_AKOTA_4_e65599e7_2	PID_AKOTA_4_2_4bed	FORM_AKOTA_4_2_2977	MockWife 4	MockFather	Patel	\N	9999900104	9999900104	\N	\N	mockwife4@example.com	Akota	Vadodara	390001	1990-01-01	mahila	Female	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	Wife	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0083	\N	x1	\N	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-23 03:30:15.852343	\N
hb_akota_b3bbbd20	FAM_AKOTA_5_ef7ebf88	MEM_FAM_AKOTA_5_ef7ebf88_1	PID_AKOTA_5_1_2ceb	FORM_AKOTA_5_1_9368	MockHead 5	MockFather	Patel	\N	9999900005	9999900005	\N	\N	mockhead5@example.com	Akota	Vadodara	390001	1990-01-01	sanyukt	Male	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0083	\N	x1	\N	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-23 03:30:15.852343	\N
hb_akota_d267477f	FAM_AKOTA_5_ef7ebf88	MEM_FAM_AKOTA_5_ef7ebf88_3	PID_AKOTA_5_3_06e1	FORM_AKOTA_5_3_1a9f	MockSon 5	MockFather	Patel	\N	9999900205	9999900205	\N	\N	mockson5@example.com	Akota	Vadodara	390001	1990-01-01	yuvak	Male	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	No	\N	f	f	f	f	Son	no	f	f	\N	\N	f	f	f	\N	f	\N	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0083	\N	x1	\N	A	t	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-23 03:30:15.852343	\N
hb_akota_d43e91bc	FAM_AKOTA_6_5f6fe1db	MEM_FAM_AKOTA_6_5f6fe1db_1	PID_AKOTA_6_1_4bb7	FORM_AKOTA_6_1_d65c	MockHead 6	MockFather	Patel	\N	9999900006	9999900006	\N	\N	mockhead6@example.com	Akota	Vadodara	390001	1990-01-01	sanyukt	Male	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0083	\N	x1	\N	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-23 03:30:15.852343	\N
hb_akota_ea40aae7	FAM_AKOTA_6_5f6fe1db	MEM_FAM_AKOTA_6_5f6fe1db_3	PID_AKOTA_6_3_6af5	FORM_AKOTA_6_3_435f	MockSon 6	MockFather	Patel	\N	9999900206	9999900206	\N	\N	mockson6@example.com	Akota	Vadodara	390001	1990-01-01	yuvak	Male	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	No	\N	f	f	f	f	Son	no	f	f	\N	\N	f	f	f	\N	f	\N	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0083	\N	x1	\N	A	t	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-23 03:30:15.852343	\N
hb_akota_62dbff57	FAM_AKOTA_7_afadcde0	MEM_FAM_AKOTA_7_afadcde0_1	PID_AKOTA_7_1_f265	FORM_AKOTA_7_1_97df	MockHead 7	MockFather	Patel	\N	9999900007	9999900007	\N	\N	mockhead7@example.com	Akota	Vadodara	390001	1990-01-01	sanyukt	Male	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0083	\N	x1	\N	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-23 03:30:15.852343	\N
hb_akota_c173fedf	FAM_AKOTA_8_6c4e4206	MEM_FAM_AKOTA_8_6c4e4206_1	PID_AKOTA_8_1_323a	FORM_AKOTA_8_1_84b4	MockHead 8	MockFather	Patel	\N	9999900008	9999900008	\N	\N	mockhead8@example.com	Akota	Vadodara	390001	1990-01-01	sanyukt	Male	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0083	\N	x1	\N	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-23 03:30:15.852343	\N
hb_akota_02124c5a	FAM_AKOTA_9_8bff26e2	MEM_FAM_AKOTA_9_8bff26e2_1	PID_AKOTA_9_1_0683	FORM_AKOTA_9_1_0b89	MockHead 9	MockFather	Patel	\N	9999900009	9999900009	\N	\N	mockhead9@example.com	Akota	Vadodara	390001	1990-01-01	sanyukt	Male	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0083	\N	x1	\N	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-23 03:30:15.852343	\N
hb_akota_14b55b83	FAM_AKOTA_10_f92f7f20	MEM_FAM_AKOTA_10_f92f7f20_1	PID_AKOTA_10_1_ef7e	FORM_AKOTA_10_1_9702	MockHead 10	MockFather	Patel	\N	9999900010	9999900010	\N	\N	mockhead10@example.com	Akota	Vadodara	390001	1990-01-01	sanyukt	Male	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0083	\N	x1	\N	A	f	active	\N	\N	\N	S1	\N	\N	f	accepted	\N	2026-05-23 03:30:15.852343	\N
hb_akota_432528dc	FAM_AKOTA_1_707a7987	MEM_FAM_AKOTA_1_707a7987_2	PID_AKOTA_1_2	FORM_AKOTA_1_2	MockWife 1	MockFather	Patel	\N	9999900101	9999900101	\N	\N	mockwife1@example.com	Akota	Vadodara	390001	1990-01-01	mahila	Female	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	Wife	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0083	\N	x1	\N	A	f	active	\N	\N	\N	G	\N	\N	f	accepted	\N	2026-05-23 03:11:47.86051	2026-05-23 04:57:21.444312
hb_akota_e7b64cee	FAM_AKOTA_1_707a7987	MEM_FAM_AKOTA_1_707a7987_1	PID_AKOTA_1_1	FORM_AKOTA_1_1	MockHead 1	MockFather	Patel	\N	9999900001	9999900001	\N	\N	mockhead1@example.com	Akota	Vadodara	390001	1990-01-01	sanyukt	Male	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0083	\N	x1	k_1779512167068	A	f	active	\N	\N	\N	G	\N	\N	f	accepted	Mandal Sanchalak	2026-05-23 03:11:47.86051	2026-05-23 04:57:21.444312
hb_akota_080e65c3	FAM_AKOTA_3_7b3b847f	MEM_FAM_AKOTA_3_7b3b847f_1	PID_AKOTA_3_1	FORM_AKOTA_3_1	MockHead 3	MockFather	Patel	\N	9999900003	9999900003	\N	\N	mockhead3@example.com	Akota	Vadodara	390001	1990-01-01	sanyukt	Male	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes	\N	f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Yes	m_0083	\N	x1	k_1779512167068	A	f	active	\N	\N	\N	G	\N	\N	f	accepted	Mandal Sanchalak	2026-05-23 03:11:47.86051	2026-05-23 04:57:24.313958
hb_1779512913249	FAM_1779512913249	MEM_FAM_1779512913249_1779512913250	P1779512913782	F1779512913249	Heer 	Hemant 	Patel	\N	0886619464	No	\N	No	heerpatel2754@gmail.com		Vadodara		2006-09-19	sanyukt	Male	\N	\N	\N			\N	\N		\N	["No"]	{}	f	f	\N	\N	\N	No	No	\N	No	No	\N	Sanyukt	\N	\N	c-114 ganga jamuna soc.,Nr.golden silver appt.,Subhanpura ,Vadodara	Gujarat	India	\N	No			f	f	f	f	Father	No	f	f			f	f	t	No	f	No	f	No	No		No		No	No	No	No	No	Yes	m_0083	\N	x1	\N	Select	t	active	\N	fdsgfhgnhj,bdv	\N	G	\N	\N	f	accepted	Mandal Sanchalak	2026-05-23 05:08:33.762941	\N
hb_akota_dda4d523	FAM_AKOTA_10_05afecaa	MEM_FAM_AKOTA_10_05afecaa_1	PID_AKOTA_10_1_4fbf	FORM_AKOTA_10_1_3f4b	Ramesh	Maheshbhai	Patel	\N	9999900010	9999900010	\N	\N	mockhead10@example.com	Akota	Vadodara	390001	1990-01-01	sanyukt	Male	\N	\N	\N		\N	\N	\N	\N	\N	\N	{}	f	f	\N	\N	\N	\N	Sah nirdeshak	2006	Farali	Pravin	\N	\N	\N	\N	\N	\N	\N	S	\N	Yes		f	f	f	f	\N	niyamit	t	f	\N	\N	f	f	t	Regular	t	\N	t	\N	Regular	3 times	Regular	3 times	Yes	Yes	Yes	Yes	Regular	Yes	m_0083	\N	x1	demo_sk_m1_0	A	f	active	\N	\N	\N	G	\N	\N	t	accepted	Sampark Karyakar 1	2026-05-23 03:29:26.492056	2026-05-23 05:25:50.068496
\.


--
-- Data for Name: karyakar_mandals; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.karyakar_mandals (karyakar_id, mandal_id) FROM stdin;
demo_santnirdeshak	m_0001
demo_santnirdeshak	m_0002
demo_santnirdeshak	m_0003
demo_santnirdeshak	m_0004
demo_santnirdeshak	m_0005
demo_santnirdeshak	m_0006
demo_santnirdeshak	m_0007
demo_santnirdeshak	m_0008
demo_santnirdeshak	m_0009
demo_santnirdeshak	m_0010
demo_santnirdeshak	m_0011
demo_santnirdeshak	m_0012
demo_santnirdeshak	m_0013
demo_santnirdeshak	m_0014
demo_santnirdeshak	m_0015
demo_santnirdeshak	m_0016
demo_santnirdeshak	m_0017
demo_santnirdeshak	m_0018
demo_santnirdeshak	m_0019
demo_santnirdeshak	m_0020
demo_santnirdeshak	m_0021
demo_santnirdeshak	m_0022
demo_santnirdeshak	m_0023
demo_santnirdeshak	m_0024
demo_santnirdeshak	m_0025
demo_santnirdeshak	m_0026
demo_santnirdeshak	m_0027
demo_santnirdeshak	m_0028
demo_santnirdeshak	m_0029
demo_santnirdeshak	m_0030
demo_santnirdeshak	m_0031
demo_santnirdeshak	m_0032
demo_santnirdeshak	m_0033
demo_santnirdeshak	m_0034
demo_santnirdeshak	m_0035
demo_santnirdeshak	m_0036
demo_santnirdeshak	m_0037
demo_santnirdeshak	m_0038
demo_santnirdeshak	m_0039
demo_santnirdeshak	m_0040
demo_santnirdeshak	m_0041
demo_santnirdeshak	m_0042
demo_santnirdeshak	m_0043
demo_santnirdeshak	m_0044
demo_santnirdeshak	m_0045
demo_santnirdeshak	m_0046
demo_santnirdeshak	m_0047
demo_santnirdeshak	m_0048
demo_santnirdeshak	m_0049
demo_santnirdeshak	m_0050
demo_santnirdeshak	m_0051
demo_santnirdeshak	m_0052
demo_santnirdeshak	m_0053
demo_santnirdeshak	m_0054
demo_santnirdeshak	m_0055
demo_santnirdeshak	m_0056
demo_santnirdeshak	m_0057
demo_santnirdeshak	m_0058
demo_santnirdeshak	m_0059
demo_santnirdeshak	m_0060
demo_santnirdeshak	m_0061
demo_santnirdeshak	m_0062
demo_santnirdeshak	m_0063
demo_santnirdeshak	m_0064
demo_santnirdeshak	m_0065
demo_santnirdeshak	m_0066
demo_santnirdeshak	m_0067
demo_santnirdeshak	m_0068
demo_santnirdeshak	m_0069
demo_santnirdeshak	m_0070
demo_santnirdeshak	m_0071
demo_santnirdeshak	m_0072
demo_santnirdeshak	m_0073
demo_santnirdeshak	m_0074
demo_santnirdeshak	m_0075
demo_santnirdeshak	m_0076
demo_santnirdeshak	m_0077
demo_santnirdeshak	m_0078
demo_santnirdeshak	m_0079
demo_santnirdeshak	m_0080
demo_santnirdeshak	m_0081
demo_santnirdeshak	m_0082
demo_santnirdeshak	m_0083
demo_santnirdeshak	m_0084
demo_santnirdeshak	m_0085
demo_santnirdeshak	m_0086
demo_santnirdeshak	m_0087
demo_santnirdeshak	m_0088
demo_santnirdeshak	m_0089
demo_santnirdeshak	m_0090
demo_santnirdeshak	m_0091
demo_santnirdeshak	m_0092
demo_santnirdeshak	m_0093
demo_santnirdeshak	m_0094
demo_santnirdeshak	m_0095
demo_santnirdeshak	m_0096
demo_santnirdeshak	m_0097
demo_santnirdeshak	m_0098
demo_santnirdeshak	m_0099
demo_santnirdeshak	m_0100
demo_santnirdeshak	m_0101
demo_santnirdeshak	m_0102
demo_santnirdeshak	m_0103
demo_santnirdeshak	m_0104
demo_santnirdeshak	m_0105
demo_santnirdeshak	m_0106
demo_santnirdeshak	m_0107
demo_santnirdeshak	m_0108
demo_santnirdeshak	m_0109
demo_santnirdeshak	m_0110
demo_santnirdeshak	m_0111
demo_santnirdeshak	m_0112
demo_santnirdeshak	m_0113
demo_santnirdeshak	m_0114
demo_santnirdeshak	m_0115
demo_santnirdeshak	m_0116
demo_santnirdeshak	m_0117
demo_santnirdeshak	m_0118
demo_santnirdeshak	m_0119
demo_santnirdeshak	m_0120
demo_santnirdeshak	m_0121
demo_santnirdeshak	m_0122
demo_santnirdeshak	m_0123
demo_santnirdeshak	m_0124
demo_santnirdeshak	m_0125
demo_santnirdeshak	m_0126
demo_santnirdeshak	m_0127
demo_santnirdeshak	m_0128
demo_santnirdeshak	m_0129
demo_santnirdeshak	m_0130
demo_santnirdeshak	m_0131
demo_santnirdeshak	m_0132
demo_santnirdeshak	m_0133
demo_santnirdeshak	m_0134
demo_santnirdeshak	m_0135
demo_santnirdeshak	m_0136
demo_santnirdeshak	m_0137
demo_santnirdeshak	m_0138
demo_santnirdeshak	m_0139
demo_santnirdeshak	m_0140
demo_santnirdeshak	m_0141
demo_santnirdeshak	m_0142
demo_santnirdeshak	m_0143
demo_santnirdeshak	m_0144
demo_santnirdeshak	m_0145
demo_santnirdeshak	m_0146
demo_santnirdeshak	m_0147
demo_santnirdeshak	m_0148
demo_santnirdeshak	m_0149
demo_santnirdeshak	m_0150
demo_santnirdeshak	m_0151
demo_santnirdeshak	m_0152
demo_santnirdeshak	m_0153
demo_santnirdeshak	m_0154
demo_santnirdeshak	m_0155
demo_santnirdeshak	m_0156
demo_santnirdeshak	m_0157
demo_santnirdeshak	m_0158
demo_santnirdeshak	m_0159
demo_santnirdeshak	m_0160
demo_santnirdeshak	m_0161
demo_santnirdeshak	m_0162
demo_santnirdeshak	m_0163
demo_santnirdeshak	m_0164
demo_santnirdeshak	m_0165
demo_santnirdeshak	m_0166
demo_santnirdeshak	m_0167
demo_santnirdeshak	m_0168
demo_santnirdeshak	m_0169
demo_santnirdeshak	m_0170
demo_santnirdeshak	m_0171
demo_santnirdeshak	m_0172
demo_santnirdeshak	m_0173
demo_santnirdeshak	m_0174
demo_santnirdeshak	m_0175
demo_santnirdeshak	m_0176
demo_santnirdeshak	m_0177
demo_santnirdeshak	m_0178
demo_santnirdeshak	m_0179
demo_santnirdeshak	m_0180
demo_santnirdeshak	m_0181
demo_santnirdeshak	m_0182
demo_santnirdeshak	m_0183
demo_santnirdeshak	m_0184
demo_santnirdeshak	m_0185
demo_santnirdeshak	m_0186
demo_santnirdeshak	m_0187
demo_santnirdeshak	m_0188
demo_santnirdeshak	m_0189
demo_santnirdeshak	m_0190
demo_santnirdeshak	m_0191
demo_santnirdeshak	m_0192
demo_santnirdeshak	m_0193
demo_santnirdeshak	m_0194
demo_santnirdeshak	m_0195
demo_santnirdeshak	m_0196
demo_santnirdeshak	m_0197
demo_santnirdeshak	m_0198
demo_santnirdeshak	m_0199
demo_santnirdeshak	m_0200
demo_santnirdeshak	m_0201
demo_santnirdeshak	m_0202
demo_santnirdeshak	m_0203
demo_santnirdeshak	m_0204
demo_santnirdeshak	m_0205
demo_santnirdeshak	m_0206
demo_santnirdeshak	m_0207
demo_santnirdeshak	m_0208
demo_santnirdeshak	m_0209
demo_santnirdeshak	m_0210
demo_santnirdeshak	m_0211
demo_santnirdeshak	m_0212
demo_santnirdeshak	m_0213
demo_santnirdeshak	m_0214
demo_santnirdeshak	m_0215
demo_santnirdeshak	m_0216
demo_santnirdeshak	m_0217
demo_santnirdeshak	m_0218
demo_santnirdeshak	m_0219
demo_santnirdeshak	m_0220
demo_santnirdeshak	m_0221
demo_santnirdeshak	m_0222
demo_santnirdeshak	m_0223
demo_santnirdeshak	m_0224
demo_santnirdeshak	m_0225
demo_santnirdeshak	m_0226
demo_santnirdeshak	m_0227
demo_santnirdeshak	m_0228
demo_santnirdeshak	m_0229
demo_santnirdeshak	m_0230
demo_santnirdeshak	m_0231
demo_santnirdeshak	m_0232
demo_santnirdeshak	m_0233
demo_santnirdeshak	m_0234
demo_santnirdeshak	m_0235
demo_santnirdeshak	m_0236
demo_santnirdeshak	m_0237
demo_santnirdeshak	m_0238
demo_santnirdeshak	m_0239
demo_santnirdeshak	m_0240
demo_santnirdeshak	m_0241
demo_santnirdeshak	m_0242
demo_santnirdeshak	m_0243
demo_santnirdeshak	m_0244
demo_santnirdeshak	m_0245
demo_santnirdeshak	m_0246
demo_santnirdeshak	m_0247
demo_santnirdeshak	m_0248
demo_santnirdeshak	m_0249
demo_santnirdeshak	m_0250
demo_santnirdeshak	m_0251
demo_santnirdeshak	m_0252
demo_santnirdeshak	m_0253
demo_santnirdeshak	m_0254
demo_santnirdeshak	m_0255
demo_santnirdeshak	m_0256
demo_santnirdeshak	m_0257
demo_santnirdeshak	m_0258
demo_santnirdeshak	m_0259
demo_santnirdeshak	m_0260
demo_santnirdeshak	m_0261
demo_santnirdeshak	m_0262
demo_santnirdeshak	m_0263
demo_santnirdeshak	m_0264
demo_santnirdeshak	m_0265
demo_santnirdeshak	m_0266
demo_santnirdeshak	m_0267
demo_santnirdeshak	m_0268
demo_santnirdeshak	m_0269
demo_santnirdeshak	m_0270
demo_santnirdeshak	m_0271
demo_santnirdeshak	m_0272
demo_santnirdeshak	m_0273
demo_santnirdeshak	m_0274
demo_santnirdeshak	m_0275
demo_santnirdeshak	m_0276
demo_santnirdeshak	m_0277
demo_santnirdeshak	m_0278
demo_santnirdeshak	m_0279
demo_santnirdeshak	m_0280
demo_santnirdeshak	m_0281
demo_santnirdeshak	m_0282
demo_sanyojak1	m_0001
demo_sanyojak1	m_0002
demo_sanyojak1	m_0003
demo_sanyojak1	m_0004
demo_sanyojak1	m_0005
demo_sanyojak1	m_0006
demo_sanyojak1	m_0007
demo_sanyojak1	m_0008
demo_sanyojak1	m_0009
demo_sanyojak1	m_0010
demo_sanyojak1	m_0011
demo_sanyojak1	m_0012
demo_sanyojak1	m_0013
demo_sanyojak1	m_0014
demo_sanyojak1	m_0015
demo_sanyojak1	m_0016
demo_sanyojak1	m_0017
demo_sanyojak1	m_0018
demo_sanyojak1	m_0019
demo_sanyojak1	m_0020
demo_sanyojak1	m_0021
demo_sanyojak1	m_0022
demo_sanyojak1	m_0023
demo_sanyojak1	m_0024
demo_sanyojak1	m_0025
demo_sanyojak1	m_0026
demo_sanyojak1	m_0027
demo_sanyojak1	m_0028
demo_sanyojak1	m_0029
demo_sanyojak1	m_0030
demo_sanyojak1	m_0031
demo_sanyojak1	m_0032
demo_sanyojak1	m_0033
demo_sanyojak1	m_0034
demo_sanyojak1	m_0035
demo_sanyojak1	m_0036
demo_sanyojak1	m_0037
demo_sanyojak1	m_0038
demo_sanyojak1	m_0039
demo_sanyojak1	m_0040
demo_sanyojak1	m_0041
demo_sanyojak1	m_0042
demo_sanyojak1	m_0043
demo_sanyojak1	m_0044
demo_sanyojak1	m_0045
demo_sanyojak1	m_0046
demo_sanyojak1	m_0047
demo_sanyojak1	m_0048
demo_sanyojak1	m_0049
demo_sanyojak1	m_0050
demo_sanyojak1	m_0051
demo_sanyojak1	m_0052
demo_sanyojak1	m_0053
demo_sanyojak1	m_0054
demo_sanyojak1	m_0055
demo_sanyojak1	m_0056
demo_sanyojak1	m_0057
demo_sanyojak1	m_0058
demo_sanyojak1	m_0059
demo_sanyojak1	m_0060
demo_sanyojak1	m_0061
demo_sanyojak1	m_0062
demo_sanyojak1	m_0063
demo_sanyojak1	m_0064
demo_sanyojak1	m_0065
demo_sanyojak1	m_0066
demo_sanyojak1	m_0067
demo_sanyojak1	m_0068
demo_sanyojak1	m_0069
demo_sanyojak1	m_0070
demo_sanyojak1	m_0071
demo_sanyojak1	m_0072
demo_sanyojak1	m_0073
demo_sanyojak1	m_0074
demo_sanyojak1	m_0075
demo_sanyojak1	m_0076
demo_sanyojak1	m_0077
demo_sanyojak1	m_0078
demo_sanyojak1	m_0079
demo_sanyojak1	m_0080
demo_sanyojak1	m_0081
demo_sanyojak1	m_0082
demo_sanyojak1	m_0083
demo_sanyojak1	m_0084
demo_sanyojak1	m_0085
demo_sanyojak1	m_0086
demo_sanyojak1	m_0087
demo_sanyojak1	m_0088
demo_sanyojak1	m_0089
demo_sanyojak1	m_0090
demo_sanyojak1	m_0091
demo_sanyojak1	m_0092
demo_sanyojak1	m_0093
demo_sanyojak1	m_0094
demo_sanyojak1	m_0095
demo_sanyojak1	m_0096
demo_sanyojak1	m_0097
demo_sanyojak1	m_0098
demo_sanyojak1	m_0099
demo_sanyojak1	m_0100
demo_sanyojak1	m_0101
demo_sanyojak1	m_0102
demo_sanyojak1	m_0103
demo_sanyojak1	m_0104
demo_sanyojak1	m_0105
demo_sanyojak1	m_0106
demo_sanyojak1	m_0107
demo_sanyojak1	m_0108
demo_sanyojak1	m_0109
demo_sanyojak1	m_0110
demo_sanyojak1	m_0111
demo_sanyojak1	m_0112
demo_sanyojak1	m_0113
demo_sanyojak1	m_0114
demo_sanyojak1	m_0115
demo_sanyojak1	m_0116
demo_sanyojak1	m_0117
demo_sanyojak1	m_0118
demo_sanyojak1	m_0119
demo_sanyojak1	m_0120
demo_sanyojak1	m_0121
demo_sanyojak1	m_0122
demo_sanyojak1	m_0123
demo_sanyojak1	m_0124
demo_sanyojak1	m_0125
demo_sanyojak1	m_0126
demo_sanyojak1	m_0127
demo_sanyojak1	m_0128
demo_sanyojak1	m_0129
demo_sanyojak1	m_0130
demo_sanyojak1	m_0131
demo_sanyojak1	m_0132
demo_sanyojak1	m_0133
demo_sanyojak1	m_0134
demo_sanyojak1	m_0135
demo_sanyojak1	m_0136
demo_sanyojak1	m_0137
demo_sanyojak1	m_0138
demo_sanyojak1	m_0139
demo_sanyojak1	m_0140
demo_sanyojak1	m_0141
demo_sanyojak1	m_0142
demo_sanyojak1	m_0143
demo_sanyojak1	m_0144
demo_sanyojak1	m_0145
demo_sanyojak1	m_0146
demo_sanyojak1	m_0147
demo_sanyojak1	m_0148
demo_sanyojak1	m_0149
demo_sanyojak1	m_0150
demo_sanyojak1	m_0151
demo_sanyojak1	m_0152
demo_sanyojak1	m_0153
demo_sanyojak1	m_0154
demo_sanyojak1	m_0155
demo_sanyojak1	m_0156
demo_sanyojak1	m_0157
demo_sanyojak1	m_0158
demo_sanyojak1	m_0159
demo_sanyojak1	m_0160
demo_sanyojak1	m_0161
demo_sanyojak1	m_0162
demo_sanyojak1	m_0163
demo_sanyojak1	m_0164
demo_sanyojak1	m_0165
demo_sanyojak1	m_0166
demo_sanyojak1	m_0167
demo_sanyojak1	m_0168
demo_sanyojak1	m_0169
demo_sanyojak1	m_0170
demo_sanyojak1	m_0171
demo_sanyojak1	m_0172
demo_sanyojak1	m_0173
demo_sanyojak1	m_0174
demo_sanyojak1	m_0175
demo_sanyojak1	m_0176
demo_sanyojak1	m_0177
demo_sanyojak1	m_0178
demo_sanyojak1	m_0179
demo_sanyojak1	m_0180
demo_sanyojak1	m_0181
demo_sanyojak1	m_0182
demo_sanyojak1	m_0183
demo_sanyojak1	m_0184
demo_sanyojak1	m_0185
demo_sanyojak1	m_0186
demo_sanyojak1	m_0187
demo_sanyojak1	m_0188
demo_sanyojak1	m_0189
demo_sanyojak1	m_0190
demo_sanyojak1	m_0191
demo_sanyojak1	m_0192
demo_sanyojak1	m_0193
demo_sanyojak1	m_0194
demo_sanyojak1	m_0195
demo_sanyojak1	m_0196
demo_sanyojak1	m_0197
demo_sanyojak1	m_0198
demo_sanyojak1	m_0199
demo_sanyojak1	m_0200
demo_sanyojak1	m_0201
demo_sanyojak1	m_0202
demo_sanyojak1	m_0203
demo_sanyojak1	m_0204
demo_sanyojak1	m_0205
demo_sanyojak1	m_0206
demo_sanyojak1	m_0207
demo_sanyojak1	m_0208
demo_sanyojak1	m_0209
demo_sanyojak1	m_0210
demo_sanyojak1	m_0211
demo_sanyojak1	m_0212
demo_sanyojak1	m_0213
demo_sanyojak1	m_0214
demo_sanyojak1	m_0215
demo_sanyojak1	m_0216
demo_sanyojak1	m_0217
demo_sanyojak1	m_0218
demo_sanyojak1	m_0219
demo_sanyojak1	m_0220
demo_sanyojak1	m_0221
demo_sanyojak1	m_0222
demo_sanyojak1	m_0223
demo_sanyojak1	m_0224
demo_sanyojak1	m_0225
demo_sanyojak1	m_0226
demo_sanyojak1	m_0227
demo_sanyojak1	m_0228
demo_sanyojak1	m_0229
demo_sanyojak1	m_0230
demo_sanyojak1	m_0231
demo_sanyojak1	m_0232
demo_sanyojak1	m_0233
demo_sanyojak1	m_0234
demo_sanyojak1	m_0235
demo_sanyojak1	m_0236
demo_sanyojak1	m_0237
demo_sanyojak1	m_0238
demo_sanyojak1	m_0239
demo_sanyojak1	m_0240
demo_sanyojak1	m_0241
demo_sanyojak1	m_0242
demo_sanyojak1	m_0243
demo_sanyojak1	m_0244
demo_sanyojak1	m_0245
demo_sanyojak1	m_0246
demo_sanyojak1	m_0247
demo_sanyojak1	m_0248
demo_sanyojak1	m_0249
demo_sanyojak1	m_0250
demo_sanyojak1	m_0251
demo_sanyojak1	m_0252
demo_sanyojak1	m_0253
demo_sanyojak1	m_0254
demo_sanyojak1	m_0255
demo_sanyojak1	m_0256
demo_sanyojak1	m_0257
demo_sanyojak1	m_0258
demo_sanyojak1	m_0259
demo_sanyojak1	m_0260
demo_sanyojak1	m_0261
demo_sanyojak1	m_0262
demo_sanyojak1	m_0263
demo_sanyojak1	m_0264
demo_sanyojak1	m_0265
demo_sanyojak1	m_0266
demo_sanyojak1	m_0267
demo_sanyojak1	m_0268
demo_sanyojak1	m_0269
demo_sanyojak1	m_0270
demo_sanyojak1	m_0271
demo_sanyojak1	m_0272
demo_sanyojak1	m_0273
demo_sanyojak1	m_0274
demo_sanyojak1	m_0275
demo_sanyojak1	m_0276
demo_sanyojak1	m_0277
demo_sanyojak1	m_0278
demo_sanyojak1	m_0279
demo_sanyojak1	m_0280
demo_sanyojak1	m_0281
demo_sanyojak1	m_0282
demo_nirdeshak1	m_0001
demo_nirdeshak1	m_0002
demo_nirdeshak1	m_0003
demo_nirdeshak1	m_0004
demo_nirdeshak1	m_0005
demo_nirdeshak1	m_0006
demo_nirdeshak1	m_0007
demo_nirdeshak1	m_0008
demo_nirdeshak1	m_0009
demo_nirdeshak1	m_0010
demo_nirdeshak1	m_0011
demo_nirdeshak1	m_0012
demo_nirdeshak1	m_0013
demo_nirdeshak1	m_0014
demo_nirdeshak1	m_0015
demo_nirdeshak1	m_0016
demo_nirdeshak1	m_0017
demo_nirdeshak1	m_0018
demo_nirdeshak1	m_0019
demo_nirdeshak1	m_0020
demo_nirdeshak1	m_0021
demo_nirdeshak1	m_0022
demo_nirdeshak1	m_0023
demo_nirdeshak1	m_0024
demo_nirdeshak1	m_0083
demo_nirdeshak1	m_0084
demo_nirdeshak1	m_0085
demo_nirdeshak1	m_0086
demo_nirdeshak1	m_0087
demo_nirdeshak1	m_0088
demo_nirdeshak1	m_0089
demo_nirdeshak1	m_0090
demo_nirdeshak1	m_0091
demo_nirdeshak1	m_0092
demo_nirdeshak1	m_0093
demo_nirdeshak1	m_0117
demo_nirdeshak1	m_0118
demo_nirdeshak1	m_0119
demo_nirdeshak1	m_0120
demo_nirdeshak1	m_0121
demo_nirdeshak1	m_0122
demo_nirdeshak1	m_0123
demo_nirdeshak1	m_0139
demo_nirdeshak1	m_0140
demo_nirdeshak1	m_0141
demo_nirdeshak1	m_0142
demo_nirdeshak1	m_0143
demo_nirdeshak1	m_0144
demo_nirdeshak1	m_0145
demo_nirdeshak1	m_0146
demo_nirdeshak1	m_0168
demo_nirdeshak1	m_0169
demo_nirdeshak1	m_0170
demo_nirdeshak1	m_0171
demo_nirdeshak1	m_0172
demo_nirdeshak1	m_0173
demo_nirdeshak1	m_0174
demo_nirdeshak1	m_0175
demo_nirdeshak1	m_0176
demo_nirdeshak1	m_0177
demo_nirdeshak1	m_0178
demo_nirdeshak1	m_0179
demo_nirdeshak1	m_0180
demo_nirdeshak1	m_0181
demo_nirdeshak1	m_0182
demo_nirdeshak1	m_0183
demo_nirdeshak1	m_0184
demo_nirdeshak1	m_0185
demo_nirdeshak1	m_0186
demo_nirdeshak1	m_0187
demo_nirdeshak1	m_0188
demo_nirdeshak1	m_0189
demo_nirdeshak1	m_0190
demo_nirdeshak1	m_0191
demo_nirdeshak1	m_0192
demo_nirdeshak1	m_0193
demo_nirdeshak1	m_0194
demo_nirdeshak1	m_0195
demo_nirdeshak1	m_0196
demo_nirdeshak1	m_0197
demo_nirdeshak1	m_0198
demo_nirdeshak1	m_0269
demo_nirdeshak1	m_0270
demo_nirdeshak1	m_0271
demo_nirdeshak1	m_0272
demo_nirdeshak1	m_0273
demo_nirdeshak1	m_0274
demo_nirdeshak1	m_0275
demo_nirdeshak1	m_0276
demo_nirdeshak2	m_0025
demo_nirdeshak2	m_0026
demo_nirdeshak2	m_0027
demo_nirdeshak2	m_0028
demo_nirdeshak2	m_0029
demo_nirdeshak2	m_0030
demo_nirdeshak2	m_0031
demo_nirdeshak2	m_0032
demo_nirdeshak2	m_0033
demo_nirdeshak2	m_0034
demo_nirdeshak2	m_0035
demo_nirdeshak2	m_0036
demo_nirdeshak2	m_0037
demo_nirdeshak2	m_0038
demo_nirdeshak2	m_0039
demo_nirdeshak2	m_0040
demo_nirdeshak2	m_0041
demo_nirdeshak2	m_0042
demo_nirdeshak2	m_0043
demo_nirdeshak2	m_0044
demo_nirdeshak2	m_0045
demo_nirdeshak2	m_0046
demo_nirdeshak2	m_0047
demo_nirdeshak2	m_0048
demo_nirdeshak2	m_0049
demo_nirdeshak2	m_0050
demo_nirdeshak2	m_0051
demo_nirdeshak2	m_0052
demo_nirdeshak2	m_0053
demo_nirdeshak2	m_0054
demo_nirdeshak2	m_0055
demo_nirdeshak2	m_0056
demo_nirdeshak2	m_0094
demo_nirdeshak2	m_0095
demo_nirdeshak2	m_0096
demo_nirdeshak2	m_0097
demo_nirdeshak2	m_0098
demo_nirdeshak2	m_0099
demo_nirdeshak2	m_0100
demo_nirdeshak2	m_0101
demo_nirdeshak2	m_0102
demo_nirdeshak2	m_0103
demo_nirdeshak2	m_0104
demo_nirdeshak2	m_0124
demo_nirdeshak2	m_0125
demo_nirdeshak2	m_0126
demo_nirdeshak2	m_0127
demo_nirdeshak2	m_0128
demo_nirdeshak2	m_0129
demo_nirdeshak2	m_0130
demo_nirdeshak2	m_0131
demo_nirdeshak2	m_0147
demo_nirdeshak2	m_0148
demo_nirdeshak2	m_0149
demo_nirdeshak2	m_0150
demo_nirdeshak2	m_0151
demo_nirdeshak2	m_0152
demo_nirdeshak2	m_0153
demo_nirdeshak2	m_0154
demo_nirdeshak2	m_0155
demo_nirdeshak2	m_0156
demo_nirdeshak2	m_0157
demo_nirdeshak2	m_0158
demo_nirdeshak2	m_0159
demo_nirdeshak2	m_0199
demo_nirdeshak2	m_0200
demo_nirdeshak2	m_0201
demo_nirdeshak2	m_0202
demo_nirdeshak2	m_0203
demo_nirdeshak2	m_0204
demo_nirdeshak2	m_0205
demo_nirdeshak2	m_0206
demo_nirdeshak2	m_0207
demo_nirdeshak2	m_0208
demo_nirdeshak2	m_0209
demo_nirdeshak2	m_0210
demo_nirdeshak2	m_0211
demo_nirdeshak2	m_0212
demo_nirdeshak2	m_0213
demo_nirdeshak2	m_0214
demo_nirdeshak2	m_0215
demo_nirdeshak2	m_0216
demo_nirdeshak2	m_0217
demo_nirdeshak2	m_0218
demo_nirdeshak2	m_0219
demo_nirdeshak2	m_0220
demo_nirdeshak2	m_0221
demo_nirdeshak2	m_0222
demo_nirdeshak2	m_0223
demo_nirdeshak2	m_0224
demo_nirdeshak2	m_0225
demo_nirdeshak2	m_0226
demo_nirdeshak2	m_0227
demo_nirdeshak2	m_0228
demo_nirdeshak2	m_0229
demo_nirdeshak2	m_0230
demo_nirdeshak2	m_0231
demo_nirdeshak2	m_0232
demo_nirdeshak2	m_0233
demo_nirdeshak2	m_0234
demo_nirdeshak2	m_0235
demo_nirdeshak2	m_0236
demo_nirdeshak2	m_0237
demo_nirdeshak2	m_0238
demo_nirdeshak2	m_0239
demo_nirdeshak2	m_0240
demo_nirdeshak2	m_0241
demo_nirdeshak2	m_0242
demo_nirdeshak2	m_0243
demo_nirdeshak2	m_0244
demo_nirdeshak2	m_0245
demo_nirdeshak2	m_0246
demo_nirdeshak2	m_0247
demo_nirdeshak2	m_0248
demo_nirdeshak2	m_0249
demo_nirdeshak3	m_0057
demo_nirdeshak3	m_0058
demo_nirdeshak3	m_0059
demo_nirdeshak3	m_0060
demo_nirdeshak3	m_0061
demo_nirdeshak3	m_0062
demo_nirdeshak3	m_0063
demo_nirdeshak3	m_0064
demo_nirdeshak3	m_0065
demo_nirdeshak3	m_0066
demo_nirdeshak3	m_0067
demo_nirdeshak3	m_0068
demo_nirdeshak3	m_0069
demo_nirdeshak3	m_0070
demo_nirdeshak3	m_0071
demo_nirdeshak3	m_0072
demo_nirdeshak3	m_0073
demo_nirdeshak3	m_0074
demo_nirdeshak3	m_0075
demo_nirdeshak3	m_0076
demo_nirdeshak3	m_0077
demo_nirdeshak3	m_0078
demo_nirdeshak3	m_0079
demo_nirdeshak3	m_0080
demo_nirdeshak3	m_0081
demo_nirdeshak3	m_0082
demo_nirdeshak3	m_0105
demo_nirdeshak3	m_0106
demo_nirdeshak3	m_0107
demo_nirdeshak3	m_0108
demo_nirdeshak3	m_0109
demo_nirdeshak3	m_0110
demo_nirdeshak3	m_0111
demo_nirdeshak3	m_0112
demo_nirdeshak3	m_0113
demo_nirdeshak3	m_0114
demo_nirdeshak3	m_0115
demo_nirdeshak3	m_0116
demo_nirdeshak3	m_0132
demo_nirdeshak3	m_0133
demo_nirdeshak3	m_0134
demo_nirdeshak3	m_0135
demo_nirdeshak3	m_0136
demo_nirdeshak3	m_0137
demo_nirdeshak3	m_0138
demo_nirdeshak3	m_0160
demo_nirdeshak3	m_0161
demo_nirdeshak3	m_0162
demo_nirdeshak3	m_0163
demo_nirdeshak3	m_0164
demo_nirdeshak3	m_0165
demo_nirdeshak3	m_0166
demo_nirdeshak3	m_0167
demo_nirdeshak3	m_0250
demo_nirdeshak3	m_0251
demo_nirdeshak3	m_0252
demo_nirdeshak3	m_0253
demo_nirdeshak3	m_0254
demo_nirdeshak3	m_0255
demo_nirdeshak3	m_0256
demo_nirdeshak3	m_0257
demo_nirdeshak3	m_0258
demo_nirdeshak3	m_0259
demo_nirdeshak3	m_0260
demo_nirdeshak3	m_0261
demo_nirdeshak3	m_0262
demo_nirdeshak3	m_0263
demo_nirdeshak3	m_0264
demo_nirdeshak3	m_0265
demo_nirdeshak3	m_0266
demo_nirdeshak3	m_0267
demo_nirdeshak3	m_0268
demo_nirdeshak3	m_0277
demo_nirdeshak3	m_0278
demo_nirdeshak3	m_0279
demo_nirdeshak3	m_0280
demo_nirdeshak3	m_0281
demo_nirdeshak3	m_0282
demo_sah_nirdeshak1	m_0083
demo_sah_nirdeshak1	m_0084
demo_sah_nirdeshak1	m_0085
demo_nirikshak1	m_0083
demo_ms_m1_0	m_0083
demo_sk_m1_0	m_0083
k_1	m_0083
k_1	m_0084
k_1	m_0085
k_1	m_0086
k_1	m_0087
k_1	m_0088
k_1	m_0089
k_1	m_0090
k_1	m_0091
k_1	m_0092
k_1	m_0093
k_2	m_0083
k_3	m_0083
k_4	m_0084
k_5	m_0084
k_6	m_0085
k_7	m_0085
k_8	m_0086
k_9	m_0086
k_10	m_0087
k_11	m_0087
k_12	m_0088
k_13	m_0088
k_14	m_0089
k_15	m_0089
k_16	m_0090
k_17	m_0090
k_18	m_0091
k_19	m_0091
k_20	m_0092
k_21	m_0092
k_22	m_0093
k_23	m_0093
k_24	m_0094
k_24	m_0095
k_24	m_0096
k_24	m_0097
k_24	m_0098
k_24	m_0099
k_24	m_0100
k_24	m_0101
k_24	m_0102
k_24	m_0103
k_24	m_0104
k_25	m_0094
k_26	m_0094
k_27	m_0095
k_28	m_0095
k_29	m_0096
k_30	m_0096
k_31	m_0097
k_32	m_0097
k_33	m_0098
k_34	m_0098
k_35	m_0099
k_36	m_0099
k_37	m_0100
k_38	m_0100
k_39	m_0101
k_40	m_0101
k_41	m_0102
k_42	m_0102
k_43	m_0103
k_44	m_0103
k_45	m_0104
k_46	m_0104
k_47	m_0105
k_47	m_0106
k_47	m_0107
k_47	m_0108
k_47	m_0109
k_47	m_0110
k_47	m_0111
k_47	m_0112
k_47	m_0113
k_47	m_0114
k_47	m_0115
k_47	m_0116
k_48	m_0105
k_49	m_0105
k_50	m_0106
k_51	m_0106
k_52	m_0107
k_53	m_0107
k_54	m_0108
k_55	m_0108
k_56	m_0109
k_57	m_0109
k_58	m_0110
k_59	m_0110
k_60	m_0111
k_61	m_0111
k_62	m_0112
k_63	m_0112
k_64	m_0113
k_65	m_0113
k_66	m_0114
k_67	m_0114
k_68	m_0115
k_69	m_0115
k_70	m_0116
k_71	m_0116
k_72	m_0117
k_72	m_0118
k_72	m_0119
k_72	m_0120
k_72	m_0121
k_72	m_0122
k_72	m_0123
k_73	m_0117
k_74	m_0117
k_75	m_0118
k_76	m_0118
k_77	m_0119
k_78	m_0119
k_79	m_0120
k_80	m_0120
k_81	m_0121
k_82	m_0121
k_83	m_0122
k_84	m_0122
k_85	m_0123
k_86	m_0123
k_87	m_0124
k_87	m_0125
k_87	m_0126
k_87	m_0127
k_87	m_0128
k_87	m_0129
k_87	m_0130
k_87	m_0131
k_88	m_0124
k_89	m_0124
k_90	m_0125
k_91	m_0125
k_92	m_0126
k_93	m_0126
k_94	m_0127
k_95	m_0127
k_96	m_0128
k_97	m_0128
k_98	m_0129
k_99	m_0129
k_100	m_0130
k_101	m_0130
k_102	m_0131
k_103	m_0131
k_104	m_0132
k_104	m_0133
k_104	m_0134
k_104	m_0135
k_104	m_0136
k_104	m_0137
k_104	m_0138
k_105	m_0132
k_106	m_0132
k_107	m_0133
k_108	m_0133
k_109	m_0134
k_110	m_0134
k_111	m_0135
k_112	m_0135
k_113	m_0136
k_114	m_0136
k_115	m_0137
k_116	m_0137
k_117	m_0138
k_118	m_0138
k_119	m_0139
k_119	m_0140
k_119	m_0141
k_119	m_0142
k_119	m_0143
k_119	m_0144
k_119	m_0145
k_119	m_0146
k_120	m_0139
k_121	m_0139
k_122	m_0140
k_123	m_0140
k_124	m_0141
k_125	m_0141
k_126	m_0142
k_127	m_0142
k_128	m_0143
k_129	m_0143
k_130	m_0144
k_131	m_0144
k_132	m_0145
k_133	m_0145
k_134	m_0146
k_135	m_0146
k_136	m_0147
k_136	m_0148
k_136	m_0149
k_136	m_0150
k_136	m_0151
k_136	m_0152
k_136	m_0153
k_136	m_0154
k_136	m_0155
k_136	m_0156
k_136	m_0157
k_136	m_0158
k_136	m_0159
k_137	m_0147
k_138	m_0147
k_139	m_0148
k_140	m_0148
k_141	m_0149
k_142	m_0149
k_143	m_0150
k_144	m_0150
k_145	m_0151
k_146	m_0151
k_147	m_0152
k_148	m_0152
k_149	m_0153
k_150	m_0153
k_151	m_0154
k_152	m_0154
k_153	m_0155
k_154	m_0155
k_155	m_0156
k_156	m_0156
k_157	m_0157
k_158	m_0157
k_159	m_0158
k_160	m_0158
k_161	m_0159
k_162	m_0159
k_163	m_0160
k_163	m_0161
k_163	m_0162
k_163	m_0163
k_163	m_0164
k_163	m_0165
k_163	m_0166
k_163	m_0167
k_164	m_0160
k_165	m_0160
k_166	m_0161
k_167	m_0161
k_168	m_0162
k_169	m_0162
k_170	m_0163
k_171	m_0163
k_172	m_0164
k_173	m_0164
k_174	m_0165
k_175	m_0165
k_176	m_0166
k_177	m_0166
k_178	m_0167
k_179	m_0167
k_180	m_0001
k_180	m_0002
k_180	m_0003
k_180	m_0004
k_180	m_0005
k_180	m_0006
k_180	m_0007
k_180	m_0008
k_180	m_0009
k_180	m_0010
k_180	m_0011
k_180	m_0012
k_180	m_0013
k_180	m_0014
k_180	m_0015
k_180	m_0016
k_180	m_0017
k_180	m_0018
k_180	m_0019
k_180	m_0020
k_180	m_0021
k_180	m_0022
k_180	m_0023
k_180	m_0024
k_181	m_0001
k_182	m_0001
k_183	m_0002
k_184	m_0002
k_185	m_0003
k_186	m_0003
k_187	m_0004
k_188	m_0004
k_189	m_0005
k_190	m_0005
k_191	m_0006
k_192	m_0006
k_193	m_0007
k_194	m_0007
k_195	m_0008
k_196	m_0008
k_197	m_0009
k_198	m_0009
k_199	m_0010
k_200	m_0010
k_201	m_0011
k_202	m_0011
k_203	m_0012
k_204	m_0012
k_205	m_0013
k_206	m_0013
k_207	m_0014
k_208	m_0014
k_209	m_0015
k_210	m_0015
k_211	m_0016
k_212	m_0016
k_213	m_0017
k_214	m_0017
k_215	m_0018
k_216	m_0018
k_217	m_0019
k_218	m_0019
k_219	m_0020
k_220	m_0020
k_221	m_0021
k_222	m_0021
k_223	m_0022
k_224	m_0022
k_225	m_0023
k_226	m_0023
k_227	m_0024
k_228	m_0024
k_229	m_0025
k_229	m_0026
k_229	m_0027
k_229	m_0028
k_229	m_0029
k_229	m_0030
k_229	m_0031
k_229	m_0032
k_229	m_0033
k_229	m_0034
k_229	m_0035
k_229	m_0036
k_229	m_0037
k_229	m_0038
k_229	m_0039
k_229	m_0040
k_229	m_0041
k_229	m_0042
k_229	m_0043
k_229	m_0044
k_229	m_0045
k_229	m_0046
k_229	m_0047
k_229	m_0048
k_229	m_0049
k_229	m_0050
k_229	m_0051
k_229	m_0052
k_229	m_0053
k_229	m_0054
k_229	m_0055
k_229	m_0056
k_230	m_0025
k_231	m_0025
k_232	m_0026
k_233	m_0026
k_234	m_0027
k_235	m_0027
k_236	m_0028
k_237	m_0028
k_238	m_0029
k_239	m_0029
k_240	m_0030
k_241	m_0030
k_242	m_0031
k_243	m_0031
k_244	m_0032
k_245	m_0032
k_246	m_0033
k_247	m_0033
k_248	m_0034
k_249	m_0034
k_250	m_0035
k_251	m_0035
k_252	m_0036
k_253	m_0036
k_254	m_0037
k_255	m_0037
k_256	m_0038
k_257	m_0038
k_258	m_0039
k_259	m_0039
k_260	m_0040
k_261	m_0040
k_262	m_0041
k_263	m_0041
k_264	m_0042
k_265	m_0042
k_266	m_0043
k_267	m_0043
k_268	m_0044
k_269	m_0044
k_270	m_0045
k_271	m_0045
k_272	m_0046
k_273	m_0046
k_274	m_0047
k_275	m_0047
k_276	m_0048
k_277	m_0048
k_278	m_0049
k_279	m_0049
k_280	m_0050
k_281	m_0050
k_282	m_0051
k_283	m_0051
k_284	m_0052
k_285	m_0052
k_286	m_0053
k_287	m_0053
k_288	m_0054
k_289	m_0054
k_290	m_0055
k_291	m_0055
k_292	m_0056
k_293	m_0056
k_294	m_0057
k_294	m_0058
k_294	m_0059
k_294	m_0060
k_294	m_0061
k_294	m_0062
k_294	m_0063
k_294	m_0064
k_294	m_0065
k_294	m_0066
k_294	m_0067
k_294	m_0068
k_294	m_0069
k_294	m_0070
k_294	m_0071
k_294	m_0072
k_294	m_0073
k_294	m_0074
k_294	m_0075
k_294	m_0076
k_294	m_0077
k_294	m_0078
k_294	m_0079
k_294	m_0080
k_294	m_0081
k_294	m_0082
k_295	m_0057
k_296	m_0057
k_297	m_0058
k_298	m_0058
k_299	m_0059
k_300	m_0059
k_301	m_0060
k_302	m_0060
k_303	m_0061
k_304	m_0061
k_305	m_0062
k_306	m_0062
k_307	m_0063
k_308	m_0063
k_309	m_0064
k_310	m_0064
k_311	m_0065
k_312	m_0065
k_313	m_0066
k_314	m_0066
k_315	m_0067
k_316	m_0067
k_317	m_0068
k_318	m_0068
k_319	m_0069
k_320	m_0069
k_321	m_0070
k_322	m_0070
k_323	m_0071
k_324	m_0071
k_325	m_0072
k_326	m_0072
k_327	m_0073
k_328	m_0073
k_329	m_0074
k_330	m_0074
k_331	m_0075
k_332	m_0075
k_333	m_0076
k_334	m_0076
k_335	m_0077
k_336	m_0077
k_337	m_0078
k_338	m_0078
k_339	m_0079
k_340	m_0079
k_341	m_0080
k_342	m_0080
k_343	m_0081
k_344	m_0081
k_345	m_0082
k_346	m_0082
k_347	m_0168
k_347	m_0169
k_347	m_0170
k_347	m_0171
k_347	m_0172
k_347	m_0173
k_347	m_0174
k_347	m_0175
k_347	m_0176
k_347	m_0177
k_347	m_0178
k_347	m_0179
k_347	m_0180
k_347	m_0181
k_347	m_0182
k_347	m_0183
k_347	m_0184
k_347	m_0185
k_347	m_0186
k_347	m_0187
k_347	m_0188
k_347	m_0189
k_347	m_0190
k_347	m_0191
k_347	m_0192
k_347	m_0193
k_347	m_0194
k_347	m_0195
k_347	m_0196
k_347	m_0197
k_347	m_0198
k_348	m_0168
k_349	m_0168
k_350	m_0169
k_351	m_0169
k_352	m_0170
k_353	m_0170
k_354	m_0171
k_355	m_0171
k_356	m_0172
k_357	m_0172
k_358	m_0173
k_359	m_0173
k_360	m_0174
k_361	m_0174
k_362	m_0175
k_363	m_0175
k_364	m_0176
k_365	m_0176
k_366	m_0177
k_367	m_0177
k_368	m_0178
k_369	m_0178
k_370	m_0179
k_371	m_0179
k_372	m_0180
k_373	m_0180
k_374	m_0181
k_375	m_0181
k_376	m_0182
k_377	m_0182
k_378	m_0183
k_379	m_0183
k_380	m_0184
k_381	m_0184
k_382	m_0185
k_383	m_0185
k_384	m_0186
k_385	m_0186
k_386	m_0187
k_387	m_0187
k_388	m_0188
k_389	m_0188
k_390	m_0189
k_391	m_0189
k_392	m_0190
k_393	m_0190
k_394	m_0191
k_395	m_0191
k_396	m_0192
k_397	m_0192
k_398	m_0193
k_399	m_0193
k_400	m_0194
k_401	m_0194
k_402	m_0195
k_403	m_0195
k_404	m_0196
k_405	m_0196
k_406	m_0197
k_407	m_0197
k_408	m_0198
k_409	m_0198
k_410	m_0199
k_410	m_0200
k_410	m_0201
k_410	m_0202
k_410	m_0203
k_410	m_0204
k_410	m_0205
k_410	m_0206
k_410	m_0207
k_410	m_0208
k_410	m_0209
k_410	m_0210
k_410	m_0211
k_410	m_0212
k_410	m_0213
k_410	m_0214
k_410	m_0215
k_410	m_0216
k_410	m_0217
k_410	m_0218
k_410	m_0219
k_410	m_0220
k_410	m_0221
k_410	m_0222
k_410	m_0223
k_410	m_0224
k_410	m_0225
k_410	m_0226
k_410	m_0227
k_410	m_0228
k_410	m_0229
k_410	m_0230
k_410	m_0231
k_410	m_0232
k_410	m_0233
k_410	m_0234
k_410	m_0235
k_410	m_0236
k_410	m_0237
k_410	m_0238
k_410	m_0239
k_410	m_0240
k_410	m_0241
k_410	m_0242
k_410	m_0243
k_410	m_0244
k_410	m_0245
k_410	m_0246
k_410	m_0247
k_410	m_0248
k_410	m_0249
k_411	m_0199
k_412	m_0199
k_413	m_0200
k_414	m_0200
k_415	m_0201
k_416	m_0201
k_417	m_0202
k_418	m_0202
k_419	m_0203
k_420	m_0203
k_421	m_0204
k_422	m_0204
k_423	m_0205
k_424	m_0205
k_425	m_0206
k_426	m_0206
k_427	m_0207
k_428	m_0207
k_429	m_0208
k_430	m_0208
k_431	m_0209
k_432	m_0209
k_433	m_0210
k_434	m_0210
k_435	m_0211
k_436	m_0211
k_437	m_0212
k_438	m_0212
k_439	m_0213
k_440	m_0213
k_441	m_0214
k_442	m_0214
k_443	m_0215
k_444	m_0215
k_445	m_0216
k_446	m_0216
k_447	m_0217
k_448	m_0217
k_449	m_0218
k_450	m_0218
k_451	m_0219
k_452	m_0219
k_453	m_0220
k_454	m_0220
k_455	m_0221
k_456	m_0221
k_457	m_0222
k_458	m_0222
k_459	m_0223
k_460	m_0223
k_461	m_0224
k_462	m_0224
k_463	m_0225
k_464	m_0225
k_465	m_0226
k_466	m_0226
k_467	m_0227
k_468	m_0227
k_469	m_0228
k_470	m_0228
k_471	m_0229
k_472	m_0229
k_473	m_0230
k_474	m_0230
k_475	m_0231
k_476	m_0231
k_477	m_0232
k_478	m_0232
k_479	m_0233
k_480	m_0233
k_481	m_0234
k_482	m_0234
k_483	m_0235
k_484	m_0235
k_485	m_0236
k_486	m_0236
k_487	m_0237
k_488	m_0237
k_489	m_0238
k_490	m_0238
k_491	m_0239
k_492	m_0239
k_493	m_0240
k_494	m_0240
k_495	m_0241
k_496	m_0241
k_497	m_0242
k_498	m_0242
k_499	m_0243
k_500	m_0243
k_501	m_0244
k_502	m_0244
k_503	m_0245
k_504	m_0245
k_505	m_0246
k_506	m_0246
k_507	m_0247
k_508	m_0247
k_509	m_0248
k_510	m_0248
k_511	m_0249
k_512	m_0249
k_513	m_0250
k_513	m_0251
k_513	m_0252
k_513	m_0253
k_513	m_0254
k_513	m_0255
k_513	m_0256
k_513	m_0257
k_513	m_0258
k_513	m_0259
k_513	m_0260
k_513	m_0261
k_513	m_0262
k_513	m_0263
k_513	m_0264
k_513	m_0265
k_513	m_0266
k_513	m_0267
k_513	m_0268
k_514	m_0250
k_515	m_0250
k_516	m_0251
k_517	m_0251
k_518	m_0252
k_519	m_0252
k_520	m_0253
k_521	m_0253
k_522	m_0254
k_523	m_0254
k_524	m_0255
k_525	m_0255
k_526	m_0256
k_527	m_0256
k_528	m_0257
k_529	m_0257
k_530	m_0258
k_531	m_0258
k_532	m_0259
k_533	m_0259
k_534	m_0260
k_535	m_0260
k_536	m_0261
k_537	m_0261
k_538	m_0262
k_539	m_0262
k_540	m_0263
k_541	m_0263
k_542	m_0264
k_543	m_0264
k_544	m_0265
k_545	m_0265
k_546	m_0266
k_547	m_0266
k_548	m_0267
k_549	m_0267
k_550	m_0268
k_551	m_0268
k_552	m_0269
k_552	m_0270
k_552	m_0271
k_552	m_0272
k_552	m_0273
k_552	m_0274
k_552	m_0275
k_552	m_0276
k_553	m_0269
k_554	m_0269
k_555	m_0270
k_556	m_0270
k_557	m_0271
k_558	m_0271
k_559	m_0272
k_560	m_0272
k_561	m_0273
k_562	m_0273
k_563	m_0274
k_564	m_0274
k_565	m_0275
k_566	m_0275
k_567	m_0276
k_568	m_0276
k_569	m_0277
k_569	m_0278
k_569	m_0279
k_569	m_0280
k_569	m_0281
k_569	m_0282
k_570	m_0277
k_571	m_0277
k_572	m_0278
k_573	m_0278
k_574	m_0279
k_575	m_0279
k_576	m_0280
k_577	m_0280
k_578	m_0281
k_579	m_0281
k_580	m_0282
k_581	m_0282
k_1779512167068	m_0083
\.


--
-- Data for Name: karyakar_xetras; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.karyakar_xetras (karyakar_id, xetra_id) FROM stdin;
demo_santnirdeshak	x1
demo_santnirdeshak	x2
demo_santnirdeshak	x3
demo_sanyojak1	x1
demo_sanyojak1	x2
demo_sanyojak1	x3
demo_nirdeshak1	x1
demo_nirdeshak2	x2
demo_nirdeshak3	x3
demo_sah_nirdeshak1	x1
demo_nirikshak1	x1
demo_ms_m1_0	x1
demo_sk_m1_0	x1
k_1	x1
k_2	x1
k_3	x1
k_4	x1
k_5	x1
k_6	x1
k_7	x1
k_8	x1
k_9	x1
k_10	x1
k_11	x1
k_12	x1
k_13	x1
k_14	x1
k_15	x1
k_16	x1
k_17	x1
k_18	x1
k_19	x1
k_20	x1
k_21	x1
k_22	x1
k_23	x1
k_24	x2
k_25	x2
k_26	x2
k_27	x2
k_28	x2
k_29	x2
k_30	x2
k_31	x2
k_32	x2
k_33	x2
k_34	x2
k_35	x2
k_36	x2
k_37	x2
k_38	x2
k_39	x2
k_40	x2
k_41	x2
k_42	x2
k_43	x2
k_44	x2
k_45	x2
k_46	x2
k_47	x3
k_48	x3
k_49	x3
k_50	x3
k_51	x3
k_52	x3
k_53	x3
k_54	x3
k_55	x3
k_56	x3
k_57	x3
k_58	x3
k_59	x3
k_60	x3
k_61	x3
k_62	x3
k_63	x3
k_64	x3
k_65	x3
k_66	x3
k_67	x3
k_68	x3
k_69	x3
k_70	x3
k_71	x3
k_72	x1
k_73	x1
k_74	x1
k_75	x1
k_76	x1
k_77	x1
k_78	x1
k_79	x1
k_80	x1
k_81	x1
k_82	x1
k_83	x1
k_84	x1
k_85	x1
k_86	x1
k_87	x2
k_88	x2
k_89	x2
k_90	x2
k_91	x2
k_92	x2
k_93	x2
k_94	x2
k_95	x2
k_96	x2
k_97	x2
k_98	x2
k_99	x2
k_100	x2
k_101	x2
k_102	x2
k_103	x2
k_104	x3
k_105	x3
k_106	x3
k_107	x3
k_108	x3
k_109	x3
k_110	x3
k_111	x3
k_112	x3
k_113	x3
k_114	x3
k_115	x3
k_116	x3
k_117	x3
k_118	x3
k_119	x1
k_120	x1
k_121	x1
k_122	x1
k_123	x1
k_124	x1
k_125	x1
k_126	x1
k_127	x1
k_128	x1
k_129	x1
k_130	x1
k_131	x1
k_132	x1
k_133	x1
k_134	x1
k_135	x1
k_136	x2
k_137	x2
k_138	x2
k_139	x2
k_140	x2
k_141	x2
k_142	x2
k_143	x2
k_144	x2
k_145	x2
k_146	x2
k_147	x2
k_148	x2
k_149	x2
k_150	x2
k_151	x2
k_152	x2
k_153	x2
k_154	x2
k_155	x2
k_156	x2
k_157	x2
k_158	x2
k_159	x2
k_160	x2
k_161	x2
k_162	x2
k_163	x3
k_164	x3
k_165	x3
k_166	x3
k_167	x3
k_168	x3
k_169	x3
k_170	x3
k_171	x3
k_172	x3
k_173	x3
k_174	x3
k_175	x3
k_176	x3
k_177	x3
k_178	x3
k_179	x3
k_180	x1
k_181	x1
k_182	x1
k_183	x1
k_184	x1
k_185	x1
k_186	x1
k_187	x1
k_188	x1
k_189	x1
k_190	x1
k_191	x1
k_192	x1
k_193	x1
k_194	x1
k_195	x1
k_196	x1
k_197	x1
k_198	x1
k_199	x1
k_200	x1
k_201	x1
k_202	x1
k_203	x1
k_204	x1
k_205	x1
k_206	x1
k_207	x1
k_208	x1
k_209	x1
k_210	x1
k_211	x1
k_212	x1
k_213	x1
k_214	x1
k_215	x1
k_216	x1
k_217	x1
k_218	x1
k_219	x1
k_220	x1
k_221	x1
k_222	x1
k_223	x1
k_224	x1
k_225	x1
k_226	x1
k_227	x1
k_228	x1
k_229	x2
k_230	x2
k_231	x2
k_232	x2
k_233	x2
k_234	x2
k_235	x2
k_236	x2
k_237	x2
k_238	x2
k_239	x2
k_240	x2
k_241	x2
k_242	x2
k_243	x2
k_244	x2
k_245	x2
k_246	x2
k_247	x2
k_248	x2
k_249	x2
k_250	x2
k_251	x2
k_252	x2
k_253	x2
k_254	x2
k_255	x2
k_256	x2
k_257	x2
k_258	x2
k_259	x2
k_260	x2
k_261	x2
k_262	x2
k_263	x2
k_264	x2
k_265	x2
k_266	x2
k_267	x2
k_268	x2
k_269	x2
k_270	x2
k_271	x2
k_272	x2
k_273	x2
k_274	x2
k_275	x2
k_276	x2
k_277	x2
k_278	x2
k_279	x2
k_280	x2
k_281	x2
k_282	x2
k_283	x2
k_284	x2
k_285	x2
k_286	x2
k_287	x2
k_288	x2
k_289	x2
k_290	x2
k_291	x2
k_292	x2
k_293	x2
k_294	x3
k_295	x3
k_296	x3
k_297	x3
k_298	x3
k_299	x3
k_300	x3
k_301	x3
k_302	x3
k_303	x3
k_304	x3
k_305	x3
k_306	x3
k_307	x3
k_308	x3
k_309	x3
k_310	x3
k_311	x3
k_312	x3
k_313	x3
k_314	x3
k_315	x3
k_316	x3
k_317	x3
k_318	x3
k_319	x3
k_320	x3
k_321	x3
k_322	x3
k_323	x3
k_324	x3
k_325	x3
k_326	x3
k_327	x3
k_328	x3
k_329	x3
k_330	x3
k_331	x3
k_332	x3
k_333	x3
k_334	x3
k_335	x3
k_336	x3
k_337	x3
k_338	x3
k_339	x3
k_340	x3
k_341	x3
k_342	x3
k_343	x3
k_344	x3
k_345	x3
k_346	x3
k_347	x1
k_348	x1
k_349	x1
k_350	x1
k_351	x1
k_352	x1
k_353	x1
k_354	x1
k_355	x1
k_356	x1
k_357	x1
k_358	x1
k_359	x1
k_360	x1
k_361	x1
k_362	x1
k_363	x1
k_364	x1
k_365	x1
k_366	x1
k_367	x1
k_368	x1
k_369	x1
k_370	x1
k_371	x1
k_372	x1
k_373	x1
k_374	x1
k_375	x1
k_376	x1
k_377	x1
k_378	x1
k_379	x1
k_380	x1
k_381	x1
k_382	x1
k_383	x1
k_384	x1
k_385	x1
k_386	x1
k_387	x1
k_388	x1
k_389	x1
k_390	x1
k_391	x1
k_392	x1
k_393	x1
k_394	x1
k_395	x1
k_396	x1
k_397	x1
k_398	x1
k_399	x1
k_400	x1
k_401	x1
k_402	x1
k_403	x1
k_404	x1
k_405	x1
k_406	x1
k_407	x1
k_408	x1
k_409	x1
k_410	x2
k_411	x2
k_412	x2
k_413	x2
k_414	x2
k_415	x2
k_416	x2
k_417	x2
k_418	x2
k_419	x2
k_420	x2
k_421	x2
k_422	x2
k_423	x2
k_424	x2
k_425	x2
k_426	x2
k_427	x2
k_428	x2
k_429	x2
k_430	x2
k_431	x2
k_432	x2
k_433	x2
k_434	x2
k_435	x2
k_436	x2
k_437	x2
k_438	x2
k_439	x2
k_440	x2
k_441	x2
k_442	x2
k_443	x2
k_444	x2
k_445	x2
k_446	x2
k_447	x2
k_448	x2
k_449	x2
k_450	x2
k_451	x2
k_452	x2
k_453	x2
k_454	x2
k_455	x2
k_456	x2
k_457	x2
k_458	x2
k_459	x2
k_460	x2
k_461	x2
k_462	x2
k_463	x2
k_464	x2
k_465	x2
k_466	x2
k_467	x2
k_468	x2
k_469	x2
k_470	x2
k_471	x2
k_472	x2
k_473	x2
k_474	x2
k_475	x2
k_476	x2
k_477	x2
k_478	x2
k_479	x2
k_480	x2
k_481	x2
k_482	x2
k_483	x2
k_484	x2
k_485	x2
k_486	x2
k_487	x2
k_488	x2
k_489	x2
k_490	x2
k_491	x2
k_492	x2
k_493	x2
k_494	x2
k_495	x2
k_496	x2
k_497	x2
k_498	x2
k_499	x2
k_500	x2
k_501	x2
k_502	x2
k_503	x2
k_504	x2
k_505	x2
k_506	x2
k_507	x2
k_508	x2
k_509	x2
k_510	x2
k_511	x2
k_512	x2
k_513	x3
k_514	x3
k_515	x3
k_516	x3
k_517	x3
k_518	x3
k_519	x3
k_520	x3
k_521	x3
k_522	x3
k_523	x3
k_524	x3
k_525	x3
k_526	x3
k_527	x3
k_528	x3
k_529	x3
k_530	x3
k_531	x3
k_532	x3
k_533	x3
k_534	x3
k_535	x3
k_536	x3
k_537	x3
k_538	x3
k_539	x3
k_540	x3
k_541	x3
k_542	x3
k_543	x3
k_544	x3
k_545	x3
k_546	x3
k_547	x3
k_548	x3
k_549	x3
k_550	x3
k_551	x3
k_552	x1
k_553	x1
k_554	x1
k_555	x1
k_556	x1
k_557	x1
k_558	x1
k_559	x1
k_560	x1
k_561	x1
k_562	x1
k_563	x1
k_564	x1
k_565	x1
k_566	x1
k_567	x1
k_568	x1
k_569	x3
k_570	x3
k_571	x3
k_572	x3
k_573	x3
k_574	x3
k_575	x3
k_576	x3
k_577	x3
k_578	x3
k_579	x3
k_580	x3
k_581	x3
f74f3ebf-f2fa-4ecc-ba79-4898bf06baf6	x1
f74f3ebf-f2fa-4ecc-ba79-4898bf06baf6	x2
f74f3ebf-f2fa-4ecc-ba79-4898bf06baf6	x3
\.


--
-- Data for Name: karyakars; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.karyakars (id, karyakar_number, name, role, username, password_hash, avatar, phone, email, parent_karyakar_id, birthday, joined_at, wing, status) FROM stdin;
demo_santnirdeshak	DEMO-SANTNIRDESHAK	Pujya Sant Nirdeshak	sant_nirdeshak	santnirdeshak	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 99999 99999	santnirdeshak@demo.com	\N	\N	2020-01-01	\N	active
demo_sanyojak1	DEMO-SANYOJAK1	Bhargav Bhai Shah	sanyojak	sanyojak1	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 99999 99999	sanyojak1@demo.com	\N	\N	2020-01-01	\N	active
demo_nirdeshak1	DEMO-NIRDESHAK1	Nirdeshak V1	nirdeshak	nirdeshak1	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 99999 99999	nirdeshak1@demo.com	\N	\N	2020-01-01	sanyukt	active
demo_nirdeshak2	DEMO-NIRDESHAK2	Nirdeshak V2	nirdeshak	nirdeshak2	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 99999 99999	nirdeshak2@demo.com	\N	\N	2020-01-01	sanyukt	active
demo_nirdeshak3	DEMO-NIRDESHAK3	Nirdeshak V3	nirdeshak	nirdeshak3	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 99999 99999	nirdeshak3@demo.com	\N	\N	2020-01-01	sanyukt	active
demo_sah_nirdeshak1	DEMO-SAH_NIRDESHAK1	Sah-Nirdeshak V1	sah_nirdeshak	sah_nirdeshak1	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 99999 99999	sah_nirdeshak1@demo.com	\N	\N	2020-01-01	sanyukt	active
demo_nirikshak1	DEMO-NIRIKSHAK1	Nirikshak V1	nirikshak	nirikshak1	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 99999 99999	nirikshak1@demo.com	\N	\N	2020-01-01	sanyukt	active
demo_ms_m1_0	DEMO-MS_M1_0	Mandal Sanchalak	mandal_sanchalak	ms_m1_0	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 99999 99999	ms_m1_0@demo.com	\N	\N	2020-01-01	sanyukt	active
demo_sk_m1_0	DEMO-SK_M1_0	Sampark Karyakar 1	sampark_karyakar	sk_m1_0	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 99999 99999	sk_m1_0@demo.com	\N	\N	2020-01-01	sanyukt	active
k_1	KN-00001	Nirikshak X1 Sanyukt	nirikshak	user1	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00001	user1@baps.org	\N	\N	2020-01-01	sanyukt	active
k_2	KN-00002	MS Akota (Sanyukt)	mandal_sanchalak	user2	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00002	user2@baps.org	\N	\N	2020-01-01	sanyukt	active
k_3	Sk-3	SK Akota (Sanyukt)	sampark_karyakar	user3	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00003	user3@baps.org	\N	\N	2020-01-01	sanyukt	active
k_4	KN-00004	MS Atladra (Sanyukt)	mandal_sanchalak	user4	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00004	user4@baps.org	\N	\N	2020-01-01	sanyukt	active
k_5	Sk-5	SK Atladra (Sanyukt)	sampark_karyakar	user5	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00005	user5@baps.org	\N	\N	2020-01-01	sanyukt	active
k_6	KN-00006	MS Kalali (Sanyukt)	mandal_sanchalak	user6	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00006	user6@baps.org	\N	\N	2020-01-01	sanyukt	active
k_7	Sk-7	SK Kalali (Sanyukt)	sampark_karyakar	user7	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00007	user7@baps.org	\N	\N	2020-01-01	sanyukt	active
k_8	KN-00008	MS Narayanwadi (Sanyukt)	mandal_sanchalak	user8	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00008	user8@baps.org	\N	\N	2020-01-01	sanyukt	active
k_9	Sk-9	SK Narayanwadi (Sanyukt)	sampark_karyakar	user9	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00009	user9@baps.org	\N	\N	2020-01-01	sanyukt	active
k_10	KN-00010	MS Niramay (Sanyukt)	mandal_sanchalak	user10	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00010	user10@baps.org	\N	\N	2020-01-01	sanyukt	active
k_11	Sk-11	SK Niramay (Sanyukt)	sampark_karyakar	user11	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00011	user11@baps.org	\N	\N	2020-01-01	sanyukt	active
k_12	KN-00012	MS P.Sw.Nagar (Sanyukt)	mandal_sanchalak	user12	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00012	user12@baps.org	\N	\N	2020-01-01	sanyukt	active
k_13	Sk-13	SK P.Sw.Nagar (Sanyukt)	sampark_karyakar	user13	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00013	user13@baps.org	\N	\N	2020-01-01	sanyukt	active
k_14	KN-00014	MS Racecourse - 1 (Sanyukt)	mandal_sanchalak	user14	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00014	user14@baps.org	\N	\N	2020-01-01	sanyukt	active
k_15	Sk-15	SK Racecourse - 1 (Sanyukt)	sampark_karyakar	user15	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00015	user15@baps.org	\N	\N	2020-01-01	sanyukt	active
k_16	KN-00016	MS Racecourse - 2 (Sanyukt)	mandal_sanchalak	user16	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00016	user16@baps.org	\N	\N	2020-01-01	sanyukt	active
k_17	Sk-17	SK Racecourse - 2 (Sanyukt)	sampark_karyakar	user17	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00017	user17@baps.org	\N	\N	2020-01-01	sanyukt	active
k_18	KN-00018	MS Samta (Sanyukt)	mandal_sanchalak	user18	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00018	user18@baps.org	\N	\N	2020-01-01	sanyukt	active
k_19	Sk-19	SK Samta (Sanyukt)	sampark_karyakar	user19	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00019	user19@baps.org	\N	\N	2020-01-01	sanyukt	active
k_20	KN-00020	MS Shyamvilla (Sanyukt)	mandal_sanchalak	user20	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00020	user20@baps.org	\N	\N	2020-01-01	sanyukt	active
k_21	Sk-21	SK Shyamvilla (Sanyukt)	sampark_karyakar	user21	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00021	user21@baps.org	\N	\N	2020-01-01	sanyukt	active
k_22	KN-00022	MS Vadsar (Sanyukt)	mandal_sanchalak	user22	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00022	user22@baps.org	\N	\N	2020-01-01	sanyukt	active
k_23	Sk-23	SK Vadsar (Sanyukt)	sampark_karyakar	user23	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00023	user23@baps.org	\N	\N	2020-01-01	sanyukt	active
k_24	KN-00024	Nirikshak X2 Sanyukt	nirikshak	user24	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00024	user24@baps.org	\N	\N	2020-01-01	sanyukt	active
k_25	KN-00025	MS Danteshwar (Sanyukt)	mandal_sanchalak	user25	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00025	user25@baps.org	\N	\N	2020-01-01	sanyukt	active
k_26	Sk-26	SK Danteshwar (Sanyukt)	sampark_karyakar	user26	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00026	user26@baps.org	\N	\N	2020-01-01	sanyukt	active
k_27	KN-00027	MS Gayatrinagar (Sanyukt)	mandal_sanchalak	user27	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00027	user27@baps.org	\N	\N	2020-01-01	sanyukt	active
k_28	Sk-28	SK Gayatrinagar (Sanyukt)	sampark_karyakar	user28	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00028	user28@baps.org	\N	\N	2020-01-01	sanyukt	active
k_29	KN-00029	MS Indrapuri - 1 (Sanyukt)	mandal_sanchalak	user29	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00029	user29@baps.org	\N	\N	2020-01-01	sanyukt	active
k_30	Sk-30	SK Indrapuri - 1 (Sanyukt)	sampark_karyakar	user30	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00030	user30@baps.org	\N	\N	2020-01-01	sanyukt	active
k_31	KN-00031	MS Indrapuri - 2 (Sanyukt)	mandal_sanchalak	user31	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00031	user31@baps.org	\N	\N	2020-01-01	sanyukt	active
k_32	Sk-32	SK Indrapuri - 2 (Sanyukt)	sampark_karyakar	user32	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00032	user32@baps.org	\N	\N	2020-01-01	sanyukt	active
k_33	KN-00033	MS Makarpura (Sanyukt)	mandal_sanchalak	user33	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00033	user33@baps.org	\N	\N	2020-01-01	sanyukt	active
k_34	Sk-34	SK Makarpura (Sanyukt)	sampark_karyakar	user34	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00034	user34@baps.org	\N	\N	2020-01-01	sanyukt	active
k_35	KN-00035	MS Maneja (Sanyukt)	mandal_sanchalak	user35	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00035	user35@baps.org	\N	\N	2020-01-01	sanyukt	active
k_36	Sk-36	SK Maneja (Sanyukt)	sampark_karyakar	user36	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00036	user36@baps.org	\N	\N	2020-01-01	sanyukt	active
k_37	KN-00037	MS Manjalpur - 1 (Sanyukt)	mandal_sanchalak	user37	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00037	user37@baps.org	\N	\N	2020-01-01	sanyukt	active
k_38	Sk-38	SK Manjalpur - 1 (Sanyukt)	sampark_karyakar	user38	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00038	user38@baps.org	\N	\N	2020-01-01	sanyukt	active
k_39	KN-00039	MS Manjalpur - 2 (Sanyukt)	mandal_sanchalak	user39	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00039	user39@baps.org	\N	\N	2020-01-01	sanyukt	active
k_40	Sk-40	SK Manjalpur - 2 (Sanyukt)	sampark_karyakar	user40	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00040	user40@baps.org	\N	\N	2020-01-01	sanyukt	active
k_41	KN-00041	MS Shiyabaug (Sanyukt)	mandal_sanchalak	user41	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00041	user41@baps.org	\N	\N	2020-01-01	sanyukt	active
k_42	Sk-42	SK Shiyabaug (Sanyukt)	sampark_karyakar	user42	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00042	user42@baps.org	\N	\N	2020-01-01	sanyukt	active
k_43	KN-00043	MS Tarsali (Sanyukt)	mandal_sanchalak	user43	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00043	user43@baps.org	\N	\N	2020-01-01	sanyukt	active
k_44	Sk-44	SK Tarsali (Sanyukt)	sampark_karyakar	user44	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00044	user44@baps.org	\N	\N	2020-01-01	sanyukt	active
k_45	KN-00045	MS Wadi (Sanyukt)	mandal_sanchalak	user45	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00045	user45@baps.org	\N	\N	2020-01-01	sanyukt	active
k_46	Sk-46	SK Wadi (Sanyukt)	sampark_karyakar	user46	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00046	user46@baps.org	\N	\N	2020-01-01	sanyukt	active
k_47	KN-00047	Nirikshak X3 Sanyukt	nirikshak	user47	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00047	user47@baps.org	\N	\N	2020-01-01	sanyukt	active
k_48	KN-00048	MS Bajwa (Sanyukt)	mandal_sanchalak	user48	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00048	user48@baps.org	\N	\N	2020-01-01	sanyukt	active
k_49	Sk-49	SK Bajwa (Sanyukt)	sampark_karyakar	user49	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00049	user49@baps.org	\N	\N	2020-01-01	sanyukt	active
k_50	KN-00050	MS Chhani Jakatnaka - 1 (Sanyukt)	mandal_sanchalak	user50	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00050	user50@baps.org	\N	\N	2020-01-01	sanyukt	active
k_51	Sk-51	SK Chhani Jakatnaka - 1 (Sanyukt)	sampark_karyakar	user51	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00051	user51@baps.org	\N	\N	2020-01-01	sanyukt	active
k_52	KN-00052	MS Chhani Jakatnaka - 2 (Sanyukt)	mandal_sanchalak	user52	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00052	user52@baps.org	\N	\N	2020-01-01	sanyukt	active
k_53	Sk-53	SK Chhani Jakatnaka - 2 (Sanyukt)	sampark_karyakar	user53	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00053	user53@baps.org	\N	\N	2020-01-01	sanyukt	active
k_54	KN-00054	MS Chhanigam (Sanyukt)	mandal_sanchalak	user54	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00054	user54@baps.org	\N	\N	2020-01-01	sanyukt	active
k_55	Sk-55	SK Chhanigam (Sanyukt)	sampark_karyakar	user55	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00055	user55@baps.org	\N	\N	2020-01-01	sanyukt	active
k_56	KN-00056	MS Gorwa (Sanyukt)	mandal_sanchalak	user56	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00056	user56@baps.org	\N	\N	2020-01-01	sanyukt	active
k_57	Sk-57	SK Gorwa (Sanyukt)	sampark_karyakar	user57	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00057	user57@baps.org	\N	\N	2020-01-01	sanyukt	active
k_58	KN-00058	MS Gotri (Sanyukt)	mandal_sanchalak	user58	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00058	user58@baps.org	\N	\N	2020-01-01	sanyukt	active
k_59	Sk-59	SK Gotri (Sanyukt)	sampark_karyakar	user59	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00059	user59@baps.org	\N	\N	2020-01-01	sanyukt	active
k_60	KN-00060	MS Karelibaug - 1 (Sanyukt)	mandal_sanchalak	user60	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00060	user60@baps.org	\N	\N	2020-01-01	sanyukt	active
k_61	Sk-61	SK Karelibaug - 1 (Sanyukt)	sampark_karyakar	user61	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00061	user61@baps.org	\N	\N	2020-01-01	sanyukt	active
k_62	KN-00062	MS Karelibaug - 2 (Sanyukt)	mandal_sanchalak	user62	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00062	user62@baps.org	\N	\N	2020-01-01	sanyukt	active
k_63	Sk-63	SK Karelibaug - 2 (Sanyukt)	sampark_karyakar	user63	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00063	user63@baps.org	\N	\N	2020-01-01	sanyukt	active
k_64	KN-00064	MS Panchvati (Sanyukt)	mandal_sanchalak	user64	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00064	user64@baps.org	\N	\N	2020-01-01	sanyukt	active
k_65	Sk-65	SK Panchvati (Sanyukt)	sampark_karyakar	user65	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00065	user65@baps.org	\N	\N	2020-01-01	sanyukt	active
k_66	KN-00066	MS Sama (Sanyukt)	mandal_sanchalak	user66	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00066	user66@baps.org	\N	\N	2020-01-01	sanyukt	active
k_67	Sk-67	SK Sama (Sanyukt)	sampark_karyakar	user67	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00067	user67@baps.org	\N	\N	2020-01-01	sanyukt	active
k_68	KN-00068	MS Sardarnagar (Sanyukt)	mandal_sanchalak	user68	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00068	user68@baps.org	\N	\N	2020-01-01	sanyukt	active
k_69	Sk-69	SK Sardarnagar (Sanyukt)	sampark_karyakar	user69	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00069	user69@baps.org	\N	\N	2020-01-01	sanyukt	active
k_70	KN-00070	MS Sevasi (Sanyukt)	mandal_sanchalak	user70	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00070	user70@baps.org	\N	\N	2020-01-01	sanyukt	active
k_71	Sk-71	SK Sevasi (Sanyukt)	sampark_karyakar	user71	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00071	user71@baps.org	\N	\N	2020-01-01	sanyukt	active
k_72	KN-00072	Nirikshak X1 Yuvak	nirikshak	user72	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00072	user72@baps.org	\N	\N	2020-01-01	yuvak	active
k_73	KN-00073	MS Racecourse (Yuvak)	mandal_sanchalak	user73	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00073	user73@baps.org	\N	\N	2020-01-01	yuvak	active
k_74	Sk-74	SK Racecourse (Yuvak)	sampark_karyakar	user74	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00074	user74@baps.org	\N	\N	2020-01-01	yuvak	active
k_75	KN-00075	MS Samta (Yuvak)	mandal_sanchalak	user75	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00075	user75@baps.org	\N	\N	2020-01-01	yuvak	active
k_76	Sk-76	SK Samta (Yuvak)	sampark_karyakar	user76	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00076	user76@baps.org	\N	\N	2020-01-01	yuvak	active
k_77	KN-00077	MS Niramay (Yuvak)	mandal_sanchalak	user77	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00077	user77@baps.org	\N	\N	2020-01-01	yuvak	active
k_78	Sk-78	SK Niramay (Yuvak)	sampark_karyakar	user78	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00078	user78@baps.org	\N	\N	2020-01-01	yuvak	active
k_79	KN-00079	MS Narayanwadi (Yuvak)	mandal_sanchalak	user79	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00079	user79@baps.org	\N	\N	2020-01-01	yuvak	active
k_80	Sk-80	SK Narayanwadi (Yuvak)	sampark_karyakar	user80	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00080	user80@baps.org	\N	\N	2020-01-01	yuvak	active
k_81	KN-00081	MS Atladara (Yuvak)	mandal_sanchalak	user81	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00081	user81@baps.org	\N	\N	2020-01-01	yuvak	active
k_82	Sk-82	SK Atladara (Yuvak)	sampark_karyakar	user82	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00082	user82@baps.org	\N	\N	2020-01-01	yuvak	active
k_83	KN-00083	MS P.Sw.Nagar (Yuvak)	mandal_sanchalak	user83	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00083	user83@baps.org	\N	\N	2020-01-01	yuvak	active
k_84	Sk-84	SK P.Sw.Nagar (Yuvak)	sampark_karyakar	user84	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00084	user84@baps.org	\N	\N	2020-01-01	yuvak	active
k_85	KN-00085	MS Vadsar (Yuvak)	mandal_sanchalak	user85	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00085	user85@baps.org	\N	\N	2020-01-01	yuvak	active
k_86	Sk-86	SK Vadsar (Yuvak)	sampark_karyakar	user86	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00086	user86@baps.org	\N	\N	2020-01-01	yuvak	active
k_87	KN-00087	Nirikshak X2 Yuvak	nirikshak	user87	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00087	user87@baps.org	\N	\N	2020-01-01	yuvak	active
k_88	KN-00088	MS Manjalpur (Yuvak)	mandal_sanchalak	user88	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00088	user88@baps.org	\N	\N	2020-01-01	yuvak	active
k_89	Sk-89	SK Manjalpur (Yuvak)	sampark_karyakar	user89	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00089	user89@baps.org	\N	\N	2020-01-01	yuvak	active
k_90	KN-00090	MS Indrapuri (Yuvak)	mandal_sanchalak	user90	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00090	user90@baps.org	\N	\N	2020-01-01	yuvak	active
k_91	Sk-91	SK Indrapuri (Yuvak)	sampark_karyakar	user91	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00091	user91@baps.org	\N	\N	2020-01-01	yuvak	active
k_92	KN-00092	MS Danteshwar (Yuvak)	mandal_sanchalak	user92	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00092	user92@baps.org	\N	\N	2020-01-01	yuvak	active
k_93	Sk-93	SK Danteshwar (Yuvak)	sampark_karyakar	user93	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00093	user93@baps.org	\N	\N	2020-01-01	yuvak	active
k_94	KN-00094	MS Makarpura (Yuvak)	mandal_sanchalak	user94	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00094	user94@baps.org	\N	\N	2020-01-01	yuvak	active
k_95	Sk-95	SK Makarpura (Yuvak)	sampark_karyakar	user95	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00095	user95@baps.org	\N	\N	2020-01-01	yuvak	active
k_96	KN-00096	MS Tarsali (Yuvak)	mandal_sanchalak	user96	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00096	user96@baps.org	\N	\N	2020-01-01	yuvak	active
k_97	Sk-97	SK Tarsali (Yuvak)	sampark_karyakar	user97	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00097	user97@baps.org	\N	\N	2020-01-01	yuvak	active
k_98	KN-00098	MS Maneja (Yuvak)	mandal_sanchalak	user98	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00098	user98@baps.org	\N	\N	2020-01-01	yuvak	active
k_99	Sk-99	SK Maneja (Yuvak)	sampark_karyakar	user99	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00099	user99@baps.org	\N	\N	2020-01-01	yuvak	active
k_100	KN-00100	MS Shiyabaug (Yuvak)	mandal_sanchalak	user100	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00100	user100@baps.org	\N	\N	2020-01-01	yuvak	active
k_101	Sk-101	SK Shiyabaug (Yuvak)	sampark_karyakar	user101	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00101	user101@baps.org	\N	\N	2020-01-01	yuvak	active
k_102	KN-00102	MS Wadi (Yuvak)	mandal_sanchalak	user102	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00102	user102@baps.org	\N	\N	2020-01-01	yuvak	active
k_103	Sk-103	SK Wadi (Yuvak)	sampark_karyakar	user103	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00103	user103@baps.org	\N	\N	2020-01-01	yuvak	active
k_104	KN-00104	Nirikshak X3 Yuvak	nirikshak	user104	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00104	user104@baps.org	\N	\N	2020-01-01	yuvak	active
k_105	KN-00105	MS Gorwa (Yuvak)	mandal_sanchalak	user105	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00105	user105@baps.org	\N	\N	2020-01-01	yuvak	active
k_106	Sk-106	SK Gorwa (Yuvak)	sampark_karyakar	user106	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00106	user106@baps.org	\N	\N	2020-01-01	yuvak	active
k_107	KN-00107	MS Gotri (Yuvak)	mandal_sanchalak	user107	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00107	user107@baps.org	\N	\N	2020-01-01	yuvak	active
k_108	Sk-108	SK Gotri (Yuvak)	sampark_karyakar	user108	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00108	user108@baps.org	\N	\N	2020-01-01	yuvak	active
k_109	KN-00109	MS Karelibaug (Yuvak)	mandal_sanchalak	user109	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00109	user109@baps.org	\N	\N	2020-01-01	yuvak	active
k_110	Sk-110	SK Karelibaug (Yuvak)	sampark_karyakar	user110	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00110	user110@baps.org	\N	\N	2020-01-01	yuvak	active
k_111	KN-00111	MS Sama (Yuvak)	mandal_sanchalak	user111	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00111	user111@baps.org	\N	\N	2020-01-01	yuvak	active
k_112	Sk-112	SK Sama (Yuvak)	sampark_karyakar	user112	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00112	user112@baps.org	\N	\N	2020-01-01	yuvak	active
k_113	KN-00113	MS Chhanigam (Yuvak)	mandal_sanchalak	user113	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00113	user113@baps.org	\N	\N	2020-01-01	yuvak	active
k_114	Sk-114	SK Chhanigam (Yuvak)	sampark_karyakar	user114	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00114	user114@baps.org	\N	\N	2020-01-01	yuvak	active
k_115	KN-00115	MS Sardarnagar (Yuvak)	mandal_sanchalak	user115	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00115	user115@baps.org	\N	\N	2020-01-01	yuvak	active
k_116	Sk-116	SK Sardarnagar (Yuvak)	sampark_karyakar	user116	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00116	user116@baps.org	\N	\N	2020-01-01	yuvak	active
k_117	KN-00117	MS Chhani Jakatnaka (Yuvak)	mandal_sanchalak	user117	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00117	user117@baps.org	\N	\N	2020-01-01	yuvak	active
k_118	Sk-118	SK Chhani Jakatnaka (Yuvak)	sampark_karyakar	user118	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00118	user118@baps.org	\N	\N	2020-01-01	yuvak	active
k_119	KN-00119	Nirikshak X1 Yuvati	nirikshak	user119	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00119	user119@baps.org	\N	\N	2020-01-01	yuvati	active
k_120	KN-00120	MS Atladara (Yuvati)	mandal_sanchalak	user120	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00120	user120@baps.org	\N	\N	2020-01-01	yuvati	active
k_121	Sk-121	SK Atladara (Yuvati)	sampark_karyakar	user121	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00121	user121@baps.org	\N	\N	2020-01-01	yuvati	active
k_122	KN-00122	MS Kalali - PR (Yuvati)	mandal_sanchalak	user122	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00122	user122@baps.org	\N	\N	2020-01-01	yuvati	active
k_123	Sk-123	SK Kalali - PR (Yuvati)	sampark_karyakar	user123	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00123	user123@baps.org	\N	\N	2020-01-01	yuvati	active
k_124	KN-00124	MS Niramay (Yuvati)	mandal_sanchalak	user124	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00124	user124@baps.org	\N	\N	2020-01-01	yuvati	active
k_125	Sk-125	SK Niramay (Yuvati)	sampark_karyakar	user125	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00125	user125@baps.org	\N	\N	2020-01-01	yuvati	active
k_126	KN-00126	MS P.Sw.Nagar (Yuvati)	mandal_sanchalak	user126	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00126	user126@baps.org	\N	\N	2020-01-01	yuvati	active
k_127	Sk-127	SK P.Sw.Nagar (Yuvati)	sampark_karyakar	user127	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00127	user127@baps.org	\N	\N	2020-01-01	yuvati	active
k_128	KN-00128	MS Racecourse (Yuvati)	mandal_sanchalak	user128	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00128	user128@baps.org	\N	\N	2020-01-01	yuvati	active
k_129	Sk-129	SK Racecourse (Yuvati)	sampark_karyakar	user129	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00129	user129@baps.org	\N	\N	2020-01-01	yuvati	active
k_130	KN-00130	MS Samta (Yuvati)	mandal_sanchalak	user130	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00130	user130@baps.org	\N	\N	2020-01-01	yuvati	active
k_131	Sk-131	SK Samta (Yuvati)	sampark_karyakar	user131	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00131	user131@baps.org	\N	\N	2020-01-01	yuvati	active
k_132	KN-00132	MS Shyamvilla (Yuvati)	mandal_sanchalak	user132	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00132	user132@baps.org	\N	\N	2020-01-01	yuvati	active
k_133	Sk-133	SK Shyamvilla (Yuvati)	sampark_karyakar	user133	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00133	user133@baps.org	\N	\N	2020-01-01	yuvati	active
k_134	KN-00134	MS Vadsar (Yuvati)	mandal_sanchalak	user134	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00134	user134@baps.org	\N	\N	2020-01-01	yuvati	active
k_135	Sk-135	SK Vadsar (Yuvati)	sampark_karyakar	user135	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00135	user135@baps.org	\N	\N	2020-01-01	yuvati	active
k_136	KN-00136	Nirikshak X2 Yuvati	nirikshak	user136	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00136	user136@baps.org	\N	\N	2020-01-01	yuvati	active
k_137	KN-00137	MS Gayatrinagar (Yuvati)	mandal_sanchalak	user137	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00137	user137@baps.org	\N	\N	2020-01-01	yuvati	active
k_138	Sk-138	SK Gayatrinagar (Yuvati)	sampark_karyakar	user138	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00138	user138@baps.org	\N	\N	2020-01-01	yuvati	active
k_139	KN-00139	MS Indrapuri - 1 (Yuvati)	mandal_sanchalak	user139	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00139	user139@baps.org	\N	\N	2020-01-01	yuvati	active
k_140	Sk-140	SK Indrapuri - 1 (Yuvati)	sampark_karyakar	user140	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00140	user140@baps.org	\N	\N	2020-01-01	yuvati	active
k_141	KN-00141	MS Indrapuri - 3 (Yuvati)	mandal_sanchalak	user141	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00141	user141@baps.org	\N	\N	2020-01-01	yuvati	active
k_142	Sk-142	SK Indrapuri - 3 (Yuvati)	sampark_karyakar	user142	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00142	user142@baps.org	\N	\N	2020-01-01	yuvati	active
k_143	KN-00143	MS Makarpura - 1 (Yuvati)	mandal_sanchalak	user143	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00143	user143@baps.org	\N	\N	2020-01-01	yuvati	active
k_144	Sk-144	SK Makarpura - 1 (Yuvati)	sampark_karyakar	user144	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00144	user144@baps.org	\N	\N	2020-01-01	yuvati	active
k_145	KN-00145	MS Makarpura - 2 (Yuvati)	mandal_sanchalak	user145	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00145	user145@baps.org	\N	\N	2020-01-01	yuvati	active
k_146	Sk-146	SK Makarpura - 2 (Yuvati)	sampark_karyakar	user146	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00146	user146@baps.org	\N	\N	2020-01-01	yuvati	active
k_147	KN-00147	MS Maneja (Yuvati)	mandal_sanchalak	user147	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00147	user147@baps.org	\N	\N	2020-01-01	yuvati	active
k_148	Sk-148	SK Maneja (Yuvati)	sampark_karyakar	user148	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00148	user148@baps.org	\N	\N	2020-01-01	yuvati	active
k_149	KN-00149	MS Manjalpur - 1 (Yuvati)	mandal_sanchalak	user149	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00149	user149@baps.org	\N	\N	2020-01-01	yuvati	active
k_150	Sk-150	SK Manjalpur - 1 (Yuvati)	sampark_karyakar	user150	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00150	user150@baps.org	\N	\N	2020-01-01	yuvati	active
k_151	KN-00151	MS Manjalpur - 2 (Yuvati)	mandal_sanchalak	user151	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00151	user151@baps.org	\N	\N	2020-01-01	yuvati	active
k_152	Sk-152	SK Manjalpur - 2 (Yuvati)	sampark_karyakar	user152	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00152	user152@baps.org	\N	\N	2020-01-01	yuvati	active
k_153	KN-00153	MS Manjalpur - 3 (Yuvati)	mandal_sanchalak	user153	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00153	user153@baps.org	\N	\N	2020-01-01	yuvati	active
k_154	Sk-154	SK Manjalpur - 3 (Yuvati)	sampark_karyakar	user154	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00154	user154@baps.org	\N	\N	2020-01-01	yuvati	active
k_155	KN-00155	MS Shiyabaug (Yuvati)	mandal_sanchalak	user155	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00155	user155@baps.org	\N	\N	2020-01-01	yuvati	active
k_156	Sk-156	SK Shiyabaug (Yuvati)	sampark_karyakar	user156	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00156	user156@baps.org	\N	\N	2020-01-01	yuvati	active
k_157	KN-00157	MS Tarsali (Yuvati)	mandal_sanchalak	user157	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00157	user157@baps.org	\N	\N	2020-01-01	yuvati	active
k_158	Sk-158	SK Tarsali (Yuvati)	sampark_karyakar	user158	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00158	user158@baps.org	\N	\N	2020-01-01	yuvati	active
k_159	KN-00159	MS Wadi - 1 (Yuvati)	mandal_sanchalak	user159	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00159	user159@baps.org	\N	\N	2020-01-01	yuvati	active
k_160	Sk-160	SK Wadi - 1 (Yuvati)	sampark_karyakar	user160	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00160	user160@baps.org	\N	\N	2020-01-01	yuvati	active
k_161	KN-00161	MS Danteshwar (Yuvati)	mandal_sanchalak	user161	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00161	user161@baps.org	\N	\N	2020-01-01	yuvati	active
k_162	Sk-162	SK Danteshwar (Yuvati)	sampark_karyakar	user162	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00162	user162@baps.org	\N	\N	2020-01-01	yuvati	active
k_163	KN-00163	Nirikshak X3 Yuvati	nirikshak	user163	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00163	user163@baps.org	\N	\N	2020-01-01	yuvati	active
k_164	KN-00164	MS Karelibaug (Yuvati)	mandal_sanchalak	user164	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00164	user164@baps.org	\N	\N	2020-01-01	yuvati	active
k_165	Sk-165	SK Karelibaug (Yuvati)	sampark_karyakar	user165	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00165	user165@baps.org	\N	\N	2020-01-01	yuvati	active
k_166	KN-00166	MS Sama (Yuvati)	mandal_sanchalak	user166	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00166	user166@baps.org	\N	\N	2020-01-01	yuvati	active
k_167	Sk-167	SK Sama (Yuvati)	sampark_karyakar	user167	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00167	user167@baps.org	\N	\N	2020-01-01	yuvati	active
k_168	KN-00168	MS Sardarnagar (Yuvati)	mandal_sanchalak	user168	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00168	user168@baps.org	\N	\N	2020-01-01	yuvati	active
k_169	Sk-169	SK Sardarnagar (Yuvati)	sampark_karyakar	user169	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00169	user169@baps.org	\N	\N	2020-01-01	yuvati	active
k_170	KN-00170	MS Chhani Jakatnaka (Yuvati)	mandal_sanchalak	user170	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00170	user170@baps.org	\N	\N	2020-01-01	yuvati	active
k_171	Sk-171	SK Chhani Jakatnaka (Yuvati)	sampark_karyakar	user171	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00171	user171@baps.org	\N	\N	2020-01-01	yuvati	active
k_172	KN-00172	MS Chhanigam (Yuvati)	mandal_sanchalak	user172	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00172	user172@baps.org	\N	\N	2020-01-01	yuvati	active
k_173	Sk-173	SK Chhanigam (Yuvati)	sampark_karyakar	user173	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00173	user173@baps.org	\N	\N	2020-01-01	yuvati	active
k_174	KN-00174	MS Gorwa (Yuvati)	mandal_sanchalak	user174	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00174	user174@baps.org	\N	\N	2020-01-01	yuvati	active
k_175	Sk-175	SK Gorwa (Yuvati)	sampark_karyakar	user175	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00175	user175@baps.org	\N	\N	2020-01-01	yuvati	active
k_176	KN-00176	MS Gotri - 1 (Yuvati)	mandal_sanchalak	user176	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00176	user176@baps.org	\N	\N	2020-01-01	yuvati	active
k_177	Sk-177	SK Gotri - 1 (Yuvati)	sampark_karyakar	user177	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00177	user177@baps.org	\N	\N	2020-01-01	yuvati	active
k_178	KN-00178	MS Gotri - 2 (Yuvati)	mandal_sanchalak	user178	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00178	user178@baps.org	\N	\N	2020-01-01	yuvati	active
k_179	Sk-179	SK Gotri - 2 (Yuvati)	sampark_karyakar	user179	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00179	user179@baps.org	\N	\N	2020-01-01	yuvati	active
k_180	KN-00180	Nirikshak X1 Mahila	nirikshak	user180	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00180	user180@baps.org	\N	\N	2020-01-01	mahila	active
k_181	KN-00181	MS P.Sw.Nagar - 1 (Mahila)	mandal_sanchalak	user181	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00181	user181@baps.org	\N	\N	2020-01-01	mahila	active
k_182	Sk-182	SK P.Sw.Nagar - 1 (Mahila)	sampark_karyakar	user182	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00182	user182@baps.org	\N	\N	2020-01-01	mahila	active
k_183	KN-00183	MS P.Sw.Nagar - 2 (Mahila)	mandal_sanchalak	user183	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00183	user183@baps.org	\N	\N	2020-01-01	mahila	active
k_184	Sk-184	SK P.Sw.Nagar - 2 (Mahila)	sampark_karyakar	user184	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00184	user184@baps.org	\N	\N	2020-01-01	mahila	active
k_185	KN-00185	MS Niramay - 1 (Mahila)	mandal_sanchalak	user185	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00185	user185@baps.org	\N	\N	2020-01-01	mahila	active
k_186	Sk-186	SK Niramay - 1 (Mahila)	sampark_karyakar	user186	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00186	user186@baps.org	\N	\N	2020-01-01	mahila	active
k_187	KN-00187	MS Niramay - 2 (Mahila)	mandal_sanchalak	user187	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00187	user187@baps.org	\N	\N	2020-01-01	mahila	active
k_188	Sk-188	SK Niramay - 2 (Mahila)	sampark_karyakar	user188	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00188	user188@baps.org	\N	\N	2020-01-01	mahila	active
k_189	KN-00189	MS Kalali - 1 (Mahila)	mandal_sanchalak	user189	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00189	user189@baps.org	\N	\N	2020-01-01	mahila	active
k_190	Sk-190	SK Kalali - 1 (Mahila)	sampark_karyakar	user190	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00190	user190@baps.org	\N	\N	2020-01-01	mahila	active
k_191	KN-00191	MS Kalali - 2 (Mahila)	mandal_sanchalak	user191	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00191	user191@baps.org	\N	\N	2020-01-01	mahila	active
k_192	Sk-192	SK Kalali - 2 (Mahila)	sampark_karyakar	user192	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00192	user192@baps.org	\N	\N	2020-01-01	mahila	active
k_193	KN-00193	MS Vishwamitri Township (Mahila)	mandal_sanchalak	user193	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00193	user193@baps.org	\N	\N	2020-01-01	mahila	active
k_194	Sk-194	SK Vishwamitri Township (Mahila)	sampark_karyakar	user194	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00194	user194@baps.org	\N	\N	2020-01-01	mahila	active
k_195	KN-00195	MS Racecourse - 1 (Mahila)	mandal_sanchalak	user195	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00195	user195@baps.org	\N	\N	2020-01-01	mahila	active
k_196	Sk-196	SK Racecourse - 1 (Mahila)	sampark_karyakar	user196	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00196	user196@baps.org	\N	\N	2020-01-01	mahila	active
k_197	KN-00197	MS Racecourse - 2 (Mahila)	mandal_sanchalak	user197	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00197	user197@baps.org	\N	\N	2020-01-01	mahila	active
k_198	Sk-198	SK Racecourse - 2 (Mahila)	sampark_karyakar	user198	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00198	user198@baps.org	\N	\N	2020-01-01	mahila	active
k_199	KN-00199	MS Racecourse - 3 (Mahila)	mandal_sanchalak	user199	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00199	user199@baps.org	\N	\N	2020-01-01	mahila	active
k_200	Sk-200	SK Racecourse - 3 (Mahila)	sampark_karyakar	user200	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00200	user200@baps.org	\N	\N	2020-01-01	mahila	active
k_201	KN-00201	MS Racecourse - 4 (Mahila)	mandal_sanchalak	user201	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00201	user201@baps.org	\N	\N	2020-01-01	mahila	active
k_202	Sk-202	SK Racecourse - 4 (Mahila)	sampark_karyakar	user202	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00202	user202@baps.org	\N	\N	2020-01-01	mahila	active
k_203	KN-00203	MS Racecourse - 5 (Mahila)	mandal_sanchalak	user203	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00203	user203@baps.org	\N	\N	2020-01-01	mahila	active
k_204	Sk-204	SK Racecourse - 5 (Mahila)	sampark_karyakar	user204	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00204	user204@baps.org	\N	\N	2020-01-01	mahila	active
k_205	KN-00205	MS Samta (Mahila)	mandal_sanchalak	user205	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00205	user205@baps.org	\N	\N	2020-01-01	mahila	active
k_206	Sk-206	SK Samta (Mahila)	sampark_karyakar	user206	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00206	user206@baps.org	\N	\N	2020-01-01	mahila	active
k_207	KN-00207	MS Harani (Mahila)	mandal_sanchalak	user207	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00207	user207@baps.org	\N	\N	2020-01-01	mahila	active
k_208	Sk-208	SK Harani (Mahila)	sampark_karyakar	user208	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00208	user208@baps.org	\N	\N	2020-01-01	mahila	active
k_209	KN-00209	MS Atladara - 1 (Mahila)	mandal_sanchalak	user209	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00209	user209@baps.org	\N	\N	2020-01-01	mahila	active
k_210	Sk-210	SK Atladara - 1 (Mahila)	sampark_karyakar	user210	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00210	user210@baps.org	\N	\N	2020-01-01	mahila	active
k_211	KN-00211	MS Atladara - 2 (Mahila)	mandal_sanchalak	user211	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00211	user211@baps.org	\N	\N	2020-01-01	mahila	active
k_212	Sk-212	SK Atladara - 2 (Mahila)	sampark_karyakar	user212	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00212	user212@baps.org	\N	\N	2020-01-01	mahila	active
k_213	KN-00213	MS Atladara - 3 (Mahila)	mandal_sanchalak	user213	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00213	user213@baps.org	\N	\N	2020-01-01	mahila	active
k_214	Sk-214	SK Atladara - 3 (Mahila)	sampark_karyakar	user214	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00214	user214@baps.org	\N	\N	2020-01-01	mahila	active
k_215	KN-00215	MS Ramlaxman - 1 (Mahila)	mandal_sanchalak	user215	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00215	user215@baps.org	\N	\N	2020-01-01	mahila	active
k_216	Sk-216	SK Ramlaxman - 1 (Mahila)	sampark_karyakar	user216	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00216	user216@baps.org	\N	\N	2020-01-01	mahila	active
k_217	KN-00217	MS Ramlaxman - 2 (Mahila)	mandal_sanchalak	user217	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00217	user217@baps.org	\N	\N	2020-01-01	mahila	active
k_218	Sk-218	SK Ramlaxman - 2 (Mahila)	sampark_karyakar	user218	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00218	user218@baps.org	\N	\N	2020-01-01	mahila	active
k_219	KN-00219	MS Vadsar (Mahila)	mandal_sanchalak	user219	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00219	user219@baps.org	\N	\N	2020-01-01	mahila	active
k_220	Sk-220	SK Vadsar (Mahila)	sampark_karyakar	user220	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00220	user220@baps.org	\N	\N	2020-01-01	mahila	active
k_221	KN-00221	MS AvadhUpavan (Mahila)	mandal_sanchalak	user221	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00221	user221@baps.org	\N	\N	2020-01-01	mahila	active
k_222	Sk-222	SK AvadhUpavan (Mahila)	sampark_karyakar	user222	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00222	user222@baps.org	\N	\N	2020-01-01	mahila	active
k_223	KN-00223	MS Vrajdham (Mahila)	mandal_sanchalak	user223	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00223	user223@baps.org	\N	\N	2020-01-01	mahila	active
k_224	Sk-224	SK Vrajdham (Mahila)	sampark_karyakar	user224	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00224	user224@baps.org	\N	\N	2020-01-01	mahila	active
k_225	KN-00225	MS Vrundavan (Mahila)	mandal_sanchalak	user225	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00225	user225@baps.org	\N	\N	2020-01-01	mahila	active
k_226	Sk-226	SK Vrundavan (Mahila)	sampark_karyakar	user226	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00226	user226@baps.org	\N	\N	2020-01-01	mahila	active
k_227	KN-00227	MS Krishna Darshan (Mahila)	mandal_sanchalak	user227	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00227	user227@baps.org	\N	\N	2020-01-01	mahila	active
k_228	Sk-228	SK Krishna Darshan (Mahila)	sampark_karyakar	user228	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00228	user228@baps.org	\N	\N	2020-01-01	mahila	active
k_229	KN-00229	Nirikshak X2 Mahila	nirikshak	user229	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00229	user229@baps.org	\N	\N	2020-01-01	mahila	active
k_230	KN-00230	MS Indrapuri - 1 (Mahila)	mandal_sanchalak	user230	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00230	user230@baps.org	\N	\N	2020-01-01	mahila	active
k_231	Sk-231	SK Indrapuri - 1 (Mahila)	sampark_karyakar	user231	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00231	user231@baps.org	\N	\N	2020-01-01	mahila	active
k_232	KN-00232	MS Indrapuri - 2 (Mahila)	mandal_sanchalak	user232	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00232	user232@baps.org	\N	\N	2020-01-01	mahila	active
k_233	Sk-233	SK Indrapuri - 2 (Mahila)	sampark_karyakar	user233	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00233	user233@baps.org	\N	\N	2020-01-01	mahila	active
k_234	KN-00234	MS Indrapuri - 3 (Mahila)	mandal_sanchalak	user234	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00234	user234@baps.org	\N	\N	2020-01-01	mahila	active
k_235	Sk-235	SK Indrapuri - 3 (Mahila)	sampark_karyakar	user235	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00235	user235@baps.org	\N	\N	2020-01-01	mahila	active
k_236	KN-00236	MS Indrapuri - 4 (Mahila)	mandal_sanchalak	user236	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00236	user236@baps.org	\N	\N	2020-01-01	mahila	active
k_237	Sk-237	SK Indrapuri - 4 (Mahila)	sampark_karyakar	user237	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00237	user237@baps.org	\N	\N	2020-01-01	mahila	active
k_238	KN-00238	MS Kapurai (Mahila)	mandal_sanchalak	user238	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00238	user238@baps.org	\N	\N	2020-01-01	mahila	active
k_239	Sk-239	SK Kapurai (Mahila)	sampark_karyakar	user239	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00239	user239@baps.org	\N	\N	2020-01-01	mahila	active
k_240	KN-00240	MS Sayajipura (Mahila)	mandal_sanchalak	user240	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00240	user240@baps.org	\N	\N	2020-01-01	mahila	active
k_241	Sk-241	SK Sayajipura (Mahila)	sampark_karyakar	user241	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00241	user241@baps.org	\N	\N	2020-01-01	mahila	active
k_242	KN-00242	MS Maneja (Mahila)	mandal_sanchalak	user242	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00242	user242@baps.org	\N	\N	2020-01-01	mahila	active
k_243	Sk-243	SK Maneja (Mahila)	sampark_karyakar	user243	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00243	user243@baps.org	\N	\N	2020-01-01	mahila	active
k_244	KN-00244	MS Manjalpur - 1 (Mahila)	mandal_sanchalak	user244	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00244	user244@baps.org	\N	\N	2020-01-01	mahila	active
k_245	Sk-245	SK Manjalpur - 1 (Mahila)	sampark_karyakar	user245	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00245	user245@baps.org	\N	\N	2020-01-01	mahila	active
k_246	KN-00246	MS Manjalpur - 2 (Mahila)	mandal_sanchalak	user246	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00246	user246@baps.org	\N	\N	2020-01-01	mahila	active
k_247	Sk-247	SK Manjalpur - 2 (Mahila)	sampark_karyakar	user247	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00247	user247@baps.org	\N	\N	2020-01-01	mahila	active
k_248	KN-00248	MS Manjalpur - 3 (Mahila)	mandal_sanchalak	user248	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00248	user248@baps.org	\N	\N	2020-01-01	mahila	active
k_249	Sk-249	SK Manjalpur - 3 (Mahila)	sampark_karyakar	user249	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00249	user249@baps.org	\N	\N	2020-01-01	mahila	active
k_250	KN-00250	MS Manjalpur - 4 (Mahila)	mandal_sanchalak	user250	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00250	user250@baps.org	\N	\N	2020-01-01	mahila	active
k_251	Sk-251	SK Manjalpur - 4 (Mahila)	sampark_karyakar	user251	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00251	user251@baps.org	\N	\N	2020-01-01	mahila	active
k_252	KN-00252	MS Manjalpur - 5 (Mahila)	mandal_sanchalak	user252	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00252	user252@baps.org	\N	\N	2020-01-01	mahila	active
k_253	Sk-253	SK Manjalpur - 5 (Mahila)	sampark_karyakar	user253	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00253	user253@baps.org	\N	\N	2020-01-01	mahila	active
k_254	KN-00254	MS GIDC - 1 (Mahila)	mandal_sanchalak	user254	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00254	user254@baps.org	\N	\N	2020-01-01	mahila	active
k_255	Sk-255	SK GIDC - 1 (Mahila)	sampark_karyakar	user255	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00255	user255@baps.org	\N	\N	2020-01-01	mahila	active
k_256	KN-00256	MS GIDC - 2 (Mahila)	mandal_sanchalak	user256	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00256	user256@baps.org	\N	\N	2020-01-01	mahila	active
k_257	Sk-257	SK GIDC - 2 (Mahila)	sampark_karyakar	user257	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00257	user257@baps.org	\N	\N	2020-01-01	mahila	active
k_258	KN-00258	MS GIDC - 3 (Mahila)	mandal_sanchalak	user258	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00258	user258@baps.org	\N	\N	2020-01-01	mahila	active
k_259	Sk-259	SK GIDC - 3 (Mahila)	sampark_karyakar	user259	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00259	user259@baps.org	\N	\N	2020-01-01	mahila	active
k_260	KN-00260	MS GIDC - 4 (Mahila)	mandal_sanchalak	user260	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00260	user260@baps.org	\N	\N	2020-01-01	mahila	active
k_261	Sk-261	SK GIDC - 4 (Mahila)	sampark_karyakar	user261	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00261	user261@baps.org	\N	\N	2020-01-01	mahila	active
k_262	KN-00262	MS Wadi - 1 (Mahila)	mandal_sanchalak	user262	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00262	user262@baps.org	\N	\N	2020-01-01	mahila	active
k_263	Sk-263	SK Wadi - 1 (Mahila)	sampark_karyakar	user263	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00263	user263@baps.org	\N	\N	2020-01-01	mahila	active
k_264	KN-00264	MS Wadi - 2 (Mahila)	mandal_sanchalak	user264	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00264	user264@baps.org	\N	\N	2020-01-01	mahila	active
k_265	Sk-265	SK Wadi - 2 (Mahila)	sampark_karyakar	user265	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00265	user265@baps.org	\N	\N	2020-01-01	mahila	active
k_266	KN-00266	MS Shiyabaug - 1 (Mahila)	mandal_sanchalak	user266	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00266	user266@baps.org	\N	\N	2020-01-01	mahila	active
k_267	Sk-267	SK Shiyabaug - 1 (Mahila)	sampark_karyakar	user267	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00267	user267@baps.org	\N	\N	2020-01-01	mahila	active
k_268	KN-00268	MS Shiyabaug - 2 (Mahila)	mandal_sanchalak	user268	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00268	user268@baps.org	\N	\N	2020-01-01	mahila	active
k_269	Sk-269	SK Shiyabaug - 2 (Mahila)	sampark_karyakar	user269	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00269	user269@baps.org	\N	\N	2020-01-01	mahila	active
k_270	KN-00270	MS Shiyabaug - 3 (Mahila)	mandal_sanchalak	user270	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00270	user270@baps.org	\N	\N	2020-01-01	mahila	active
k_271	Sk-271	SK Shiyabaug - 3 (Mahila)	sampark_karyakar	user271	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00271	user271@baps.org	\N	\N	2020-01-01	mahila	active
k_272	KN-00272	MS Shiyabaug - 4 (Mahila)	mandal_sanchalak	user272	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00272	user272@baps.org	\N	\N	2020-01-01	mahila	active
k_273	Sk-273	SK Shiyabaug - 4 (Mahila)	sampark_karyakar	user273	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00273	user273@baps.org	\N	\N	2020-01-01	mahila	active
k_274	KN-00274	MS Shiyabaug - 5 (Mahila)	mandal_sanchalak	user274	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00274	user274@baps.org	\N	\N	2020-01-01	mahila	active
k_275	Sk-275	SK Shiyabaug - 5 (Mahila)	sampark_karyakar	user275	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00275	user275@baps.org	\N	\N	2020-01-01	mahila	active
k_276	KN-00276	MS Danteshwar - 1 (Mahila)	mandal_sanchalak	user276	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00276	user276@baps.org	\N	\N	2020-01-01	mahila	active
k_277	Sk-277	SK Danteshwar - 1 (Mahila)	sampark_karyakar	user277	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00277	user277@baps.org	\N	\N	2020-01-01	mahila	active
k_278	KN-00278	MS Danteshwar - 2 (Mahila)	mandal_sanchalak	user278	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00278	user278@baps.org	\N	\N	2020-01-01	mahila	active
k_279	Sk-279	SK Danteshwar - 2 (Mahila)	sampark_karyakar	user279	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00279	user279@baps.org	\N	\N	2020-01-01	mahila	active
k_280	KN-00280	MS Tarsali - 1 (Mahila)	mandal_sanchalak	user280	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00280	user280@baps.org	\N	\N	2020-01-01	mahila	active
k_281	Sk-281	SK Tarsali - 1 (Mahila)	sampark_karyakar	user281	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00281	user281@baps.org	\N	\N	2020-01-01	mahila	active
k_282	KN-00282	MS Tarsali - 2 (Mahila)	mandal_sanchalak	user282	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00282	user282@baps.org	\N	\N	2020-01-01	mahila	active
k_283	Sk-283	SK Tarsali - 2 (Mahila)	sampark_karyakar	user283	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00283	user283@baps.org	\N	\N	2020-01-01	mahila	active
k_284	KN-00284	MS Makarpura - 1 (Mahila)	mandal_sanchalak	user284	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00284	user284@baps.org	\N	\N	2020-01-01	mahila	active
k_285	Sk-285	SK Makarpura - 1 (Mahila)	sampark_karyakar	user285	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00285	user285@baps.org	\N	\N	2020-01-01	mahila	active
k_286	KN-00286	MS Makarpura - 2 (Mahila)	mandal_sanchalak	user286	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00286	user286@baps.org	\N	\N	2020-01-01	mahila	active
k_287	Sk-287	SK Makarpura - 2 (Mahila)	sampark_karyakar	user287	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00287	user287@baps.org	\N	\N	2020-01-01	mahila	active
k_288	KN-00288	MS Makarpura - 3 (Mahila)	mandal_sanchalak	user288	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00288	user288@baps.org	\N	\N	2020-01-01	mahila	active
k_289	Sk-289	SK Makarpura - 3 (Mahila)	sampark_karyakar	user289	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00289	user289@baps.org	\N	\N	2020-01-01	mahila	active
k_290	KN-00290	MS Makarpura - 4 (Mahila)	mandal_sanchalak	user290	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00290	user290@baps.org	\N	\N	2020-01-01	mahila	active
k_291	Sk-291	SK Makarpura - 4 (Mahila)	sampark_karyakar	user291	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00291	user291@baps.org	\N	\N	2020-01-01	mahila	active
k_292	KN-00292	MS Gayatrinagar (Mahila)	mandal_sanchalak	user292	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00292	user292@baps.org	\N	\N	2020-01-01	mahila	active
k_293	Sk-293	SK Gayatrinagar (Mahila)	sampark_karyakar	user293	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00293	user293@baps.org	\N	\N	2020-01-01	mahila	active
k_294	KN-00294	Nirikshak X3 Mahila	nirikshak	user294	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00294	user294@baps.org	\N	\N	2020-01-01	mahila	active
k_295	KN-00295	MS Sevasi - 1 (Mahila)	mandal_sanchalak	user295	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00295	user295@baps.org	\N	\N	2020-01-01	mahila	active
k_296	Sk-296	SK Sevasi - 1 (Mahila)	sampark_karyakar	user296	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00296	user296@baps.org	\N	\N	2020-01-01	mahila	active
k_297	KN-00297	MS Sevasi - 2 (Mahila)	mandal_sanchalak	user297	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00297	user297@baps.org	\N	\N	2020-01-01	mahila	active
k_298	Sk-298	SK Sevasi - 2 (Mahila)	sampark_karyakar	user298	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00298	user298@baps.org	\N	\N	2020-01-01	mahila	active
k_299	KN-00299	MS Gotri - 1 (Mahila)	mandal_sanchalak	user299	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00299	user299@baps.org	\N	\N	2020-01-01	mahila	active
k_300	Sk-300	SK Gotri - 1 (Mahila)	sampark_karyakar	user300	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00300	user300@baps.org	\N	\N	2020-01-01	mahila	active
k_301	KN-00301	MS Gotri - 2 (Mahila)	mandal_sanchalak	user301	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00301	user301@baps.org	\N	\N	2020-01-01	mahila	active
k_302	Sk-302	SK Gotri - 2 (Mahila)	sampark_karyakar	user302	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00302	user302@baps.org	\N	\N	2020-01-01	mahila	active
k_303	KN-00303	MS Gotri - 3 (Mahila)	mandal_sanchalak	user303	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00303	user303@baps.org	\N	\N	2020-01-01	mahila	active
k_304	Sk-304	SK Gotri - 3 (Mahila)	sampark_karyakar	user304	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00304	user304@baps.org	\N	\N	2020-01-01	mahila	active
k_305	KN-00305	MS Gotri - 4 (Mahila)	mandal_sanchalak	user305	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00305	user305@baps.org	\N	\N	2020-01-01	mahila	active
k_306	Sk-306	SK Gotri - 4 (Mahila)	sampark_karyakar	user306	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00306	user306@baps.org	\N	\N	2020-01-01	mahila	active
k_307	KN-00307	MS Gotri - 5 (Mahila)	mandal_sanchalak	user307	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00307	user307@baps.org	\N	\N	2020-01-01	mahila	active
k_308	Sk-308	SK Gotri - 5 (Mahila)	sampark_karyakar	user308	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00308	user308@baps.org	\N	\N	2020-01-01	mahila	active
k_309	KN-00309	MS Chhani Jakatnaka - 1 (Mahila)	mandal_sanchalak	user309	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00309	user309@baps.org	\N	\N	2020-01-01	mahila	active
k_310	Sk-310	SK Chhani Jakatnaka - 1 (Mahila)	sampark_karyakar	user310	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00310	user310@baps.org	\N	\N	2020-01-01	mahila	active
k_311	KN-00311	MS Chhani Jakatnaka - 2 (Mahila)	mandal_sanchalak	user311	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00311	user311@baps.org	\N	\N	2020-01-01	mahila	active
k_312	Sk-312	SK Chhani Jakatnaka - 2 (Mahila)	sampark_karyakar	user312	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00312	user312@baps.org	\N	\N	2020-01-01	mahila	active
k_313	KN-00313	MS Chhani Jakatnaka - 3 (Mahila)	mandal_sanchalak	user313	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00313	user313@baps.org	\N	\N	2020-01-01	mahila	active
k_314	Sk-314	SK Chhani Jakatnaka - 3 (Mahila)	sampark_karyakar	user314	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00314	user314@baps.org	\N	\N	2020-01-01	mahila	active
k_315	KN-00315	MS Chhanigam - 1 (Mahila)	mandal_sanchalak	user315	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00315	user315@baps.org	\N	\N	2020-01-01	mahila	active
k_316	Sk-316	SK Chhanigam - 1 (Mahila)	sampark_karyakar	user316	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00316	user316@baps.org	\N	\N	2020-01-01	mahila	active
k_317	KN-00317	MS Chhanigam - 2 (Mahila)	mandal_sanchalak	user317	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00317	user317@baps.org	\N	\N	2020-01-01	mahila	active
k_318	Sk-318	SK Chhanigam - 2 (Mahila)	sampark_karyakar	user318	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00318	user318@baps.org	\N	\N	2020-01-01	mahila	active
k_319	KN-00319	MS Karelibaug - 1 (Mahila)	mandal_sanchalak	user319	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00319	user319@baps.org	\N	\N	2020-01-01	mahila	active
k_320	Sk-320	SK Karelibaug - 1 (Mahila)	sampark_karyakar	user320	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00320	user320@baps.org	\N	\N	2020-01-01	mahila	active
k_321	KN-00321	MS Karelibaug - 2 (Mahila)	mandal_sanchalak	user321	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00321	user321@baps.org	\N	\N	2020-01-01	mahila	active
k_322	Sk-322	SK Karelibaug - 2 (Mahila)	sampark_karyakar	user322	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00322	user322@baps.org	\N	\N	2020-01-01	mahila	active
k_323	KN-00323	MS Sama (Mahila)	mandal_sanchalak	user323	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00323	user323@baps.org	\N	\N	2020-01-01	mahila	active
k_324	Sk-324	SK Sama (Mahila)	sampark_karyakar	user324	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00324	user324@baps.org	\N	\N	2020-01-01	mahila	active
k_325	KN-00325	MS Vemali (Mahila)	mandal_sanchalak	user325	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00325	user325@baps.org	\N	\N	2020-01-01	mahila	active
k_326	Sk-326	SK Vemali (Mahila)	sampark_karyakar	user326	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00326	user326@baps.org	\N	\N	2020-01-01	mahila	active
k_327	KN-00327	MS Motnath (Mahila)	mandal_sanchalak	user327	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00327	user327@baps.org	\N	\N	2020-01-01	mahila	active
k_328	Sk-328	SK Motnath (Mahila)	sampark_karyakar	user328	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00328	user328@baps.org	\N	\N	2020-01-01	mahila	active
k_329	KN-00329	MS Lileriya (Mahila)	mandal_sanchalak	user329	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00329	user329@baps.org	\N	\N	2020-01-01	mahila	active
k_330	Sk-330	SK Lileriya (Mahila)	sampark_karyakar	user330	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00330	user330@baps.org	\N	\N	2020-01-01	mahila	active
k_331	KN-00331	MS Sardarnagar (Mahila)	mandal_sanchalak	user331	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00331	user331@baps.org	\N	\N	2020-01-01	mahila	active
k_332	Sk-332	SK Sardarnagar (Mahila)	sampark_karyakar	user332	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00332	user332@baps.org	\N	\N	2020-01-01	mahila	active
k_333	KN-00333	MS Gorwa - 1 (Mahila)	mandal_sanchalak	user333	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00333	user333@baps.org	\N	\N	2020-01-01	mahila	active
k_334	Sk-334	SK Gorwa - 1 (Mahila)	sampark_karyakar	user334	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00334	user334@baps.org	\N	\N	2020-01-01	mahila	active
k_335	KN-00335	MS Gorwa - 2 (Mahila)	mandal_sanchalak	user335	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00335	user335@baps.org	\N	\N	2020-01-01	mahila	active
k_336	Sk-336	SK Gorwa - 2 (Mahila)	sampark_karyakar	user336	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00336	user336@baps.org	\N	\N	2020-01-01	mahila	active
k_337	KN-00337	MS Gorwa - 3 (Mahila)	mandal_sanchalak	user337	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00337	user337@baps.org	\N	\N	2020-01-01	mahila	active
k_338	Sk-338	SK Gorwa - 3 (Mahila)	sampark_karyakar	user338	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00338	user338@baps.org	\N	\N	2020-01-01	mahila	active
k_339	KN-00339	MS Gorwa - 4 (Mahila)	mandal_sanchalak	user339	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00339	user339@baps.org	\N	\N	2020-01-01	mahila	active
k_340	Sk-340	SK Gorwa - 4 (Mahila)	sampark_karyakar	user340	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00340	user340@baps.org	\N	\N	2020-01-01	mahila	active
k_341	KN-00341	MS Bajwa (Mahila)	mandal_sanchalak	user341	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00341	user341@baps.org	\N	\N	2020-01-01	mahila	active
k_342	Sk-342	SK Bajwa (Mahila)	sampark_karyakar	user342	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00342	user342@baps.org	\N	\N	2020-01-01	mahila	active
k_343	KN-00343	MS Karachiya (Mahila)	mandal_sanchalak	user343	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00343	user343@baps.org	\N	\N	2020-01-01	mahila	active
k_344	Sk-344	SK Karachiya (Mahila)	sampark_karyakar	user344	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00344	user344@baps.org	\N	\N	2020-01-01	mahila	active
k_345	KN-00345	MS Lakshmipura (Mahila)	mandal_sanchalak	user345	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00345	user345@baps.org	\N	\N	2020-01-01	mahila	active
k_346	Sk-346	SK Lakshmipura (Mahila)	sampark_karyakar	user346	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00346	user346@baps.org	\N	\N	2020-01-01	mahila	active
k_347	KN-00347	Nirikshak X1 Bal	nirikshak	user347	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00347	user347@baps.org	\N	\N	2020-01-01	bal	active
k_348	KN-00348	MS Labh Bal (Bal)	mandal_sanchalak	user348	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00348	user348@baps.org	\N	\N	2020-01-01	bal	active
k_349	Sk-349	SK Labh Bal (Bal)	sampark_karyakar	user349	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00349	user349@baps.org	\N	\N	2020-01-01	bal	active
k_350	KN-00350	MS Labh Shishu (Bal)	mandal_sanchalak	user350	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00350	user350@baps.org	\N	\N	2020-01-01	bal	active
k_351	Sk-351	SK Labh Shishu (Bal)	sampark_karyakar	user351	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00351	user351@baps.org	\N	\N	2020-01-01	bal	active
k_352	KN-00352	MS Nilkanth Bal (Bal)	mandal_sanchalak	user352	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00352	user352@baps.org	\N	\N	2020-01-01	bal	active
k_353	Sk-353	SK Nilkanth Bal (Bal)	sampark_karyakar	user353	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00353	user353@baps.org	\N	\N	2020-01-01	bal	active
k_354	KN-00354	MS Nilkanth Shishu (Bal)	mandal_sanchalak	user354	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00354	user354@baps.org	\N	\N	2020-01-01	bal	active
k_355	Sk-355	SK Nilkanth Shishu (Bal)	sampark_karyakar	user355	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00355	user355@baps.org	\N	\N	2020-01-01	bal	active
k_356	KN-00356	MS Sun Pharma Bal (Bal)	mandal_sanchalak	user356	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00356	user356@baps.org	\N	\N	2020-01-01	bal	active
k_357	Sk-357	SK Sun Pharma Bal (Bal)	sampark_karyakar	user357	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00357	user357@baps.org	\N	\N	2020-01-01	bal	active
k_358	KN-00358	MS Akshar Green Shishu (Bal)	mandal_sanchalak	user358	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00358	user358@baps.org	\N	\N	2020-01-01	bal	active
k_359	Sk-359	SK Akshar Green Shishu (Bal)	sampark_karyakar	user359	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00359	user359@baps.org	\N	\N	2020-01-01	bal	active
k_360	KN-00360	MS Atladara Bal (Bal)	mandal_sanchalak	user360	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00360	user360@baps.org	\N	\N	2020-01-01	bal	active
k_361	Sk-361	SK Atladara Bal (Bal)	sampark_karyakar	user361	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00361	user361@baps.org	\N	\N	2020-01-01	bal	active
k_362	KN-00362	MS Atladara Shishu (Bal)	mandal_sanchalak	user362	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00362	user362@baps.org	\N	\N	2020-01-01	bal	active
k_363	Sk-363	SK Atladara Shishu (Bal)	sampark_karyakar	user363	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00363	user363@baps.org	\N	\N	2020-01-01	bal	active
k_364	KN-00364	MS Pramukh Swami Nagar Bal (Bal)	mandal_sanchalak	user364	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00364	user364@baps.org	\N	\N	2020-01-01	bal	active
k_365	Sk-365	SK Pramukh Swami Nagar Bal (Bal)	sampark_karyakar	user365	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00365	user365@baps.org	\N	\N	2020-01-01	bal	active
k_366	KN-00366	MS Hiranagar Bal (Bal)	mandal_sanchalak	user366	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00366	user366@baps.org	\N	\N	2020-01-01	bal	active
k_367	Sk-367	SK Hiranagar Bal (Bal)	sampark_karyakar	user367	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00367	user367@baps.org	\N	\N	2020-01-01	bal	active
k_368	KN-00368	MS Hiranagar Shishu (Bal)	mandal_sanchalak	user368	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00368	user368@baps.org	\N	\N	2020-01-01	bal	active
k_369	Sk-369	SK Hiranagar Shishu (Bal)	sampark_karyakar	user369	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00369	user369@baps.org	\N	\N	2020-01-01	bal	active
k_370	KN-00370	MS Vidyut Nagar Bal (Bal)	mandal_sanchalak	user370	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00370	user370@baps.org	\N	\N	2020-01-01	bal	active
k_371	Sk-371	SK Vidyut Nagar Bal (Bal)	sampark_karyakar	user371	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00371	user371@baps.org	\N	\N	2020-01-01	bal	active
k_372	KN-00372	MS Kalali Bal (Bal)	mandal_sanchalak	user372	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00372	user372@baps.org	\N	\N	2020-01-01	bal	active
k_373	Sk-373	SK Kalali Bal (Bal)	sampark_karyakar	user373	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00373	user373@baps.org	\N	\N	2020-01-01	bal	active
k_374	KN-00374	MS Atladara Gam Bal (Bal)	mandal_sanchalak	user374	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00374	user374@baps.org	\N	\N	2020-01-01	bal	active
k_375	Sk-375	SK Atladara Gam Bal (Bal)	sampark_karyakar	user375	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00375	user375@baps.org	\N	\N	2020-01-01	bal	active
k_376	KN-00376	MS Atladara Gam 2 Bal (Bal)	mandal_sanchalak	user376	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00376	user376@baps.org	\N	\N	2020-01-01	bal	active
k_377	Sk-377	SK Atladara Gam 2 Bal (Bal)	sampark_karyakar	user377	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00377	user377@baps.org	\N	\N	2020-01-01	bal	active
k_378	KN-00378	MS Gunatitdham Bal (Bal)	mandal_sanchalak	user378	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00378	user378@baps.org	\N	\N	2020-01-01	bal	active
k_379	Sk-379	SK Gunatitdham Bal (Bal)	sampark_karyakar	user379	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00379	user379@baps.org	\N	\N	2020-01-01	bal	active
k_380	KN-00380	MS Gunatitdham Shishu (Bal)	mandal_sanchalak	user380	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00380	user380@baps.org	\N	\N	2020-01-01	bal	active
k_381	Sk-381	SK Gunatitdham Shishu (Bal)	sampark_karyakar	user381	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00381	user381@baps.org	\N	\N	2020-01-01	bal	active
k_382	KN-00382	MS Sairang Bal (Bal)	mandal_sanchalak	user382	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00382	user382@baps.org	\N	\N	2020-01-01	bal	active
k_383	Sk-383	SK Sairang Bal (Bal)	sampark_karyakar	user383	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00383	user383@baps.org	\N	\N	2020-01-01	bal	active
k_384	KN-00384	MS Avadh Upavan Bal (Bal)	mandal_sanchalak	user384	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00384	user384@baps.org	\N	\N	2020-01-01	bal	active
k_385	Sk-385	SK Avadh Upavan Bal (Bal)	sampark_karyakar	user385	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00385	user385@baps.org	\N	\N	2020-01-01	bal	active
k_386	KN-00386	MS Avadh Upavan Shishu (Bal)	mandal_sanchalak	user386	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00386	user386@baps.org	\N	\N	2020-01-01	bal	active
k_387	Sk-387	SK Avadh Upavan Shishu (Bal)	sampark_karyakar	user387	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00387	user387@baps.org	\N	\N	2020-01-01	bal	active
k_388	KN-00388	MS Akshar Paradise Bal (Bal)	mandal_sanchalak	user388	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00388	user388@baps.org	\N	\N	2020-01-01	bal	active
k_389	Sk-389	SK Akshar Paradise Bal (Bal)	sampark_karyakar	user389	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00389	user389@baps.org	\N	\N	2020-01-01	bal	active
k_390	KN-00390	MS Indravilla Bal (Bal)	mandal_sanchalak	user390	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00390	user390@baps.org	\N	\N	2020-01-01	bal	active
k_391	Sk-391	SK Indravilla Bal (Bal)	sampark_karyakar	user391	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00391	user391@baps.org	\N	\N	2020-01-01	bal	active
k_392	KN-00392	MS Anant Swagatam Bal (Bal)	mandal_sanchalak	user392	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00392	user392@baps.org	\N	\N	2020-01-01	bal	active
k_393	Sk-393	SK Anant Swagatam Bal (Bal)	sampark_karyakar	user393	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00393	user393@baps.org	\N	\N	2020-01-01	bal	active
k_394	KN-00394	MS Param Krisht Bal (Bal)	mandal_sanchalak	user394	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00394	user394@baps.org	\N	\N	2020-01-01	bal	active
k_395	Sk-395	SK Param Krisht Bal (Bal)	sampark_karyakar	user395	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00395	user395@baps.org	\N	\N	2020-01-01	bal	active
k_396	KN-00396	MS Arya Empire Bal (Bal)	mandal_sanchalak	user396	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00396	user396@baps.org	\N	\N	2020-01-01	bal	active
k_397	Sk-397	SK Arya Empire Bal (Bal)	sampark_karyakar	user397	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00397	user397@baps.org	\N	\N	2020-01-01	bal	active
k_398	KN-00398	MS Green Yard Bal (Bal)	mandal_sanchalak	user398	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00398	user398@baps.org	\N	\N	2020-01-01	bal	active
k_399	Sk-399	SK Green Yard Bal (Bal)	sampark_karyakar	user399	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00399	user399@baps.org	\N	\N	2020-01-01	bal	active
k_400	KN-00400	MS Kishan Glory Bal (Bal)	mandal_sanchalak	user400	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00400	user400@baps.org	\N	\N	2020-01-01	bal	active
k_401	Sk-401	SK Kishan Glory Bal (Bal)	sampark_karyakar	user401	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00401	user401@baps.org	\N	\N	2020-01-01	bal	active
k_402	KN-00402	MS Pramukh Swami Villa Bal (Bal)	mandal_sanchalak	user402	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00402	user402@baps.org	\N	\N	2020-01-01	bal	active
k_403	Sk-403	SK Pramukh Swami Villa Bal (Bal)	sampark_karyakar	user403	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00403	user403@baps.org	\N	\N	2020-01-01	bal	active
k_404	KN-00404	MS Yoginagar Bal (Bal)	mandal_sanchalak	user404	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00404	user404@baps.org	\N	\N	2020-01-01	bal	active
k_405	Sk-405	SK Yoginagar Bal (Bal)	sampark_karyakar	user405	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00405	user405@baps.org	\N	\N	2020-01-01	bal	active
k_406	KN-00406	MS Vrundavan Shishu (Bal)	mandal_sanchalak	user406	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00406	user406@baps.org	\N	\N	2020-01-01	bal	active
k_407	Sk-407	SK Vrundavan Shishu (Bal)	sampark_karyakar	user407	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00407	user407@baps.org	\N	\N	2020-01-01	bal	active
k_408	KN-00408	MS Pramukh Swami Tirth Bal (Bal)	mandal_sanchalak	user408	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00408	user408@baps.org	\N	\N	2020-01-01	bal	active
k_409	Sk-409	SK Pramukh Swami Tirth Bal (Bal)	sampark_karyakar	user409	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00409	user409@baps.org	\N	\N	2020-01-01	bal	active
k_410	KN-00410	Nirikshak X2 Bal	nirikshak	user410	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00410	user410@baps.org	\N	\N	2020-01-01	bal	active
k_411	KN-00411	MS Indrapuri Bal (Bal)	mandal_sanchalak	user411	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00411	user411@baps.org	\N	\N	2020-01-01	bal	active
k_412	Sk-412	SK Indrapuri Bal (Bal)	sampark_karyakar	user412	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00412	user412@baps.org	\N	\N	2020-01-01	bal	active
k_413	KN-00413	MS Nathiba Nagar Bal (Bal)	mandal_sanchalak	user413	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00413	user413@baps.org	\N	\N	2020-01-01	bal	active
k_414	Sk-414	SK Nathiba Nagar Bal (Bal)	sampark_karyakar	user414	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00414	user414@baps.org	\N	\N	2020-01-01	bal	active
k_415	KN-00415	MS Vaikunth Bal (Bal)	mandal_sanchalak	user415	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00415	user415@baps.org	\N	\N	2020-01-01	bal	active
k_416	Sk-416	SK Vaikunth Bal (Bal)	sampark_karyakar	user416	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00416	user416@baps.org	\N	\N	2020-01-01	bal	active
k_417	KN-00417	MS Kamlanagar Bal (Bal)	mandal_sanchalak	user417	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00417	user417@baps.org	\N	\N	2020-01-01	bal	active
k_418	Sk-418	SK Kamlanagar Bal (Bal)	sampark_karyakar	user418	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00418	user418@baps.org	\N	\N	2020-01-01	bal	active
k_419	KN-00419	MS Seva Kunj Bal (Bal)	mandal_sanchalak	user419	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00419	user419@baps.org	\N	\N	2020-01-01	bal	active
k_420	Sk-420	SK Seva Kunj Bal (Bal)	sampark_karyakar	user420	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00420	user420@baps.org	\N	\N	2020-01-01	bal	active
k_421	KN-00421	MS Pancham Villa Bal (Bal)	mandal_sanchalak	user421	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00421	user421@baps.org	\N	\N	2020-01-01	bal	active
k_422	Sk-422	SK Pancham Villa Bal (Bal)	sampark_karyakar	user422	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00422	user422@baps.org	\N	\N	2020-01-01	bal	active
k_423	KN-00423	MS Sugam Park Bal (Bal)	mandal_sanchalak	user423	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00423	user423@baps.org	\N	\N	2020-01-01	bal	active
k_424	Sk-424	SK Sugam Park Bal (Bal)	sampark_karyakar	user424	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00424	user424@baps.org	\N	\N	2020-01-01	bal	active
k_425	KN-00425	MS Shri Hari Township Bal (Bal)	mandal_sanchalak	user425	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00425	user425@baps.org	\N	\N	2020-01-01	bal	active
k_426	Sk-426	SK Shri Hari Township Bal (Bal)	sampark_karyakar	user426	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00426	user426@baps.org	\N	\N	2020-01-01	bal	active
k_427	KN-00427	MS Ambika Darshan 2 Bal (Bal)	mandal_sanchalak	user427	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00427	user427@baps.org	\N	\N	2020-01-01	bal	active
k_428	Sk-428	SK Ambika Darshan 2 Bal (Bal)	sampark_karyakar	user428	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00428	user428@baps.org	\N	\N	2020-01-01	bal	active
k_429	KN-00429	MS Harikrishna Township Bal (Bal)	mandal_sanchalak	user429	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00429	user429@baps.org	\N	\N	2020-01-01	bal	active
k_430	Sk-430	SK Harikrishna Township Bal (Bal)	sampark_karyakar	user430	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00430	user430@baps.org	\N	\N	2020-01-01	bal	active
k_431	KN-00431	MS Parimal 3 Bal (Bal)	mandal_sanchalak	user431	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00431	user431@baps.org	\N	\N	2020-01-01	bal	active
k_432	Sk-432	SK Parimal 3 Bal (Bal)	sampark_karyakar	user432	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00432	user432@baps.org	\N	\N	2020-01-01	bal	active
k_433	KN-00433	MS Sayajinagar Bal (Bal)	mandal_sanchalak	user433	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00433	user433@baps.org	\N	\N	2020-01-01	bal	active
k_434	Sk-434	SK Sayajinagar Bal (Bal)	sampark_karyakar	user434	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00434	user434@baps.org	\N	\N	2020-01-01	bal	active
k_435	KN-00435	MS Kishanwadi Bal (Bal)	mandal_sanchalak	user435	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00435	user435@baps.org	\N	\N	2020-01-01	bal	active
k_436	Sk-436	SK Kishanwadi Bal (Bal)	sampark_karyakar	user436	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00436	user436@baps.org	\N	\N	2020-01-01	bal	active
k_437	KN-00437	MS Satadhar Bal (Bal)	mandal_sanchalak	user437	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00437	user437@baps.org	\N	\N	2020-01-01	bal	active
k_438	Sk-438	SK Satadhar Bal (Bal)	sampark_karyakar	user438	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00438	user438@baps.org	\N	\N	2020-01-01	bal	active
k_439	KN-00439	MS Bhailalbhai Park Bal (Bal)	mandal_sanchalak	user439	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00439	user439@baps.org	\N	\N	2020-01-01	bal	active
k_440	Sk-440	SK Bhailalbhai Park Bal (Bal)	sampark_karyakar	user440	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00440	user440@baps.org	\N	\N	2020-01-01	bal	active
k_441	KN-00441	MS Indrapuri Shishu (Bal)	mandal_sanchalak	user441	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00441	user441@baps.org	\N	\N	2020-01-01	bal	active
k_442	Sk-442	SK Indrapuri Shishu (Bal)	sampark_karyakar	user442	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00442	user442@baps.org	\N	\N	2020-01-01	bal	active
k_443	KN-00443	MS Danteshwar Bal (Bal)	mandal_sanchalak	user443	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00443	user443@baps.org	\N	\N	2020-01-01	bal	active
k_444	Sk-444	SK Danteshwar Bal (Bal)	sampark_karyakar	user444	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00444	user444@baps.org	\N	\N	2020-01-01	bal	active
k_445	KN-00445	MS Anupam Nagar Bal (Bal)	mandal_sanchalak	user445	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00445	user445@baps.org	\N	\N	2020-01-01	bal	active
k_446	Sk-446	SK Anupam Nagar Bal (Bal)	sampark_karyakar	user446	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00446	user446@baps.org	\N	\N	2020-01-01	bal	active
k_447	KN-00447	MS Zillion Bal (Bal)	mandal_sanchalak	user447	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00447	user447@baps.org	\N	\N	2020-01-01	bal	active
k_448	Sk-448	SK Zillion Bal (Bal)	sampark_karyakar	user448	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00448	user448@baps.org	\N	\N	2020-01-01	bal	active
k_449	KN-00449	MS Tarsali Bal (Bal)	mandal_sanchalak	user449	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00449	user449@baps.org	\N	\N	2020-01-01	bal	active
k_450	Sk-450	SK Tarsali Bal (Bal)	sampark_karyakar	user450	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00450	user450@baps.org	\N	\N	2020-01-01	bal	active
k_451	KN-00451	MS Vallabh Duplex Bal (Bal)	mandal_sanchalak	user451	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00451	user451@baps.org	\N	\N	2020-01-01	bal	active
k_452	Sk-452	SK Vallabh Duplex Bal (Bal)	sampark_karyakar	user452	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00452	user452@baps.org	\N	\N	2020-01-01	bal	active
k_453	KN-00453	MS Gold City Bal (Bal)	mandal_sanchalak	user453	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00453	user453@baps.org	\N	\N	2020-01-01	bal	active
k_454	Sk-454	SK Gold City Bal (Bal)	sampark_karyakar	user454	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00454	user454@baps.org	\N	\N	2020-01-01	bal	active
k_455	KN-00455	MS Tuljanagar Bal (Bal)	mandal_sanchalak	user455	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00455	user455@baps.org	\N	\N	2020-01-01	bal	active
k_456	Sk-456	SK Tuljanagar Bal (Bal)	sampark_karyakar	user456	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00456	user456@baps.org	\N	\N	2020-01-01	bal	active
k_457	KN-00457	MS Makarpura Bal (Bal)	mandal_sanchalak	user457	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00457	user457@baps.org	\N	\N	2020-01-01	bal	active
k_458	Sk-458	SK Makarpura Bal (Bal)	sampark_karyakar	user458	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00458	user458@baps.org	\N	\N	2020-01-01	bal	active
k_459	KN-00459	MS Akruti Duplex Bal (Bal)	mandal_sanchalak	user459	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00459	user459@baps.org	\N	\N	2020-01-01	bal	active
k_460	Sk-460	SK Akruti Duplex Bal (Bal)	sampark_karyakar	user460	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00460	user460@baps.org	\N	\N	2020-01-01	bal	active
k_461	KN-00461	MS Maneja Bal (Bal)	mandal_sanchalak	user461	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00461	user461@baps.org	\N	\N	2020-01-01	bal	active
k_462	Sk-462	SK Maneja Bal (Bal)	sampark_karyakar	user462	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00462	user462@baps.org	\N	\N	2020-01-01	bal	active
k_463	KN-00463	MS Gayatrinagar Bal (Bal)	mandal_sanchalak	user463	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00463	user463@baps.org	\N	\N	2020-01-01	bal	active
k_464	Sk-464	SK Gayatrinagar Bal (Bal)	sampark_karyakar	user464	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00464	user464@baps.org	\N	\N	2020-01-01	bal	active
k_465	KN-00465	MS Danteshwar Shishu (Bal)	mandal_sanchalak	user465	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00465	user465@baps.org	\N	\N	2020-01-01	bal	active
k_466	Sk-466	SK Danteshwar Shishu (Bal)	sampark_karyakar	user466	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00466	user466@baps.org	\N	\N	2020-01-01	bal	active
k_467	KN-00467	MS Sharadnagar Shishu (Bal)	mandal_sanchalak	user467	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00467	user467@baps.org	\N	\N	2020-01-01	bal	active
k_468	Sk-468	SK Sharadnagar Shishu (Bal)	sampark_karyakar	user468	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00468	user468@baps.org	\N	\N	2020-01-01	bal	active
k_469	KN-00469	MS Gayatrinagar Shishu (Bal)	mandal_sanchalak	user469	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00469	user469@baps.org	\N	\N	2020-01-01	bal	active
k_470	Sk-470	SK Gayatrinagar Shishu (Bal)	sampark_karyakar	user470	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00470	user470@baps.org	\N	\N	2020-01-01	bal	active
k_471	KN-00471	MS Shiyabaug Bal (Bal)	mandal_sanchalak	user471	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00471	user471@baps.org	\N	\N	2020-01-01	bal	active
k_472	Sk-472	SK Shiyabaug Bal (Bal)	sampark_karyakar	user472	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00472	user472@baps.org	\N	\N	2020-01-01	bal	active
k_473	KN-00473	MS Nyaymandir Bal (Bal)	mandal_sanchalak	user473	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00473	user473@baps.org	\N	\N	2020-01-01	bal	active
k_474	Sk-474	SK Nyaymandir Bal (Bal)	sampark_karyakar	user474	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00474	user474@baps.org	\N	\N	2020-01-01	bal	active
k_475	KN-00475	MS Wadi Bal (Bal)	mandal_sanchalak	user475	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00475	user475@baps.org	\N	\N	2020-01-01	bal	active
k_476	Sk-476	SK Wadi Bal (Bal)	sampark_karyakar	user476	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00476	user476@baps.org	\N	\N	2020-01-01	bal	active
k_477	KN-00477	MS Akshar Tenament Bal (Bal)	mandal_sanchalak	user477	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00477	user477@baps.org	\N	\N	2020-01-01	bal	active
k_478	Sk-478	SK Akshar Tenament Bal (Bal)	sampark_karyakar	user478	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00478	user478@baps.org	\N	\N	2020-01-01	bal	active
k_479	KN-00479	MS Vaishnav Park Bal (Bal)	mandal_sanchalak	user479	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00479	user479@baps.org	\N	\N	2020-01-01	bal	active
k_480	Sk-480	SK Vaishnav Park Bal (Bal)	sampark_karyakar	user480	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00480	user480@baps.org	\N	\N	2020-01-01	bal	active
k_481	KN-00481	MS Yogi Raday Bal (Bal)	mandal_sanchalak	user481	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00481	user481@baps.org	\N	\N	2020-01-01	bal	active
k_482	Sk-482	SK Yogi Raday Bal (Bal)	sampark_karyakar	user482	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00482	user482@baps.org	\N	\N	2020-01-01	bal	active
k_483	KN-00483	MS Shivam Bal (Bal)	mandal_sanchalak	user483	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00483	user483@baps.org	\N	\N	2020-01-01	bal	active
k_484	Sk-484	SK Shivam Bal (Bal)	sampark_karyakar	user484	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00484	user484@baps.org	\N	\N	2020-01-01	bal	active
k_485	KN-00485	MS Soles Bal (Bal)	mandal_sanchalak	user485	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00485	user485@baps.org	\N	\N	2020-01-01	bal	active
k_486	Sk-486	SK Soles Bal (Bal)	sampark_karyakar	user486	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00486	user486@baps.org	\N	\N	2020-01-01	bal	active
k_487	KN-00487	MS Darshanam Green Bal (Bal)	mandal_sanchalak	user487	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00487	user487@baps.org	\N	\N	2020-01-01	bal	active
k_488	Sk-488	SK Darshanam Green Bal (Bal)	sampark_karyakar	user488	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00488	user488@baps.org	\N	\N	2020-01-01	bal	active
k_489	KN-00489	MS Jalaram Nagar Bal (Bal)	mandal_sanchalak	user489	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00489	user489@baps.org	\N	\N	2020-01-01	bal	active
k_490	Sk-490	SK Jalaram Nagar Bal (Bal)	sampark_karyakar	user490	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00490	user490@baps.org	\N	\N	2020-01-01	bal	active
k_491	KN-00491	MS D Mart Bal (Bal)	mandal_sanchalak	user491	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00491	user491@baps.org	\N	\N	2020-01-01	bal	active
k_492	Sk-492	SK D Mart Bal (Bal)	sampark_karyakar	user492	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00492	user492@baps.org	\N	\N	2020-01-01	bal	active
k_493	KN-00493	MS Dhanlaxmi Tenament Bal (Bal)	mandal_sanchalak	user493	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00493	user493@baps.org	\N	\N	2020-01-01	bal	active
k_494	Sk-494	SK Dhanlaxmi Tenament Bal (Bal)	sampark_karyakar	user494	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00494	user494@baps.org	\N	\N	2020-01-01	bal	active
k_495	KN-00495	MS Manjalpur Bal (Bal)	mandal_sanchalak	user495	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00495	user495@baps.org	\N	\N	2020-01-01	bal	active
k_496	Sk-496	SK Manjalpur Bal (Bal)	sampark_karyakar	user496	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00496	user496@baps.org	\N	\N	2020-01-01	bal	active
k_497	KN-00497	MS Surabhipark Bal (Bal)	mandal_sanchalak	user497	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00497	user497@baps.org	\N	\N	2020-01-01	bal	active
k_498	Sk-498	SK Surabhipark Bal (Bal)	sampark_karyakar	user498	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00498	user498@baps.org	\N	\N	2020-01-01	bal	active
k_499	KN-00499	MS Pujan Bal (Bal)	mandal_sanchalak	user499	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00499	user499@baps.org	\N	\N	2020-01-01	bal	active
k_500	Sk-500	SK Pujan Bal (Bal)	sampark_karyakar	user500	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00500	user500@baps.org	\N	\N	2020-01-01	bal	active
k_501	KN-00501	MS Vaibhav Vatika Bal (Bal)	mandal_sanchalak	user501	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00501	user501@baps.org	\N	\N	2020-01-01	bal	active
k_502	Sk-502	SK Vaibhav Vatika Bal (Bal)	sampark_karyakar	user502	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00502	user502@baps.org	\N	\N	2020-01-01	bal	active
k_503	KN-00503	MS Kedardham Bal (Bal)	mandal_sanchalak	user503	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00503	user503@baps.org	\N	\N	2020-01-01	bal	active
k_504	Sk-504	SK Kedardham Bal (Bal)	sampark_karyakar	user504	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00504	user504@baps.org	\N	\N	2020-01-01	bal	active
k_505	KN-00505	MS Kamleshwar Nagar Bal (Bal)	mandal_sanchalak	user505	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00505	user505@baps.org	\N	\N	2020-01-01	bal	active
k_506	Sk-506	SK Kamleshwar Nagar Bal (Bal)	sampark_karyakar	user506	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00506	user506@baps.org	\N	\N	2020-01-01	bal	active
k_507	KN-00507	MS Gayatri Krupa Bal (Bal)	mandal_sanchalak	user507	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00507	user507@baps.org	\N	\N	2020-01-01	bal	active
k_508	Sk-508	SK Gayatri Krupa Bal (Bal)	sampark_karyakar	user508	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00508	user508@baps.org	\N	\N	2020-01-01	bal	active
k_509	KN-00509	MS Parthbhumi Bal (Bal)	mandal_sanchalak	user509	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00509	user509@baps.org	\N	\N	2020-01-01	bal	active
k_510	Sk-510	SK Parthbhumi Bal (Bal)	sampark_karyakar	user510	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00510	user510@baps.org	\N	\N	2020-01-01	bal	active
k_511	KN-00511	MS Vadsar Bal (Bal)	mandal_sanchalak	user511	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00511	user511@baps.org	\N	\N	2020-01-01	bal	active
k_512	Sk-512	SK Vadsar Bal (Bal)	sampark_karyakar	user512	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00512	user512@baps.org	\N	\N	2020-01-01	bal	active
k_513	KN-00513	Nirikshak X3 Bal	nirikshak	user513	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00513	user513@baps.org	\N	\N	2020-01-01	bal	active
k_514	KN-00514	MS Sama Bal (Bal)	mandal_sanchalak	user514	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00514	user514@baps.org	\N	\N	2020-01-01	bal	active
k_515	Sk-515	SK Sama Bal (Bal)	sampark_karyakar	user515	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00515	user515@baps.org	\N	\N	2020-01-01	bal	active
k_516	KN-00516	MS Vemali Bal (Bal)	mandal_sanchalak	user516	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00516	user516@baps.org	\N	\N	2020-01-01	bal	active
k_517	Sk-517	SK Vemali Bal (Bal)	sampark_karyakar	user517	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00517	user517@baps.org	\N	\N	2020-01-01	bal	active
k_518	KN-00518	MS Vemali Gam Sanskar Kendra (Bal)	mandal_sanchalak	user518	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00518	user518@baps.org	\N	\N	2020-01-01	bal	active
k_519	Sk-519	SK Vemali Gam Sanskar Kendra (Bal)	sampark_karyakar	user519	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00519	user519@baps.org	\N	\N	2020-01-01	bal	active
k_520	KN-00520	MS Karelibaug Bal (Bal)	mandal_sanchalak	user520	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00520	user520@baps.org	\N	\N	2020-01-01	bal	active
k_521	Sk-521	SK Karelibaug Bal (Bal)	sampark_karyakar	user521	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00521	user521@baps.org	\N	\N	2020-01-01	bal	active
k_522	KN-00522	MS Pramukh Preet Bal (Bal)	mandal_sanchalak	user522	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00522	user522@baps.org	\N	\N	2020-01-01	bal	active
k_523	Sk-523	SK Pramukh Preet Bal (Bal)	sampark_karyakar	user523	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00523	user523@baps.org	\N	\N	2020-01-01	bal	active
k_524	KN-00524	MS Airport Bal (Bal)	mandal_sanchalak	user524	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00524	user524@baps.org	\N	\N	2020-01-01	bal	active
k_525	Sk-525	SK Airport Bal (Bal)	sampark_karyakar	user525	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00525	user525@baps.org	\N	\N	2020-01-01	bal	active
k_526	KN-00526	MS Khodiyar Nagar Bal (Bal)	mandal_sanchalak	user526	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00526	user526@baps.org	\N	\N	2020-01-01	bal	active
k_527	Sk-527	SK Khodiyar Nagar Bal (Bal)	sampark_karyakar	user527	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00527	user527@baps.org	\N	\N	2020-01-01	bal	active
k_528	KN-00528	MS Vrundavan Bal (Bal)	mandal_sanchalak	user528	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00528	user528@baps.org	\N	\N	2020-01-01	bal	active
k_529	Sk-529	SK Vrundavan Bal (Bal)	sampark_karyakar	user529	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00529	user529@baps.org	\N	\N	2020-01-01	bal	active
k_530	KN-00530	MS Siddharth Bungalow Sanskar Kendra (Bal)	mandal_sanchalak	user530	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00530	user530@baps.org	\N	\N	2020-01-01	bal	active
k_531	Sk-531	SK Siddharth Bungalow Sanskar Kendra (Bal)	sampark_karyakar	user531	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00531	user531@baps.org	\N	\N	2020-01-01	bal	active
k_532	KN-00532	MS Motnath Residency Sanskar Kendra (Bal)	mandal_sanchalak	user532	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00532	user532@baps.org	\N	\N	2020-01-01	bal	active
k_533	Sk-533	SK Motnath Residency Sanskar Kendra (Bal)	sampark_karyakar	user533	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00533	user533@baps.org	\N	\N	2020-01-01	bal	active
k_534	KN-00534	MS Chhani Jakatnaka Bal (Bal)	mandal_sanchalak	user534	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00534	user534@baps.org	\N	\N	2020-01-01	bal	active
k_535	Sk-535	SK Chhani Jakatnaka Bal (Bal)	sampark_karyakar	user535	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00535	user535@baps.org	\N	\N	2020-01-01	bal	active
k_536	KN-00536	MS Nakshatra Bal (Bal)	mandal_sanchalak	user536	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00536	user536@baps.org	\N	\N	2020-01-01	bal	active
k_537	Sk-537	SK Nakshatra Bal (Bal)	sampark_karyakar	user537	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00537	user537@baps.org	\N	\N	2020-01-01	bal	active
k_538	KN-00538	MS Satyanarayan Bal (Bal)	mandal_sanchalak	user538	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00538	user538@baps.org	\N	\N	2020-01-01	bal	active
k_539	Sk-539	SK Satyanarayan Bal (Bal)	sampark_karyakar	user539	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00539	user539@baps.org	\N	\N	2020-01-01	bal	active
k_540	KN-00540	MS Sardarnagar Bal (Bal)	mandal_sanchalak	user540	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00540	user540@baps.org	\N	\N	2020-01-01	bal	active
k_541	Sk-541	SK Sardarnagar Bal (Bal)	sampark_karyakar	user541	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00541	user541@baps.org	\N	\N	2020-01-01	bal	active
k_542	KN-00542	MS Chhanigam Bal (Bal)	mandal_sanchalak	user542	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00542	user542@baps.org	\N	\N	2020-01-01	bal	active
k_543	Sk-543	SK Chhanigam Bal (Bal)	sampark_karyakar	user543	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00543	user543@baps.org	\N	\N	2020-01-01	bal	active
k_544	KN-00544	MS Marutinandan Sanskar Kendra (Bal)	mandal_sanchalak	user544	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00544	user544@baps.org	\N	\N	2020-01-01	bal	active
k_545	Sk-545	SK Marutinandan Sanskar Kendra (Bal)	sampark_karyakar	user545	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00545	user545@baps.org	\N	\N	2020-01-01	bal	active
k_546	KN-00546	MS Karelibaug Shishu (Bal)	mandal_sanchalak	user546	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00546	user546@baps.org	\N	\N	2020-01-01	bal	active
k_547	Sk-547	SK Karelibaug Shishu (Bal)	sampark_karyakar	user547	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00547	user547@baps.org	\N	\N	2020-01-01	bal	active
k_548	KN-00548	MS Sama Shishu (Bal)	mandal_sanchalak	user548	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00548	user548@baps.org	\N	\N	2020-01-01	bal	active
k_549	Sk-549	SK Sama Shishu (Bal)	sampark_karyakar	user549	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00549	user549@baps.org	\N	\N	2020-01-01	bal	active
k_550	KN-00550	MS Chhani Jakatnaka Shishu (Bal)	mandal_sanchalak	user550	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00550	user550@baps.org	\N	\N	2020-01-01	bal	active
k_551	Sk-551	SK Chhani Jakatnaka Shishu (Bal)	sampark_karyakar	user551	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00551	user551@baps.org	\N	\N	2020-01-01	bal	active
k_552	KN-00552	Nirikshak X1 Balika	nirikshak	user552	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00552	user552@baps.org	\N	\N	2020-01-01	balika	active
k_553	KN-00553	MS Pushpam (Balika)	mandal_sanchalak	user553	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00553	user553@baps.org	\N	\N	2020-01-01	balika	active
k_554	Sk-554	SK Pushpam (Balika)	sampark_karyakar	user554	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00554	user554@baps.org	\N	\N	2020-01-01	balika	active
k_555	KN-00555	MS Harinagar (Balika)	mandal_sanchalak	user555	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00555	user555@baps.org	\N	\N	2020-01-01	balika	active
k_556	Sk-556	SK Harinagar (Balika)	sampark_karyakar	user556	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00556	user556@baps.org	\N	\N	2020-01-01	balika	active
k_557	KN-00557	MS Harinagar Shishu (Balika)	mandal_sanchalak	user557	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00557	user557@baps.org	\N	\N	2020-01-01	balika	active
k_558	Sk-558	SK Harinagar Shishu (Balika)	sampark_karyakar	user558	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00558	user558@baps.org	\N	\N	2020-01-01	balika	active
k_559	KN-00559	MS Chandranagar (Balika)	mandal_sanchalak	user559	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00559	user559@baps.org	\N	\N	2020-01-01	balika	active
k_560	Sk-560	SK Chandranagar (Balika)	sampark_karyakar	user560	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00560	user560@baps.org	\N	\N	2020-01-01	balika	active
k_561	KN-00561	MS Jay Ambe (Balika)	mandal_sanchalak	user561	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00561	user561@baps.org	\N	\N	2020-01-01	balika	active
k_562	Sk-562	SK Jay Ambe (Balika)	sampark_karyakar	user562	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00562	user562@baps.org	\N	\N	2020-01-01	balika	active
k_563	KN-00563	MS Shreeji (Balika)	mandal_sanchalak	user563	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00563	user563@baps.org	\N	\N	2020-01-01	balika	active
k_564	Sk-564	SK Shreeji (Balika)	sampark_karyakar	user564	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00564	user564@baps.org	\N	\N	2020-01-01	balika	active
k_565	KN-00565	MS Vaikunth (Balika)	mandal_sanchalak	user565	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00565	user565@baps.org	\N	\N	2020-01-01	balika	active
k_566	Sk-566	SK Vaikunth (Balika)	sampark_karyakar	user566	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00566	user566@baps.org	\N	\N	2020-01-01	balika	active
k_567	KN-00567	MS Samta Balika (Balika)	mandal_sanchalak	user567	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00567	user567@baps.org	\N	\N	2020-01-01	balika	active
k_568	Sk-568	SK Samta Balika (Balika)	sampark_karyakar	user568	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00568	user568@baps.org	\N	\N	2020-01-01	balika	active
k_569	KN-00569	Nirikshak X3 Balika	nirikshak	user569	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00569	user569@baps.org	\N	\N	2020-01-01	balika	active
k_570	KN-00570	MS Gokulnagar (Balika)	mandal_sanchalak	user570	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00570	user570@baps.org	\N	\N	2020-01-01	balika	active
k_571	Sk-571	SK Gokulnagar (Balika)	sampark_karyakar	user571	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00571	user571@baps.org	\N	\N	2020-01-01	balika	active
k_572	KN-00572	MS Jaladarshan (Balika)	mandal_sanchalak	user572	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00572	user572@baps.org	\N	\N	2020-01-01	balika	active
k_573	Sk-573	SK Jaladarshan (Balika)	sampark_karyakar	user573	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00573	user573@baps.org	\N	\N	2020-01-01	balika	active
k_574	KN-00574	MS Gotri Balika (Balika)	mandal_sanchalak	user574	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00574	user574@baps.org	\N	\N	2020-01-01	balika	active
k_575	Sk-575	SK Gotri Balika (Balika)	sampark_karyakar	user575	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00575	user575@baps.org	\N	\N	2020-01-01	balika	active
k_576	KN-00576	MS Yagnapurush (Balika)	mandal_sanchalak	user576	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00576	user576@baps.org	\N	\N	2020-01-01	balika	active
k_577	Sk-577	SK Yagnapurush (Balika)	sampark_karyakar	user577	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00577	user577@baps.org	\N	\N	2020-01-01	balika	active
k_578	KN-00578	MS Life Arena (Balika)	mandal_sanchalak	user578	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00578	user578@baps.org	\N	\N	2020-01-01	balika	active
k_579	Sk-579	SK Life Arena (Balika)	sampark_karyakar	user579	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00579	user579@baps.org	\N	\N	2020-01-01	balika	active
k_580	KN-00580	MS Khanpur (Balika)	mandal_sanchalak	user580	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00580	user580@baps.org	\N	\N	2020-01-01	balika	active
k_581	Sk-581	SK Khanpur (Balika)	sampark_karyakar	user581	$2b$12$pQjBzFouAcM.ehcLP/z5kugQI3yS6Zy/af8TDL4ii/FbexYiU4xx2	\N	+91 90000 00581	user581@baps.org	\N	\N	2020-01-01	balika	active
f74f3ebf-f2fa-4ecc-ba79-4898bf06baf6	AD001	System Admin	admin	admin	$2b$12$tD9BT59iKOZC03yrZvJqVOT25zDs.8FJR0CgKMWKp5ze8xcgkuWXK	\N	0000000000	admin@baps.org	\N	\N	2026-01-01	\N	active
k_1779512167068	Sk-284	Suresh	sampark_karyakar	Suresh_Patel	$2b$12$D6DGiCrUWTL.h/3CkSlVZeQ4BVti1CujFFNagBX7RAGw4r3ppKYGm		9876500025	hb25@baps.org	\N	\N	2026-05-23	sanyukt	active
\.


--
-- Data for Name: mandals; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.mandals (id, xetra_id, name, wing) FROM stdin;
m_0001	x1	P.Sw.Nagar - 1	mahila
m_0002	x1	P.Sw.Nagar - 2	mahila
m_0003	x1	Niramay - 1	mahila
m_0004	x1	Niramay - 2	mahila
m_0005	x1	Kalali - 1	mahila
m_0006	x1	Kalali - 2	mahila
m_0007	x1	Vishwamitri Township	mahila
m_0008	x1	Racecourse - 1	mahila
m_0009	x1	Racecourse - 2	mahila
m_0010	x1	Racecourse - 3	mahila
m_0011	x1	Racecourse - 4	mahila
m_0012	x1	Racecourse - 5	mahila
m_0013	x1	Samta	mahila
m_0014	x1	Harani	mahila
m_0015	x1	Atladara - 1	mahila
m_0016	x1	Atladara - 2	mahila
m_0017	x1	Atladara - 3	mahila
m_0018	x1	Ramlaxman - 1	mahila
m_0019	x1	Ramlaxman - 2	mahila
m_0020	x1	Vadsar	mahila
m_0021	x1	AvadhUpavan	mahila
m_0022	x1	Vrajdham	mahila
m_0023	x1	Vrundavan	mahila
m_0024	x1	Krishna Darshan	mahila
m_0025	x2	Indrapuri - 1	mahila
m_0026	x2	Indrapuri - 2	mahila
m_0027	x2	Indrapuri - 3	mahila
m_0028	x2	Indrapuri - 4	mahila
m_0029	x2	Kapurai	mahila
m_0030	x2	Sayajipura	mahila
m_0031	x2	Maneja	mahila
m_0032	x2	Manjalpur - 1	mahila
m_0033	x2	Manjalpur - 2	mahila
m_0034	x2	Manjalpur - 3	mahila
m_0035	x2	Manjalpur - 4	mahila
m_0036	x2	Manjalpur - 5	mahila
m_0037	x2	GIDC - 1	mahila
m_0038	x2	GIDC - 2	mahila
m_0039	x2	GIDC - 3	mahila
m_0040	x2	GIDC - 4	mahila
m_0041	x2	Wadi - 1	mahila
m_0042	x2	Wadi - 2	mahila
m_0043	x2	Shiyabaug - 1	mahila
m_0044	x2	Shiyabaug - 2	mahila
m_0045	x2	Shiyabaug - 3	mahila
m_0046	x2	Shiyabaug - 4	mahila
m_0047	x2	Shiyabaug - 5	mahila
m_0048	x2	Danteshwar - 1	mahila
m_0049	x2	Danteshwar - 2	mahila
m_0050	x2	Tarsali - 1	mahila
m_0051	x2	Tarsali - 2	mahila
m_0052	x2	Makarpura - 1	mahila
m_0053	x2	Makarpura - 2	mahila
m_0054	x2	Makarpura - 3	mahila
m_0055	x2	Makarpura - 4	mahila
m_0056	x2	Gayatrinagar	mahila
m_0057	x3	Sevasi - 1	mahila
m_0058	x3	Sevasi - 2	mahila
m_0059	x3	Gotri - 1	mahila
m_0060	x3	Gotri - 2	mahila
m_0061	x3	Gotri - 3	mahila
m_0062	x3	Gotri - 4	mahila
m_0063	x3	Gotri - 5	mahila
m_0064	x3	Chhani Jakatnaka - 1	mahila
m_0065	x3	Chhani Jakatnaka - 2	mahila
m_0066	x3	Chhani Jakatnaka - 3	mahila
m_0067	x3	Chhanigam - 1	mahila
m_0068	x3	Chhanigam - 2	mahila
m_0069	x3	Karelibaug - 1	mahila
m_0070	x3	Karelibaug - 2	mahila
m_0071	x3	Sama	mahila
m_0072	x3	Vemali	mahila
m_0073	x3	Motnath	mahila
m_0074	x3	Lileriya	mahila
m_0075	x3	Sardarnagar	mahila
m_0076	x3	Gorwa - 1	mahila
m_0077	x3	Gorwa - 2	mahila
m_0078	x3	Gorwa - 3	mahila
m_0079	x3	Gorwa - 4	mahila
m_0080	x3	Bajwa	mahila
m_0081	x3	Karachiya	mahila
m_0082	x3	Lakshmipura	mahila
m_0083	x1	Akota	sanyukt
m_0084	x1	Atladra	sanyukt
m_0085	x1	Kalali	sanyukt
m_0086	x1	Narayanwadi	sanyukt
m_0087	x1	Niramay	sanyukt
m_0088	x1	P.Sw.Nagar	sanyukt
m_0089	x1	Racecourse - 1	sanyukt
m_0090	x1	Racecourse - 2	sanyukt
m_0091	x1	Samta	sanyukt
m_0092	x1	Shyamvilla	sanyukt
m_0093	x1	Vadsar	sanyukt
m_0094	x2	Danteshwar	sanyukt
m_0095	x2	Gayatrinagar	sanyukt
m_0096	x2	Indrapuri - 1	sanyukt
m_0097	x2	Indrapuri - 2	sanyukt
m_0098	x2	Makarpura	sanyukt
m_0099	x2	Maneja	sanyukt
m_0100	x2	Manjalpur - 1	sanyukt
m_0101	x2	Manjalpur - 2	sanyukt
m_0102	x2	Shiyabaug	sanyukt
m_0103	x2	Tarsali	sanyukt
m_0104	x2	Wadi	sanyukt
m_0105	x3	Bajwa	sanyukt
m_0106	x3	Chhani Jakatnaka - 1	sanyukt
m_0107	x3	Chhani Jakatnaka - 2	sanyukt
m_0108	x3	Chhanigam	sanyukt
m_0109	x3	Gorwa	sanyukt
m_0110	x3	Gotri	sanyukt
m_0111	x3	Karelibaug - 1	sanyukt
m_0112	x3	Karelibaug - 2	sanyukt
m_0113	x3	Panchvati	sanyukt
m_0114	x3	Sama	sanyukt
m_0115	x3	Sardarnagar	sanyukt
m_0116	x3	Sevasi	sanyukt
m_0117	x1	Racecourse	yuvak
m_0118	x1	Samta	yuvak
m_0119	x1	Niramay	yuvak
m_0120	x1	Narayanwadi	yuvak
m_0121	x1	Atladara	yuvak
m_0122	x1	P.Sw.Nagar	yuvak
m_0123	x1	Vadsar	yuvak
m_0124	x2	Manjalpur	yuvak
m_0125	x2	Indrapuri	yuvak
m_0126	x2	Danteshwar	yuvak
m_0127	x2	Makarpura	yuvak
m_0128	x2	Tarsali	yuvak
m_0129	x2	Maneja	yuvak
m_0130	x2	Shiyabaug	yuvak
m_0131	x2	Wadi	yuvak
m_0132	x3	Gorwa	yuvak
m_0133	x3	Gotri	yuvak
m_0134	x3	Karelibaug	yuvak
m_0135	x3	Sama	yuvak
m_0136	x3	Chhanigam	yuvak
m_0137	x3	Sardarnagar	yuvak
m_0138	x3	Chhani Jakatnaka	yuvak
m_0139	x1	Atladara	yuvati
m_0140	x1	Kalali - PR	yuvati
m_0141	x1	Niramay	yuvati
m_0142	x1	P.Sw.Nagar	yuvati
m_0143	x1	Racecourse	yuvati
m_0144	x1	Samta	yuvati
m_0145	x1	Shyamvilla	yuvati
m_0146	x1	Vadsar	yuvati
m_0147	x2	Gayatrinagar	yuvati
m_0148	x2	Indrapuri - 1	yuvati
m_0149	x2	Indrapuri - 3	yuvati
m_0150	x2	Makarpura - 1	yuvati
m_0151	x2	Makarpura - 2	yuvati
m_0152	x2	Maneja	yuvati
m_0153	x2	Manjalpur - 1	yuvati
m_0154	x2	Manjalpur - 2	yuvati
m_0155	x2	Manjalpur - 3	yuvati
m_0156	x2	Shiyabaug	yuvati
m_0157	x2	Tarsali	yuvati
m_0158	x2	Wadi - 1	yuvati
m_0159	x2	Danteshwar	yuvati
m_0160	x3	Karelibaug	yuvati
m_0161	x3	Sama	yuvati
m_0162	x3	Sardarnagar	yuvati
m_0163	x3	Chhani Jakatnaka	yuvati
m_0164	x3	Chhanigam	yuvati
m_0165	x3	Gorwa	yuvati
m_0166	x3	Gotri - 1	yuvati
m_0167	x3	Gotri - 2	yuvati
m_0168	x1	Labh Bal	bal
m_0169	x1	Labh Shishu	bal
m_0170	x1	Nilkanth Bal	bal
m_0171	x1	Nilkanth Shishu	bal
m_0172	x1	Sun Pharma Bal	bal
m_0173	x1	Akshar Green Shishu	bal
m_0174	x1	Atladara Bal	bal
m_0175	x1	Atladara Shishu	bal
m_0176	x1	Pramukh Swami Nagar Bal	bal
m_0177	x1	Hiranagar Bal	bal
m_0178	x1	Hiranagar Shishu	bal
m_0179	x1	Vidyut Nagar Bal	bal
m_0180	x1	Kalali Bal	bal
m_0181	x1	Atladara Gam Bal	bal
m_0182	x1	Atladara Gam 2 Bal	bal
m_0183	x1	Gunatitdham Bal	bal
m_0184	x1	Gunatitdham Shishu	bal
m_0185	x1	Sairang Bal	bal
m_0186	x1	Avadh Upavan Bal	bal
m_0187	x1	Avadh Upavan Shishu	bal
m_0188	x1	Akshar Paradise Bal	bal
m_0189	x1	Indravilla Bal	bal
m_0190	x1	Anant Swagatam Bal	bal
m_0191	x1	Param Krisht Bal	bal
m_0192	x1	Arya Empire Bal	bal
m_0193	x1	Green Yard Bal	bal
m_0194	x1	Kishan Glory Bal	bal
m_0195	x1	Pramukh Swami Villa Bal	bal
m_0196	x1	Yoginagar Bal	bal
m_0197	x1	Vrundavan Shishu	bal
m_0198	x1	Pramukh Swami Tirth Bal	bal
m_0199	x2	Indrapuri Bal	bal
m_0200	x2	Nathiba Nagar Bal	bal
m_0201	x2	Vaikunth Bal	bal
m_0202	x2	Kamlanagar Bal	bal
m_0203	x2	Seva Kunj Bal	bal
m_0204	x2	Pancham Villa Bal	bal
m_0205	x2	Sugam Park Bal	bal
m_0206	x2	Shri Hari Township Bal	bal
m_0207	x2	Ambika Darshan 2 Bal	bal
m_0208	x2	Harikrishna Township Bal	bal
m_0209	x2	Parimal 3 Bal	bal
m_0210	x2	Sayajinagar Bal	bal
m_0211	x2	Kishanwadi Bal	bal
m_0212	x2	Satadhar Bal	bal
m_0213	x2	Bhailalbhai Park Bal	bal
m_0214	x2	Indrapuri Shishu	bal
m_0215	x2	Danteshwar Bal	bal
m_0216	x2	Anupam Nagar Bal	bal
m_0217	x2	Zillion Bal	bal
m_0218	x2	Tarsali Bal	bal
m_0219	x2	Vallabh Duplex Bal	bal
m_0220	x2	Gold City Bal	bal
m_0221	x2	Tuljanagar Bal	bal
m_0222	x2	Makarpura Bal	bal
m_0223	x2	Akruti Duplex Bal	bal
m_0224	x2	Maneja Bal	bal
m_0225	x2	Gayatrinagar Bal	bal
m_0226	x2	Danteshwar Shishu	bal
m_0227	x2	Sharadnagar Shishu	bal
m_0228	x2	Gayatrinagar Shishu	bal
m_0229	x2	Shiyabaug Bal	bal
m_0230	x2	Nyaymandir Bal	bal
m_0231	x2	Wadi Bal	bal
m_0232	x2	Akshar Tenament Bal	bal
m_0233	x2	Vaishnav Park Bal	bal
m_0234	x2	Yogi Raday Bal	bal
m_0235	x2	Shivam Bal	bal
m_0236	x2	Soles Bal	bal
m_0237	x2	Darshanam Green Bal	bal
m_0238	x2	Jalaram Nagar Bal	bal
m_0239	x2	D Mart Bal	bal
m_0240	x2	Dhanlaxmi Tenament Bal	bal
m_0241	x2	Manjalpur Bal	bal
m_0242	x2	Surabhipark Bal	bal
m_0243	x2	Pujan Bal	bal
m_0244	x2	Vaibhav Vatika Bal	bal
m_0245	x2	Kedardham Bal	bal
m_0246	x2	Kamleshwar Nagar Bal	bal
m_0247	x2	Gayatri Krupa Bal	bal
m_0248	x2	Parthbhumi Bal	bal
m_0249	x2	Vadsar Bal	bal
m_0250	x3	Sama Bal	bal
m_0251	x3	Vemali Bal	bal
m_0252	x3	Vemali Gam Sanskar Kendra	bal
m_0253	x3	Karelibaug Bal	bal
m_0254	x3	Pramukh Preet Bal	bal
m_0255	x3	Airport Bal	bal
m_0256	x3	Khodiyar Nagar Bal	bal
m_0257	x3	Vrundavan Bal	bal
m_0258	x3	Siddharth Bungalow Sanskar Kendra	bal
m_0259	x3	Motnath Residency Sanskar Kendra	bal
m_0260	x3	Chhani Jakatnaka Bal	bal
m_0261	x3	Nakshatra Bal	bal
m_0262	x3	Satyanarayan Bal	bal
m_0263	x3	Sardarnagar Bal	bal
m_0264	x3	Chhanigam Bal	bal
m_0265	x3	Marutinandan Sanskar Kendra	bal
m_0266	x3	Karelibaug Shishu	bal
m_0267	x3	Sama Shishu	bal
m_0268	x3	Chhani Jakatnaka Shishu	bal
m_0269	x1	Pushpam	balika
m_0270	x1	Harinagar	balika
m_0271	x1	Harinagar Shishu	balika
m_0272	x1	Chandranagar	balika
m_0273	x1	Jay Ambe	balika
m_0274	x1	Shreeji	balika
m_0275	x1	Vaikunth	balika
m_0276	x1	Samta Balika	balika
m_0277	x3	Gokulnagar	balika
m_0278	x3	Jaladarshan	balika
m_0279	x3	Gotri Balika	balika
m_0280	x3	Yagnapurush	balika
m_0281	x3	Life Arena	balika
m_0282	x3	Khanpur	balika
m_0283	x1	Akota	sadbhavi
m_0284	x1	Atladra	sadbhavi
m_0285	x1	Kalali	sadbhavi
m_0286	x1	Narayanwadi	sadbhavi
m_0287	x1	Niramay	sadbhavi
m_0288	x1	P.Sw.Nagar	sadbhavi
m_0289	x1	Racecourse - 1	sadbhavi
m_0290	x1	Racecourse - 2	sadbhavi
m_0291	x1	Samta	sadbhavi
m_0292	x1	Shyamvilla	sadbhavi
m_0293	x1	Vadsar	sadbhavi
m_0294	x2	Danteshwar	sadbhavi
m_0295	x2	Gayatrinagar	sadbhavi
m_0296	x2	Indrapuri - 1	sadbhavi
m_0297	x2	Indrapuri - 2	sadbhavi
m_0298	x2	Makarpura	sadbhavi
m_0299	x2	Maneja	sadbhavi
m_0300	x2	Manjalpur - 1	sadbhavi
m_0301	x2	Manjalpur - 2	sadbhavi
m_0302	x2	Shiyabaug	sadbhavi
m_0303	x2	Tarsali	sadbhavi
m_0304	x2	Wadi	sadbhavi
m_0305	x3	Bajwa	sadbhavi
m_0306	x3	Chhani Jakatnaka - 1	sadbhavi
m_0307	x3	Chhani Jakatnaka - 2	sadbhavi
m_0308	x3	Chhanigam	sadbhavi
m_0309	x3	Gorwa	sadbhavi
m_0310	x3	Gotri	sadbhavi
m_0311	x3	Karelibaug - 1	sadbhavi
m_0312	x3	Karelibaug - 2	sadbhavi
m_0313	x3	Panchvati	sadbhavi
m_0314	x3	Sama	sadbhavi
m_0315	x3	Sardarnagar	sadbhavi
m_0316	x3	Sevasi	sadbhavi
\.


--
-- Data for Name: xetras; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.xetras (id, name) FROM stdin;
x1	Vadodara 1
x2	Vadodara 2
x3	Vadodara 3
\.


--
-- Name: announcements announcements_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.announcements
    ADD CONSTRAINT announcements_pkey PRIMARY KEY (id);


--
-- Name: haribhakts haribhakts_person_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.haribhakts
    ADD CONSTRAINT haribhakts_person_id_key UNIQUE (person_id);


--
-- Name: haribhakts haribhakts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.haribhakts
    ADD CONSTRAINT haribhakts_pkey PRIMARY KEY (id);


--
-- Name: karyakar_mandals karyakar_mandals_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.karyakar_mandals
    ADD CONSTRAINT karyakar_mandals_pkey PRIMARY KEY (karyakar_id, mandal_id);


--
-- Name: karyakar_xetras karyakar_xetras_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.karyakar_xetras
    ADD CONSTRAINT karyakar_xetras_pkey PRIMARY KEY (karyakar_id, xetra_id);


--
-- Name: karyakars karyakars_karyakar_number_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.karyakars
    ADD CONSTRAINT karyakars_karyakar_number_key UNIQUE (karyakar_number);


--
-- Name: karyakars karyakars_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.karyakars
    ADD CONSTRAINT karyakars_pkey PRIMARY KEY (id);


--
-- Name: karyakars karyakars_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.karyakars
    ADD CONSTRAINT karyakars_username_key UNIQUE (username);


--
-- Name: mandals mandals_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mandals
    ADD CONSTRAINT mandals_pkey PRIMARY KEY (id);


--
-- Name: xetras xetras_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.xetras
    ADD CONSTRAINT xetras_pkey PRIMARY KEY (id);


--
-- Name: haribhakts haribhakts_mandal_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.haribhakts
    ADD CONSTRAINT haribhakts_mandal_id_fkey FOREIGN KEY (mandal_id) REFERENCES public.mandals(id);


--
-- Name: haribhakts haribhakts_sampark_karyakar_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.haribhakts
    ADD CONSTRAINT haribhakts_sampark_karyakar_id_fkey FOREIGN KEY (sampark_karyakar_id) REFERENCES public.karyakars(id);


--
-- Name: haribhakts haribhakts_xetra_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.haribhakts
    ADD CONSTRAINT haribhakts_xetra_id_fkey FOREIGN KEY (xetra_id) REFERENCES public.xetras(id);


--
-- Name: karyakar_mandals karyakar_mandals_karyakar_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.karyakar_mandals
    ADD CONSTRAINT karyakar_mandals_karyakar_id_fkey FOREIGN KEY (karyakar_id) REFERENCES public.karyakars(id) ON DELETE CASCADE;


--
-- Name: karyakar_mandals karyakar_mandals_mandal_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.karyakar_mandals
    ADD CONSTRAINT karyakar_mandals_mandal_id_fkey FOREIGN KEY (mandal_id) REFERENCES public.mandals(id) ON DELETE CASCADE;


--
-- Name: karyakar_xetras karyakar_xetras_karyakar_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.karyakar_xetras
    ADD CONSTRAINT karyakar_xetras_karyakar_id_fkey FOREIGN KEY (karyakar_id) REFERENCES public.karyakars(id) ON DELETE CASCADE;


--
-- Name: karyakar_xetras karyakar_xetras_xetra_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.karyakar_xetras
    ADD CONSTRAINT karyakar_xetras_xetra_id_fkey FOREIGN KEY (xetra_id) REFERENCES public.xetras(id) ON DELETE CASCADE;


--
-- Name: karyakars karyakars_parent_karyakar_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.karyakars
    ADD CONSTRAINT karyakars_parent_karyakar_id_fkey FOREIGN KEY (parent_karyakar_id) REFERENCES public.karyakars(id);


--
-- Name: mandals mandals_xetra_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mandals
    ADD CONSTRAINT mandals_xetra_id_fkey FOREIGN KEY (xetra_id) REFERENCES public.xetras(id);


--
-- PostgreSQL database dump complete
--

\unrestrict KUhZ1LkhRK3KDvK3AYQ4qo0QfX5KY1HPybB2XAtgizVLa0C8NOSR2nxsoOKoCbD

