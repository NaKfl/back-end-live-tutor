--
-- PostgreSQL database dump
--

-- Dumped from database version 13.1
-- Dumped by pg_dump version 13.1

-- Started on 2021-06-25 17:25:29

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
-- TOC entry 200 (class 1259 OID 41731)
-- Name: Bookings; Type: TABLE; Schema: public; Owner: livetutor
--

CREATE TABLE public."Bookings" (
    id uuid NOT NULL,
    "userId" uuid NOT NULL,
    "scheduleDetailId" uuid NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL,
    "isDeleted" boolean DEFAULT false
);


ALTER TABLE public."Bookings" OWNER TO livetutor;

--
-- TOC entry 201 (class 1259 OID 41737)
-- Name: CallSessions; Type: TABLE; Schema: public; Owner: livetutor
--

CREATE TABLE public."CallSessions" (
    id uuid NOT NULL,
    "studentId" uuid NOT NULL,
    "tutorId" uuid NOT NULL,
    "videoUrl" character varying(255),
    "startTime" timestamp with time zone NOT NULL,
    "endTime" timestamp with time zone NOT NULL,
    "isReviewed" boolean NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public."CallSessions" OWNER TO livetutor;

--
-- TOC entry 202 (class 1259 OID 41742)
-- Name: Categories; Type: TABLE; Schema: public; Owner: livetutor
--

CREATE TABLE public."Categories" (
    id uuid NOT NULL,
    "typeId" uuid NOT NULL,
    description character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public."Categories" OWNER TO livetutor;

--
-- TOC entry 203 (class 1259 OID 41747)
-- Name: Courses; Type: TABLE; Schema: public; Owner: livetutor
--

CREATE TABLE public."Courses" (
    id uuid NOT NULL,
    "tutorId" uuid NOT NULL,
    name text,
    description text,
    level text,
    other_details text,
    "imageUrl" text,
    default_price double precision,
    course_price double precision,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public."Courses" OWNER TO livetutor;

--
-- TOC entry 204 (class 1259 OID 41755)
-- Name: FavoriteTutors; Type: TABLE; Schema: public; Owner: livetutor
--

CREATE TABLE public."FavoriteTutors" (
    id uuid NOT NULL,
    "firstId" uuid NOT NULL,
    "secondId" uuid NOT NULL,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public."FavoriteTutors" OWNER TO livetutor;

--
-- TOC entry 205 (class 1259 OID 41758)
-- Name: Fees; Type: TABLE; Schema: public; Owner: livetutor
--

CREATE TABLE public."Fees" (
    id uuid NOT NULL,
    key character varying(255) NOT NULL,
    price bigint NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public."Fees" OWNER TO livetutor;

--
-- TOC entry 206 (class 1259 OID 41763)
-- Name: Majors; Type: TABLE; Schema: public; Owner: livetutor
--

CREATE TABLE public."Majors" (
    id uuid NOT NULL,
    key character varying(255) NOT NULL,
    "englishName" text,
    "vietnameseName" text,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public."Majors" OWNER TO livetutor;

--
-- TOC entry 207 (class 1259 OID 41771)
-- Name: Messages; Type: TABLE; Schema: public; Owner: livetutor
--

CREATE TABLE public."Messages" (
    id uuid NOT NULL,
    content text,
    "fromId" uuid NOT NULL,
    "toId" uuid NOT NULL,
    "isRead" boolean,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public."Messages" OWNER TO livetutor;

--
-- TOC entry 208 (class 1259 OID 41779)
-- Name: RefreshTokens; Type: TABLE; Schema: public; Owner: livetutor
--

CREATE TABLE public."RefreshTokens" (
    id uuid NOT NULL,
    token character varying(255) NOT NULL,
    "userId" uuid NOT NULL,
    "userEmail" character varying(255) NOT NULL,
    expires timestamp with time zone,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public."RefreshTokens" OWNER TO livetutor;

--
-- TOC entry 209 (class 1259 OID 41787)
-- Name: Roles; Type: TABLE; Schema: public; Owner: livetutor
--

CREATE TABLE public."Roles" (
    id uuid NOT NULL,
    name character varying(255),
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public."Roles" OWNER TO livetutor;

--
-- TOC entry 210 (class 1259 OID 41792)
-- Name: ScheduleDetails; Type: TABLE; Schema: public; Owner: livetutor
--

CREATE TABLE public."ScheduleDetails" (
    id uuid NOT NULL,
    "startPeriod" character varying(255) NOT NULL,
    "endPeriod" character varying(255) NOT NULL,
    "scheduleId" uuid NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public."ScheduleDetails" OWNER TO livetutor;

--
-- TOC entry 211 (class 1259 OID 41800)
-- Name: Schedules; Type: TABLE; Schema: public; Owner: livetutor
--

CREATE TABLE public."Schedules" (
    id uuid NOT NULL,
    date date NOT NULL,
    "startTime" character varying(255) NOT NULL,
    "endTime" character varying(255) NOT NULL,
    "tutorId" uuid NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public."Schedules" OWNER TO livetutor;

--
-- TOC entry 212 (class 1259 OID 41808)
-- Name: SequelizeMeta; Type: TABLE; Schema: public; Owner: livetutor
--

CREATE TABLE public."SequelizeMeta" (
    name character varying(255) NOT NULL
);


ALTER TABLE public."SequelizeMeta" OWNER TO livetutor;

--
-- TOC entry 213 (class 1259 OID 41811)
-- Name: SubMajors; Type: TABLE; Schema: public; Owner: livetutor
--

CREATE TABLE public."SubMajors" (
    id uuid NOT NULL,
    "majorId" uuid NOT NULL,
    key character varying(255) NOT NULL,
    "englishName" text,
    "vietnameseName" text,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public."SubMajors" OWNER TO livetutor;

--
-- TOC entry 214 (class 1259 OID 41819)
-- Name: Topics; Type: TABLE; Schema: public; Owner: livetutor
--

CREATE TABLE public."Topics" (
    id uuid NOT NULL,
    "courseId" uuid NOT NULL,
    name text,
    description text,
    "orderCourse" integer,
    "videoUrl" text,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public."Topics" OWNER TO livetutor;

--
-- TOC entry 215 (class 1259 OID 41827)
-- Name: Transactions; Type: TABLE; Schema: public; Owner: livetutor
--

CREATE TABLE public."Transactions" (
    id uuid NOT NULL,
    "walletId" uuid NOT NULL,
    "bookingId" uuid,
    price bigint NOT NULL,
    status character varying(255),
    type character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public."Transactions" OWNER TO livetutor;

--
-- TOC entry 216 (class 1259 OID 41835)
-- Name: TutorFeedbacks; Type: TABLE; Schema: public; Owner: livetutor
--

CREATE TABLE public."TutorFeedbacks" (
    id uuid NOT NULL,
    "sessionId" uuid NOT NULL,
    "firstId" uuid NOT NULL,
    "secondId" uuid NOT NULL,
    rating double precision NOT NULL,
    content text NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public."TutorFeedbacks" OWNER TO livetutor;

--
-- TOC entry 217 (class 1259 OID 41843)
-- Name: Tutors; Type: TABLE; Schema: public; Owner: livetutor
--

CREATE TABLE public."Tutors" (
    id uuid NOT NULL,
    "userId" uuid NOT NULL,
    video character varying(255),
    bio text,
    languages character varying(255)[],
    specialties character varying(255)[],
    resume text,
    education text,
    experience text,
    accent character varying(255),
    "targetStudent" character varying(255),
    profession text,
    interests text,
    "isActivated" boolean NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public."Tutors" OWNER TO livetutor;

--
-- TOC entry 218 (class 1259 OID 41851)
-- Name: Types; Type: TABLE; Schema: public; Owner: livetutor
--

CREATE TABLE public."Types" (
    id uuid NOT NULL,
    title character varying(255) NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public."Types" OWNER TO livetutor;

--
-- TOC entry 219 (class 1259 OID 41856)
-- Name: UserRoles; Type: TABLE; Schema: public; Owner: livetutor
--

CREATE TABLE public."UserRoles" (
    "userId" uuid NOT NULL,
    "roleId" uuid NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public."UserRoles" OWNER TO livetutor;

--
-- TOC entry 220 (class 1259 OID 41861)
-- Name: Users; Type: TABLE; Schema: public; Owner: livetutor
--

CREATE TABLE public."Users" (
    id uuid NOT NULL,
    email character varying(255),
    google character varying(255),
    facebook character varying(255),
    password character varying(255),
    avatar text DEFAULT 'https://www.alliancerehabmed.com/wp-content/uploads/icon-avatar-default.png'::text,
    name character varying(255),
    country character varying(255),
    phone character varying(255),
    language character varying(255),
    birthday character varying(255),
    "isActivated" boolean NOT NULL,
    "requestPassword" boolean DEFAULT false NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL,
    "deletedAt" timestamp with time zone
);


ALTER TABLE public."Users" OWNER TO livetutor;

--
-- TOC entry 221 (class 1259 OID 41871)
-- Name: Wallets; Type: TABLE; Schema: public; Owner: livetutor
--

CREATE TABLE public."Wallets" (
    id uuid NOT NULL,
    "userId" uuid NOT NULL,
    amount bigint DEFAULT 0 NOT NULL,
    "isBlocked" boolean DEFAULT false,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public."Wallets" OWNER TO livetutor;

--
-- TOC entry 3184 (class 0 OID 41731)
-- Dependencies: 200
-- Data for Name: Bookings; Type: TABLE DATA; Schema: public; Owner: livetutor
--

COPY public."Bookings" (id, "userId", "scheduleDetailId", "createdAt", "updatedAt", "isDeleted") FROM stdin;
c3f3a968-4e74-4964-b14b-2dd5da707ffd	5df1c8dd-1939-4fdd-b01d-d03d28ad67eb	2997e125-4a58-444b-afc3-10d7c6cbce3f	2021-06-18 04:18:10.508+07	2021-06-18 04:18:10.508+07	f
64912c66-68d7-4928-8dc5-b06975f90371	5df1c8dd-1939-4fdd-b01d-d03d28ad67eb	ff503141-612c-407d-a078-a4591ffd7492	2021-06-18 04:18:23.872+07	2021-06-18 04:18:23.872+07	f
b92d9839-2be8-43ca-8c8c-01a9c6a69d63	5df1c8dd-1939-4fdd-b01d-d03d28ad67eb	aca203c1-fc4d-4dab-9a3e-596559e01c2a	2021-06-18 04:21:21.566+07	2021-06-18 04:21:21.566+07	f
e33b12c8-cbc3-4d48-b809-769f80dccb84	5df1c8dd-1939-4fdd-b01d-d03d28ad67eb	6249e9f6-96b7-4d4b-a50c-8434f5850f55	2021-06-18 04:21:21.566+07	2021-06-18 04:21:21.566+07	f
8c53465e-cb8b-4be5-997c-9b3cedd922ec	5df1c8dd-1939-4fdd-b01d-d03d28ad67eb	32de13e1-77d6-406c-9c46-a6a857ea6385	2021-06-18 04:21:21.566+07	2021-06-18 04:21:21.566+07	f
cec9d19e-42ba-4904-851a-6fa6fd39b88f	5df1c8dd-1939-4fdd-b01d-d03d28ad67eb	813a8f2f-b86e-4f16-bc06-d480c8db843b	2021-06-18 04:22:10.638+07	2021-06-18 04:22:10.638+07	f
00fe334c-4b8c-4b92-80f3-27df75b3d9b7	5df1c8dd-1939-4fdd-b01d-d03d28ad67eb	d83e29be-a0c0-4a56-9d53-df91561fe858	2021-06-18 04:22:10.638+07	2021-06-18 04:22:10.638+07	f
49e0fc82-d577-4bc4-a71d-dc5f18ca40d8	5df1c8dd-1939-4fdd-b01d-d03d28ad67eb	b24430d1-8695-456e-b48a-8d37b107a70e	2021-06-18 04:45:57.591+07	2021-06-18 04:45:57.591+07	f
43f1659e-ce33-42f6-9e77-0f1b189c1c5f	5df1c8dd-1939-4fdd-b01d-d03d28ad67eb	1b4bc78f-3738-4b2f-8bd1-06fe141f32bc	2021-06-18 04:45:57.592+07	2021-06-18 04:45:57.592+07	f
2f19c5de-9d79-4c5a-8a3e-8a397d05692a	5df1c8dd-1939-4fdd-b01d-d03d28ad67eb	7d4fbe1c-69cd-4daf-b0eb-2865d67e05dd	2021-06-18 04:48:30.199+07	2021-06-18 04:48:30.199+07	f
75189681-8ff2-4fee-93a6-89ec7ffed4f0	5df1c8dd-1939-4fdd-b01d-d03d28ad67eb	5251eb2f-21e4-4478-83af-5b7f26e95248	2021-06-18 04:48:44.161+07	2021-06-18 04:48:44.161+07	f
ee0f75d6-80a7-4c05-ab94-637dcbb6f269	5df1c8dd-1939-4fdd-b01d-d03d28ad67eb	7232c2f4-21c0-496f-a8bf-31a38a152840	2021-06-18 04:48:53.722+07	2021-06-18 04:48:53.722+07	f
b084a097-aa8a-4ee5-8dc5-1bf9b4f8b92b	846710e2-e0f4-4f11-b6aa-54efe4fbe455	d2e32ccf-347a-4db4-b516-e96905ca329a	2021-06-18 04:52:31.664+07	2021-06-18 04:52:31.664+07	f
f1c21c05-3a5f-49ba-8319-9757ee282b68	846710e2-e0f4-4f11-b6aa-54efe4fbe455	dc411056-e01b-4bd7-ad79-a1e905a27d4a	2021-06-18 04:52:31.664+07	2021-06-18 04:52:31.664+07	f
ca73fa3d-a030-4eaf-a5eb-1f7b9fdcc035	846710e2-e0f4-4f11-b6aa-54efe4fbe455	da343862-52cd-4f62-b3c4-474fb18e7277	2021-06-18 04:52:43.382+07	2021-06-18 04:52:43.382+07	f
e542a757-740c-48da-8f4c-ef291fe65882	846710e2-e0f4-4f11-b6aa-54efe4fbe455	cbc3ce89-ee6e-4460-837d-df8051842523	2021-06-18 04:52:57.848+07	2021-06-18 04:52:57.848+07	f
9cf17360-2eb9-4cdd-a7bb-374104a9c344	846710e2-e0f4-4f11-b6aa-54efe4fbe455	28471dc8-f8cb-40a0-b7da-16e83929b463	2021-06-18 04:53:09.966+07	2021-06-18 04:53:09.966+07	f
f81fc486-ad04-41a8-9a9c-a5b73447ce2a	846710e2-e0f4-4f11-b6aa-54efe4fbe455	67e4df62-6f91-41eb-8d27-c6f1e773a6a8	2021-06-18 04:53:32.517+07	2021-06-18 04:53:32.517+07	f
6c66ba74-5e8e-4497-a237-c94cec9c449f	846710e2-e0f4-4f11-b6aa-54efe4fbe455	d147f3c0-488c-461a-84ae-07666f0a50ad	2021-06-18 04:53:32.517+07	2021-06-18 04:53:32.517+07	f
1a11e57c-db2a-4994-a39e-49b0e8f767e0	846710e2-e0f4-4f11-b6aa-54efe4fbe455	4da4d703-3b52-4f3e-89f8-a73cabb7f3cc	2021-06-18 04:53:58.879+07	2021-06-18 04:53:58.879+07	f
a0a439ae-ec23-4a49-8dab-afb16ff7dfaf	846710e2-e0f4-4f11-b6aa-54efe4fbe455	52187acb-27ce-47f1-a402-fc5c452098ed	2021-06-18 04:53:58.879+07	2021-06-18 04:53:58.879+07	f
5e5d03e0-2648-4575-9e4f-2155ba3d1673	846710e2-e0f4-4f11-b6aa-54efe4fbe455	fc15d0f6-d457-4ef2-b432-d2e361fb4a59	2021-06-18 04:54:26.146+07	2021-06-18 04:54:26.146+07	f
f791a6fb-f69c-4e61-af99-1b0a295be445	846710e2-e0f4-4f11-b6aa-54efe4fbe455	6e74c503-8648-4d2b-b73e-7a97d96634cf	2021-06-18 04:57:34.371+07	2021-06-18 04:57:34.371+07	f
3619e3ee-82a4-4129-975a-41d63fa83949	846710e2-e0f4-4f11-b6aa-54efe4fbe455	77c426bc-02b0-44d5-b6df-7cce61314181	2021-06-18 04:57:34.371+07	2021-06-18 04:57:34.371+07	f
77d59126-afc3-487f-b075-66949923c1b4	846710e2-e0f4-4f11-b6aa-54efe4fbe455	734459be-9fc4-48e7-b6dd-dec35fa96d8a	2021-06-18 04:57:39.769+07	2021-06-18 04:57:39.769+07	f
50b3dca3-8575-45cd-b922-94f54a175613	846710e2-e0f4-4f11-b6aa-54efe4fbe455	f1a915be-fa2e-4185-b914-be2a769b4b71	2021-06-18 04:57:56.628+07	2021-06-18 04:57:56.628+07	f
b44bf4cb-a18c-4972-81a6-c6a2914c891a	846710e2-e0f4-4f11-b6aa-54efe4fbe455	819af493-3957-4db6-be46-457046a6400e	2021-06-18 04:57:56.628+07	2021-06-18 04:57:56.628+07	f
43b6484f-f9f4-453f-9b1e-818d8a668857	846710e2-e0f4-4f11-b6aa-54efe4fbe455	a6545b8b-4309-4ea9-8e13-79eb8de27e3d	2021-06-18 04:58:06.025+07	2021-06-18 04:58:06.025+07	f
e4b9618e-107b-4fae-8c5f-27ac0c527224	846710e2-e0f4-4f11-b6aa-54efe4fbe455	6a8053d3-b7e9-475a-9087-b168fb90e5a4	2021-06-18 04:58:06.025+07	2021-06-18 04:58:06.025+07	f
2577f1ab-b546-4c82-b891-d0abe16f9fa4	846710e2-e0f4-4f11-b6aa-54efe4fbe455	8e118f58-0b07-43b9-ad14-355195337d0b	2021-06-18 05:00:25.725+07	2021-06-18 05:00:25.725+07	f
bf38180b-175c-4759-8c07-289e96530dfe	846710e2-e0f4-4f11-b6aa-54efe4fbe455	b57fd044-ebc9-40fd-83a4-5f8557ad0d46	2021-06-18 05:00:25.726+07	2021-06-18 05:00:25.726+07	f
474144ad-d3c9-4c96-90c9-493781d598d8	846710e2-e0f4-4f11-b6aa-54efe4fbe455	f53b98bb-fc36-4b0a-99ec-5bf1211f2bfa	2021-06-18 05:00:43.101+07	2021-06-18 05:00:43.101+07	f
d49f52f6-07f8-440a-84fc-dbc21cf87d48	846710e2-e0f4-4f11-b6aa-54efe4fbe455	2f07267c-b66a-4f99-9a19-fdd085556419	2021-06-18 05:00:53.179+07	2021-06-18 05:00:53.179+07	f
820ef9c6-2e82-4ea0-af6a-2663fda7a456	846710e2-e0f4-4f11-b6aa-54efe4fbe455	3353018f-fdd0-400e-ac14-8bf334a35cec	2021-06-18 05:00:53.179+07	2021-06-18 05:00:53.179+07	f
febd772f-3e3b-4cf9-89b0-c2acaae74913	846710e2-e0f4-4f11-b6aa-54efe4fbe455	2a175327-7874-40da-97e2-453cb2621412	2021-06-18 05:03:15.448+07	2021-06-18 05:03:15.448+07	f
a95a470e-8a13-41ad-afb2-705a82449216	846710e2-e0f4-4f11-b6aa-54efe4fbe455	96ab224c-e727-455a-a2d9-de6382bdbc5d	2021-06-18 05:03:15.449+07	2021-06-18 05:03:15.449+07	f
4a2b2fa0-5065-484a-b637-2101ca2acc66	846710e2-e0f4-4f11-b6aa-54efe4fbe455	1cf097d0-e5fc-4d7e-90f8-bb7577b9d5ac	2021-06-18 05:03:28.818+07	2021-06-18 05:03:28.818+07	f
725ca5cd-6786-435a-97e1-101cc68b9a3e	846710e2-e0f4-4f11-b6aa-54efe4fbe455	06d3b74d-5590-4496-9b82-211a715f3aaa	2021-06-18 05:03:28.818+07	2021-06-18 05:03:28.818+07	f
ffbbe8cd-a851-44d5-be1c-b413d8c6e513	846710e2-e0f4-4f11-b6aa-54efe4fbe455	c52d0783-955b-4d30-be64-d0d939acb1df	2021-06-18 05:03:44.921+07	2021-06-18 05:03:44.921+07	f
56c4e787-bbf4-4eea-9d0e-38f566a76abd	846710e2-e0f4-4f11-b6aa-54efe4fbe455	ea2fcac6-eab2-42fb-8c01-1f839fb7abfc	2021-06-18 05:03:44.922+07	2021-06-18 05:03:44.922+07	f
607439ca-dde4-4814-bd20-55a11033a9a5	34e95981-3426-4103-9bfd-df43464723d0	2131b6ce-3181-43a4-a323-191de8d898f1	2021-06-18 05:05:40.766+07	2021-06-18 05:05:40.766+07	f
e8607d12-3281-4307-a1af-24254bb8b92e	34e95981-3426-4103-9bfd-df43464723d0	fbe8a7ec-9149-44ae-a74a-a2722908250b	2021-06-18 05:05:40.766+07	2021-06-18 05:05:40.766+07	f
cffca1e0-8898-4354-b1ab-d0a2637cd963	34e95981-3426-4103-9bfd-df43464723d0	a41e8813-79af-42b4-996d-e4067809ff92	2021-06-18 05:05:52.679+07	2021-06-18 05:05:52.679+07	f
372f2ff7-fdba-4496-b827-33be72be1ae0	34e95981-3426-4103-9bfd-df43464723d0	c0cc4441-0742-4a6f-bea9-b2f6bd526eb4	2021-06-18 05:05:52.68+07	2021-06-18 05:05:52.68+07	f
94ba38c1-fcad-4bd8-9995-be34fb869342	34e95981-3426-4103-9bfd-df43464723d0	3f9d9ad1-f650-4823-91af-aac824dad294	2021-06-18 05:06:02.686+07	2021-06-18 05:06:02.686+07	f
2d7aa9c4-6e03-4208-be44-fbe4d10df2f6	34e95981-3426-4103-9bfd-df43464723d0	f35ac18d-58cc-4aeb-b995-e9c0d2b2745b	2021-06-18 05:06:02.686+07	2021-06-18 05:06:02.686+07	f
5971c1a0-6855-49d7-aebd-caa7880557d8	34e95981-3426-4103-9bfd-df43464723d0	a12abfc0-7fdf-4e71-9565-dee032bd096a	2021-06-18 05:07:35.747+07	2021-06-18 05:07:35.747+07	f
3170b699-c716-46fe-9c1c-bc051d3549c7	34e95981-3426-4103-9bfd-df43464723d0	509e3312-2ccd-4ba5-881b-ae5bc4019194	2021-06-18 05:07:35.747+07	2021-06-18 05:07:35.747+07	f
8ad560cd-d230-4b81-8d39-7c39968f9e27	34e95981-3426-4103-9bfd-df43464723d0	819ed493-5d59-491a-ae9e-18e87deb478d	2021-06-18 05:07:48.189+07	2021-06-18 05:07:48.189+07	f
b985361e-0512-4795-aeac-da9c4a6e4af6	34e95981-3426-4103-9bfd-df43464723d0	d3f83eb8-cd5d-4d01-85a9-8ce588cffa80	2021-06-18 05:07:48.189+07	2021-06-18 05:07:48.189+07	f
4621ea87-2cf1-4169-a073-cba987d87f24	34e95981-3426-4103-9bfd-df43464723d0	7a0d5ff6-9902-49d0-92c1-8971e0377c8c	2021-06-18 05:07:56.299+07	2021-06-18 05:07:56.299+07	f
2e0efeba-60ef-4033-bdbb-1a66bac5d67d	34e95981-3426-4103-9bfd-df43464723d0	4576af2c-7ec4-4c51-9c36-76bc574456b5	2021-06-18 05:07:56.299+07	2021-06-18 05:07:56.299+07	f
9f40abfd-3e98-4a54-b71c-35047f284a86	74655b72-3b14-463e-98b6-a2f64a459aa9	a401e434-8997-49c2-b4b3-47edc2fd0336	2021-06-18 05:09:52.517+07	2021-06-18 05:09:52.517+07	f
2d9530c7-d255-4111-a986-9601cae32c9c	74655b72-3b14-463e-98b6-a2f64a459aa9	733c36af-0458-4eda-8995-a75045a1759d	2021-06-18 05:09:52.517+07	2021-06-18 05:09:52.517+07	f
e6ec280d-5216-4f03-9d17-6584bc7208aa	74655b72-3b14-463e-98b6-a2f64a459aa9	6a97b589-ea97-4921-ab70-223b8a336689	2021-06-18 05:09:58.898+07	2021-06-18 05:09:58.898+07	f
04a9ebce-6879-467f-9338-a86734fc26d1	74655b72-3b14-463e-98b6-a2f64a459aa9	19ec79aa-f5c6-42d4-8d92-dee08cd8867f	2021-06-18 05:09:58.899+07	2021-06-18 05:09:58.899+07	f
41f41727-b586-49ef-ac0a-358421c5776d	74655b72-3b14-463e-98b6-a2f64a459aa9	611fb799-a996-4a6c-a296-fa7b954c1c77	2021-06-18 05:10:12.617+07	2021-06-18 05:10:12.617+07	f
1da5e622-601b-465d-9411-ac87ee529374	74655b72-3b14-463e-98b6-a2f64a459aa9	e6144f90-8452-4b47-886c-2497b0479542	2021-06-18 05:10:12.617+07	2021-06-18 05:10:12.617+07	f
5caa49a0-1815-4feb-ad70-7f96da60253d	fbf670b6-6a3d-45b1-9711-08de91ac7181	959724e4-bbe8-489d-89f8-199bc0600568	2021-06-18 05:15:26.646+07	2021-06-18 05:15:26.646+07	f
627e6da7-4fed-48c0-996a-335c267e4974	fbf670b6-6a3d-45b1-9711-08de91ac7181	f2eda4ac-6a40-4616-b1af-f218ccb03a7e	2021-06-18 05:15:26.646+07	2021-06-18 05:15:26.646+07	f
8eac286a-41f4-4898-93d4-3070b52ad439	fbf670b6-6a3d-45b1-9711-08de91ac7181	a1dce5a8-688f-40be-a67f-3e95df96282d	2021-06-18 05:15:39.927+07	2021-06-18 05:15:39.927+07	f
d2608c66-56dc-4a31-a71f-4089544d42e1	fbf670b6-6a3d-45b1-9711-08de91ac7181	9788f012-87c0-41fa-bd26-fe51e7bdaf88	2021-06-18 05:15:39.927+07	2021-06-18 05:15:39.927+07	f
7e92e4c2-810a-4da5-918a-901f2d3f805c	fbf670b6-6a3d-45b1-9711-08de91ac7181	d6f3ca3c-4e9f-4abb-a623-dfdcb955b86b	2021-06-18 05:15:58.057+07	2021-06-18 05:15:58.057+07	f
fc141146-23ee-4c73-b0ff-13127ceaf4e9	fbf670b6-6a3d-45b1-9711-08de91ac7181	6364e53a-ee3e-4a1d-8529-0f9f6d2b270a	2021-06-18 05:15:58.057+07	2021-06-18 05:15:58.057+07	f
3317243a-08b3-45a5-9327-ece17d04edd1	fbf670b6-6a3d-45b1-9711-08de91ac7181	3ab57d7d-3ffe-4dc5-91fa-b57dcee8440c	2021-06-18 05:16:06.446+07	2021-06-18 05:16:06.446+07	f
585348e4-cf14-455f-a0ee-9ec0853ab4e9	fbf670b6-6a3d-45b1-9711-08de91ac7181	fce4720b-34a0-45d4-8276-26368e1332bf	2021-06-18 05:16:06.446+07	2021-06-18 05:16:06.446+07	f
\.


--
-- TOC entry 3185 (class 0 OID 41737)
-- Dependencies: 201
-- Data for Name: CallSessions; Type: TABLE DATA; Schema: public; Owner: livetutor
--

COPY public."CallSessions" (id, "studentId", "tutorId", "videoUrl", "startTime", "endTime", "isReviewed", "createdAt", "updatedAt") FROM stdin;
7800b820-32b1-4647-9c13-fc16643a8d02	5df1c8dd-1939-4fdd-b01d-d03d28ad67eb	02ed45b7-b427-4f24-8705-d182b7199e1a	\N	2021-06-25 03:14:31+07	2021-06-25 03:14:52+07	t	2021-06-25 03:14:56.658+07	2021-06-25 03:15:07.707+07
09eea1bb-039d-4287-a98a-ad2c00b78e81	846710e2-e0f4-4f11-b6aa-54efe4fbe455	02ed45b7-b427-4f24-8705-d182b7199e1a	\N	2021-06-25 03:15:32+07	2021-06-25 03:15:49+07	f	2021-06-25 03:15:53.62+07	2021-06-25 03:15:53.62+07
ad77bb75-454d-4d1b-a848-eea1d7bfb130	846710e2-e0f4-4f11-b6aa-54efe4fbe455	02ed45b7-b427-4f24-8705-d182b7199e1a	\N	2021-06-25 03:15:32+07	2021-06-25 03:15:50+07	t	2021-06-25 03:15:53.653+07	2021-06-25 03:16:32.436+07
8c1b2dac-936d-4620-a680-a88cb61ce05a	74655b72-3b14-463e-98b6-a2f64a459aa9	02ed45b7-b427-4f24-8705-d182b7199e1a	\N	2021-06-25 03:16:51+07	2021-06-25 03:17:10+07	f	2021-06-25 03:17:14.332+07	2021-06-25 03:17:14.332+07
e77980b6-2be4-4460-9759-945457f83746	74655b72-3b14-463e-98b6-a2f64a459aa9	02ed45b7-b427-4f24-8705-d182b7199e1a	\N	2021-06-25 03:16:51+07	2021-06-25 03:17:09+07	f	2021-06-25 03:17:14.339+07	2021-06-25 03:17:14.339+07
ef79b9da-5949-4bfc-bd98-82192b7fe4af	74655b72-3b14-463e-98b6-a2f64a459aa9	02ed45b7-b427-4f24-8705-d182b7199e1a	\N	2021-06-25 03:16:51+07	2021-06-25 03:17:09+07	t	2021-06-25 03:17:14.327+07	2021-06-25 03:17:23.077+07
2add1213-eaec-4fb4-9fda-415aaf555d6d	04ef870e-60cc-4822-9b6d-67c8143d2029	02ed45b7-b427-4f24-8705-d182b7199e1a	\N	2021-06-25 03:17:46+07	2021-06-25 03:18:05+07	t	2021-06-25 03:18:11.092+07	2021-06-25 03:18:15.978+07
24581968-1e22-4d46-ba66-94ab1ade6fb0	04ef870e-60cc-4822-9b6d-67c8143d2029	0d7d4348-cf7e-4b6a-9a01-1d88f283e910	\N	2021-06-25 03:18:38+07	2021-06-25 03:18:52+07	f	2021-06-25 03:18:59.111+07	2021-06-25 03:18:59.111+07
80bf2a99-2498-4313-bc73-c4fcc2e442b3	04ef870e-60cc-4822-9b6d-67c8143d2029	0d7d4348-cf7e-4b6a-9a01-1d88f283e910	\N	2021-06-25 03:18:38+07	2021-06-25 03:18:53+07	f	2021-06-25 03:18:59.127+07	2021-06-25 03:18:59.127+07
166b835a-8eca-423f-8ee4-e06c1bb50b8d	04ef870e-60cc-4822-9b6d-67c8143d2029	0d7d4348-cf7e-4b6a-9a01-1d88f283e910	\N	2021-06-25 03:18:38+07	2021-06-25 03:18:53+07	f	2021-06-25 03:18:59.319+07	2021-06-25 03:18:59.319+07
45be1221-fee3-4fd7-a871-c74b3ee2ed6c	04ef870e-60cc-4822-9b6d-67c8143d2029	0d7d4348-cf7e-4b6a-9a01-1d88f283e910	\N	2021-06-25 03:19:04+07	2021-06-25 03:19:21+07	t	2021-06-25 03:19:25.016+07	2021-06-25 03:19:32.962+07
21663c3e-da38-4d02-97cf-d6c2f37821af	846710e2-e0f4-4f11-b6aa-54efe4fbe455	0d7d4348-cf7e-4b6a-9a01-1d88f283e910	\N	2021-06-25 03:20:02+07	2021-06-25 03:20:28+07	f	2021-06-25 03:20:32.45+07	2021-06-25 03:20:32.45+07
eb62fa84-69e4-415a-9ec4-4c980bc0f4bd	846710e2-e0f4-4f11-b6aa-54efe4fbe455	0d7d4348-cf7e-4b6a-9a01-1d88f283e910	\N	2021-06-25 03:20:02+07	2021-06-25 03:20:29+07	t	2021-06-25 03:20:32.434+07	2021-06-25 03:20:40.444+07
d07deb91-a3ca-4970-bcda-a9691d78bb0c	846710e2-e0f4-4f11-b6aa-54efe4fbe455	02ed45b7-b427-4f24-8705-d182b7199e1a	\N	2021-06-25 03:20:54+07	2021-06-25 03:21:13+07	t	2021-06-25 03:21:17.19+07	2021-06-25 03:21:32.584+07
d9011256-57ea-4560-b7ec-d67b4d42ab9b	846710e2-e0f4-4f11-b6aa-54efe4fbe455	c6e0dd89-bc9d-45f2-87d4-975fd07ff8ba	\N	2021-06-25 03:21:54+07	2021-06-25 03:22:07+07	t	2021-06-25 03:22:11.573+07	2021-06-25 03:22:18.74+07
66f8359d-5906-41d1-b528-effa8822beac	74655b72-3b14-463e-98b6-a2f64a459aa9	c6e0dd89-bc9d-45f2-87d4-975fd07ff8ba	\N	2021-06-25 03:22:36+07	2021-06-25 03:22:48+07	t	2021-06-25 03:22:52.056+07	2021-06-25 03:23:01.757+07
8b1ccf34-4fba-452f-8ddd-8ed2b5d6d719	74655b72-3b14-463e-98b6-a2f64a459aa9	a57371e1-07d7-403f-bd71-fa2f14c7c537	\N	2021-06-25 03:23:24+07	2021-06-25 03:23:36+07	t	2021-06-25 03:23:40.365+07	2021-06-25 03:58:10.404+07
\.


--
-- TOC entry 3186 (class 0 OID 41742)
-- Dependencies: 202
-- Data for Name: Categories; Type: TABLE DATA; Schema: public; Owner: livetutor
--

COPY public."Categories" (id, "typeId", description, "createdAt", "updatedAt") FROM stdin;
f0f39780-2bf7-47e4-be8a-2dcc8a51660b	1b88fe80-8136-490b-adbc-e3fef6bcfda9	andorra	2021-06-10 21:51:05.215092+07	2021-06-10 21:51:05.215092+07
529f3cd4-b426-47be-a24d-9a6917ae8550	1b88fe80-8136-490b-adbc-e3fef6bcfda9	armenia	2021-06-10 21:51:05.215092+07	2021-06-10 21:51:05.215092+07
055f6817-bb31-47de-902f-a339d2d92fcc	1b88fe80-8136-490b-adbc-e3fef6bcfda9	aahrain	2021-06-10 21:51:05.215092+07	2021-06-10 21:51:05.215092+07
545b7a7d-f4f3-4cdd-acb6-870d5b901704	1b88fe80-8136-490b-adbc-e3fef6bcfda9	angola	2021-06-10 21:51:05.215092+07	2021-06-10 21:51:05.215092+07
42d44b19-f66f-47f2-ac0c-e3353372e1ff	1b88fe80-8136-490b-adbc-e3fef6bcfda9	australia	2021-06-10 21:51:05.215092+07	2021-06-10 21:51:05.215092+07
183431e6-d58d-454f-b3cd-901039c8ff45	1b88fe80-8136-490b-adbc-e3fef6bcfda9	bangladesh	2021-06-10 21:51:05.215092+07	2021-06-10 21:51:05.215092+07
e87e7edf-02cc-4bdf-ba3c-b0a94d5c4182	1b88fe80-8136-490b-adbc-e3fef6bcfda9	albania	2021-06-10 21:51:05.215092+07	2021-06-10 21:51:05.215092+07
ed0130e2-6ce5-4a4b-a97c-14207188b658	1b88fe80-8136-490b-adbc-e3fef6bcfda9	anguilla	2021-06-10 21:51:05.215092+07	2021-06-10 21:51:05.215092+07
8f3cc91b-0e82-4b51-98de-4dd515be1da1	1b88fe80-8136-490b-adbc-e3fef6bcfda9	austria	2021-06-10 21:51:05.215092+07	2021-06-10 21:51:05.215092+07
160ff43d-d316-43b8-be2b-e09f4925128d	1b88fe80-8136-490b-adbc-e3fef6bcfda9	belarus	2021-06-10 21:51:05.215092+07	2021-06-10 21:51:05.215092+07
d4dabe53-f48d-4f0a-8764-79759846a757	1b88fe80-8136-490b-adbc-e3fef6bcfda9	algeria	2021-06-10 21:51:05.215092+07	2021-06-10 21:51:05.215092+07
f62e4d17-e7c0-418e-b534-7fd6114709c8	1b88fe80-8136-490b-adbc-e3fef6bcfda9	antigua & barbuda	2021-06-10 21:51:05.215092+07	2021-06-10 21:51:05.215092+07
b7dd7b43-8126-4e61-b3d9-4084da188a9c	1b88fe80-8136-490b-adbc-e3fef6bcfda9	azerbaijan	2021-06-10 21:51:05.215092+07	2021-06-10 21:51:05.215092+07
90df962f-7cb1-4f41-9802-d229669846eb	1b88fe80-8136-490b-adbc-e3fef6bcfda9	american samoa	2021-06-10 21:51:05.215092+07	2021-06-10 21:51:05.215092+07
ee4da389-2dd9-4fce-997b-9adc09dc7ba3	1b88fe80-8136-490b-adbc-e3fef6bcfda9	argentina	2021-06-10 21:51:05.215092+07	2021-06-10 21:51:05.215092+07
523cf58d-e3aa-423a-93dc-1fb04c204cd8	1b88fe80-8136-490b-adbc-e3fef6bcfda9	bahamas	2021-06-10 21:51:05.215092+07	2021-06-10 21:51:05.215092+07
1fbe4c62-34fc-4ef3-8edf-611012c79a53	1b88fe80-8136-490b-adbc-e3fef6bcfda9	benin	2021-06-10 21:51:05.215092+07	2021-06-10 21:51:05.215092+07
4a5fde0a-8423-420b-bc56-2f6b860a1ff1	1b88fe80-8136-490b-adbc-e3fef6bcfda9	gernamy	2021-06-10 21:51:05.215092+07	2021-06-10 21:51:05.215092+07
b6253ab9-98fb-4080-9023-03c6f8c003e9	1b88fe80-8136-490b-adbc-e3fef6bcfda9	mexico	2021-06-10 21:51:05.215092+07	2021-06-10 21:51:05.215092+07
b6c1110f-9b7e-46a2-ab80-fc8142822342	1b88fe80-8136-490b-adbc-e3fef6bcfda9	bolivia	2021-06-10 21:51:05.215092+07	2021-06-10 21:51:05.215092+07
36760e3b-1299-43d8-b36b-0f3fb7677c73	1b88fe80-8136-490b-adbc-e3fef6bcfda9	brazil	2021-06-10 21:51:05.215092+07	2021-06-10 21:51:05.215092+07
b9841089-b862-4df8-86cb-daae85a67fe2	1b88fe80-8136-490b-adbc-e3fef6bcfda9	brunei	2021-06-10 21:51:05.215092+07	2021-06-10 21:51:05.215092+07
ea9363c9-7479-47b4-bf05-7927b4216484	1b88fe80-8136-490b-adbc-e3fef6bcfda9	myanmar	2021-06-10 21:51:05.215092+07	2021-06-10 21:51:05.215092+07
59ce9dd4-8898-410f-b1c0-532f5a47834d	1b88fe80-8136-490b-adbc-e3fef6bcfda9	south africa	2021-06-10 21:51:05.215092+07	2021-06-10 21:51:05.215092+07
0ffb844b-93af-4197-bc52-12c1c2a776fe	1b88fe80-8136-490b-adbc-e3fef6bcfda9	south korea	2021-06-10 21:51:05.215092+07	2021-06-10 21:51:05.215092+07
bcb870b7-a80a-4f7e-aee7-16f8d0ca2b5b	1b88fe80-8136-490b-adbc-e3fef6bcfda9	hugary	2021-06-10 21:51:05.215092+07	2021-06-10 21:51:05.215092+07
446d362c-f2d5-40a3-9f39-ef73c7f3945f	1b88fe80-8136-490b-adbc-e3fef6bcfda9	hong kong	2021-06-10 21:51:05.215092+07	2021-06-10 21:51:05.215092+07
ba91f266-bd77-4ffe-ac3a-aaab1ebddc33	1b88fe80-8136-490b-adbc-e3fef6bcfda9	spain	2021-06-10 21:51:05.215092+07	2021-06-10 21:51:05.215092+07
21842bb1-5984-448c-bcfb-b0d0931ec37a	1b88fe80-8136-490b-adbc-e3fef6bcfda9	nauru	2021-06-10 21:51:05.215092+07	2021-06-10 21:51:05.215092+07
e857e50e-0441-4ac5-9919-1a47f5be2b79	1b88fe80-8136-490b-adbc-e3fef6bcfda9	nepal	2021-06-10 21:51:05.215092+07	2021-06-10 21:51:05.215092+07
1454bf4c-aed3-404d-8fd7-766f80a0684b	1b88fe80-8136-490b-adbc-e3fef6bcfda9	india	2021-06-10 21:51:05.215092+07	2021-06-10 21:51:05.215092+07
6d94d1ab-e756-4967-80be-0dd320477556	1b88fe80-8136-490b-adbc-e3fef6bcfda9	indonesia	2021-06-10 21:51:05.215092+07	2021-06-10 21:51:05.215092+07
a3bf40fc-8f6d-444b-9069-aa28f2ef30ef	1b88fe80-8136-490b-adbc-e3fef6bcfda9	new Zealand	2021-06-10 21:51:05.215092+07	2021-06-10 21:51:05.215092+07
7684e6ef-755b-4f6f-9d03-7e772634d7be	1b88fe80-8136-490b-adbc-e3fef6bcfda9	nigeria	2021-06-10 21:51:05.215092+07	2021-06-10 21:51:05.215092+07
a8829c63-eec8-4fc8-a8b4-5089d526a1bc	1b88fe80-8136-490b-adbc-e3fef6bcfda9	taiwan	2021-06-10 21:51:05.215092+07	2021-06-10 21:51:05.215092+07
933152a3-dd00-46e4-9666-8365dc59993b	1b88fe80-8136-490b-adbc-e3fef6bcfda9	english	2021-06-10 21:51:05.215092+07	2021-06-10 21:51:05.215092+07
ec811461-c647-4885-9826-e78737154c67	1b88fe80-8136-490b-adbc-e3fef6bcfda9	cuba	2021-06-10 21:51:05.215092+07	2021-06-10 21:51:05.215092+07
48d3f3b3-b185-4566-a63a-55436a984a3b	1b88fe80-8136-490b-adbc-e3fef6bcfda9	france	2021-06-10 21:51:05.215092+07	2021-06-10 21:51:05.215092+07
9286ab61-3787-470b-a6e0-9a341490d47b	1b88fe80-8136-490b-adbc-e3fef6bcfda9	vietnamese	2021-06-10 21:51:05.215092+07	2021-06-10 21:51:05.215092+07
fbf39eb1-e691-45ad-8c50-419e49691525	1b88fe80-8136-490b-adbc-e3fef6bcfda9	zambia	2021-06-10 21:51:05.215092+07	2021-06-10 21:51:05.215092+07
1f3ba4e6-f6b9-4468-9368-66661d3dc7ea	1b88fe80-8136-490b-adbc-e3fef6bcfda9	united kingdom	2021-06-10 21:51:05.215092+07	2021-06-10 21:51:05.215092+07
293c35cb-a774-404a-882c-62cbea11f95a	1b88fe80-8136-490b-adbc-e3fef6bcfda9	united states	2021-06-10 21:51:05.215092+07	2021-06-10 21:51:05.215092+07
b213025a-16af-4b84-950b-24082e9907b0	bfed6a51-c79e-45f7-a32b-7c880d6c6ac7	foreign languages	2021-06-10 21:51:05.215092+07	2021-06-10 21:51:05.215092+07
1ff108c7-9bf2-4c53-9ce4-1a2b092630fe	bfed6a51-c79e-45f7-a32b-7c880d6c6ac7	marketing	2021-06-10 21:51:05.215092+07	2021-06-10 21:51:05.215092+07
980b5a1f-3150-4d97-a5c3-b86c0d69b76c	bfed6a51-c79e-45f7-a32b-7c880d6c6ac7	office infomation	2021-06-10 21:51:05.215092+07	2021-06-10 21:51:05.215092+07
aeed714d-8ed2-4634-98c7-9eea0499b05c	bfed6a51-c79e-45f7-a32b-7c880d6c6ac7	design	2021-06-10 21:51:05.215092+07	2021-06-10 21:51:05.215092+07
ad310923-ac7a-4d72-8ebd-8434410eb116	bfed6a51-c79e-45f7-a32b-7c880d6c6ac7	business	2021-06-10 21:51:05.215092+07	2021-06-10 21:51:05.215092+07
4729204d-dc38-4dbe-a6aa-4367b7dc9ecb	bfed6a51-c79e-45f7-a32b-7c880d6c6ac7	health care	2021-06-10 21:51:05.215092+07	2021-06-10 21:51:05.215092+07
1178a786-7b9d-4ffd-9bcc-9d04d2f2d71f	bfed6a51-c79e-45f7-a32b-7c880d6c6ac7	infomation technology	2021-06-10 21:51:05.215092+07	2021-06-10 21:51:05.215092+07
d3fc67a1-b3ea-4724-bf96-e5691d41f282	38da0d33-dcf8-4e3d-b1af-f8eceb4a02d1	andorra	2021-06-25 03:59:30.486243+07	2021-06-25 03:59:30.486243+07
0978dbc6-c70b-4bf5-b843-4d766dcccc9a	38da0d33-dcf8-4e3d-b1af-f8eceb4a02d1	armenia	2021-06-25 03:59:30.486243+07	2021-06-25 03:59:30.486243+07
7c444fdb-bdec-49bd-b16d-f97ae423054e	38da0d33-dcf8-4e3d-b1af-f8eceb4a02d1	aahrain	2021-06-25 03:59:30.486243+07	2021-06-25 03:59:30.486243+07
da802955-9721-4b9d-83d0-153f83f53b0b	38da0d33-dcf8-4e3d-b1af-f8eceb4a02d1	angola	2021-06-25 03:59:30.486243+07	2021-06-25 03:59:30.486243+07
4af32ddb-3f36-4760-9d53-8d879883aabd	38da0d33-dcf8-4e3d-b1af-f8eceb4a02d1	australia	2021-06-25 03:59:30.486243+07	2021-06-25 03:59:30.486243+07
836eaf3c-552f-460e-9d5b-a1c6507b5370	38da0d33-dcf8-4e3d-b1af-f8eceb4a02d1	bangladesh	2021-06-25 03:59:30.486243+07	2021-06-25 03:59:30.486243+07
35f31352-5496-4cfd-991a-9b549a2e7d44	38da0d33-dcf8-4e3d-b1af-f8eceb4a02d1	albania	2021-06-25 03:59:30.486243+07	2021-06-25 03:59:30.486243+07
28f502a2-b805-42a1-910c-868c2334dc69	38da0d33-dcf8-4e3d-b1af-f8eceb4a02d1	anguilla	2021-06-25 03:59:30.486243+07	2021-06-25 03:59:30.486243+07
f227463c-6ca1-4a9a-bdac-4392925e2587	38da0d33-dcf8-4e3d-b1af-f8eceb4a02d1	austria	2021-06-25 03:59:30.486243+07	2021-06-25 03:59:30.486243+07
dbec9d4a-155e-4edb-8304-f6d8db4e5bce	38da0d33-dcf8-4e3d-b1af-f8eceb4a02d1	belarus	2021-06-25 03:59:30.486243+07	2021-06-25 03:59:30.486243+07
d4935ba6-9241-4eda-89b0-bee1d7b5dd53	38da0d33-dcf8-4e3d-b1af-f8eceb4a02d1	algeria	2021-06-25 03:59:30.486243+07	2021-06-25 03:59:30.486243+07
458b099e-2690-4689-a748-afe04eb765bf	38da0d33-dcf8-4e3d-b1af-f8eceb4a02d1	antigua & barbuda	2021-06-25 03:59:30.486243+07	2021-06-25 03:59:30.486243+07
d8e555e0-310c-42c1-95fe-a1b48faf3b5b	38da0d33-dcf8-4e3d-b1af-f8eceb4a02d1	azerbaijan	2021-06-25 03:59:30.486243+07	2021-06-25 03:59:30.486243+07
5bb7def1-441b-4817-9c6c-d0d02ad02a8a	38da0d33-dcf8-4e3d-b1af-f8eceb4a02d1	american samoa	2021-06-25 03:59:30.486243+07	2021-06-25 03:59:30.486243+07
d86a0edf-4f2e-4308-9c97-330bc8ada0d9	38da0d33-dcf8-4e3d-b1af-f8eceb4a02d1	argentina	2021-06-25 03:59:30.486243+07	2021-06-25 03:59:30.486243+07
a67baa0c-ce40-4765-a04d-81d35c186093	38da0d33-dcf8-4e3d-b1af-f8eceb4a02d1	bahamas	2021-06-25 03:59:30.486243+07	2021-06-25 03:59:30.486243+07
7a410a13-1066-4e18-9dfd-e719a52d9c9c	38da0d33-dcf8-4e3d-b1af-f8eceb4a02d1	benin	2021-06-25 03:59:30.486243+07	2021-06-25 03:59:30.486243+07
8c4e688c-ddc1-4469-8e79-ced3549de097	38da0d33-dcf8-4e3d-b1af-f8eceb4a02d1	gernamy	2021-06-25 03:59:30.486243+07	2021-06-25 03:59:30.486243+07
e7cd6fa6-5e9a-47cb-a813-1e1e1db012ca	38da0d33-dcf8-4e3d-b1af-f8eceb4a02d1	mexico	2021-06-25 03:59:30.486243+07	2021-06-25 03:59:30.486243+07
eebbb576-123c-4184-884f-c7ff59d66acb	38da0d33-dcf8-4e3d-b1af-f8eceb4a02d1	bolivia	2021-06-25 03:59:30.486243+07	2021-06-25 03:59:30.486243+07
590472c3-3ae6-442e-b37e-6c59db5eac08	38da0d33-dcf8-4e3d-b1af-f8eceb4a02d1	brazil	2021-06-25 03:59:30.486243+07	2021-06-25 03:59:30.486243+07
882480ba-cbbe-4f97-9a09-9c5006517eaf	38da0d33-dcf8-4e3d-b1af-f8eceb4a02d1	brunei	2021-06-25 03:59:30.486243+07	2021-06-25 03:59:30.486243+07
645696c7-f072-4258-b1a7-dbf0affe0aab	38da0d33-dcf8-4e3d-b1af-f8eceb4a02d1	myanmar	2021-06-25 03:59:30.486243+07	2021-06-25 03:59:30.486243+07
c81a902d-11fa-4d81-acda-70942fd3ebcd	38da0d33-dcf8-4e3d-b1af-f8eceb4a02d1	south africa	2021-06-25 03:59:30.486243+07	2021-06-25 03:59:30.486243+07
d05ecbb3-af14-4195-86f6-2f8748c1f18d	38da0d33-dcf8-4e3d-b1af-f8eceb4a02d1	south korea	2021-06-25 03:59:30.486243+07	2021-06-25 03:59:30.486243+07
115e5bed-9fa6-4413-94de-cbae7b1c1cf6	38da0d33-dcf8-4e3d-b1af-f8eceb4a02d1	hugary	2021-06-25 03:59:30.486243+07	2021-06-25 03:59:30.486243+07
01a97f45-26f4-4ed0-940b-822788e2ad56	38da0d33-dcf8-4e3d-b1af-f8eceb4a02d1	hong kong	2021-06-25 03:59:30.486243+07	2021-06-25 03:59:30.486243+07
3339b961-2a00-40b1-a06d-4b95b438480a	38da0d33-dcf8-4e3d-b1af-f8eceb4a02d1	spain	2021-06-25 03:59:30.486243+07	2021-06-25 03:59:30.486243+07
20703d8a-bd19-4501-a042-a3b77d1c059f	38da0d33-dcf8-4e3d-b1af-f8eceb4a02d1	nauru	2021-06-25 03:59:30.486243+07	2021-06-25 03:59:30.486243+07
0afb028d-2a16-4a71-95be-33e78796bc86	38da0d33-dcf8-4e3d-b1af-f8eceb4a02d1	nepal	2021-06-25 03:59:30.486243+07	2021-06-25 03:59:30.486243+07
4900638f-ad80-47f8-862a-5faab51eb3e3	38da0d33-dcf8-4e3d-b1af-f8eceb4a02d1	india	2021-06-25 03:59:30.486243+07	2021-06-25 03:59:30.486243+07
e1aea1e7-9907-4391-8190-0736c99465fa	38da0d33-dcf8-4e3d-b1af-f8eceb4a02d1	indonesia	2021-06-25 03:59:30.486243+07	2021-06-25 03:59:30.486243+07
72042ad8-1ec7-4af0-be9d-e8e5f9d19ae5	38da0d33-dcf8-4e3d-b1af-f8eceb4a02d1	new Zealand	2021-06-25 03:59:30.486243+07	2021-06-25 03:59:30.486243+07
0c029ce2-c723-4979-bc8b-1e7e216e2a77	38da0d33-dcf8-4e3d-b1af-f8eceb4a02d1	nigeria	2021-06-25 03:59:30.486243+07	2021-06-25 03:59:30.486243+07
df9628fa-1cf9-44e5-8e44-81f7affbd56f	38da0d33-dcf8-4e3d-b1af-f8eceb4a02d1	taiwan	2021-06-25 03:59:30.486243+07	2021-06-25 03:59:30.486243+07
9f5b6ea0-b96a-46c0-9a44-08c4bfea51f1	38da0d33-dcf8-4e3d-b1af-f8eceb4a02d1	english	2021-06-25 03:59:30.486243+07	2021-06-25 03:59:30.486243+07
2725f82b-3223-4135-99cd-8836cfd54fd9	38da0d33-dcf8-4e3d-b1af-f8eceb4a02d1	cuba	2021-06-25 03:59:30.486243+07	2021-06-25 03:59:30.486243+07
e4cb52fc-37e4-4348-835d-c588ca149159	38da0d33-dcf8-4e3d-b1af-f8eceb4a02d1	france	2021-06-25 03:59:30.486243+07	2021-06-25 03:59:30.486243+07
179c8c53-f2ac-490c-8a78-92692bd98b44	38da0d33-dcf8-4e3d-b1af-f8eceb4a02d1	vietnamese	2021-06-25 03:59:30.486243+07	2021-06-25 03:59:30.486243+07
4d8537fb-cadd-4719-9744-ab8ff7e9550e	38da0d33-dcf8-4e3d-b1af-f8eceb4a02d1	zambia	2021-06-25 03:59:30.486243+07	2021-06-25 03:59:30.486243+07
0b2ee0e6-f975-47d1-a1fd-fa2224738c10	38da0d33-dcf8-4e3d-b1af-f8eceb4a02d1	united kingdom	2021-06-25 03:59:30.486243+07	2021-06-25 03:59:30.486243+07
cf1d89ff-fb30-4b42-aef1-d97969eb7187	38da0d33-dcf8-4e3d-b1af-f8eceb4a02d1	united states	2021-06-25 03:59:30.486243+07	2021-06-25 03:59:30.486243+07
a53bee2e-1a0f-4165-ac41-7cfde3c43c0a	1e3061ab-0e15-42f7-b81d-6641e4067393	foreign languages	2021-06-25 03:59:30.486243+07	2021-06-25 03:59:30.486243+07
ec94977f-c32f-4fb1-95e9-ad3f57610277	1e3061ab-0e15-42f7-b81d-6641e4067393	marketing	2021-06-25 03:59:30.486243+07	2021-06-25 03:59:30.486243+07
1138d900-90b2-4059-8a34-2ef9af9ea99e	1e3061ab-0e15-42f7-b81d-6641e4067393	office infomation	2021-06-25 03:59:30.486243+07	2021-06-25 03:59:30.486243+07
7baba75e-fe0c-4a3d-b763-8cf1e1dbeb86	1e3061ab-0e15-42f7-b81d-6641e4067393	design	2021-06-25 03:59:30.486243+07	2021-06-25 03:59:30.486243+07
85cb36eb-ab06-4390-9262-5bb669f6d87d	1e3061ab-0e15-42f7-b81d-6641e4067393	business	2021-06-25 03:59:30.486243+07	2021-06-25 03:59:30.486243+07
1ad2b504-f1c0-4fca-9a0e-e5ae9dbe5432	1e3061ab-0e15-42f7-b81d-6641e4067393	health care	2021-06-25 03:59:30.486243+07	2021-06-25 03:59:30.486243+07
0048186d-28f3-491b-9268-ede23f7ca4a7	1e3061ab-0e15-42f7-b81d-6641e4067393	infomation technology	2021-06-25 03:59:30.486243+07	2021-06-25 03:59:30.486243+07
\.


--
-- TOC entry 3187 (class 0 OID 41747)
-- Dependencies: 203
-- Data for Name: Courses; Type: TABLE DATA; Schema: public; Owner: livetutor
--

COPY public."Courses" (id, "tutorId", name, description, level, other_details, "imageUrl", default_price, course_price, "createdAt", "updatedAt") FROM stdin;
\.


--
-- TOC entry 3188 (class 0 OID 41755)
-- Dependencies: 204
-- Data for Name: FavoriteTutors; Type: TABLE DATA; Schema: public; Owner: livetutor
--

COPY public."FavoriteTutors" (id, "firstId", "secondId", "createdAt", "updatedAt") FROM stdin;
0f143886-57cc-4cb0-8cbe-41554be8f5f1	8aa24fdf-f527-46d8-8523-c21f477c9edf	08d34ffc-e19c-40d3-8265-55044d5ed68e	2021-06-18 03:59:03.936+07	2021-06-18 03:59:03.936+07
23ea1da0-76ee-4a80-ac79-dc522a3db0d1	8aa24fdf-f527-46d8-8523-c21f477c9edf	0d7d4348-cf7e-4b6a-9a01-1d88f283e910	2021-06-18 03:59:06.793+07	2021-06-18 03:59:06.793+07
f08868c6-8294-42de-b13d-ee80f509294d	0712174d-c389-4286-af91-8a6b1beb9077	ed6fd0c2-ed38-430a-ae55-a9e6a460b239	2021-06-18 04:31:44.877+07	2021-06-18 04:31:44.877+07
f9b31368-26f8-47e8-8612-d1cab4efdddd	0712174d-c389-4286-af91-8a6b1beb9077	c616bfac-c701-484c-8c3f-f914639be512	2021-06-18 04:31:47.256+07	2021-06-18 04:31:47.256+07
fcbd0c88-cc9a-4412-a7bd-a628fa0d7132	0712174d-c389-4286-af91-8a6b1beb9077	42c2a84a-163b-44d7-9a72-b136f85b594e	2021-06-18 04:31:50.187+07	2021-06-18 04:31:50.187+07
\.


--
-- TOC entry 3189 (class 0 OID 41758)
-- Dependencies: 205
-- Data for Name: Fees; Type: TABLE DATA; Schema: public; Owner: livetutor
--

COPY public."Fees" (id, key, price, "createdAt", "updatedAt") FROM stdin;
0e5574d5-922f-4809-8af1-a06ed3205188	pricePerSession	100000	2021-06-10 21:53:56.032+07	2021-06-10 21:53:56.032+07
\.


--
-- TOC entry 3190 (class 0 OID 41763)
-- Dependencies: 206
-- Data for Name: Majors; Type: TABLE DATA; Schema: public; Owner: livetutor
--

COPY public."Majors" (id, key, "englishName", "vietnameseName", "createdAt", "updatedAt") FROM stdin;
12bc8073-0ac3-4557-9c26-b62abacd7bd8	fl	Foreign Languages	Ngoại ngữ	2021-06-10 21:54:31.964+07	2021-06-10 21:54:31.964+07
a472d2d1-83ef-4c3c-a213-d789603d3d88	mt	Marketing	Marketing	2021-06-10 21:54:31.964+07	2021-06-10 21:54:31.964+07
ebbbca1a-157c-4bd1-a18c-2f7828c84826	of	Office Information	Tin học văn phòng	2021-06-10 21:54:31.964+07	2021-06-10 21:54:31.964+07
5dc53ab8-f3b8-4005-aab7-201da2dc9f5d	ds	Design	Thiết kế	2021-06-10 21:54:31.964+07	2021-06-10 21:54:31.964+07
ad234a86-4d84-4af0-b50e-0f44573895e0	bs	Business	Kinh doanh	2021-06-10 21:54:31.964+07	2021-06-10 21:54:31.964+07
e8f0ec67-70ef-47d6-92fc-7de07bd42990	hc	Health Care	Chăm sóc sức khỏe	2021-06-10 21:54:31.964+07	2021-06-10 21:54:31.964+07
47245390-e608-4bf4-a5db-8487763215e6	it	Information Technology	Công nghệ thông tin	2021-06-10 21:54:31.964+07	2021-06-10 21:54:31.964+07
9ec73cac-5416-43a2-bad2-ce076af5542f	fl	Foreign Languages	Ngoại ngữ	2021-06-25 03:59:53.999+07	2021-06-25 03:59:53.999+07
195bded2-c8b3-4bb7-a773-b4ea9e5d55e7	mt	Marketing	Marketing	2021-06-25 03:59:53.999+07	2021-06-25 03:59:53.999+07
cc4ec334-298f-440f-b9ad-1ffc9b18e73a	of	Office Information	Tin học văn phòng	2021-06-25 03:59:53.999+07	2021-06-25 03:59:53.999+07
f380d0d3-8ebd-4d63-9bc3-778a42d49a5e	ds	Design	Thiết kế	2021-06-25 03:59:53.999+07	2021-06-25 03:59:53.999+07
981d5f33-0e56-4f2a-ab37-0a1228bb596e	bs	Business	Kinh doanh	2021-06-25 03:59:53.999+07	2021-06-25 03:59:53.999+07
b054f380-0b71-42d4-961a-0e8ae2b4c695	hc	Health Care	Chăm sóc sức khỏe	2021-06-25 03:59:54+07	2021-06-25 03:59:54+07
a83ec7aa-d96f-443e-bda6-cbfb011e8924	it	Information Technology	Công nghệ thông tin	2021-06-25 03:59:54+07	2021-06-25 03:59:54+07
\.


--
-- TOC entry 3191 (class 0 OID 41771)
-- Dependencies: 207
-- Data for Name: Messages; Type: TABLE DATA; Schema: public; Owner: livetutor
--

COPY public."Messages" (id, content, "fromId", "toId", "isRead", "createdAt", "updatedAt") FROM stdin;
d8b654df-d745-451b-a136-60a17d8b10e6	Hello chào bạn	0712174d-c389-4286-af91-8a6b1beb9077	ed6fd0c2-ed38-430a-ae55-a9e6a460b239	f	2021-06-18 04:31:59.067+07	2021-06-18 04:31:59.068+07
4ae8cc49-ed13-4804-8f4f-d28d79fd291f	Mình tên là Tâm nè	0712174d-c389-4286-af91-8a6b1beb9077	ed6fd0c2-ed38-430a-ae55-a9e6a460b239	f	2021-06-18 04:32:03.496+07	2021-06-18 04:32:03.496+07
b03f77c4-96aa-4a89-bcce-3eedf4cb8550	Hello chị Chi	0712174d-c389-4286-af91-8a6b1beb9077	a57371e1-07d7-403f-bd71-fa2f14c7c537	f	2021-06-18 04:32:16.998+07	2021-06-18 04:32:16.998+07
01f51b57-a137-430b-a739-eb96db385c72	Học viên hôm nay thế nào Tài	0712174d-c389-4286-af91-8a6b1beb9077	0728421c-15d0-4a81-8382-a23fb30d6500	f	2021-06-18 04:32:46.309+07	2021-06-18 04:32:46.309+07
62e0929a-a3b5-4c21-ac9a-28555cd9778f	Chào anh	0712174d-c389-4286-af91-8a6b1beb9077	02ed45b7-b427-4f24-8705-d182b7199e1a	f	2021-06-18 04:33:09.848+07	2021-06-18 04:33:09.848+07
cd0120ff-bc8e-4061-9cfd-fea5e08825cb	Anh vừa mới đăng kí vào live tutor à	0712174d-c389-4286-af91-8a6b1beb9077	02ed45b7-b427-4f24-8705-d182b7199e1a	f	2021-06-18 04:33:19.689+07	2021-06-18 04:33:19.69+07
b8d194aa-8309-4bb0-a101-e095c5b57c63	cần em hỗ trợ gì không	0712174d-c389-4286-af91-8a6b1beb9077	02ed45b7-b427-4f24-8705-d182b7199e1a	f	2021-06-18 04:33:24.635+07	2021-06-18 04:33:24.636+07
6d7953a0-bc50-43e5-8097-b66869498d11	anh đẹpt rai quá	0712174d-c389-4286-af91-8a6b1beb9077	02ed45b7-b427-4f24-8705-d182b7199e1a	f	2021-06-18 04:33:27.441+07	2021-06-18 04:33:27.441+07
4f13538e-fb0d-4917-9a58-6011f1d1d64c	Em chào cô	5df1c8dd-1939-4fdd-b01d-d03d28ad67eb	0712174d-c389-4286-af91-8a6b1beb9077	f	2021-06-18 04:33:55.238+07	2021-06-18 04:33:55.238+07
74eb58e3-1cd7-4149-8418-e3d2d068720c	Cô có khoẻ không cô	5df1c8dd-1939-4fdd-b01d-d03d28ad67eb	0712174d-c389-4286-af91-8a6b1beb9077	f	2021-06-18 04:33:59.72+07	2021-06-18 04:33:59.72+07
10584d86-496c-42c0-badb-5fd750aa9722	Em chào thầy	5df1c8dd-1939-4fdd-b01d-d03d28ad67eb	0728421c-15d0-4a81-8382-a23fb30d6500	f	2021-06-18 04:34:10.263+07	2021-06-18 04:34:10.263+07
9bb4d155-800c-4dfb-ac46-a38ec04914b3	Em chào chị Chi	5df1c8dd-1939-4fdd-b01d-d03d28ad67eb	a57371e1-07d7-403f-bd71-fa2f14c7c537	f	2021-06-18 04:34:29.905+07	2021-06-18 04:34:29.905+07
aba9d685-c2ce-440f-9723-124a247896b9	Hello Thầy ơi	5df1c8dd-1939-4fdd-b01d-d03d28ad67eb	8aa24fdf-f527-46d8-8523-c21f477c9edf	f	2021-06-18 04:34:54.067+07	2021-06-18 04:34:54.067+07
33c6df0c-403c-4664-ab05-6ddda0359168	Bài hôm nay em có vài chố thắc mắc	5df1c8dd-1939-4fdd-b01d-d03d28ad67eb	8aa24fdf-f527-46d8-8523-c21f477c9edf	f	2021-06-18 04:35:04.544+07	2021-06-18 04:35:04.544+07
6d671149-5121-4028-bbde-12f7014975ef	Chào Thầy Bảo đẹp trai, thầy có bạn gái chưa	5df1c8dd-1939-4fdd-b01d-d03d28ad67eb	0d7d4348-cf7e-4b6a-9a01-1d88f283e910	f	2021-06-18 04:35:20.553+07	2021-06-18 04:35:20.553+07
b40caf50-752d-4fac-85b3-d84da7595b37	nếu chưa có	5df1c8dd-1939-4fdd-b01d-d03d28ad67eb	0d7d4348-cf7e-4b6a-9a01-1d88f283e910	f	2021-06-18 04:35:23.002+07	2021-06-18 04:35:23.002+07
b0ef3baf-b892-4688-aa3f-f6da58721cd5	thì thầy ế tiếp đi nha	5df1c8dd-1939-4fdd-b01d-d03d28ad67eb	0d7d4348-cf7e-4b6a-9a01-1d88f283e910	f	2021-06-18 04:35:27.968+07	2021-06-18 04:35:27.968+07
f30041d0-e66f-45b4-853f-9d0792866b69	hihi =))	5df1c8dd-1939-4fdd-b01d-d03d28ad67eb	0d7d4348-cf7e-4b6a-9a01-1d88f283e910	f	2021-06-18 04:35:33.697+07	2021-06-18 04:35:33.697+07
cac0b4ff-7481-4829-8fcb-e6d7c6526147	Bữa em vừa coi phim chị đóng hay thhaajt	5df1c8dd-1939-4fdd-b01d-d03d28ad67eb	c616bfac-c701-484c-8c3f-f914639be512	f	2021-06-18 04:35:48.841+07	2021-06-18 04:35:48.841+07
0513a50b-7577-410e-a503-9c2ae774426a	Chị có thể vừa đi làm vựa đi dạy	5df1c8dd-1939-4fdd-b01d-d03d28ad67eb	c616bfac-c701-484c-8c3f-f914639be512	f	2021-06-18 04:36:00.024+07	2021-06-18 04:36:00.024+07
ca680df2-8c3d-4ba0-8e07-ab5c920addf2	chị yêu nghề, yêu học sinh thế	5df1c8dd-1939-4fdd-b01d-d03d28ad67eb	c616bfac-c701-484c-8c3f-f914639be512	f	2021-06-18 04:36:08.144+07	2021-06-18 04:36:08.144+07
992f186e-d912-47b0-8ab4-3cf328a8e001	Ơ có phải anh là võ tòng đã hổ không đấy	5df1c8dd-1939-4fdd-b01d-d03d28ad67eb	ed6fd0c2-ed38-430a-ae55-a9e6a460b239	f	2021-06-18 04:36:28.017+07	2021-06-18 04:36:28.018+07
a25c4834-7ba2-48f1-911c-9dcf2b91775f	Thầy ơi ???	5df1c8dd-1939-4fdd-b01d-d03d28ad67eb	ed6fd0c2-ed38-430a-ae55-a9e6a460b239	f	2021-06-18 04:36:30.674+07	2021-06-18 04:36:30.674+07
7fd34472-6ba4-47f7-8974-1a3008cb8d8a	Chào cô siêu pro ạ	5df1c8dd-1939-4fdd-b01d-d03d28ad67eb	c6e0dd89-bc9d-45f2-87d4-975fd07ff8ba	f	2021-06-18 04:36:47.281+07	2021-06-18 04:36:47.281+07
95ac67d7-4a52-4835-b166-43830c98e03f	Em chào thầy, chúc thầy ngày mới vui vẻ	5df1c8dd-1939-4fdd-b01d-d03d28ad67eb	08d34ffc-e19c-40d3-8265-55044d5ed68e	f	2021-06-18 04:37:13.854+07	2021-06-18 04:37:13.854+07
1bb2f79e-73f8-4ae2-9bd8-499fef04a5f9	Ơ 	5df1c8dd-1939-4fdd-b01d-d03d28ad67eb	02ed45b7-b427-4f24-8705-d182b7199e1a	f	2021-06-18 04:37:27.312+07	2021-06-18 04:37:27.313+07
988865ab-18b3-4928-82b8-2ec1083bbb11	Ơ	5df1c8dd-1939-4fdd-b01d-d03d28ad67eb	02ed45b7-b427-4f24-8705-d182b7199e1a	f	2021-06-18 04:37:28.035+07	2021-06-18 04:37:28.035+07
aa92d61a-46e4-40b7-90d0-f745071bcf45	Thầy ơi	5df1c8dd-1939-4fdd-b01d-d03d28ad67eb	02ed45b7-b427-4f24-8705-d182b7199e1a	f	2021-06-18 04:37:32.982+07	2021-06-18 04:37:32.982+07
3d73bf11-130e-4fdb-93ed-b2f16beb576d	Mai thầy dạy nhớ em nha thầy	5df1c8dd-1939-4fdd-b01d-d03d28ad67eb	42c2a84a-163b-44d7-9a72-b136f85b594e	f	2021-06-18 04:38:13.188+07	2021-06-18 04:38:13.188+07
eb6dee4b-3fec-4ccc-893a-4d442404afc5	Lâu ngày quá mới thấy chị dạy đó	0712174d-c389-4286-af91-8a6b1beb9077	a57371e1-07d7-403f-bd71-fa2f14c7c537	t	2021-06-18 04:32:25.116+07	2021-06-18 04:39:13.665+07
706619c1-fb8b-4581-b25a-4683a49823fd	Ơi chị đây	a57371e1-07d7-403f-bd71-fa2f14c7c537	0712174d-c389-4286-af91-8a6b1beb9077	f	2021-06-18 04:39:19.569+07	2021-06-18 04:39:19.57+07
42058a00-6546-4525-a601-aa06f35c4a7c	Lâu quá chị cũng mới thấy em đó	a57371e1-07d7-403f-bd71-fa2f14c7c537	0712174d-c389-4286-af91-8a6b1beb9077	f	2021-06-18 04:39:30.178+07	2021-06-18 04:39:30.178+07
eb4c21b4-a380-4a0a-8e28-778345279770	dạo này ổn không	a57371e1-07d7-403f-bd71-fa2f14c7c537	0712174d-c389-4286-af91-8a6b1beb9077	f	2021-06-18 04:39:34.927+07	2021-06-18 04:39:34.927+07
1952d875-96dd-46a6-8faa-c052c17465c7	mai chị có giờ rảnh nhớ book, em đăng kí chị liền nè	5df1c8dd-1939-4fdd-b01d-d03d28ad67eb	a57371e1-07d7-403f-bd71-fa2f14c7c537	t	2021-06-18 04:34:47.359+07	2021-06-18 04:39:38.334+07
dea808a8-de71-4689-92e9-dddf51b5d3fd	Ok em	a57371e1-07d7-403f-bd71-fa2f14c7c537	5df1c8dd-1939-4fdd-b01d-d03d28ad67eb	f	2021-06-18 04:39:41.461+07	2021-06-18 04:39:41.461+07
e8ebd2c7-3e1e-4816-adec-43a9c5c23d0a	Chị sẽ sắp xếp thời gian nè	a57371e1-07d7-403f-bd71-fa2f14c7c537	5df1c8dd-1939-4fdd-b01d-d03d28ad67eb	t	2021-06-18 04:39:48.354+07	2021-06-18 04:39:54.728+07
d7606ba5-3d04-4a0b-9355-5359ee6df4b8	Dạ vâng chị ạ	5df1c8dd-1939-4fdd-b01d-d03d28ad67eb	a57371e1-07d7-403f-bd71-fa2f14c7c537	t	2021-06-18 04:39:58.528+07	2021-06-18 04:40:03.27+07
6d94f76f-91e1-4c30-ac23-0b524e6f863d	Thầy có khoẻ không thầy	5df1c8dd-1939-4fdd-b01d-d03d28ad67eb	0728421c-15d0-4a81-8382-a23fb30d6500	t	2021-06-18 04:34:15.298+07	2021-06-18 04:56:04.39+07
300dec4e-6e01-464b-91d4-c8ff2daf83a0	Ừ thầy cũng ổn	0728421c-15d0-4a81-8382-a23fb30d6500	5df1c8dd-1939-4fdd-b01d-d03d28ad67eb	f	2021-06-18 04:56:08.777+07	2021-06-18 04:56:08.778+07
4d0f6693-5f00-4985-b537-721b155538c2	Có ổn lắm không đấy	0712174d-c389-4286-af91-8a6b1beb9077	0728421c-15d0-4a81-8382-a23fb30d6500	t	2021-06-18 04:32:50.74+07	2021-06-18 04:56:12.231+07
6d1645d7-5dbf-48cf-b276-f11c23558b5c	Hiazz	0728421c-15d0-4a81-8382-a23fb30d6500	0712174d-c389-4286-af91-8a6b1beb9077	f	2021-06-18 04:56:14.802+07	2021-06-18 04:56:14.802+07
de70953b-137d-4e02-a1cf-7739e471fe74	Dịch dủm chán lắm	0728421c-15d0-4a81-8382-a23fb30d6500	0712174d-c389-4286-af91-8a6b1beb9077	f	2021-06-18 04:56:19.156+07	2021-06-18 04:56:19.156+07
124bdf0a-ccf3-4da1-b367-2996a5af2973	Hi anh	74655b72-3b14-463e-98b6-a2f64a459aa9	8aa24fdf-f527-46d8-8523-c21f477c9edf	f	2021-06-18 05:08:52.195+07	2021-06-18 05:08:52.195+07
5b03016a-86d9-41ea-a76d-ec37cc3f7a12	Em chào chị	74655b72-3b14-463e-98b6-a2f64a459aa9	0712174d-c389-4286-af91-8a6b1beb9077	f	2021-06-18 05:08:57.137+07	2021-06-18 05:08:57.137+07
\.


--
-- TOC entry 3192 (class 0 OID 41779)
-- Dependencies: 208
-- Data for Name: RefreshTokens; Type: TABLE DATA; Schema: public; Owner: livetutor
--

COPY public."RefreshTokens" (id, token, "userId", "userEmail", expires, "createdAt", "updatedAt") FROM stdin;
f28fd7b2-ca65-4786-9bf5-8f232dc38e1d	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIwMmVkNDViNy1iNDI3LTRmMjQtODcwNS1kMTgyYjcxOTllMWEiLCJpYXQiOjE2MjQ1NjU1MTQsImV4cCI6MTYyNzE1NzUxNCwidHlwZSI6InJlZnJlc2gifQ.xny9m8yBgICjuBoMqQEJQ6228RC63kvlrbSHNRDFIaU	02ed45b7-b427-4f24-8705-d182b7199e1a	lttutor7@yopmail.com	2021-07-25 03:11:54.357+07	2021-06-25 03:11:54.358+07	2021-06-25 03:11:54.358+07
92657b6e-2232-4c59-aea4-250a983966f9	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIwMmVkNDViNy1iNDI3LTRmMjQtODcwNS1kMTgyYjcxOTllMWEiLCJpYXQiOjE2MjQ1NjU2MzksImV4cCI6MTYyNzE1NzYzOSwidHlwZSI6InJlZnJlc2gifQ.Je7bquy3do7l1e8y5N1OfClUKMD57vzdBIsdyPFtYDg	02ed45b7-b427-4f24-8705-d182b7199e1a	lttutor7@yopmail.com	2021-07-25 03:13:59.638+07	2021-06-25 03:13:59.64+07	2021-06-25 03:13:59.64+07
6877528f-ce5c-4ec9-8ea5-4db276e116b8	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI1ZGYxYzhkZC0xOTM5LTRmZGQtYjAxZC1kMDNkMjhhZDY3ZWIiLCJpYXQiOjE2MjQ1NjU2NjMsImV4cCI6MTYyNzE1NzY2MywidHlwZSI6InJlZnJlc2gifQ.bsMmcLvsO2kBYv94ayss7kkdiZAdohCF1WSaj89Qn0w	5df1c8dd-1939-4fdd-b01d-d03d28ad67eb	ltstudent1@yopmail.com	2021-07-25 03:14:23.451+07	2021-06-25 03:14:23.451+07	2021-06-25 03:14:23.451+07
aadf7769-4f8f-4b49-994c-f64971c275fb	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI4NDY3MTBlMi1lMGY0LTRmMTEtYjZhYS01NGVmZTRmYmU0NTUiLCJpYXQiOjE2MjQ1NjU3MjgsImV4cCI6MTYyNzE1NzcyOCwidHlwZSI6InJlZnJlc2gifQ.xqEiohnnVKFsYK0KvS0tWZ6WDr18fEyDbv2sF03Uz08	846710e2-e0f4-4f11-b6aa-54efe4fbe455	ltstudent2@yopmail.com	2021-07-25 03:15:28.689+07	2021-06-25 03:15:28.689+07	2021-06-25 03:15:28.689+07
2f9b806b-b248-45ce-8c58-f94d6f115299	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI3NDY1NWI3Mi0zYjE0LTQ2M2UtOThiNi1hMmY2NGE0NTlhYTkiLCJpYXQiOjE2MjQ1NjU4MDcsImV4cCI6MTYyNzE1NzgwNywidHlwZSI6InJlZnJlc2gifQ.--wwnaYaGVmm6Xh9oAZv7Oh8lJHzu72UfOV1XcNVRls	74655b72-3b14-463e-98b6-a2f64a459aa9	ltstudent4@yopmail.com	2021-07-25 03:16:47.231+07	2021-06-25 03:16:47.232+07	2021-06-25 03:16:47.232+07
dae55482-d2e6-4f0c-978a-d5a93fbb5104	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIwNGVmODcwZS02MGNjLTQ4MjItOWI2ZC02N2M4MTQzZDIwMjkiLCJpYXQiOjE2MjQ1NjU4NjAsImV4cCI6MTYyNzE1Nzg2MCwidHlwZSI6InJlZnJlc2gifQ.790isksZBar43W4CMZp6Dm-ds-Ix7coKOyxdC_KWQ9g	04ef870e-60cc-4822-9b6d-67c8143d2029	ltstudent7@yopmail.com	2021-07-25 03:17:40.168+07	2021-06-25 03:17:40.169+07	2021-06-25 03:17:40.169+07
1328f195-da6f-4789-a6af-2b99eda1ed8d	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIwZDdkNDM0OC1jZjdlLTRiNmEtOWEwMS0xZDg4ZjI4M2U5MTAiLCJpYXQiOjE2MjQ1NjU5MTMsImV4cCI6MTYyNzE1NzkxMywidHlwZSI6InJlZnJlc2gifQ.4DGA-g485qVjb7-BT_hI0QnEkVFLPh5HENebVo9ecR4	0d7d4348-cf7e-4b6a-9a01-1d88f283e910	lttutor1@yopmail.com	2021-07-25 03:18:33.269+07	2021-06-25 03:18:33.269+07	2021-06-25 03:18:33.269+07
d7b8b070-2d00-462a-8fb4-046b9f109abf	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI4NDY3MTBlMi1lMGY0LTRmMTEtYjZhYS01NGVmZTRmYmU0NTUiLCJpYXQiOjE2MjQ1NjU5OTEsImV4cCI6MTYyNzE1Nzk5MSwidHlwZSI6InJlZnJlc2gifQ.85lxrmP7Z95k9ROx9-ApJ9bhZnlNCP1hrQnTbObuIzg	846710e2-e0f4-4f11-b6aa-54efe4fbe455	ltstudent2@yopmail.com	2021-07-25 03:19:51.409+07	2021-06-25 03:19:51.41+07	2021-06-25 03:19:51.41+07
3aaf1c96-0d36-4664-934f-3c4183711870	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIwMmVkNDViNy1iNDI3LTRmMjQtODcwNS1kMTgyYjcxOTllMWEiLCJpYXQiOjE2MjQ1NjYwNTAsImV4cCI6MTYyNzE1ODA1MCwidHlwZSI6InJlZnJlc2gifQ.dst_zzKO3vixn20ZAxZwaCSr2VaxpL7HLm0eIQGppn4	02ed45b7-b427-4f24-8705-d182b7199e1a	lttutor7@yopmail.com	2021-07-25 03:20:50.081+07	2021-06-25 03:20:50.082+07	2021-06-25 03:20:50.082+07
0bb0aa97-fbcf-452b-88ba-d66fb664eaca	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJjNmUwZGQ4OS1iYzlkLTQ1ZjItODdkNC05NzVmZDA3ZmY4YmEiLCJpYXQiOjE2MjQ1NjYxMDQsImV4cCI6MTYyNzE1ODEwNCwidHlwZSI6InJlZnJlc2gifQ.R6q7gUbw6NLHy9wfOGXqQaG1wBg76ZL4d0MPgdITqDg	c6e0dd89-bc9d-45f2-87d4-975fd07ff8ba	lttutor9@yopmail.com	2021-07-25 03:21:44.08+07	2021-06-25 03:21:44.081+07	2021-06-25 03:21:44.081+07
69b94b72-6c5d-444e-bf7b-411080908602	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI3NDY1NWI3Mi0zYjE0LTQ2M2UtOThiNi1hMmY2NGE0NTlhYTkiLCJpYXQiOjE2MjQ1Njc4ODksImV4cCI6MTYyNzE1OTg4OSwidHlwZSI6InJlZnJlc2gifQ.LNN2gWglj5Tyc_NKqSDQLAzgeSALHy3-HIxTdIkvdXo	74655b72-3b14-463e-98b6-a2f64a459aa9	ltstudent4@yopmail.com	2021-07-25 03:51:29.204+07	2021-06-25 03:51:29.205+07	2021-06-25 03:51:29.205+07
c1806c9e-499f-4538-8152-6a7b031595e1	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJhNTczNzFlMS0wN2Q3LTQwM2YtYmQ3MS1mYTJmMTRjN2M1MzciLCJpYXQiOjE2MjQ1Njc5MzgsImV4cCI6MTYyNzE1OTkzOCwidHlwZSI6InJlZnJlc2gifQ.u-dgzB_syuSxGfHUvVyk8UUKFqIhAhQfu0Z6guXK1Mg	a57371e1-07d7-403f-bd71-fa2f14c7c537	lttutor6@yopmail.com	2021-07-25 03:52:18.118+07	2021-06-25 03:52:18.119+07	2021-06-25 03:52:18.119+07
\.


--
-- TOC entry 3193 (class 0 OID 41787)
-- Dependencies: 209
-- Data for Name: Roles; Type: TABLE DATA; Schema: public; Owner: livetutor
--

COPY public."Roles" (id, name, "createdAt", "updatedAt") FROM stdin;
90ae8b64-b728-4457-bf17-f9e5c0f14198	student	2021-06-10 21:51:58.012+07	2021-06-10 21:51:58.012+07
6f24a66a-421f-4165-bb41-e0e3603a2460	tutor	2021-06-10 21:51:58.012+07	2021-06-10 21:51:58.012+07
a31e0f43-d0f5-4046-8eb9-837e001b62b6	admin	2021-06-10 21:51:58.012+07	2021-06-10 21:51:58.012+07
\.


--
-- TOC entry 3194 (class 0 OID 41792)
-- Dependencies: 210
-- Data for Name: ScheduleDetails; Type: TABLE DATA; Schema: public; Owner: livetutor
--

COPY public."ScheduleDetails" (id, "startPeriod", "endPeriod", "scheduleId", "createdAt", "updatedAt") FROM stdin;
c3e618a7-a5f0-467e-bf40-e880259f76c1	15:00	15:30	d7ec1364-8897-41fa-9013-c39983410804	2021-06-18 03:50:11.095+07	2021-06-18 03:50:11.095+07
df2e1089-b7b7-46a9-907a-9d0b654126a9	15:30	16:00	d7ec1364-8897-41fa-9013-c39983410804	2021-06-18 03:50:11.096+07	2021-06-18 03:50:11.096+07
2b3a14c6-520f-4baa-ac09-cfa385d640eb	16:00	16:30	d7ec1364-8897-41fa-9013-c39983410804	2021-06-18 03:50:11.096+07	2021-06-18 03:50:11.096+07
e6fc086c-cacd-43cb-8bec-d16887456c55	16:30	17:00	d7ec1364-8897-41fa-9013-c39983410804	2021-06-18 03:50:11.097+07	2021-06-18 03:50:11.097+07
2b8fceff-fa05-424d-9bc1-bfe66f7ff815	17:00	17:30	d7ec1364-8897-41fa-9013-c39983410804	2021-06-18 03:50:11.097+07	2021-06-18 03:50:11.097+07
e83d1237-e120-421a-90f9-a4414b5796a6	17:30	18:00	d7ec1364-8897-41fa-9013-c39983410804	2021-06-18 03:50:11.097+07	2021-06-18 03:50:11.097+07
06be6bfb-523c-438a-ac18-3a49b1c7bbae	18:00	18:30	d7ec1364-8897-41fa-9013-c39983410804	2021-06-18 03:50:11.097+07	2021-06-18 03:50:11.097+07
124d6f62-218b-4a32-8ec6-7704c1d030f8	18:30	19:00	d7ec1364-8897-41fa-9013-c39983410804	2021-06-18 03:50:11.098+07	2021-06-18 03:50:11.098+07
5ede907d-a81e-429c-8429-a6c609a4780b	19:00	19:30	d7ec1364-8897-41fa-9013-c39983410804	2021-06-18 03:50:11.098+07	2021-06-18 03:50:11.098+07
103b01bd-4f20-4913-b987-2b1505816015	19:30	20:00	d7ec1364-8897-41fa-9013-c39983410804	2021-06-18 03:50:11.098+07	2021-06-18 03:50:11.098+07
c13909c8-1528-491f-909f-15b6bd37ecd0	16:00	16:30	70b12e80-af1c-4532-a887-b167430167a2	2021-06-18 03:57:24.246+07	2021-06-18 03:57:24.246+07
d4c6d885-bbe2-482b-b704-a8d527158133	16:30	17:00	70b12e80-af1c-4532-a887-b167430167a2	2021-06-18 03:57:24.246+07	2021-06-18 03:57:24.246+07
e205e180-3e33-44e8-80dd-8a0c6bdf2547	17:00	17:30	70b12e80-af1c-4532-a887-b167430167a2	2021-06-18 03:57:24.248+07	2021-06-18 03:57:24.248+07
8883ce28-dc04-4821-aca7-672e8a18493d	17:30	18:00	70b12e80-af1c-4532-a887-b167430167a2	2021-06-18 03:57:24.248+07	2021-06-18 03:57:24.248+07
b0121f8d-9556-4214-a80b-07ba969ce145	18:00	18:30	70b12e80-af1c-4532-a887-b167430167a2	2021-06-18 03:57:24.249+07	2021-06-18 03:57:24.249+07
4bc4692b-34ff-41ce-aab0-76ad48381e0d	18:30	19:00	70b12e80-af1c-4532-a887-b167430167a2	2021-06-18 03:57:24.249+07	2021-06-18 03:57:24.249+07
de7b47ba-796c-4a8c-9dbf-2360ebe530c1	16:00	16:30	6f480ca8-24cd-45c5-8a19-5525c6c584db	2021-06-18 03:57:24.255+07	2021-06-18 03:57:24.255+07
209406dd-65c1-4f47-9297-bc03854b4ab3	16:30	17:00	6f480ca8-24cd-45c5-8a19-5525c6c584db	2021-06-18 03:57:24.255+07	2021-06-18 03:57:24.255+07
19307ade-e749-481d-94e6-c38a041aa449	17:00	17:30	6f480ca8-24cd-45c5-8a19-5525c6c584db	2021-06-18 03:57:24.256+07	2021-06-18 03:57:24.256+07
2ea8764d-be37-47b8-8701-510654ba1c58	17:30	18:00	6f480ca8-24cd-45c5-8a19-5525c6c584db	2021-06-18 03:57:24.256+07	2021-06-18 03:57:24.256+07
e0697346-e2b0-43ce-a9e3-e84ba84cdcfd	18:00	18:30	6f480ca8-24cd-45c5-8a19-5525c6c584db	2021-06-18 03:57:24.256+07	2021-06-18 03:57:24.256+07
eec08b7e-fb9e-48cc-9844-4a160891091e	18:30	19:00	6f480ca8-24cd-45c5-8a19-5525c6c584db	2021-06-18 03:57:24.256+07	2021-06-18 03:57:24.256+07
83eea495-5826-4f5d-9be7-4af7cb9ac7a7	16:00	16:30	a0c54ab6-73dd-4cd2-8506-c2d0e372b5f0	2021-06-18 03:57:24.266+07	2021-06-18 03:57:24.266+07
1949e3ba-5a30-4c6a-b788-ceceb3f53863	16:30	17:00	a0c54ab6-73dd-4cd2-8506-c2d0e372b5f0	2021-06-18 03:57:24.266+07	2021-06-18 03:57:24.266+07
f4edfdc6-656d-447f-b25e-71bcbffb40d7	17:00	17:30	a0c54ab6-73dd-4cd2-8506-c2d0e372b5f0	2021-06-18 03:57:24.266+07	2021-06-18 03:57:24.266+07
9bc3127e-6e57-4370-9abd-0bc0121fa4f0	17:30	18:00	a0c54ab6-73dd-4cd2-8506-c2d0e372b5f0	2021-06-18 03:57:24.267+07	2021-06-18 03:57:24.267+07
f620bffe-0711-4a02-b1fa-cfabfb1fe58a	18:00	18:30	a0c54ab6-73dd-4cd2-8506-c2d0e372b5f0	2021-06-18 03:57:24.267+07	2021-06-18 03:57:24.267+07
889703a1-69e4-4d65-a32f-0364bf6141ae	18:30	19:00	a0c54ab6-73dd-4cd2-8506-c2d0e372b5f0	2021-06-18 03:57:24.267+07	2021-06-18 03:57:24.267+07
90af0c6f-20a6-4bc9-b4e1-512c463fe97f	16:00	16:30	84a97d79-fdc3-4ee3-b499-0929cf152259	2021-06-18 03:57:24.349+07	2021-06-18 03:57:24.349+07
ac1271aa-920c-4328-a438-2e62743ad0f6	16:30	17:00	84a97d79-fdc3-4ee3-b499-0929cf152259	2021-06-18 03:57:24.349+07	2021-06-18 03:57:24.349+07
c401900b-f431-4bab-bf4c-28ed98cee8c1	17:00	17:30	84a97d79-fdc3-4ee3-b499-0929cf152259	2021-06-18 03:57:24.35+07	2021-06-18 03:57:24.35+07
07249f13-3a44-4a87-95a9-4b6b2bbaadea	17:30	18:00	84a97d79-fdc3-4ee3-b499-0929cf152259	2021-06-18 03:57:24.35+07	2021-06-18 03:57:24.35+07
64e840a3-780d-4c53-89ae-292775d59207	18:00	18:30	84a97d79-fdc3-4ee3-b499-0929cf152259	2021-06-18 03:57:24.35+07	2021-06-18 03:57:24.35+07
523497bf-bc6e-42f7-80c6-d31d2c2df52c	18:30	19:00	84a97d79-fdc3-4ee3-b499-0929cf152259	2021-06-18 03:57:24.35+07	2021-06-18 03:57:24.35+07
a3fdaacf-aee2-408e-a751-58c97a4d6f25	16:00	16:30	78701819-1390-4237-a81e-abef133a2781	2021-06-18 03:57:24.354+07	2021-06-18 03:57:24.354+07
4f8b3f94-2bba-42d2-9228-6252a8bc3ada	16:30	17:00	78701819-1390-4237-a81e-abef133a2781	2021-06-18 03:57:24.355+07	2021-06-18 03:57:24.355+07
31c29a3c-fb29-4d49-8eb4-b34f419f83c0	17:00	17:30	78701819-1390-4237-a81e-abef133a2781	2021-06-18 03:57:24.355+07	2021-06-18 03:57:24.355+07
6ca5e049-4602-44ac-8d04-992f48b3a797	17:30	18:00	78701819-1390-4237-a81e-abef133a2781	2021-06-18 03:57:24.355+07	2021-06-18 03:57:24.355+07
5ad16b55-879d-4d63-adba-85c92f14727a	18:00	18:30	78701819-1390-4237-a81e-abef133a2781	2021-06-18 03:57:24.355+07	2021-06-18 03:57:24.355+07
5d92d4b7-6c5e-4df5-b1b5-783ea74fc68d	18:30	19:00	78701819-1390-4237-a81e-abef133a2781	2021-06-18 03:57:24.355+07	2021-06-18 03:57:24.355+07
78379e22-4dfb-422d-96c9-63c7e735724b	16:00	16:30	fdc625ab-ad14-4ae8-bde1-2fb53cf1eefd	2021-06-18 03:57:24.451+07	2021-06-18 03:57:24.451+07
a2cd4f36-bdb2-487e-a005-9b642492ba10	16:30	17:00	fdc625ab-ad14-4ae8-bde1-2fb53cf1eefd	2021-06-18 03:57:24.451+07	2021-06-18 03:57:24.451+07
a139a02e-9693-4eeb-8789-e8ae932f2ac4	17:00	17:30	fdc625ab-ad14-4ae8-bde1-2fb53cf1eefd	2021-06-18 03:57:24.451+07	2021-06-18 03:57:24.451+07
f8af06ca-76e5-4425-8e31-bd459522aee8	17:30	18:00	fdc625ab-ad14-4ae8-bde1-2fb53cf1eefd	2021-06-18 03:57:24.451+07	2021-06-18 03:57:24.451+07
b94cc095-c107-4410-920e-0589185061b0	18:00	18:30	fdc625ab-ad14-4ae8-bde1-2fb53cf1eefd	2021-06-18 03:57:24.452+07	2021-06-18 03:57:24.452+07
dd634d47-e012-42ca-b889-9f8b41ebb102	18:30	19:00	fdc625ab-ad14-4ae8-bde1-2fb53cf1eefd	2021-06-18 03:57:24.452+07	2021-06-18 03:57:24.452+07
c09c5303-5791-4fc9-9d94-a4ba1db34595	16:00	16:30	61766dbe-bd80-4b6e-870d-840db60574f5	2021-06-18 03:57:24.5+07	2021-06-18 03:57:24.5+07
73d4c401-c68f-4204-b36e-f65cf49156ba	16:30	17:00	61766dbe-bd80-4b6e-870d-840db60574f5	2021-06-18 03:57:24.501+07	2021-06-18 03:57:24.501+07
813a8f2f-b86e-4f16-bc06-d480c8db843b	17:00	17:30	61766dbe-bd80-4b6e-870d-840db60574f5	2021-06-18 03:57:24.501+07	2021-06-18 03:57:24.501+07
8409543d-a2fa-49d7-a681-2f32c1eb0071	17:30	18:00	61766dbe-bd80-4b6e-870d-840db60574f5	2021-06-18 03:57:24.501+07	2021-06-18 03:57:24.501+07
d83e29be-a0c0-4a56-9d53-df91561fe858	18:00	18:30	61766dbe-bd80-4b6e-870d-840db60574f5	2021-06-18 03:57:24.501+07	2021-06-18 03:57:24.501+07
31413746-37ea-4960-8f91-517bddaae0fd	18:30	19:00	61766dbe-bd80-4b6e-870d-840db60574f5	2021-06-18 03:57:24.501+07	2021-06-18 03:57:24.501+07
af7626f9-4391-4a5b-ba67-aa062ee70fe9	16:00	16:30	2195ca9f-4226-4cc0-a184-47e4f2ee549b	2021-06-18 03:57:24.506+07	2021-06-18 03:57:24.506+07
ffc7affb-5312-4c50-9411-507a0b091929	16:30	17:00	2195ca9f-4226-4cc0-a184-47e4f2ee549b	2021-06-18 03:57:24.506+07	2021-06-18 03:57:24.506+07
587e5aad-ae17-4bae-b00f-c7ed81253e6a	17:00	17:30	2195ca9f-4226-4cc0-a184-47e4f2ee549b	2021-06-18 03:57:24.506+07	2021-06-18 03:57:24.506+07
7139ecdd-4515-4b33-9d6e-d6d3f7af2013	17:30	18:00	2195ca9f-4226-4cc0-a184-47e4f2ee549b	2021-06-18 03:57:24.507+07	2021-06-18 03:57:24.507+07
6d5e1a41-9adc-4667-878e-22b793fe01d0	18:00	18:30	2195ca9f-4226-4cc0-a184-47e4f2ee549b	2021-06-18 03:57:24.507+07	2021-06-18 03:57:24.507+07
e2da6431-d3dd-4b06-85a9-735367877e7f	18:30	19:00	2195ca9f-4226-4cc0-a184-47e4f2ee549b	2021-06-18 03:57:24.507+07	2021-06-18 03:57:24.507+07
d18306bb-3369-428a-b479-e272cbdcc303	16:00	16:30	75912ebf-35fb-4333-b5c1-6a77d4f66211	2021-06-18 03:57:24.511+07	2021-06-18 03:57:24.511+07
d6c2eb25-3675-4457-8228-57646bc8abc2	16:30	17:00	75912ebf-35fb-4333-b5c1-6a77d4f66211	2021-06-18 03:57:24.511+07	2021-06-18 03:57:24.511+07
dac93041-92b7-470f-a859-486075aea5c8	17:00	17:30	75912ebf-35fb-4333-b5c1-6a77d4f66211	2021-06-18 03:57:24.511+07	2021-06-18 03:57:24.511+07
7d9e5c11-2be3-444c-93b9-463a37e6e38b	17:30	18:00	75912ebf-35fb-4333-b5c1-6a77d4f66211	2021-06-18 03:57:24.511+07	2021-06-18 03:57:24.511+07
aeb8c15c-00d7-4eeb-b0fb-8b22dfa9ff6d	18:00	18:30	75912ebf-35fb-4333-b5c1-6a77d4f66211	2021-06-18 03:57:24.511+07	2021-06-18 03:57:24.511+07
958af60a-f0a0-4e3b-b52a-9f6dd386ea54	18:30	19:00	75912ebf-35fb-4333-b5c1-6a77d4f66211	2021-06-18 03:57:24.512+07	2021-06-18 03:57:24.512+07
ee50b884-40aa-4a1f-8a11-9b359a592c74	16:00	16:30	8bb81bc3-315e-4175-b0bc-be526dd1d82a	2021-06-18 03:57:24.515+07	2021-06-18 03:57:24.515+07
6efb9119-ccd9-4b17-b2ae-392a4c1f90d1	16:30	17:00	8bb81bc3-315e-4175-b0bc-be526dd1d82a	2021-06-18 03:57:24.515+07	2021-06-18 03:57:24.515+07
d815a82c-518f-459e-930b-9d65a3cacae9	17:00	17:30	8bb81bc3-315e-4175-b0bc-be526dd1d82a	2021-06-18 03:57:24.516+07	2021-06-18 03:57:24.516+07
6a0fc797-cb5f-49e7-96c2-ad7d1663825d	17:30	18:00	8bb81bc3-315e-4175-b0bc-be526dd1d82a	2021-06-18 03:57:24.516+07	2021-06-18 03:57:24.516+07
69fc3d5b-57f0-43d0-a31b-68424d80a57f	18:00	18:30	8bb81bc3-315e-4175-b0bc-be526dd1d82a	2021-06-18 03:57:24.516+07	2021-06-18 03:57:24.516+07
a0163cbf-5aad-45fd-9122-847ce1d756e4	18:30	19:00	8bb81bc3-315e-4175-b0bc-be526dd1d82a	2021-06-18 03:57:24.516+07	2021-06-18 03:57:24.516+07
f2ccf74c-9cfa-4ef5-8090-267d891eca64	16:00	16:30	f2148574-dc89-4781-8628-05799f44d636	2021-06-18 03:57:24.519+07	2021-06-18 03:57:24.519+07
76c8736a-024a-4af6-99e0-66b7ec2f7700	16:30	17:00	f2148574-dc89-4781-8628-05799f44d636	2021-06-18 03:57:24.519+07	2021-06-18 03:57:24.519+07
90c3e4ad-f9a7-4857-a65d-36717735fa5b	17:00	17:30	f2148574-dc89-4781-8628-05799f44d636	2021-06-18 03:57:24.519+07	2021-06-18 03:57:24.519+07
870c7c1d-1508-4f52-b389-32d2c67814f2	17:30	18:00	f2148574-dc89-4781-8628-05799f44d636	2021-06-18 03:57:24.52+07	2021-06-18 03:57:24.52+07
c751c168-90e2-471e-ae1f-9589558bd1f7	18:00	18:30	f2148574-dc89-4781-8628-05799f44d636	2021-06-18 03:57:24.52+07	2021-06-18 03:57:24.52+07
72833a5d-1ab3-474a-97b9-4df5fede0942	18:30	19:00	f2148574-dc89-4781-8628-05799f44d636	2021-06-18 03:57:24.52+07	2021-06-18 03:57:24.52+07
d61382aa-feb1-4c82-b530-5b1215543b2f	16:00	16:30	075fc746-814e-4611-97de-0c2754a24c8d	2021-06-18 03:57:24.528+07	2021-06-18 03:57:24.528+07
e003cc15-2f3a-400b-a764-45aa48c8dce7	16:30	17:00	075fc746-814e-4611-97de-0c2754a24c8d	2021-06-18 03:57:24.529+07	2021-06-18 03:57:24.529+07
cb7cae20-b168-4bb0-a584-2f5c16da3c3d	17:00	17:30	075fc746-814e-4611-97de-0c2754a24c8d	2021-06-18 03:57:24.529+07	2021-06-18 03:57:24.529+07
cf394f1a-134a-486b-87f0-c117dc36d6ce	17:30	18:00	075fc746-814e-4611-97de-0c2754a24c8d	2021-06-18 03:57:24.529+07	2021-06-18 03:57:24.529+07
dee709d5-2ef2-4d23-b5bf-9edb2e474035	18:00	18:30	075fc746-814e-4611-97de-0c2754a24c8d	2021-06-18 03:57:24.53+07	2021-06-18 03:57:24.53+07
35b0ad10-0b84-400c-9a98-0263db454b19	18:30	19:00	075fc746-814e-4611-97de-0c2754a24c8d	2021-06-18 03:57:24.53+07	2021-06-18 03:57:24.53+07
5d789926-9b87-4e47-99f5-ff91c041f883	02:00	02:30	508d99ca-79c4-40c5-b04d-e51e6fed7b53	2021-06-18 03:58:00.364+07	2021-06-18 03:58:00.364+07
2fbfd85a-3d4c-4c55-bf85-27f2f9641c01	02:30	03:00	508d99ca-79c4-40c5-b04d-e51e6fed7b53	2021-06-18 03:58:00.364+07	2021-06-18 03:58:00.364+07
b3b233c2-7887-43be-91f4-02d7e629a0cd	03:00	03:30	508d99ca-79c4-40c5-b04d-e51e6fed7b53	2021-06-18 03:58:00.364+07	2021-06-18 03:58:00.364+07
0fe87911-fc21-4bc6-819a-d7036bf1405b	03:30	04:00	508d99ca-79c4-40c5-b04d-e51e6fed7b53	2021-06-18 03:58:00.366+07	2021-06-18 03:58:00.366+07
aca203c1-fc4d-4dab-9a3e-596559e01c2a	04:00	04:30	508d99ca-79c4-40c5-b04d-e51e6fed7b53	2021-06-18 03:58:00.366+07	2021-06-18 03:58:00.366+07
907e6659-0da6-4d3c-819f-e7d4d75996ce	04:30	05:00	508d99ca-79c4-40c5-b04d-e51e6fed7b53	2021-06-18 03:58:00.366+07	2021-06-18 03:58:00.366+07
6249e9f6-96b7-4d4b-a50c-8434f5850f55	05:00	05:30	508d99ca-79c4-40c5-b04d-e51e6fed7b53	2021-06-18 03:58:00.366+07	2021-06-18 03:58:00.366+07
10474a5c-e80b-4227-90ff-22e4bf6217ef	03:00	03:30	c070240f-7d97-4408-8e0e-88ee83823531	2021-06-18 03:58:00.371+07	2021-06-18 03:58:00.371+07
51f68286-5f65-494e-9fe2-185a050f0f83	05:30	06:00	c070240f-7d97-4408-8e0e-88ee83823531	2021-06-18 03:58:00.372+07	2021-06-18 03:58:00.372+07
c05c8cd3-7578-4421-800b-4db88bd3b55c	04:00	04:30	c299fec6-bb03-4abb-8c0b-8e043d061cbd	2021-06-18 03:58:00.384+07	2021-06-18 03:58:00.384+07
5bb8b604-0484-4982-a9c9-051b082242da	02:00	02:30	5d401606-cab4-4ac3-8e43-88248ed22de0	2021-06-18 03:58:00.397+07	2021-06-18 03:58:00.397+07
e91bab70-a3c7-4a9a-886a-1d97bafd4fc2	04:30	05:00	5d401606-cab4-4ac3-8e43-88248ed22de0	2021-06-18 03:58:00.398+07	2021-06-18 03:58:00.398+07
f68fdf57-95ab-4a9b-890c-fb4a09dd75ea	03:30	04:00	487827c8-6595-4671-8d4b-bf4a5119070f	2021-06-18 03:58:00.407+07	2021-06-18 03:58:00.407+07
bb438345-bb5b-45a7-95a3-e7189097b6f0	02:00	02:30	76264bb3-fff3-4e6f-8d20-57b9a044212c	2021-06-18 03:58:00.415+07	2021-06-18 03:58:00.415+07
2090bdb5-7409-44f7-a174-d8db6fb5b66c	04:30	05:00	76264bb3-fff3-4e6f-8d20-57b9a044212c	2021-06-18 03:58:00.416+07	2021-06-18 03:58:00.416+07
6f7745e3-472b-4413-949c-572b767ceb2e	02:00	02:30	206f98fa-34b7-4088-8e4f-b79a0a2f84b3	2021-06-18 03:58:00.421+07	2021-06-18 03:58:00.421+07
0ae11c5a-f2f0-4870-a712-c87fb118574b	05:00	05:30	206f98fa-34b7-4088-8e4f-b79a0a2f84b3	2021-06-18 03:58:00.424+07	2021-06-18 03:58:00.424+07
75b6af60-e482-406d-bef0-81fea954ebb9	03:00	03:30	8adf577e-cc0d-45e5-b236-05cd6d8d8413	2021-06-18 03:58:00.43+07	2021-06-18 03:58:00.43+07
e8de5535-3d40-4173-8089-e320b84c2233	05:30	06:00	8adf577e-cc0d-45e5-b236-05cd6d8d8413	2021-06-18 03:58:00.431+07	2021-06-18 03:58:00.431+07
faf554c1-cd8a-4ec8-8de1-2a2d9c7f813d	04:00	04:30	46629bf1-0f5c-4c66-ad9f-761291df2d15	2021-06-18 03:58:00.437+07	2021-06-18 03:58:00.437+07
b1b7e6d6-19a1-4114-81f8-f7d9f84d4e3e	02:00	02:30	7f0d7023-d5c0-489f-a651-ba549c8d6655	2021-06-18 03:58:00.444+07	2021-06-18 03:58:00.444+07
a5afba45-cfb3-452c-945d-1fb61d3a46a8	03:30	04:00	7f0d7023-d5c0-489f-a651-ba549c8d6655	2021-06-18 03:58:00.447+07	2021-06-18 03:58:00.447+07
252a4944-3108-4fab-a5c1-a1101e8533ff	02:00	02:30	c2645d1d-0cb2-4070-a62b-496e9e7ae92d	2021-06-18 03:58:00.451+07	2021-06-18 03:58:00.451+07
5ec1f867-e067-4ce0-a067-c33f44e63df7	04:30	05:00	c2645d1d-0cb2-4070-a62b-496e9e7ae92d	2021-06-18 03:58:00.452+07	2021-06-18 03:58:00.452+07
7b3a860f-fcc4-403a-99ed-8b3870dc1021	02:30	03:00	bd716ebe-4fbf-49dd-930b-db554c4de3e0	2021-06-18 03:58:00.456+07	2021-06-18 03:58:00.456+07
35735519-c560-45fd-a4e6-3ae1dba06686	05:30	06:00	bd716ebe-4fbf-49dd-930b-db554c4de3e0	2021-06-18 03:58:00.457+07	2021-06-18 03:58:00.457+07
0f431273-f2f8-48f9-a22f-9de178c375ec	05:30	06:00	508d99ca-79c4-40c5-b04d-e51e6fed7b53	2021-06-18 03:58:00.366+07	2021-06-18 03:58:00.366+07
afb2a73c-3a25-4d87-9d5a-c75dac1b0122	03:30	04:00	c070240f-7d97-4408-8e0e-88ee83823531	2021-06-18 03:58:00.371+07	2021-06-18 03:58:00.371+07
f9ec48e2-90d7-43c9-afbe-b6edba3895b9	06:00	06:30	c070240f-7d97-4408-8e0e-88ee83823531	2021-06-18 03:58:00.372+07	2021-06-18 03:58:00.372+07
0acff105-5b8a-4430-9801-b1353edbfd3c	04:30	05:00	c299fec6-bb03-4abb-8c0b-8e043d061cbd	2021-06-18 03:58:00.385+07	2021-06-18 03:58:00.385+07
b92d0bb7-a4cc-43bd-bf5b-d202cc873017	02:30	03:00	5d401606-cab4-4ac3-8e43-88248ed22de0	2021-06-18 03:58:00.397+07	2021-06-18 03:58:00.397+07
59784415-dca7-464d-ad49-f2611e56e45f	05:00	05:30	5d401606-cab4-4ac3-8e43-88248ed22de0	2021-06-18 03:58:00.398+07	2021-06-18 03:58:00.398+07
32fe71c3-9be1-4c62-8d7a-2898dd37de62	04:00	04:30	487827c8-6595-4671-8d4b-bf4a5119070f	2021-06-18 03:58:00.407+07	2021-06-18 03:58:00.407+07
ea071aca-1909-4752-b50a-6380fb4d4639	05:00	05:30	487827c8-6595-4671-8d4b-bf4a5119070f	2021-06-18 03:58:00.407+07	2021-06-18 03:58:00.407+07
28294093-1f09-4ed0-8b93-76777e6f40d2	03:00	03:30	76264bb3-fff3-4e6f-8d20-57b9a044212c	2021-06-18 03:58:00.415+07	2021-06-18 03:58:00.415+07
fa908351-00e9-4263-aa9a-f59b33b5d9f9	05:30	06:00	76264bb3-fff3-4e6f-8d20-57b9a044212c	2021-06-18 03:58:00.416+07	2021-06-18 03:58:00.416+07
414eb437-efd4-4677-978c-0c12f695782c	04:00	04:30	206f98fa-34b7-4088-8e4f-b79a0a2f84b3	2021-06-18 03:58:00.422+07	2021-06-18 03:58:00.422+07
45023494-e593-42ca-a46c-c1333d2e28cd	02:00	02:30	8adf577e-cc0d-45e5-b236-05cd6d8d8413	2021-06-18 03:58:00.43+07	2021-06-18 03:58:00.43+07
312b2b76-57df-48e3-be4e-a84fd6e3beb5	04:30	05:00	8adf577e-cc0d-45e5-b236-05cd6d8d8413	2021-06-18 03:58:00.431+07	2021-06-18 03:58:00.431+07
e1393958-f4dd-494d-ba33-10db994d0cbd	03:00	03:30	46629bf1-0f5c-4c66-ad9f-761291df2d15	2021-06-18 03:58:00.437+07	2021-06-18 03:58:00.437+07
c08e0da0-885d-453b-9558-0bb4795dfe2b	06:00	06:30	46629bf1-0f5c-4c66-ad9f-761291df2d15	2021-06-18 03:58:00.438+07	2021-06-18 03:58:00.438+07
f843970f-3213-4554-9afb-af5449f27d73	03:00	03:30	7f0d7023-d5c0-489f-a651-ba549c8d6655	2021-06-18 03:58:00.446+07	2021-06-18 03:58:00.446+07
b7c18760-20d4-405c-b3c5-5c702d2149cf	06:00	06:30	7f0d7023-d5c0-489f-a651-ba549c8d6655	2021-06-18 03:58:00.447+07	2021-06-18 03:58:00.447+07
8756a73c-6d74-4064-8d9d-e615a7dce4f8	04:00	04:30	c2645d1d-0cb2-4070-a62b-496e9e7ae92d	2021-06-18 03:58:00.452+07	2021-06-18 03:58:00.452+07
cd30b69f-1a32-4ff7-a3be-f289aa2c1fda	02:00	02:30	bd716ebe-4fbf-49dd-930b-db554c4de3e0	2021-06-18 03:58:00.456+07	2021-06-18 03:58:00.456+07
8198c309-b28b-4d8b-8f41-79199722f463	05:00	05:30	bd716ebe-4fbf-49dd-930b-db554c4de3e0	2021-06-18 03:58:00.457+07	2021-06-18 03:58:00.457+07
32de13e1-77d6-406c-9c46-a6a857ea6385	06:00	06:30	508d99ca-79c4-40c5-b04d-e51e6fed7b53	2021-06-18 03:58:00.366+07	2021-06-18 03:58:00.366+07
002ecdf1-77af-4181-b45f-1669a3261d45	04:00	04:30	c070240f-7d97-4408-8e0e-88ee83823531	2021-06-18 03:58:00.372+07	2021-06-18 03:58:00.372+07
4da37335-e0e7-4dc5-b433-1a107ce082ca	02:00	02:30	c299fec6-bb03-4abb-8c0b-8e043d061cbd	2021-06-18 03:58:00.383+07	2021-06-18 03:58:00.383+07
aec8b692-52d5-483e-87a0-c190529404be	03:30	04:00	c299fec6-bb03-4abb-8c0b-8e043d061cbd	2021-06-18 03:58:00.384+07	2021-06-18 03:58:00.384+07
e9d46fe2-b648-4c40-ba17-07336a9646f2	06:00	06:30	c299fec6-bb03-4abb-8c0b-8e043d061cbd	2021-06-18 03:58:00.385+07	2021-06-18 03:58:00.385+07
be7830e1-8c27-4836-bbf7-0bb00f77b5f3	04:00	04:30	5d401606-cab4-4ac3-8e43-88248ed22de0	2021-06-18 03:58:00.398+07	2021-06-18 03:58:00.398+07
355cd9ba-1f6c-4648-8b1f-f0973fc0549f	02:00	02:30	487827c8-6595-4671-8d4b-bf4a5119070f	2021-06-18 03:58:00.406+07	2021-06-18 03:58:00.406+07
3c3a47f1-508b-4e68-9cb0-7cf33212d03f	05:30	06:00	487827c8-6595-4671-8d4b-bf4a5119070f	2021-06-18 03:58:00.407+07	2021-06-18 03:58:00.407+07
1fd49d62-1cfe-4dae-9e89-b1755b0b9c44	03:30	04:00	76264bb3-fff3-4e6f-8d20-57b9a044212c	2021-06-18 03:58:00.415+07	2021-06-18 03:58:00.415+07
77be5d32-c895-470f-a66b-23b554900711	06:00	06:30	76264bb3-fff3-4e6f-8d20-57b9a044212c	2021-06-18 03:58:00.416+07	2021-06-18 03:58:00.416+07
2eceba20-39d0-4452-bc84-fdbd5525444b	03:00	03:30	206f98fa-34b7-4088-8e4f-b79a0a2f84b3	2021-06-18 03:58:00.422+07	2021-06-18 03:58:00.422+07
90a9ba9d-bd32-4fea-8d91-5b5b7677be4a	06:00	06:30	206f98fa-34b7-4088-8e4f-b79a0a2f84b3	2021-06-18 03:58:00.424+07	2021-06-18 03:58:00.424+07
3d412aca-24aa-4652-9b21-fe2cb97cca57	04:00	04:30	8adf577e-cc0d-45e5-b236-05cd6d8d8413	2021-06-18 03:58:00.431+07	2021-06-18 03:58:00.431+07
02fd1b8f-d9cd-44d8-bef4-06c3d20d9e98	02:30	03:00	46629bf1-0f5c-4c66-ad9f-761291df2d15	2021-06-18 03:58:00.437+07	2021-06-18 03:58:00.437+07
843a633d-6f65-445a-86e6-2dc8758f6482	05:00	05:30	46629bf1-0f5c-4c66-ad9f-761291df2d15	2021-06-18 03:58:00.438+07	2021-06-18 03:58:00.438+07
49ac5d62-3fff-42cb-83aa-96cba0509d73	04:30	05:00	7f0d7023-d5c0-489f-a651-ba549c8d6655	2021-06-18 03:58:00.447+07	2021-06-18 03:58:00.447+07
e0e667f0-ab5f-407c-a28d-6b8d3b21075a	05:30	06:00	7f0d7023-d5c0-489f-a651-ba549c8d6655	2021-06-18 03:58:00.447+07	2021-06-18 03:58:00.447+07
52744fc1-0957-41fe-9e72-c224632f7306	03:30	04:00	c2645d1d-0cb2-4070-a62b-496e9e7ae92d	2021-06-18 03:58:00.452+07	2021-06-18 03:58:00.452+07
8d21f593-e527-4a84-91dc-e9ebfafbdb25	06:00	06:30	c2645d1d-0cb2-4070-a62b-496e9e7ae92d	2021-06-18 03:58:00.452+07	2021-06-18 03:58:00.452+07
b7ce9a11-2fe6-4a1e-99c9-30fdcaaaa2f0	04:00	04:30	bd716ebe-4fbf-49dd-930b-db554c4de3e0	2021-06-18 03:58:00.457+07	2021-06-18 03:58:00.457+07
6478ebf2-7d2c-4e51-a0cf-f521073ad45a	04:30	05:00	bd716ebe-4fbf-49dd-930b-db554c4de3e0	2021-06-18 03:58:00.457+07	2021-06-18 03:58:00.457+07
b9ab3848-87d2-4e0c-942c-49f509bf8cd8	02:00	02:30	c070240f-7d97-4408-8e0e-88ee83823531	2021-06-18 03:58:00.371+07	2021-06-18 03:58:00.371+07
cc2c6a66-4688-4531-a7d0-04190dda4c52	04:30	05:00	c070240f-7d97-4408-8e0e-88ee83823531	2021-06-18 03:58:00.372+07	2021-06-18 03:58:00.372+07
9d57daa6-0dea-4868-a787-68c9092a2801	02:30	03:00	c299fec6-bb03-4abb-8c0b-8e043d061cbd	2021-06-18 03:58:00.384+07	2021-06-18 03:58:00.384+07
b5e95601-c087-4651-bdee-964d83084f0b	05:00	05:30	c299fec6-bb03-4abb-8c0b-8e043d061cbd	2021-06-18 03:58:00.385+07	2021-06-18 03:58:00.385+07
9b5c7388-dc8f-4a9b-9795-f1fa99b79b4b	03:00	03:30	5d401606-cab4-4ac3-8e43-88248ed22de0	2021-06-18 03:58:00.397+07	2021-06-18 03:58:00.397+07
df30d1f0-bf56-4ea0-bd03-28b03cfcf392	05:30	06:00	5d401606-cab4-4ac3-8e43-88248ed22de0	2021-06-18 03:58:00.399+07	2021-06-18 03:58:00.399+07
e5a35f68-3a9f-4f4d-aa0a-ea069f9e91fb	02:30	03:00	487827c8-6595-4671-8d4b-bf4a5119070f	2021-06-18 03:58:00.407+07	2021-06-18 03:58:00.407+07
562051ed-0d1b-4c43-9068-b1f9c6c02f6a	06:00	06:30	487827c8-6595-4671-8d4b-bf4a5119070f	2021-06-18 03:58:00.408+07	2021-06-18 03:58:00.408+07
10e742ad-5798-44ac-b19a-56e52583c8a6	04:00	04:30	76264bb3-fff3-4e6f-8d20-57b9a044212c	2021-06-18 03:58:00.416+07	2021-06-18 03:58:00.416+07
46463e58-850f-4a13-9a01-bf17680d676f	03:30	04:00	206f98fa-34b7-4088-8e4f-b79a0a2f84b3	2021-06-18 03:58:00.422+07	2021-06-18 03:58:00.422+07
64308f47-2206-4452-9478-e23b6de4fa77	04:30	05:00	206f98fa-34b7-4088-8e4f-b79a0a2f84b3	2021-06-18 03:58:00.423+07	2021-06-18 03:58:00.423+07
aa81e34f-a31c-406d-9aa2-376beb855bd5	02:30	03:00	8adf577e-cc0d-45e5-b236-05cd6d8d8413	2021-06-18 03:58:00.43+07	2021-06-18 03:58:00.43+07
23ad3789-7e6b-4b4a-96c3-12f17bde12d0	05:00	05:30	8adf577e-cc0d-45e5-b236-05cd6d8d8413	2021-06-18 03:58:00.431+07	2021-06-18 03:58:00.431+07
dc4f5491-5b2f-4997-9d0b-af6b9cda1aaf	06:00	06:30	8adf577e-cc0d-45e5-b236-05cd6d8d8413	2021-06-18 03:58:00.431+07	2021-06-18 03:58:00.431+07
e9392c6e-6228-4c4d-ae6c-b3d98b7a7bd3	03:30	04:00	46629bf1-0f5c-4c66-ad9f-761291df2d15	2021-06-18 03:58:00.437+07	2021-06-18 03:58:00.437+07
248b65cf-6f9e-4e61-9e61-7df48ca3cffa	05:30	06:00	46629bf1-0f5c-4c66-ad9f-761291df2d15	2021-06-18 03:58:00.438+07	2021-06-18 03:58:00.438+07
fcd6a894-a09e-41bf-b56b-0adb468cd6ba	05:00	05:30	7f0d7023-d5c0-489f-a651-ba549c8d6655	2021-06-18 03:58:00.447+07	2021-06-18 03:58:00.447+07
0c2668e9-be7e-4762-802b-6574a32f8274	03:00	03:30	c2645d1d-0cb2-4070-a62b-496e9e7ae92d	2021-06-18 03:58:00.451+07	2021-06-18 03:58:00.451+07
e0d39aab-eb33-4bd6-8022-53d4e7846def	05:30	06:00	c2645d1d-0cb2-4070-a62b-496e9e7ae92d	2021-06-18 03:58:00.452+07	2021-06-18 03:58:00.452+07
8f123667-2d78-4431-bdee-9ecabfaf72c2	03:30	04:00	bd716ebe-4fbf-49dd-930b-db554c4de3e0	2021-06-18 03:58:00.456+07	2021-06-18 03:58:00.456+07
0fd5e33c-1620-4428-b0db-c262f589045b	02:30	03:00	c070240f-7d97-4408-8e0e-88ee83823531	2021-06-18 03:58:00.371+07	2021-06-18 03:58:00.371+07
5e6d06ae-bc47-44c2-a69e-c262250a72d7	05:00	05:30	c070240f-7d97-4408-8e0e-88ee83823531	2021-06-18 03:58:00.372+07	2021-06-18 03:58:00.372+07
1f4ce5da-0143-4563-877a-ac4590d230ec	03:00	03:30	c299fec6-bb03-4abb-8c0b-8e043d061cbd	2021-06-18 03:58:00.384+07	2021-06-18 03:58:00.384+07
b36c63aa-a6f0-4db1-8b18-1f55b19a9f2b	05:30	06:00	c299fec6-bb03-4abb-8c0b-8e043d061cbd	2021-06-18 03:58:00.385+07	2021-06-18 03:58:00.385+07
23cf870f-55cf-4c08-8155-b5545b2634f1	03:30	04:00	5d401606-cab4-4ac3-8e43-88248ed22de0	2021-06-18 03:58:00.398+07	2021-06-18 03:58:00.398+07
73c7c5bb-853e-48cd-a3d0-120ef2f52fd0	06:00	06:30	5d401606-cab4-4ac3-8e43-88248ed22de0	2021-06-18 03:58:00.399+07	2021-06-18 03:58:00.399+07
851af7f3-5cb5-4ee9-965e-6d1c416e889a	03:00	03:30	487827c8-6595-4671-8d4b-bf4a5119070f	2021-06-18 03:58:00.407+07	2021-06-18 03:58:00.407+07
3ecc61fd-6978-48e4-998c-a8aeb2864adc	04:30	05:00	487827c8-6595-4671-8d4b-bf4a5119070f	2021-06-18 03:58:00.407+07	2021-06-18 03:58:00.407+07
dc1a5f3a-1a61-4866-b378-bde28f6af7d7	02:30	03:00	76264bb3-fff3-4e6f-8d20-57b9a044212c	2021-06-18 03:58:00.415+07	2021-06-18 03:58:00.415+07
2f192903-1b6e-4585-a8a4-8a9590d0932a	05:00	05:30	76264bb3-fff3-4e6f-8d20-57b9a044212c	2021-06-18 03:58:00.416+07	2021-06-18 03:58:00.416+07
9b96a0c2-2a20-4f4e-81ac-985bb475a3b3	02:30	03:00	206f98fa-34b7-4088-8e4f-b79a0a2f84b3	2021-06-18 03:58:00.422+07	2021-06-18 03:58:00.422+07
55208977-f850-466c-a5b5-2423f96df958	05:30	06:00	206f98fa-34b7-4088-8e4f-b79a0a2f84b3	2021-06-18 03:58:00.424+07	2021-06-18 03:58:00.424+07
300fea1e-f003-4fef-8da0-4e829c910760	03:30	04:00	8adf577e-cc0d-45e5-b236-05cd6d8d8413	2021-06-18 03:58:00.43+07	2021-06-18 03:58:00.43+07
29f5163f-d41b-4b66-b208-42f521fd56f7	02:00	02:30	46629bf1-0f5c-4c66-ad9f-761291df2d15	2021-06-18 03:58:00.437+07	2021-06-18 03:58:00.437+07
d11bc5cb-5fde-4292-9b6e-4313c0170727	04:30	05:00	46629bf1-0f5c-4c66-ad9f-761291df2d15	2021-06-18 03:58:00.437+07	2021-06-18 03:58:00.437+07
e0ded426-7bde-44ce-9fb9-d58dd2ef167b	02:30	03:00	7f0d7023-d5c0-489f-a651-ba549c8d6655	2021-06-18 03:58:00.444+07	2021-06-18 03:58:00.444+07
06f3caaa-6feb-4420-8b5e-5e491b28c869	04:00	04:30	7f0d7023-d5c0-489f-a651-ba549c8d6655	2021-06-18 03:58:00.447+07	2021-06-18 03:58:00.447+07
85d2e851-fa2c-4f7c-a9a3-6adb66092173	02:30	03:00	c2645d1d-0cb2-4070-a62b-496e9e7ae92d	2021-06-18 03:58:00.451+07	2021-06-18 03:58:00.451+07
65a9294a-0476-431d-82ba-a8673a2d7db0	05:00	05:30	c2645d1d-0cb2-4070-a62b-496e9e7ae92d	2021-06-18 03:58:00.452+07	2021-06-18 03:58:00.452+07
665f6a5b-aaa6-48cf-9ee2-433d533ba9ff	03:00	03:30	bd716ebe-4fbf-49dd-930b-db554c4de3e0	2021-06-18 03:58:00.456+07	2021-06-18 03:58:00.456+07
31ddee28-1998-418e-ad66-9494fb8ad616	06:00	06:30	bd716ebe-4fbf-49dd-930b-db554c4de3e0	2021-06-18 03:58:00.458+07	2021-06-18 03:58:00.458+07
456f1779-33a5-4afe-930d-4dece66f2cb7	20:00	20:30	d2c19572-4cc7-4dd8-b9ba-276b12dd5ad5	2021-06-18 03:58:15.385+07	2021-06-18 03:58:15.385+07
590efca2-cd71-4955-95be-42640969f350	20:30	21:00	d2c19572-4cc7-4dd8-b9ba-276b12dd5ad5	2021-06-18 03:58:15.385+07	2021-06-18 03:58:15.385+07
80dca739-4ef1-4f98-8468-62d1a06a4512	21:00	21:30	d2c19572-4cc7-4dd8-b9ba-276b12dd5ad5	2021-06-18 03:58:15.385+07	2021-06-18 03:58:15.385+07
e1757f5b-5cfa-49b6-9f54-f1a962cde00b	21:30	22:00	d2c19572-4cc7-4dd8-b9ba-276b12dd5ad5	2021-06-18 03:58:15.385+07	2021-06-18 03:58:15.385+07
ba26c23b-b2e4-46b8-bdfb-8a9280b2516f	06:30	07:00	d6bdd917-f917-422f-b6a4-27fd9c603b41	2021-06-18 03:58:36.915+07	2021-06-18 03:58:36.915+07
76a88379-9b07-4c7c-a608-7aab9fae98a4	07:00	07:30	d6bdd917-f917-422f-b6a4-27fd9c603b41	2021-06-18 03:58:36.915+07	2021-06-18 03:58:36.915+07
4f608953-b3eb-4c58-8588-738ce9bc9af1	07:30	08:00	d6bdd917-f917-422f-b6a4-27fd9c603b41	2021-06-18 03:58:36.916+07	2021-06-18 03:58:36.916+07
2997e125-4a58-444b-afc3-10d7c6cbce3f	20:00	20:30	8a395702-74be-4403-aa98-c86ff63ce9d2	2021-06-18 04:17:54.865+07	2021-06-18 04:17:54.865+07
b36752c9-121a-4e2d-b803-3662c7a0e5b6	20:30	21:00	8a395702-74be-4403-aa98-c86ff63ce9d2	2021-06-18 04:17:54.866+07	2021-06-18 04:17:54.866+07
92d67e12-bd5e-49f0-b8bc-afd9c7e1e5f7	20:00	20:30	27d98ad6-be29-4f76-a3ca-5c129ce4206d	2021-06-18 04:17:54.875+07	2021-06-18 04:17:54.875+07
0a33c865-0753-4b13-beda-f13c834575fd	20:30	21:00	27d98ad6-be29-4f76-a3ca-5c129ce4206d	2021-06-18 04:17:54.876+07	2021-06-18 04:17:54.876+07
acccf56e-acf5-4b94-a254-6b50d140f74b	20:00	20:30	56ae52aa-d2b1-4ccd-a49d-ed7b7f357b50	2021-06-18 04:17:54.88+07	2021-06-18 04:17:54.88+07
5fe4b421-05c2-4e0b-be0d-1aff98f51d60	20:00	20:30	04b68c42-41df-405d-96cb-1772c44abab2	2021-06-18 04:17:54.885+07	2021-06-18 04:17:54.885+07
ff503141-612c-407d-a078-a4591ffd7492	20:30	21:00	04b68c42-41df-405d-96cb-1772c44abab2	2021-06-18 04:17:54.885+07	2021-06-18 04:17:54.885+07
421c6525-9bfd-4c3f-b752-65f5662220e9	20:30	21:00	56ae52aa-d2b1-4ccd-a49d-ed7b7f357b50	2021-06-18 04:17:54.881+07	2021-06-18 04:17:54.881+07
b396bf77-2bbe-4c43-b6f7-a1db5362440e	20:00	20:30	95065f18-ab7e-40f0-ab41-10d9c8d8cbe3	2021-06-18 04:17:54.957+07	2021-06-18 04:17:54.957+07
5e9312d0-3649-4dfc-b8a3-9f22d7c01c13	20:30	21:00	95065f18-ab7e-40f0-ab41-10d9c8d8cbe3	2021-06-18 04:17:54.957+07	2021-06-18 04:17:54.957+07
f1169a4b-8900-4223-a982-323c2ea35882	20:00	20:30	3bbcce63-0bab-414e-9a6c-752a9c141a48	2021-06-18 04:17:55.05+07	2021-06-18 04:17:55.05+07
7627f1b0-e041-4eb4-be2d-1631de3b2d83	20:30	21:00	3bbcce63-0bab-414e-9a6c-752a9c141a48	2021-06-18 04:17:55.051+07	2021-06-18 04:17:55.051+07
ff0cfbaa-bde4-470b-9a74-f58427e77b73	20:00	20:30	97f20304-66e7-48db-9e76-1c260b896f10	2021-06-18 04:17:55.055+07	2021-06-18 04:17:55.055+07
bbaf5a5f-73eb-4c0e-9c1e-a657d32ed452	20:30	21:00	97f20304-66e7-48db-9e76-1c260b896f10	2021-06-18 04:17:55.056+07	2021-06-18 04:17:55.056+07
2c36dacc-113d-400f-815f-7e31fe699be0	20:00	20:30	73290c21-cd0f-45d1-aeb2-0a257b8fcdd6	2021-06-18 04:17:55.096+07	2021-06-18 04:17:55.096+07
6e9e886b-7fea-4310-9b43-10bb31b501ed	20:30	21:00	73290c21-cd0f-45d1-aeb2-0a257b8fcdd6	2021-06-18 04:17:55.096+07	2021-06-18 04:17:55.096+07
c6d2d534-bc19-4cb3-9605-7cdb99e4fa98	20:00	20:30	7781041f-7a06-451e-a4f5-483b97f0dbd9	2021-06-18 04:17:55.103+07	2021-06-18 04:17:55.103+07
33b4dc0a-7e8f-4a6b-a851-8ad4ca632654	20:30	21:00	7781041f-7a06-451e-a4f5-483b97f0dbd9	2021-06-18 04:17:55.103+07	2021-06-18 04:17:55.103+07
32e31c7a-be1d-4bfd-b332-6491695010cf	20:00	20:30	65a88372-bf76-46c0-ae0c-1b566b6a6523	2021-06-18 04:17:55.11+07	2021-06-18 04:17:55.11+07
216c77e1-49a8-44cb-bb66-c84350a0379b	20:30	21:00	65a88372-bf76-46c0-ae0c-1b566b6a6523	2021-06-18 04:17:55.11+07	2021-06-18 04:17:55.11+07
20106631-f1ec-4063-ae2a-cb20d166b04e	20:00	20:30	742462ea-55e5-42ad-99c2-d830ceba64f9	2021-06-18 04:17:55.113+07	2021-06-18 04:17:55.113+07
272f45c7-cd44-4a09-b691-49f337fc33f0	20:30	21:00	742462ea-55e5-42ad-99c2-d830ceba64f9	2021-06-18 04:17:55.114+07	2021-06-18 04:17:55.114+07
139b87fd-d04b-4d90-b03b-2e8ae15ad332	20:00	20:30	5a2a3737-1629-4000-ac26-3e52015911a9	2021-06-18 04:17:55.117+07	2021-06-18 04:17:55.117+07
44d295ef-b24c-4402-831f-3a8c893c0946	20:30	21:00	5a2a3737-1629-4000-ac26-3e52015911a9	2021-06-18 04:17:55.117+07	2021-06-18 04:17:55.117+07
7c38067a-3215-40da-bffb-50114d98efca	19:00	19:30	96f42007-3898-484d-a92c-3fed4b535675	2021-06-18 04:23:18.523+07	2021-06-18 04:23:18.523+07
8243bc71-73cb-461a-ae9d-5eecc5fbc443	19:30	20:00	96f42007-3898-484d-a92c-3fed4b535675	2021-06-18 04:23:18.523+07	2021-06-18 04:23:18.523+07
ad9e502d-b6a1-4fba-b0a0-be67424c556b	20:00	20:30	96f42007-3898-484d-a92c-3fed4b535675	2021-06-18 04:23:18.523+07	2021-06-18 04:23:18.523+07
c4c6e608-d843-4a10-9062-bd667ea49477	20:30	21:00	96f42007-3898-484d-a92c-3fed4b535675	2021-06-18 04:23:18.523+07	2021-06-18 04:23:18.523+07
005a0702-549c-46dd-aefc-00c9dbc101b0	21:30	22:00	e420f361-b484-49f9-beec-bb44cfb94950	2021-06-18 04:24:04.062+07	2021-06-18 04:24:04.062+07
6c601ce9-3817-432d-b308-039199329662	11:30	12:00	5c36b47d-f7a1-4f15-9a1f-5046ab0e7cca	2021-06-18 04:24:14.382+07	2021-06-18 04:24:14.382+07
1b44b3be-070a-4cb6-b71f-71a35b977516	10:00	10:30	5c36b47d-f7a1-4f15-9a1f-5046ab0e7cca	2021-06-18 04:24:14.381+07	2021-06-18 04:24:14.381+07
d94cff87-db00-43ca-b70f-2bbb9298f28c	11:00	11:30	5c36b47d-f7a1-4f15-9a1f-5046ab0e7cca	2021-06-18 04:24:14.382+07	2021-06-18 04:24:14.382+07
60153c64-5253-4539-a234-d6a9a08ade26	10:30	11:00	5c36b47d-f7a1-4f15-9a1f-5046ab0e7cca	2021-06-18 04:24:14.382+07	2021-06-18 04:24:14.382+07
30f7ab4d-5dbe-4604-b288-305aa48c58f6	16:00	16:30	5d42c94a-cd40-46b4-ab93-ecf8d64e6148	2021-06-18 04:24:23.27+07	2021-06-18 04:24:23.27+07
f19b59c7-1e02-4f1f-8307-cb16c1d2357d	16:30	17:00	5d42c94a-cd40-46b4-ab93-ecf8d64e6148	2021-06-18 04:24:23.27+07	2021-06-18 04:24:23.27+07
0b810680-deb5-48b5-99dc-fbeec338e521	16:00	16:30	8be4ef59-dd8d-4a5e-8eac-7fb06904ab21	2021-06-18 04:24:29.23+07	2021-06-18 04:24:29.23+07
05ea6904-fed1-4bae-9e2a-33c55f837a83	16:30	17:00	8be4ef59-dd8d-4a5e-8eac-7fb06904ab21	2021-06-18 04:24:29.231+07	2021-06-18 04:24:29.231+07
b6e5db0b-f266-4efa-a9da-d40b2802c2c2	16:00	16:30	a9da0030-ed1c-48dc-b1a5-e257b8942a61	2021-06-18 04:24:29.234+07	2021-06-18 04:24:29.234+07
e42b47aa-e707-45e8-92ce-db940c212e10	16:30	17:00	a9da0030-ed1c-48dc-b1a5-e257b8942a61	2021-06-18 04:24:29.234+07	2021-06-18 04:24:29.234+07
ee3781c4-f02a-4ac2-b8ff-58166364ecdb	16:00	16:30	5973837a-ef84-4768-a7db-8e7cc01fff2b	2021-06-18 04:24:29.237+07	2021-06-18 04:24:29.237+07
35a1f744-0528-4bed-aa60-f14df4e5f67b	16:30	17:00	5973837a-ef84-4768-a7db-8e7cc01fff2b	2021-06-18 04:24:29.239+07	2021-06-18 04:24:29.239+07
65a8d470-ad5d-4f3e-b2bb-cbdd45451f7f	16:00	16:30	0d53fa2b-2ddf-4a0a-a35d-ef3e3eae6dee	2021-06-18 04:24:29.242+07	2021-06-18 04:24:29.242+07
630b60e3-2470-4b19-8a66-4d2d61098cf7	16:30	17:00	0d53fa2b-2ddf-4a0a-a35d-ef3e3eae6dee	2021-06-18 04:24:29.242+07	2021-06-18 04:24:29.242+07
ee5686c9-4e30-4b1b-97c6-53819fbf67c1	16:00	16:30	2c2f7a7f-5ca7-404d-9b13-cc67c5c1594f	2021-06-18 04:24:29.245+07	2021-06-18 04:24:29.245+07
b6ae232c-3311-473e-a796-1bf904ae64fe	16:30	17:00	2c2f7a7f-5ca7-404d-9b13-cc67c5c1594f	2021-06-18 04:24:29.246+07	2021-06-18 04:24:29.246+07
764cba03-df9c-47d8-ada7-51b8c3d80cd1	16:00	16:30	3070e429-6a0f-4d81-8a90-08e5a6a8a93f	2021-06-18 04:24:29.248+07	2021-06-18 04:24:29.248+07
2a4ceb39-b330-487b-b030-e21e44e4ccbf	16:30	17:00	3070e429-6a0f-4d81-8a90-08e5a6a8a93f	2021-06-18 04:24:29.249+07	2021-06-18 04:24:29.249+07
7aeb42e9-6cd3-48b4-bde1-162ec793a19b	16:00	16:30	a0a6db58-7d7b-411a-866c-928b8d567e2d	2021-06-18 04:24:29.257+07	2021-06-18 04:24:29.257+07
acddfa98-c098-42ed-b545-089d464281d8	16:30	17:00	a0a6db58-7d7b-411a-866c-928b8d567e2d	2021-06-18 04:24:29.257+07	2021-06-18 04:24:29.257+07
2f0c374b-0c61-407b-a9da-076b136fa0e7	16:00	16:30	a6be3bd6-45fc-4607-b68b-21bfe9c952a4	2021-06-18 04:24:29.26+07	2021-06-18 04:24:29.26+07
84adbf4e-586e-46f7-822b-fa6656bbb8ec	16:30	17:00	a6be3bd6-45fc-4607-b68b-21bfe9c952a4	2021-06-18 04:24:29.261+07	2021-06-18 04:24:29.261+07
1c1e64ce-6cd0-4bea-a514-80540971cf9d	16:00	16:30	6d9a7509-0606-4dc2-b167-dcd19c369a5f	2021-06-18 04:24:29.263+07	2021-06-18 04:24:29.263+07
eb340ea1-5f96-4efd-9cfe-0b621b8ddb45	16:30	17:00	6d9a7509-0606-4dc2-b167-dcd19c369a5f	2021-06-18 04:24:29.264+07	2021-06-18 04:24:29.264+07
f0db7fae-ccdc-4ead-a2b2-8e3c66560130	17:00	17:30	c246c786-2023-4480-bc61-04ddc4833bab	2021-06-18 04:24:44.987+07	2021-06-18 04:24:44.987+07
96b7afc1-7378-422c-b253-822f4bc477f4	17:30	18:00	c246c786-2023-4480-bc61-04ddc4833bab	2021-06-18 04:24:44.988+07	2021-06-18 04:24:44.988+07
52c1170c-e468-40e7-a8d6-512ed6d8d155	18:00	18:30	c246c786-2023-4480-bc61-04ddc4833bab	2021-06-18 04:24:44.988+07	2021-06-18 04:24:44.988+07
afc13520-d7c6-434f-a2cb-6138506d719b	18:30	19:00	c246c786-2023-4480-bc61-04ddc4833bab	2021-06-18 04:24:44.988+07	2021-06-18 04:24:44.988+07
12a5a53f-23e6-451a-83ec-5e98a9ccaf16	17:00	17:30	6786506a-a9d8-40e1-8741-79957f256b7a	2021-06-18 04:24:44.991+07	2021-06-18 04:24:44.991+07
501b74af-02af-4374-a01e-8f409c446c6a	17:30	18:00	6786506a-a9d8-40e1-8741-79957f256b7a	2021-06-18 04:24:44.991+07	2021-06-18 04:24:44.991+07
5e2f89fb-db0f-4d0f-b362-a61fec86b1df	18:00	18:30	6786506a-a9d8-40e1-8741-79957f256b7a	2021-06-18 04:24:44.991+07	2021-06-18 04:24:44.991+07
d4488be3-7248-43d8-919f-f7da29bdb698	18:30	19:00	6786506a-a9d8-40e1-8741-79957f256b7a	2021-06-18 04:24:44.992+07	2021-06-18 04:24:44.992+07
8e77990d-8861-4485-9097-748a24b4a8e8	17:00	17:30	4a7c3903-9bba-49c6-a9e7-c928db59f3b8	2021-06-18 04:24:45.001+07	2021-06-18 04:24:45.001+07
d4d624a3-1460-48f5-80b1-5ae842feddd6	17:30	18:00	7b7b10b4-7b3e-4d15-bb47-908a123ca2b5	2021-06-18 04:24:45.006+07	2021-06-18 04:24:45.006+07
4da4d703-3b52-4f3e-89f8-a73cabb7f3cc	18:30	19:00	7b7b10b4-7b3e-4d15-bb47-908a123ca2b5	2021-06-18 04:24:45.007+07	2021-06-18 04:24:45.007+07
5aab674e-02d0-479f-9d40-b00dd61e0528	17:00	17:30	b12323be-f16e-4922-a813-6858ac5ca3c8	2021-06-18 04:24:45.019+07	2021-06-18 04:24:45.019+07
7d632f73-35e8-42c2-88fa-c5a9d3988ec7	18:30	19:00	b12323be-f16e-4922-a813-6858ac5ca3c8	2021-06-18 04:24:45.02+07	2021-06-18 04:24:45.02+07
8aa3d744-1879-4927-8f43-d9f8e84d374d	17:00	17:30	a0f12474-1162-4146-bed5-ae569ad3e7c2	2021-06-18 04:24:45.03+07	2021-06-18 04:24:45.03+07
df606969-76f7-4460-a6f2-e0d492177d46	17:30	18:00	a04bd4db-f3e5-49ee-a043-55ffa7418e64	2021-06-18 04:24:45.036+07	2021-06-18 04:24:45.036+07
8a6d898c-fd44-4d89-811f-731d0f9ffe6c	17:00	17:30	f2b6a571-e00e-442c-9297-30a85f81ef03	2021-06-18 04:24:44.996+07	2021-06-18 04:24:44.996+07
02a649c5-ca0c-4441-877d-eb34320aadc2	17:30	18:00	4a7c3903-9bba-49c6-a9e7-c928db59f3b8	2021-06-18 04:24:45.001+07	2021-06-18 04:24:45.001+07
6ea8c44a-893d-49c5-9922-c1ea0eb09b29	17:00	17:30	9fe61e91-7048-4607-9515-dae11265be07	2021-06-18 04:24:45.01+07	2021-06-18 04:24:45.01+07
81b5fb95-e6fd-43dc-91aa-1d8d8999f2c5	17:30	18:00	b12323be-f16e-4922-a813-6858ac5ca3c8	2021-06-18 04:24:45.019+07	2021-06-18 04:24:45.019+07
a66f0908-a5d0-4755-90da-3e198b58f6b6	17:00	17:30	759e2109-61ca-4df9-ba87-09fde7cad1fc	2021-06-18 04:24:45.025+07	2021-06-18 04:24:45.025+07
10b6ee22-9cad-493e-a240-52e748ba3155	17:30	18:00	a0f12474-1162-4146-bed5-ae569ad3e7c2	2021-06-18 04:24:45.03+07	2021-06-18 04:24:45.03+07
45e8661d-cb71-4af7-8837-c257b52084eb	18:00	18:30	a04bd4db-f3e5-49ee-a043-55ffa7418e64	2021-06-18 04:24:45.037+07	2021-06-18 04:24:45.037+07
a0353045-1fa1-43f0-a915-df4222d8b981	17:30	18:00	f2b6a571-e00e-442c-9297-30a85f81ef03	2021-06-18 04:24:44.996+07	2021-06-18 04:24:44.996+07
79392224-8755-45ef-90f7-7870a0cfa3c4	18:00	18:30	4a7c3903-9bba-49c6-a9e7-c928db59f3b8	2021-06-18 04:24:45.001+07	2021-06-18 04:24:45.001+07
3c4e478e-36f3-4670-95d1-4ade8e975750	17:30	18:00	9fe61e91-7048-4607-9515-dae11265be07	2021-06-18 04:24:45.012+07	2021-06-18 04:24:45.012+07
92942e32-6cbb-4eee-a425-d9a9e3bc6873	18:00	18:30	b12323be-f16e-4922-a813-6858ac5ca3c8	2021-06-18 04:24:45.019+07	2021-06-18 04:24:45.019+07
5bf26ccc-dbf1-4c60-9a93-81a11cea88ca	18:30	19:00	759e2109-61ca-4df9-ba87-09fde7cad1fc	2021-06-18 04:24:45.026+07	2021-06-18 04:24:45.026+07
bf5511d5-8e51-4ab6-8217-d8cb4bd74eb6	17:00	17:30	a04bd4db-f3e5-49ee-a043-55ffa7418e64	2021-06-18 04:24:45.036+07	2021-06-18 04:24:45.036+07
ecc6b91b-42e3-4789-842f-52a4112d737c	18:00	18:30	f2b6a571-e00e-442c-9297-30a85f81ef03	2021-06-18 04:24:44.997+07	2021-06-18 04:24:44.997+07
bfaa2a49-6d28-4042-8073-693a51d91c0f	18:30	19:00	4a7c3903-9bba-49c6-a9e7-c928db59f3b8	2021-06-18 04:24:45.002+07	2021-06-18 04:24:45.002+07
4a91e80f-7123-42a3-adc1-b7b4a35a56b8	18:00	18:30	9fe61e91-7048-4607-9515-dae11265be07	2021-06-18 04:24:45.012+07	2021-06-18 04:24:45.012+07
92e6cf4c-9c75-4404-aa28-7e751ef085e2	17:30	18:00	759e2109-61ca-4df9-ba87-09fde7cad1fc	2021-06-18 04:24:45.026+07	2021-06-18 04:24:45.026+07
d5e3ee9b-4525-4ae6-bb5a-14ac42daf28f	18:00	18:30	a0f12474-1162-4146-bed5-ae569ad3e7c2	2021-06-18 04:24:45.03+07	2021-06-18 04:24:45.03+07
d13ff5a3-3d69-4528-9e7c-2cde930758e4	18:30	19:00	a04bd4db-f3e5-49ee-a043-55ffa7418e64	2021-06-18 04:24:45.037+07	2021-06-18 04:24:45.037+07
9e9053fc-2a37-4a56-ada8-85af41e250b2	18:30	19:00	f2b6a571-e00e-442c-9297-30a85f81ef03	2021-06-18 04:24:44.997+07	2021-06-18 04:24:44.997+07
0694a3f7-1fac-4c1d-bb12-c8724548e4fb	17:00	17:30	7b7b10b4-7b3e-4d15-bb47-908a123ca2b5	2021-06-18 04:24:45.006+07	2021-06-18 04:24:45.006+07
52187acb-27ce-47f1-a402-fc5c452098ed	18:00	18:30	7b7b10b4-7b3e-4d15-bb47-908a123ca2b5	2021-06-18 04:24:45.007+07	2021-06-18 04:24:45.007+07
fc15d0f6-d457-4ef2-b432-d2e361fb4a59	18:30	19:00	9fe61e91-7048-4607-9515-dae11265be07	2021-06-18 04:24:45.012+07	2021-06-18 04:24:45.012+07
a1489cf4-3cb7-4772-8582-a78ad9782d44	18:00	18:30	759e2109-61ca-4df9-ba87-09fde7cad1fc	2021-06-18 04:24:45.026+07	2021-06-18 04:24:45.026+07
6b9824c8-e9df-4fb7-b0b9-92fedb3ebd58	18:30	19:00	a0f12474-1162-4146-bed5-ae569ad3e7c2	2021-06-18 04:24:45.031+07	2021-06-18 04:24:45.031+07
272d8892-7799-430b-9f9e-8cce753960fa	04:00	04:30	3da236f4-960c-4686-ac10-680020cfbbd4	2021-06-18 04:25:10.955+07	2021-06-18 04:25:10.955+07
75c7576d-0105-4c04-bfcd-2924b902b86b	04:30	05:00	3da236f4-960c-4686-ac10-680020cfbbd4	2021-06-18 04:25:10.955+07	2021-06-18 04:25:10.955+07
1d98134a-9ef4-462f-af17-e4b7e7431bda	10:00	10:30	dc40b46e-1746-4e1f-8544-a6a50752c49d	2021-06-18 04:25:50.996+07	2021-06-18 04:25:50.996+07
2a0d6a66-db24-4298-8d04-a7cdbe1d2e11	10:30	11:00	dc40b46e-1746-4e1f-8544-a6a50752c49d	2021-06-18 04:25:50.997+07	2021-06-18 04:25:50.997+07
9904d4eb-69ea-4421-b5ac-cd0e20af5d35	11:00	11:30	dc40b46e-1746-4e1f-8544-a6a50752c49d	2021-06-18 04:25:50.997+07	2021-06-18 04:25:50.997+07
b670236c-23ae-47c4-afd7-ec0099a9cb01	11:30	12:00	dc40b46e-1746-4e1f-8544-a6a50752c49d	2021-06-18 04:25:50.997+07	2021-06-18 04:25:50.997+07
1f3f79e2-4919-4f1b-950c-10c2b166e328	10:00	10:30	4f74849b-e534-4bc0-aa5d-65147e631e82	2021-06-18 04:25:51.001+07	2021-06-18 04:25:51.001+07
19c6a3fe-cc80-4ea3-ba22-7ff2d8b2e6ac	10:30	11:00	4f74849b-e534-4bc0-aa5d-65147e631e82	2021-06-18 04:25:51.001+07	2021-06-18 04:25:51.001+07
f403a469-768c-4d9b-aa3d-60c278cdc658	11:00	11:30	4f74849b-e534-4bc0-aa5d-65147e631e82	2021-06-18 04:25:51.001+07	2021-06-18 04:25:51.001+07
4e39a1be-7c38-457c-8058-7f670d95c55b	11:30	12:00	4f74849b-e534-4bc0-aa5d-65147e631e82	2021-06-18 04:25:51.002+07	2021-06-18 04:25:51.002+07
6f2f8b41-e019-46df-a7cf-9161290c9d04	10:00	10:30	4081b3cf-ea98-44b7-8b9d-e9e7d8f2049e	2021-06-18 04:25:51.006+07	2021-06-18 04:25:51.006+07
20471b3a-3103-461b-aa3f-c4fa2cbc9ba1	10:30	11:00	4081b3cf-ea98-44b7-8b9d-e9e7d8f2049e	2021-06-18 04:25:51.006+07	2021-06-18 04:25:51.006+07
f6cbec3e-9d1c-4175-8fb6-bbe58dd208b0	11:00	11:30	4081b3cf-ea98-44b7-8b9d-e9e7d8f2049e	2021-06-18 04:25:51.007+07	2021-06-18 04:25:51.007+07
c4ea8200-0892-4afe-80a3-5d336dfc1a31	11:30	12:00	4081b3cf-ea98-44b7-8b9d-e9e7d8f2049e	2021-06-18 04:25:51.007+07	2021-06-18 04:25:51.007+07
9b39400b-0748-4c41-a2d6-f8e570824efa	20:00	20:30	d98f3178-7bff-4ea0-b660-c37a9068b5fe	2021-06-18 04:26:26.606+07	2021-06-18 04:26:26.606+07
563867fa-821a-4746-9580-045e23507fa7	20:30	21:00	d98f3178-7bff-4ea0-b660-c37a9068b5fe	2021-06-18 04:26:26.606+07	2021-06-18 04:26:26.606+07
4576ae0c-49d2-46a6-a334-139f888498e1	21:00	21:30	d98f3178-7bff-4ea0-b660-c37a9068b5fe	2021-06-18 04:26:26.606+07	2021-06-18 04:26:26.606+07
3ed5fbeb-ce09-4ead-8a5e-d36631eebf9c	20:00	20:30	3bbe2bb7-5475-45fe-b165-48675bd8ccdb	2021-06-18 04:26:26.613+07	2021-06-18 04:26:26.613+07
6366f1b9-c789-4d93-bdc4-48bfe1387a9d	20:30	21:00	3bbe2bb7-5475-45fe-b165-48675bd8ccdb	2021-06-18 04:26:26.614+07	2021-06-18 04:26:26.614+07
a7109be3-4040-4ff3-957c-eca493fac0e7	21:00	21:30	3bbe2bb7-5475-45fe-b165-48675bd8ccdb	2021-06-18 04:26:26.614+07	2021-06-18 04:26:26.614+07
a34db3ab-ac9d-4e3c-a697-7c5e7e7a2d8b	21:30	22:00	15258116-cff8-412a-9bef-f040a4788e27	2021-06-18 04:26:49.622+07	2021-06-18 04:26:49.622+07
46f39c76-319f-4ed8-ae73-6c97be6429ce	22:00	22:30	15258116-cff8-412a-9bef-f040a4788e27	2021-06-18 04:26:49.622+07	2021-06-18 04:26:49.622+07
e1b856ab-aee7-49ab-a204-2f27fa9a7708	22:30	23:00	15258116-cff8-412a-9bef-f040a4788e27	2021-06-18 04:26:49.622+07	2021-06-18 04:26:49.622+07
90bf562e-0681-447b-8e55-69b2c0d0f47e	23:00	23:30	15258116-cff8-412a-9bef-f040a4788e27	2021-06-18 04:26:49.622+07	2021-06-18 04:26:49.622+07
21f0c7de-e08e-4bbf-8c85-ae7ae06bce96	21:30	22:00	7721a531-436a-417f-a85c-8b0c4e0101f6	2021-06-18 04:26:49.626+07	2021-06-18 04:26:49.626+07
959724e4-bbe8-489d-89f8-199bc0600568	22:00	22:30	7721a531-436a-417f-a85c-8b0c4e0101f6	2021-06-18 04:26:49.627+07	2021-06-18 04:26:49.627+07
f2eda4ac-6a40-4616-b1af-f218ccb03a7e	22:30	23:00	7721a531-436a-417f-a85c-8b0c4e0101f6	2021-06-18 04:26:49.627+07	2021-06-18 04:26:49.627+07
a15f5b16-5234-4c28-855b-c149aea5bce7	23:00	23:30	7721a531-436a-417f-a85c-8b0c4e0101f6	2021-06-18 04:26:49.627+07	2021-06-18 04:26:49.627+07
b05c2802-f6f5-4105-838e-4693cb74ac74	21:30	22:00	1e061300-ebae-4d56-966e-1cc63df0b1b1	2021-06-18 04:26:49.632+07	2021-06-18 04:26:49.632+07
141b9aff-4979-46db-a336-4c8a33d3e6ca	22:00	22:30	1e061300-ebae-4d56-966e-1cc63df0b1b1	2021-06-18 04:26:49.632+07	2021-06-18 04:26:49.632+07
bd035cc5-fecf-49e4-82fe-4647391eb405	22:30	23:00	1e061300-ebae-4d56-966e-1cc63df0b1b1	2021-06-18 04:26:49.634+07	2021-06-18 04:26:49.634+07
609331d2-5330-497a-aa79-1b33b4c818ba	23:00	23:30	1e061300-ebae-4d56-966e-1cc63df0b1b1	2021-06-18 04:26:49.634+07	2021-06-18 04:26:49.634+07
98abd853-7ab1-4313-b99e-751ffa40c38f	21:30	22:00	1f1b368e-141e-48ed-8853-7eae3f5490c0	2021-06-18 04:26:49.638+07	2021-06-18 04:26:49.638+07
1cc21abd-919a-4ab9-9192-5d9d4ba0b076	22:00	22:30	1f1b368e-141e-48ed-8853-7eae3f5490c0	2021-06-18 04:26:49.638+07	2021-06-18 04:26:49.638+07
1cb8f827-36f7-4892-ab13-c075b7508417	22:30	23:00	1f1b368e-141e-48ed-8853-7eae3f5490c0	2021-06-18 04:26:49.639+07	2021-06-18 04:26:49.639+07
40aa0231-1c37-451c-8fc3-ceab6459fbfe	23:00	23:30	1f1b368e-141e-48ed-8853-7eae3f5490c0	2021-06-18 04:26:49.639+07	2021-06-18 04:26:49.639+07
1a3fd2c7-ce62-45b6-a172-8eba27cb8e89	07:00	07:30	31583053-ad70-4e2e-91c5-03384e4433ca	2021-06-18 04:27:11.182+07	2021-06-18 04:27:11.182+07
e6eb5bf0-0de3-4f6b-af12-0bb20561b7d0	07:30	08:00	31583053-ad70-4e2e-91c5-03384e4433ca	2021-06-18 04:27:11.183+07	2021-06-18 04:27:11.183+07
84bd0a85-c8fd-4d99-b0f4-3fd635bc404c	08:00	08:30	31583053-ad70-4e2e-91c5-03384e4433ca	2021-06-18 04:27:11.183+07	2021-06-18 04:27:11.183+07
08e28f89-94c0-4c8a-8c82-556dcfb8bab8	08:30	09:00	31583053-ad70-4e2e-91c5-03384e4433ca	2021-06-18 04:27:11.183+07	2021-06-18 04:27:11.183+07
2131b6ce-3181-43a4-a323-191de8d898f1	16:00	16:30	45846148-deba-48c4-8235-a324b13f3143	2021-06-18 04:43:13.215+07	2021-06-18 04:43:13.215+07
fbe8a7ec-9149-44ae-a74a-a2722908250b	16:30	17:00	45846148-deba-48c4-8235-a324b13f3143	2021-06-18 04:43:13.216+07	2021-06-18 04:43:13.216+07
32afe02f-b97b-4178-a222-48aec4a4a4f4	17:00	17:30	45846148-deba-48c4-8235-a324b13f3143	2021-06-18 04:43:13.216+07	2021-06-18 04:43:13.216+07
b24430d1-8695-456e-b48a-8d37b107a70e	17:30	18:00	45846148-deba-48c4-8235-a324b13f3143	2021-06-18 04:43:13.216+07	2021-06-18 04:43:13.216+07
368bd1aa-27a8-49b4-b8e4-ec912618b0b2	16:00	16:30	65d206f4-4a92-4035-9bca-077f4cc2cce9	2021-06-18 04:43:13.219+07	2021-06-18 04:43:13.219+07
e48f32f5-dd83-4219-8c54-1656f4af01d1	16:30	17:00	65d206f4-4a92-4035-9bca-077f4cc2cce9	2021-06-18 04:43:13.219+07	2021-06-18 04:43:13.219+07
67e4df62-6f91-41eb-8d27-c6f1e773a6a8	17:00	17:30	65d206f4-4a92-4035-9bca-077f4cc2cce9	2021-06-18 04:43:13.22+07	2021-06-18 04:43:13.22+07
d147f3c0-488c-461a-84ae-07666f0a50ad	17:30	18:00	65d206f4-4a92-4035-9bca-077f4cc2cce9	2021-06-18 04:43:13.22+07	2021-06-18 04:43:13.22+07
6f80b8ad-1099-4be7-9122-2b11b1471d24	16:00	16:30	0a88e9eb-d3de-479d-bf9e-7ac64fce481f	2021-06-18 04:43:13.223+07	2021-06-18 04:43:13.223+07
f083a9b5-3d2d-40fb-8f24-3d5c102cc36b	16:30	17:00	0a88e9eb-d3de-479d-bf9e-7ac64fce481f	2021-06-18 04:43:13.223+07	2021-06-18 04:43:13.223+07
5355a78b-0d1e-4dc4-8df0-a5ec3efcbd21	17:00	17:30	0a88e9eb-d3de-479d-bf9e-7ac64fce481f	2021-06-18 04:43:13.223+07	2021-06-18 04:43:13.223+07
05298435-cc10-439d-af4c-7e52588f1177	17:30	18:00	0a88e9eb-d3de-479d-bf9e-7ac64fce481f	2021-06-18 04:43:13.223+07	2021-06-18 04:43:13.223+07
ae78dd3b-d1a6-40bf-b7d0-e76782c58785	16:00	16:30	46add844-d2c4-430a-b4b1-6e865ad783ac	2021-06-18 04:43:13.227+07	2021-06-18 04:43:13.227+07
3098b3cb-fc83-4c54-a6db-b88add2092b6	16:30	17:00	46add844-d2c4-430a-b4b1-6e865ad783ac	2021-06-18 04:43:13.228+07	2021-06-18 04:43:13.228+07
e872f4be-896c-499b-87b6-b91643f35388	17:00	17:30	46add844-d2c4-430a-b4b1-6e865ad783ac	2021-06-18 04:43:13.228+07	2021-06-18 04:43:13.228+07
4416b8f3-da37-4804-8706-252b4058dabf	17:30	18:00	46add844-d2c4-430a-b4b1-6e865ad783ac	2021-06-18 04:43:13.228+07	2021-06-18 04:43:13.228+07
dc5c73bc-0e86-44e4-967e-25ef8e20aaef	16:00	16:30	fcc3c8cf-28eb-4f78-bdbb-4366d8a3d8c9	2021-06-18 04:43:13.233+07	2021-06-18 04:43:13.233+07
dd577ca9-bf73-49e2-a30c-861680684061	16:30	17:00	fcc3c8cf-28eb-4f78-bdbb-4366d8a3d8c9	2021-06-18 04:43:13.233+07	2021-06-18 04:43:13.233+07
657e92ca-ceab-4c72-b80c-d702998e37b9	17:00	17:30	fcc3c8cf-28eb-4f78-bdbb-4366d8a3d8c9	2021-06-18 04:43:13.233+07	2021-06-18 04:43:13.233+07
e4580e63-a8dd-4e6d-bb8d-ebfd2b1d03c6	17:30	18:00	fcc3c8cf-28eb-4f78-bdbb-4366d8a3d8c9	2021-06-18 04:43:13.234+07	2021-06-18 04:43:13.234+07
b9e9c29d-a20a-48bf-97da-7964670f32a2	16:00	16:30	d5ad3f60-bcf9-449e-a8c1-e676c28e3ffc	2021-06-18 04:43:13.236+07	2021-06-18 04:43:13.236+07
22f6c4f8-c63f-47df-8de5-a62615afee00	16:30	17:00	d5ad3f60-bcf9-449e-a8c1-e676c28e3ffc	2021-06-18 04:43:13.237+07	2021-06-18 04:43:13.237+07
feb5079a-a84f-4822-9d1c-9cb0abd7ccba	17:00	17:30	d5ad3f60-bcf9-449e-a8c1-e676c28e3ffc	2021-06-18 04:43:13.237+07	2021-06-18 04:43:13.237+07
7527af5e-3645-4933-bfdc-fb115438b27a	17:30	18:00	d5ad3f60-bcf9-449e-a8c1-e676c28e3ffc	2021-06-18 04:43:13.237+07	2021-06-18 04:43:13.237+07
91353857-1aac-4f73-8297-3fcd7cdbe56c	16:00	16:30	42f80cc7-7703-4dd7-b696-423af34437a7	2021-06-18 04:43:13.239+07	2021-06-18 04:43:13.239+07
db25c5ec-4615-4060-bf1b-1da1fdca2a7e	16:30	17:00	42f80cc7-7703-4dd7-b696-423af34437a7	2021-06-18 04:43:13.24+07	2021-06-18 04:43:13.24+07
18cdae98-fdab-4713-ac1a-632dfc00ceaa	17:00	17:30	42f80cc7-7703-4dd7-b696-423af34437a7	2021-06-18 04:43:13.24+07	2021-06-18 04:43:13.24+07
a4befdd6-4f7f-41b4-827f-7d58f9d7a254	17:30	18:00	42f80cc7-7703-4dd7-b696-423af34437a7	2021-06-18 04:43:13.24+07	2021-06-18 04:43:13.24+07
fd107428-a071-4428-989f-1824e507ebc5	16:00	16:30	07f15f8c-4029-4715-a2e2-ae4f32295dd8	2021-06-18 04:43:13.243+07	2021-06-18 04:43:13.243+07
d57ef3c2-fe99-417e-a0ca-cd13e1dad49a	16:30	17:00	07f15f8c-4029-4715-a2e2-ae4f32295dd8	2021-06-18 04:43:13.243+07	2021-06-18 04:43:13.243+07
2df7a9d0-96f7-491f-9509-963510435c27	17:00	17:30	07f15f8c-4029-4715-a2e2-ae4f32295dd8	2021-06-18 04:43:13.243+07	2021-06-18 04:43:13.243+07
4893f0e2-2912-408d-9eb8-6dfd7d4c5ebd	17:30	18:00	07f15f8c-4029-4715-a2e2-ae4f32295dd8	2021-06-18 04:43:13.243+07	2021-06-18 04:43:13.243+07
a12abfc0-7fdf-4e71-9565-dee032bd096a	16:00	16:30	8b3f87a9-817a-4604-a8c2-e3b69c45c2b0	2021-06-18 04:43:13.247+07	2021-06-18 04:43:13.247+07
509e3312-2ccd-4ba5-881b-ae5bc4019194	16:30	17:00	8b3f87a9-817a-4604-a8c2-e3b69c45c2b0	2021-06-18 04:43:13.248+07	2021-06-18 04:43:13.248+07
3f9d9ad1-f650-4823-91af-aac824dad294	17:00	17:30	8b3f87a9-817a-4604-a8c2-e3b69c45c2b0	2021-06-18 04:43:13.248+07	2021-06-18 04:43:13.248+07
f35ac18d-58cc-4aeb-b995-e9c0d2b2745b	17:30	18:00	8b3f87a9-817a-4604-a8c2-e3b69c45c2b0	2021-06-18 04:43:13.248+07	2021-06-18 04:43:13.248+07
6e77bfe9-9918-4119-b7ca-259d36879f22	16:00	16:30	c28b7bd8-276e-4ad7-8b0f-e6a9e8ae14f8	2021-06-18 04:43:13.251+07	2021-06-18 04:43:13.251+07
68e135f5-78cf-463d-a619-202080a1a614	16:30	17:00	c28b7bd8-276e-4ad7-8b0f-e6a9e8ae14f8	2021-06-18 04:43:13.251+07	2021-06-18 04:43:13.251+07
d6cc5f8f-132e-4206-9e23-5107213573b8	17:00	17:30	c28b7bd8-276e-4ad7-8b0f-e6a9e8ae14f8	2021-06-18 04:43:13.251+07	2021-06-18 04:43:13.251+07
8d2748ee-d28f-4579-b48c-a1eee5b27951	17:30	18:00	c28b7bd8-276e-4ad7-8b0f-e6a9e8ae14f8	2021-06-18 04:43:13.252+07	2021-06-18 04:43:13.252+07
3f4063a7-7168-4103-97e6-c102e4e24850	16:00	16:30	1c8dd612-465c-40ac-b331-0d8ac743fb04	2021-06-18 04:43:13.254+07	2021-06-18 04:43:13.254+07
c1745536-7122-45bf-b811-681b7961dc66	16:30	17:00	1c8dd612-465c-40ac-b331-0d8ac743fb04	2021-06-18 04:43:13.254+07	2021-06-18 04:43:13.254+07
c61cc8d9-a981-4ddb-873e-73b77b8ff6be	17:00	17:30	1c8dd612-465c-40ac-b331-0d8ac743fb04	2021-06-18 04:43:13.254+07	2021-06-18 04:43:13.254+07
b5b4da49-0642-458e-a30b-f44f1bbeec82	17:30	18:00	d01d8472-dda7-4c10-9530-6bcf566a8f95	2021-06-18 04:43:13.258+07	2021-06-18 04:43:13.258+07
c0cc4441-0742-4a6f-bea9-b2f6bd526eb4	22:30	23:00	0aab4e61-24f9-44b7-be16-e459c3cc10ce	2021-06-18 04:43:26.443+07	2021-06-18 04:43:26.443+07
91ddf131-5636-4a65-a638-97d6b107c2f8	19:30	20:00	c695d922-d974-47ab-8794-1c3c4d99f41e	2021-06-18 04:43:36.363+07	2021-06-18 04:43:36.363+07
6f7ec208-27d0-48d1-ac7a-c4eeec41aab0	17:30	18:00	1c8dd612-465c-40ac-b331-0d8ac743fb04	2021-06-18 04:43:13.254+07	2021-06-18 04:43:13.254+07
3407bac1-6b55-4b0f-98de-2dbf2d3f94a9	16:00	16:30	d01d8472-dda7-4c10-9530-6bcf566a8f95	2021-06-18 04:43:13.257+07	2021-06-18 04:43:13.257+07
aaf150d2-6d57-4399-a138-5384a37d4ae4	16:30	17:00	d01d8472-dda7-4c10-9530-6bcf566a8f95	2021-06-18 04:43:13.257+07	2021-06-18 04:43:13.257+07
a41e8813-79af-42b4-996d-e4067809ff92	22:00	22:30	0aab4e61-24f9-44b7-be16-e459c3cc10ce	2021-06-18 04:43:26.443+07	2021-06-18 04:43:26.443+07
76766c13-19b2-4479-8aec-296893ff97b7	19:00	19:30	c695d922-d974-47ab-8794-1c3c4d99f41e	2021-06-18 04:43:36.363+07	2021-06-18 04:43:36.363+07
4f6cc090-f725-4c6d-8d25-0d7abe079474	17:00	17:30	d01d8472-dda7-4c10-9530-6bcf566a8f95	2021-06-18 04:43:13.258+07	2021-06-18 04:43:13.258+07
1b4bc78f-3738-4b2f-8bd1-06fe141f32bc	20:00	20:30	fd4a6c47-e3d7-4e74-87ad-40a59ddb02d4	2021-06-18 04:44:02.99+07	2021-06-18 04:44:02.99+07
eb30f7e2-9cbc-4d46-8f85-f1c9b9267d62	20:30	21:00	fd4a6c47-e3d7-4e74-87ad-40a59ddb02d4	2021-06-18 04:44:02.991+07	2021-06-18 04:44:02.991+07
9b001dc9-561d-49e7-b87d-a065691e1ee7	11:30	12:00	0bf20843-1928-49e5-9898-3247164b9428	2021-06-18 04:44:16.791+07	2021-06-18 04:44:16.791+07
dfe177d5-7898-4b57-aebd-397bbac82cf5	11:00	11:30	0bf20843-1928-49e5-9898-3247164b9428	2021-06-18 04:44:16.791+07	2021-06-18 04:44:16.791+07
87d0939e-ef97-486a-8524-a9f198883549	19:00	19:30	bc94b130-eea2-46f9-a638-1acf6e109a83	2021-06-18 04:46:51.299+07	2021-06-18 04:46:51.299+07
d2e32ccf-347a-4db4-b516-e96905ca329a	20:00	20:30	bc94b130-eea2-46f9-a638-1acf6e109a83	2021-06-18 04:46:51.299+07	2021-06-18 04:46:51.299+07
38ab9fad-23d8-4ea9-aa91-0818a025ca6e	19:30	20:00	bc94b130-eea2-46f9-a638-1acf6e109a83	2021-06-18 04:46:51.299+07	2021-06-18 04:46:51.299+07
1d1e355c-e216-42ed-a55f-7e99265ca18d	20:30	21:00	bc94b130-eea2-46f9-a638-1acf6e109a83	2021-06-18 04:46:51.299+07	2021-06-18 04:46:51.299+07
dc411056-e01b-4bd7-ad79-a1e905a27d4a	22:30	23:00	bb8be244-c8ad-4eff-bba0-8f6071942703	2021-06-18 04:47:00.265+07	2021-06-18 04:47:00.265+07
565fe860-04c5-4009-a152-d8372bec0bc3	22:00	22:30	bb8be244-c8ad-4eff-bba0-8f6071942703	2021-06-18 04:47:00.265+07	2021-06-18 04:47:00.265+07
5ba76b93-a1c7-4a1f-89ff-94388beed099	13:00	13:30	3d506609-2928-43f5-a849-e9d141bcb91e	2021-06-18 04:47:11.854+07	2021-06-18 04:47:11.854+07
c75a3f00-ca77-4742-8ddc-7163cfb3cd15	13:30	14:00	3d506609-2928-43f5-a849-e9d141bcb91e	2021-06-18 04:47:11.854+07	2021-06-18 04:47:11.854+07
bc4f034c-aff8-4c72-a6f1-f3156d386ea1	14:00	14:30	3d506609-2928-43f5-a849-e9d141bcb91e	2021-06-18 04:47:11.854+07	2021-06-18 04:47:11.854+07
f0ab6ead-3c90-4bd8-8c08-8adf346b4467	14:30	15:00	3d506609-2928-43f5-a849-e9d141bcb91e	2021-06-18 04:47:11.854+07	2021-06-18 04:47:11.854+07
7232c2f4-21c0-496f-a8bf-31a38a152840	09:00	09:30	2bf4da18-bced-47dc-8a31-6bbf9240fb7d	2021-06-18 04:47:31.776+07	2021-06-18 04:47:31.776+07
a9d39fc3-7787-4c14-928b-0e70686ca7ca	09:30	10:00	2bf4da18-bced-47dc-8a31-6bbf9240fb7d	2021-06-18 04:47:31.776+07	2021-06-18 04:47:31.776+07
da343862-52cd-4f62-b3c4-474fb18e7277	10:00	10:30	2bf4da18-bced-47dc-8a31-6bbf9240fb7d	2021-06-18 04:47:31.776+07	2021-06-18 04:47:31.776+07
a350348f-4ff1-426d-b23d-b06d4acbdf5c	10:30	11:00	2bf4da18-bced-47dc-8a31-6bbf9240fb7d	2021-06-18 04:47:31.776+07	2021-06-18 04:47:31.776+07
a159a6a6-897b-47cf-aeb9-56ae5b3a2738	09:00	09:30	92100587-5662-4797-b821-c13f0a63e60c	2021-06-18 04:47:31.781+07	2021-06-18 04:47:31.781+07
a2bf38a4-b3f6-4356-bad8-fac1e08be83e	09:30	10:00	92100587-5662-4797-b821-c13f0a63e60c	2021-06-18 04:47:31.781+07	2021-06-18 04:47:31.781+07
d45b20f1-e945-437e-9394-29d66b2e0bca	10:00	10:30	92100587-5662-4797-b821-c13f0a63e60c	2021-06-18 04:47:31.781+07	2021-06-18 04:47:31.781+07
e57a9962-2683-4e5a-b868-c5a577ff28f8	10:30	11:00	92100587-5662-4797-b821-c13f0a63e60c	2021-06-18 04:47:31.781+07	2021-06-18 04:47:31.781+07
db47da29-9c38-440a-be71-2f4dc29bcafc	09:00	09:30	e6cf4fd3-08a9-446d-806d-153d98be54c3	2021-06-18 04:47:31.787+07	2021-06-18 04:47:31.787+07
4742d18e-246e-45ec-9751-ac5a4d65c342	09:30	10:00	e6cf4fd3-08a9-446d-806d-153d98be54c3	2021-06-18 04:47:31.787+07	2021-06-18 04:47:31.787+07
5251eb2f-21e4-4478-83af-5b7f26e95248	10:00	10:30	e6cf4fd3-08a9-446d-806d-153d98be54c3	2021-06-18 04:47:31.787+07	2021-06-18 04:47:31.787+07
e7f34a62-e37f-47a2-b294-7daf74305fed	10:30	11:00	e6cf4fd3-08a9-446d-806d-153d98be54c3	2021-06-18 04:47:31.788+07	2021-06-18 04:47:31.788+07
611fb799-a996-4a6c-a296-fa7b954c1c77	14:00	14:30	dd8df5e1-0cae-4101-8ceb-aa753ec8a4da	2021-06-18 04:47:49.074+07	2021-06-18 04:47:49.074+07
e6144f90-8452-4b47-886c-2497b0479542	14:30	15:00	dd8df5e1-0cae-4101-8ceb-aa753ec8a4da	2021-06-18 04:47:49.074+07	2021-06-18 04:47:49.074+07
587ac348-fa17-405f-bcc4-efe2a2c126cf	07:00	07:30	397c251d-fb0e-41a1-8fa3-2e6916f4882f	2021-06-18 04:48:08.579+07	2021-06-18 04:48:08.579+07
cbc3ce89-ee6e-4460-837d-df8051842523	07:30	08:00	397c251d-fb0e-41a1-8fa3-2e6916f4882f	2021-06-18 04:48:08.579+07	2021-06-18 04:48:08.579+07
bedfc3b4-5ba6-459a-8d47-09c1aab6d3f6	07:00	07:30	6682c067-7daa-412b-82dc-cbcb0375c21b	2021-06-18 04:48:08.582+07	2021-06-18 04:48:08.582+07
7d4fbe1c-69cd-4daf-b0eb-2865d67e05dd	07:00	07:30	d84e3c6f-df86-47cb-826d-1f1bed2c4a0e	2021-06-18 04:48:08.674+07	2021-06-18 04:48:08.674+07
118434cc-11bd-428b-abc5-6ad9a3d81a17	07:30	08:00	d84e3c6f-df86-47cb-826d-1f1bed2c4a0e	2021-06-18 04:48:08.674+07	2021-06-18 04:48:08.674+07
e937b8df-1cfd-4ced-b8d9-101564d8558b	07:30	08:00	6682c067-7daa-412b-82dc-cbcb0375c21b	2021-06-18 04:48:08.582+07	2021-06-18 04:48:08.582+07
0617fae0-33c8-4133-808a-57677bba16f7	07:00	07:30	fb342fe6-ccd8-447b-9fb7-64ddf0e8d4ca	2021-06-18 04:48:08.733+07	2021-06-18 04:48:08.733+07
ab3e1483-2a90-4050-a2be-487328c6bd7f	07:30	08:00	fb342fe6-ccd8-447b-9fb7-64ddf0e8d4ca	2021-06-18 04:48:08.733+07	2021-06-18 04:48:08.733+07
6bff9f67-40b7-490e-9244-f07db8196ed7	07:00	07:30	bca5a9e9-413f-4460-9c4b-e6c507a23b66	2021-06-18 04:48:08.739+07	2021-06-18 04:48:08.739+07
28471dc8-f8cb-40a0-b7da-16e83929b463	07:30	08:00	bca5a9e9-413f-4460-9c4b-e6c507a23b66	2021-06-18 04:48:08.739+07	2021-06-18 04:48:08.739+07
afd92be7-e816-47a9-b303-09e5e33b53d3	07:00	07:30	0e3178f5-02d7-4f33-b1d7-a674ce1dd7c8	2021-06-18 04:48:08.749+07	2021-06-18 04:48:08.749+07
2736d13d-e36f-47eb-b531-9ce289beaf38	07:30	08:00	0e3178f5-02d7-4f33-b1d7-a674ce1dd7c8	2021-06-18 04:48:08.75+07	2021-06-18 04:48:08.75+07
3a68fc8d-c6e1-4946-a646-3adb2f6ba7c2	07:00	07:30	08c2e5a8-4c84-45be-89e5-ec7ba878cc02	2021-06-18 04:48:08.756+07	2021-06-18 04:48:08.756+07
add8b189-7795-4a9c-a21b-149c30a37632	07:30	08:00	08c2e5a8-4c84-45be-89e5-ec7ba878cc02	2021-06-18 04:48:08.756+07	2021-06-18 04:48:08.756+07
91384f9f-20f7-4228-8d7a-56fa09b3133d	07:00	07:30	f3e04d82-cc17-4d52-a267-91fffc45400f	2021-06-18 04:48:08.764+07	2021-06-18 04:48:08.764+07
51701ab8-7b36-4fd9-a0c9-0cd3372e6d2c	07:30	08:00	f3e04d82-cc17-4d52-a267-91fffc45400f	2021-06-18 04:48:08.764+07	2021-06-18 04:48:08.764+07
dd402d17-223a-416c-83bb-ae93b69bdad3	07:00	07:30	33bfc837-666b-413e-98f4-504ee86f2808	2021-06-18 04:56:50.527+07	2021-06-18 04:56:50.527+07
b714b8bd-2239-4c44-a0b1-a9c94ccece98	08:00	08:30	33bfc837-666b-413e-98f4-504ee86f2808	2021-06-18 04:56:50.528+07	2021-06-18 04:56:50.528+07
dec7bbca-0b22-4107-aba6-43907a4616fc	07:30	08:00	33bfc837-666b-413e-98f4-504ee86f2808	2021-06-18 04:56:50.528+07	2021-06-18 04:56:50.528+07
a10b7a92-2267-4e03-bf94-a955b6d73048	07:00	07:30	e20fce8f-6a3f-492a-b457-bfb550aa706f	2021-06-18 04:56:50.533+07	2021-06-18 04:56:50.533+07
c450050d-f1d7-4e09-9ea7-2829b54e1059	07:30	08:00	e20fce8f-6a3f-492a-b457-bfb550aa706f	2021-06-18 04:56:50.533+07	2021-06-18 04:56:50.533+07
d3bfa3e6-bad9-4c53-a27c-469cd34a9173	08:30	09:00	33bfc837-666b-413e-98f4-504ee86f2808	2021-06-18 04:56:50.528+07	2021-06-18 04:56:50.528+07
2eafb512-30df-4eb4-9cc4-71b285fe7cbd	08:00	08:30	e20fce8f-6a3f-492a-b457-bfb550aa706f	2021-06-18 04:56:50.533+07	2021-06-18 04:56:50.533+07
1b4814e9-9622-4209-9167-3d8d22a68da9	08:30	09:00	e20fce8f-6a3f-492a-b457-bfb550aa706f	2021-06-18 04:56:50.533+07	2021-06-18 04:56:50.533+07
717f18d1-82d5-4c2d-a588-828d85abeaa6	07:00	07:30	bd1a8d26-84e0-4b1f-a840-46395fb0bce7	2021-06-18 04:56:50.54+07	2021-06-18 04:56:50.54+07
5ce95e29-0c2f-47dc-9314-09156c64d017	07:30	08:00	bd1a8d26-84e0-4b1f-a840-46395fb0bce7	2021-06-18 04:56:50.54+07	2021-06-18 04:56:50.54+07
5a5eb86c-19a1-43ca-aa7e-3737c1040e5d	08:00	08:30	bd1a8d26-84e0-4b1f-a840-46395fb0bce7	2021-06-18 04:56:50.54+07	2021-06-18 04:56:50.54+07
b618de16-d038-48b5-92a3-42881781919d	08:30	09:00	bd1a8d26-84e0-4b1f-a840-46395fb0bce7	2021-06-18 04:56:50.541+07	2021-06-18 04:56:50.541+07
6e74c503-8648-4d2b-b73e-7a97d96634cf	07:00	07:30	40d6b009-577c-440d-86e3-bacdf9b0a562	2021-06-18 04:56:50.565+07	2021-06-18 04:56:50.565+07
77c426bc-02b0-44d5-b6df-7cce61314181	07:30	08:00	40d6b009-577c-440d-86e3-bacdf9b0a562	2021-06-18 04:56:50.566+07	2021-06-18 04:56:50.566+07
f8da4a17-568e-4379-9b5d-8f9b6ad41985	08:00	08:30	40d6b009-577c-440d-86e3-bacdf9b0a562	2021-06-18 04:56:50.566+07	2021-06-18 04:56:50.566+07
734459be-9fc4-48e7-b6dd-dec35fa96d8a	08:30	09:00	40d6b009-577c-440d-86e3-bacdf9b0a562	2021-06-18 04:56:50.566+07	2021-06-18 04:56:50.566+07
6c42d049-beac-4e3a-9586-6bb4b5cb57e0	07:00	07:30	d77434fd-bc7e-4737-8100-cb8063b1b993	2021-06-18 04:56:50.578+07	2021-06-18 04:56:50.578+07
11576e68-469c-4e70-9027-8376264a58d4	07:30	08:00	d77434fd-bc7e-4737-8100-cb8063b1b993	2021-06-18 04:56:50.579+07	2021-06-18 04:56:50.579+07
b1e39b12-1946-44b0-863a-1fbaa37cc60c	08:00	08:30	d77434fd-bc7e-4737-8100-cb8063b1b993	2021-06-18 04:56:50.579+07	2021-06-18 04:56:50.579+07
b5df92cb-f0c7-4223-bb25-807abe5987f7	08:30	09:00	d77434fd-bc7e-4737-8100-cb8063b1b993	2021-06-18 04:56:50.579+07	2021-06-18 04:56:50.579+07
0c75315e-6007-4445-89d8-f50f203e3351	07:00	07:30	8451cfae-cb9b-414e-bade-d82727d23fde	2021-06-18 04:56:50.584+07	2021-06-18 04:56:50.584+07
44add37c-1a6b-4977-8c4d-431f7014e3e5	07:30	08:00	8451cfae-cb9b-414e-bade-d82727d23fde	2021-06-18 04:56:50.584+07	2021-06-18 04:56:50.584+07
8fb4f2aa-5224-4b5a-928e-41934d2b4e25	08:00	08:30	8451cfae-cb9b-414e-bade-d82727d23fde	2021-06-18 04:56:50.585+07	2021-06-18 04:56:50.585+07
15e15162-8967-49a0-96ca-aa6294373ba8	08:30	09:00	8451cfae-cb9b-414e-bade-d82727d23fde	2021-06-18 04:56:50.585+07	2021-06-18 04:56:50.585+07
acd8d152-97d6-4487-9acd-dcd25812fe51	07:00	07:30	31e3b099-50b0-4830-96eb-fc725e8fc329	2021-06-18 04:56:50.686+07	2021-06-18 04:56:50.686+07
9c2f035a-6cbc-4dc0-907f-e8a94b19e6e5	07:30	08:00	31e3b099-50b0-4830-96eb-fc725e8fc329	2021-06-18 04:56:50.686+07	2021-06-18 04:56:50.686+07
e6b70ab3-70eb-487c-9f1a-8924df0315f3	08:00	08:30	31e3b099-50b0-4830-96eb-fc725e8fc329	2021-06-18 04:56:50.686+07	2021-06-18 04:56:50.686+07
f8ce64a6-7048-4c40-9f02-fd166ce0deca	08:30	09:00	31e3b099-50b0-4830-96eb-fc725e8fc329	2021-06-18 04:56:50.687+07	2021-06-18 04:56:50.687+07
98a2dc7f-7d20-416f-abc6-896326cc88cb	07:00	07:30	a6a1a059-6f9b-4b48-8dfc-b32a09ee481e	2021-06-18 04:56:50.755+07	2021-06-18 04:56:50.755+07
46d40333-b1c7-43b9-992f-50325c8e0709	07:30	08:00	a6a1a059-6f9b-4b48-8dfc-b32a09ee481e	2021-06-18 04:56:50.755+07	2021-06-18 04:56:50.755+07
b69fdd4a-458d-4625-8336-b18e546694c3	08:00	08:30	a6a1a059-6f9b-4b48-8dfc-b32a09ee481e	2021-06-18 04:56:50.755+07	2021-06-18 04:56:50.755+07
43c7f56b-7919-44c3-9c25-7d3b9eb026b3	08:30	09:00	a6a1a059-6f9b-4b48-8dfc-b32a09ee481e	2021-06-18 04:56:50.757+07	2021-06-18 04:56:50.757+07
f7130072-c3a9-445e-a430-259b4f52c618	07:00	07:30	60f8f3a9-a8a0-43a3-bafa-c0757d482ab0	2021-06-18 04:56:50.865+07	2021-06-18 04:56:50.865+07
02cae9d7-2088-4e77-a67f-01194a43ed4b	07:30	08:00	60f8f3a9-a8a0-43a3-bafa-c0757d482ab0	2021-06-18 04:56:50.865+07	2021-06-18 04:56:50.865+07
f87e9e70-d3d6-4e2f-84e9-fd13af9215b5	08:00	08:30	60f8f3a9-a8a0-43a3-bafa-c0757d482ab0	2021-06-18 04:56:50.865+07	2021-06-18 04:56:50.865+07
23c73732-7a83-45d4-bc59-720dc3f0a363	08:30	09:00	60f8f3a9-a8a0-43a3-bafa-c0757d482ab0	2021-06-18 04:56:50.865+07	2021-06-18 04:56:50.865+07
ecb96561-6ca6-473e-a2b2-7968fae06969	07:00	07:30	c68f607e-f81f-429f-8039-6e4dc5098bbd	2021-06-18 04:56:50.87+07	2021-06-18 04:56:50.87+07
e12ceb07-1b8d-4910-8b16-151656638f2d	07:30	08:00	c68f607e-f81f-429f-8039-6e4dc5098bbd	2021-06-18 04:56:50.87+07	2021-06-18 04:56:50.87+07
8437b607-37d7-49a9-8edd-b09bc82b2e0e	08:00	08:30	c68f607e-f81f-429f-8039-6e4dc5098bbd	2021-06-18 04:56:50.87+07	2021-06-18 04:56:50.87+07
bf82b52c-7ef2-4be3-baf9-ab8dacd08f6e	08:30	09:00	c68f607e-f81f-429f-8039-6e4dc5098bbd	2021-06-18 04:56:50.871+07	2021-06-18 04:56:50.871+07
da70f011-f787-41a0-88b2-2dceac46af6c	07:00	07:30	7bd6d638-bbab-4764-903b-57d61127855d	2021-06-18 04:56:50.876+07	2021-06-18 04:56:50.876+07
bbde219e-ea3c-4a04-ad92-b6741c337b17	07:30	08:00	7bd6d638-bbab-4764-903b-57d61127855d	2021-06-18 04:56:50.876+07	2021-06-18 04:56:50.876+07
b75299d8-98e4-41db-a617-9b48565d6460	08:00	08:30	7bd6d638-bbab-4764-903b-57d61127855d	2021-06-18 04:56:50.876+07	2021-06-18 04:56:50.876+07
f6fe4cdc-0141-4202-a24d-9020348fd2b7	08:30	09:00	7bd6d638-bbab-4764-903b-57d61127855d	2021-06-18 04:56:50.876+07	2021-06-18 04:56:50.876+07
88f26cae-e914-4027-bd68-3c64c3dafe30	07:00	07:30	b2c6b0bb-c6c9-471f-a262-31f9c6fa2ab6	2021-06-18 04:56:50.887+07	2021-06-18 04:56:50.887+07
f1a915be-fa2e-4185-b914-be2a769b4b71	07:00	07:30	0368487a-53b7-4b0f-aafd-edaed78df01b	2021-06-18 04:56:50.88+07	2021-06-18 04:56:50.88+07
8481cb06-d83e-4bf8-9e18-c6063b614fce	07:30	08:00	b2c6b0bb-c6c9-471f-a262-31f9c6fa2ab6	2021-06-18 04:56:50.887+07	2021-06-18 04:56:50.887+07
a1dce5a8-688f-40be-a67f-3e95df96282d	21:00	21:30	d37f57c7-270b-42d4-bd17-5984218d698a	2021-06-18 04:57:01.14+07	2021-06-18 04:57:01.14+07
819af493-3957-4db6-be46-457046a6400e	07:30	08:00	0368487a-53b7-4b0f-aafd-edaed78df01b	2021-06-18 04:56:50.88+07	2021-06-18 04:56:50.88+07
a6545b8b-4309-4ea9-8e13-79eb8de27e3d	08:00	08:30	b2c6b0bb-c6c9-471f-a262-31f9c6fa2ab6	2021-06-18 04:56:50.888+07	2021-06-18 04:56:50.888+07
9788f012-87c0-41fa-bd26-fe51e7bdaf88	21:30	22:00	d37f57c7-270b-42d4-bd17-5984218d698a	2021-06-18 04:57:01.14+07	2021-06-18 04:57:01.14+07
bd5a83dd-468f-4b8a-a333-06cc2e57ddc2	08:00	08:30	0368487a-53b7-4b0f-aafd-edaed78df01b	2021-06-18 04:56:50.88+07	2021-06-18 04:56:50.88+07
6a8053d3-b7e9-475a-9087-b168fb90e5a4	08:30	09:00	b2c6b0bb-c6c9-471f-a262-31f9c6fa2ab6	2021-06-18 04:56:50.888+07	2021-06-18 04:56:50.888+07
fa510123-236b-4dfb-b271-0f7e708adb2d	08:30	09:00	0368487a-53b7-4b0f-aafd-edaed78df01b	2021-06-18 04:56:50.881+07	2021-06-18 04:56:50.881+07
949a9d7d-a4a2-4b79-a756-bd3971cf62b4	16:00	16:30	0ec70a75-bfa6-4ad2-8922-e2b8ec45b58f	2021-06-18 04:57:10.951+07	2021-06-18 04:57:10.951+07
813cbb93-b8cf-4310-ab1a-df50612b8ac8	16:30	17:00	0ec70a75-bfa6-4ad2-8922-e2b8ec45b58f	2021-06-18 04:57:10.951+07	2021-06-18 04:57:10.951+07
0e11d3bf-1114-4b58-b7ae-c5b255c78a6c	17:00	17:30	32d73b5e-a57a-449f-a3c3-ac181d5971f9	2021-06-18 04:57:22.136+07	2021-06-18 04:57:22.136+07
b1970a9f-8cb9-40d1-816b-604aed15ce92	17:30	18:00	32d73b5e-a57a-449f-a3c3-ac181d5971f9	2021-06-18 04:57:22.136+07	2021-06-18 04:57:22.136+07
cfb3caab-b32b-4942-b2b1-d9e721996526	08:00	08:30	90bcd78c-86f4-4c25-862e-43b9012161cb	2021-06-18 04:59:17.513+07	2021-06-18 04:59:17.513+07
bb01075b-1786-4f1e-b5fb-df7129289def	08:30	09:00	90bcd78c-86f4-4c25-862e-43b9012161cb	2021-06-18 04:59:17.514+07	2021-06-18 04:59:17.514+07
e2a74570-851e-48a8-ac2c-04d76c87835c	09:00	09:30	90bcd78c-86f4-4c25-862e-43b9012161cb	2021-06-18 04:59:17.514+07	2021-06-18 04:59:17.514+07
3f91ad67-71a6-4f05-9f6a-4ac1e723d924	08:00	08:30	5bc6e1f9-ee61-4061-a85f-46135b8ab19a	2021-06-18 04:59:17.521+07	2021-06-18 04:59:17.521+07
b412d86d-24f9-48ff-bc21-5eeef99a1529	09:30	10:00	90bcd78c-86f4-4c25-862e-43b9012161cb	2021-06-18 04:59:17.514+07	2021-06-18 04:59:17.514+07
f21aeb4c-7b78-4b5d-a16b-662d270b1cbe	08:30	09:00	5bc6e1f9-ee61-4061-a85f-46135b8ab19a	2021-06-18 04:59:17.522+07	2021-06-18 04:59:17.522+07
c8cd2913-d4a9-4538-972b-49aa635ce5f2	09:00	09:30	5bc6e1f9-ee61-4061-a85f-46135b8ab19a	2021-06-18 04:59:17.522+07	2021-06-18 04:59:17.522+07
f53b98bb-fc36-4b0a-99ec-5bf1211f2bfa	09:30	10:00	5bc6e1f9-ee61-4061-a85f-46135b8ab19a	2021-06-18 04:59:17.522+07	2021-06-18 04:59:17.522+07
229a3656-f805-487f-8fb0-f5fd8a2d3570	08:00	08:30	280e0c9c-6c41-4f7a-9d2c-878de4651882	2021-06-18 04:59:17.526+07	2021-06-18 04:59:17.526+07
8f7bb808-6477-4968-a2a7-4daa633b3cd9	08:30	09:00	280e0c9c-6c41-4f7a-9d2c-878de4651882	2021-06-18 04:59:17.526+07	2021-06-18 04:59:17.526+07
8dad0f31-aef8-4a53-92c8-9515b4cf48c1	09:00	09:30	280e0c9c-6c41-4f7a-9d2c-878de4651882	2021-06-18 04:59:17.527+07	2021-06-18 04:59:17.527+07
7834f928-7fd9-4122-a8f7-60235ea647ba	09:30	10:00	280e0c9c-6c41-4f7a-9d2c-878de4651882	2021-06-18 04:59:17.527+07	2021-06-18 04:59:17.527+07
6b2f5d9b-2846-44ab-98a1-64550eb43458	08:00	08:30	41e64f87-6df6-4fed-bbf3-cb9bb6d3336e	2021-06-18 04:59:17.531+07	2021-06-18 04:59:17.531+07
fa17c568-79e4-427e-b520-0dd3c1f24378	08:30	09:00	41e64f87-6df6-4fed-bbf3-cb9bb6d3336e	2021-06-18 04:59:17.531+07	2021-06-18 04:59:17.531+07
8e426e30-ae3a-40ee-84df-65fab0bea81c	09:00	09:30	41e64f87-6df6-4fed-bbf3-cb9bb6d3336e	2021-06-18 04:59:17.531+07	2021-06-18 04:59:17.531+07
0ad3fcee-17dd-4b1f-8e48-d1595ab0b3a2	09:30	10:00	41e64f87-6df6-4fed-bbf3-cb9bb6d3336e	2021-06-18 04:59:17.532+07	2021-06-18 04:59:17.532+07
ea5ee766-d2e8-4762-8367-9502b69b6801	08:00	08:30	e1b242ed-70ec-4dd8-8b58-706dfc3e2460	2021-06-18 04:59:17.536+07	2021-06-18 04:59:17.536+07
8eb3423b-9e80-4006-8172-c26e6c69c006	08:30	09:00	e1b242ed-70ec-4dd8-8b58-706dfc3e2460	2021-06-18 04:59:17.536+07	2021-06-18 04:59:17.536+07
5022d2c5-a19b-4054-ad1f-0d6f25a49bfb	09:00	09:30	e1b242ed-70ec-4dd8-8b58-706dfc3e2460	2021-06-18 04:59:17.537+07	2021-06-18 04:59:17.537+07
e62048de-3171-4714-8fe4-67b9435a6593	09:30	10:00	e1b242ed-70ec-4dd8-8b58-706dfc3e2460	2021-06-18 04:59:17.537+07	2021-06-18 04:59:17.537+07
0f3b6385-dc1a-4e44-8fd1-52cd2d795d1b	08:00	08:30	122e04d7-9215-41fe-aab3-44dd358bc434	2021-06-18 04:59:17.543+07	2021-06-18 04:59:17.543+07
eedaec95-3230-4638-8fdf-712009b4dc2e	08:30	09:00	122e04d7-9215-41fe-aab3-44dd358bc434	2021-06-18 04:59:17.543+07	2021-06-18 04:59:17.543+07
e42dd41d-5c4d-4f53-a88e-ae774698d48b	09:00	09:30	122e04d7-9215-41fe-aab3-44dd358bc434	2021-06-18 04:59:17.544+07	2021-06-18 04:59:17.544+07
5ad7494f-0a63-42ff-a33d-568cdabaa7f3	09:30	10:00	122e04d7-9215-41fe-aab3-44dd358bc434	2021-06-18 04:59:17.544+07	2021-06-18 04:59:17.544+07
48dcfcb0-ffb0-49eb-8981-b065faad3fe1	08:00	08:30	2997aaa3-31bc-458e-941f-35c66c8e8aa8	2021-06-18 04:59:17.553+07	2021-06-18 04:59:17.553+07
6e1073ad-3594-47ff-908c-70fbff556eac	08:30	09:00	2997aaa3-31bc-458e-941f-35c66c8e8aa8	2021-06-18 04:59:17.554+07	2021-06-18 04:59:17.554+07
a401e434-8997-49c2-b4b3-47edc2fd0336	09:00	09:30	2997aaa3-31bc-458e-941f-35c66c8e8aa8	2021-06-18 04:59:17.554+07	2021-06-18 04:59:17.554+07
733c36af-0458-4eda-8995-a75045a1759d	09:30	10:00	2997aaa3-31bc-458e-941f-35c66c8e8aa8	2021-06-18 04:59:17.556+07	2021-06-18 04:59:17.556+07
cbfda459-bcef-4afe-b457-579f283d8e87	08:00	08:30	31ad59b0-67ff-46d3-a59c-9de3ea6403b5	2021-06-18 04:59:17.562+07	2021-06-18 04:59:17.562+07
c26b28d7-59aa-430d-9e75-e1f0eabafbb9	08:30	09:00	31ad59b0-67ff-46d3-a59c-9de3ea6403b5	2021-06-18 04:59:17.563+07	2021-06-18 04:59:17.563+07
b131586d-6723-460a-91f5-82e5cf65f3a9	09:00	09:30	31ad59b0-67ff-46d3-a59c-9de3ea6403b5	2021-06-18 04:59:17.563+07	2021-06-18 04:59:17.563+07
240a4720-ee94-479c-9ad7-2044ada74963	09:30	10:00	31ad59b0-67ff-46d3-a59c-9de3ea6403b5	2021-06-18 04:59:17.563+07	2021-06-18 04:59:17.563+07
22bdf984-d144-40ad-aa30-56009ec9af24	13:00	13:30	88033f99-4135-4729-8b16-6bfdae02f0e6	2021-06-18 04:59:33.975+07	2021-06-18 04:59:33.975+07
875dddd3-53e5-4003-a08c-b5be32f656f0	13:30	14:00	88033f99-4135-4729-8b16-6bfdae02f0e6	2021-06-18 04:59:33.976+07	2021-06-18 04:59:33.976+07
c2e6c599-4d0e-44e3-a819-22a9cc43d27c	13:00	13:30	19bb3447-5931-4339-b977-acff7a6d3f37	2021-06-18 04:59:34.145+07	2021-06-18 04:59:34.145+07
2103cd72-487a-4fd1-94ca-a90c21f9cd6f	13:30	14:00	19bb3447-5931-4339-b977-acff7a6d3f37	2021-06-18 04:59:34.146+07	2021-06-18 04:59:34.146+07
8e118f58-0b07-43b9-ad14-355195337d0b	13:00	13:30	b81a03ea-7b73-4ebe-aee4-1bddd0645828	2021-06-18 04:59:34.349+07	2021-06-18 04:59:34.349+07
b57fd044-ebc9-40fd-83a4-5f8557ad0d46	13:30	14:00	b81a03ea-7b73-4ebe-aee4-1bddd0645828	2021-06-18 04:59:34.35+07	2021-06-18 04:59:34.35+07
a65f83ce-9f9d-4b80-911f-7ab5a45725bc	13:00	13:30	0c33bff7-fa83-435e-a1aa-4153d33de8c4	2021-06-18 04:59:34.418+07	2021-06-18 04:59:34.418+07
df916fc8-7015-4364-8c5c-fd45c9f47407	13:30	14:00	0c33bff7-fa83-435e-a1aa-4153d33de8c4	2021-06-18 04:59:34.418+07	2021-06-18 04:59:34.418+07
6a97b589-ea97-4921-ab70-223b8a336689	13:00	13:30	6ed6da8e-e505-4c38-a679-50ce97627d1c	2021-06-18 04:59:34.422+07	2021-06-18 04:59:34.422+07
19ec79aa-f5c6-42d4-8d92-dee08cd8867f	13:30	14:00	6ed6da8e-e505-4c38-a679-50ce97627d1c	2021-06-18 04:59:34.423+07	2021-06-18 04:59:34.423+07
d1e9c7e2-f2ae-43e6-ab84-e968a0a21223	13:00	13:30	73cdad67-548c-4a90-b2b0-3d961c35c802	2021-06-18 04:59:34.427+07	2021-06-18 04:59:34.427+07
55adb224-bd7c-41d5-9e4d-4b5ee74fc620	13:30	14:00	73cdad67-548c-4a90-b2b0-3d961c35c802	2021-06-18 04:59:34.427+07	2021-06-18 04:59:34.427+07
06d65283-7e5d-47c2-98a1-6508a208b6af	13:00	13:30	a09cf400-f9cd-4c9d-822a-50017ac5a260	2021-06-18 04:59:34.43+07	2021-06-18 04:59:34.43+07
9f437126-8078-4274-be08-c0f317a8d2f0	13:30	14:00	a09cf400-f9cd-4c9d-822a-50017ac5a260	2021-06-18 04:59:34.43+07	2021-06-18 04:59:34.43+07
3353018f-fdd0-400e-ac14-8bf334a35cec	13:00	13:30	c3c1d42e-7fcb-495e-8a12-078d96a9a767	2021-06-18 04:59:34.453+07	2021-06-18 04:59:34.453+07
2f07267c-b66a-4f99-9a19-fdd085556419	13:30	14:00	c3c1d42e-7fcb-495e-8a12-078d96a9a767	2021-06-18 04:59:34.453+07	2021-06-18 04:59:34.453+07
54cca450-f92f-433c-b679-21c20bffaad6	13:00	13:30	16371d30-c502-4680-ab3c-43d3bc06f20e	2021-06-18 04:59:34.459+07	2021-06-18 04:59:34.459+07
40cb1b7e-aacf-454f-98ce-f229720bc589	13:30	14:00	16371d30-c502-4680-ab3c-43d3bc06f20e	2021-06-18 04:59:34.459+07	2021-06-18 04:59:34.459+07
304810ce-5743-4dff-a697-b83a6e590158	08:00	08:30	2a4c34af-db51-4b68-b97d-e07011323333	2021-06-18 05:02:12.151+07	2021-06-18 05:02:12.151+07
2c3ea55b-9858-488e-bc8b-3c1d3fc0d8d8	08:30	09:00	2a4c34af-db51-4b68-b97d-e07011323333	2021-06-18 05:02:12.152+07	2021-06-18 05:02:12.152+07
a5df0971-4239-4c6e-98e6-b56fca257267	09:00	09:30	2a4c34af-db51-4b68-b97d-e07011323333	2021-06-18 05:02:12.152+07	2021-06-18 05:02:12.152+07
343e9136-b9ed-4ea1-a1f1-c014e5b9abd3	09:30	10:00	2a4c34af-db51-4b68-b97d-e07011323333	2021-06-18 05:02:12.152+07	2021-06-18 05:02:12.152+07
7a0d5ff6-9902-49d0-92c1-8971e0377c8c	08:00	08:30	2bf4e838-99c0-4d40-ba2a-66eb282a465e	2021-06-18 05:02:12.156+07	2021-06-18 05:02:12.156+07
4576af2c-7ec4-4c51-9c36-76bc574456b5	08:30	09:00	2bf4e838-99c0-4d40-ba2a-66eb282a465e	2021-06-18 05:02:12.156+07	2021-06-18 05:02:12.156+07
5d9b5ca4-fc51-4a11-950e-2fcae27e98e7	08:00	08:30	bc83da6f-b124-4fad-90f4-bd4bcf65c951	2021-06-18 05:02:12.16+07	2021-06-18 05:02:12.16+07
2a175327-7874-40da-97e2-453cb2621412	09:00	09:30	2bf4e838-99c0-4d40-ba2a-66eb282a465e	2021-06-18 05:02:12.156+07	2021-06-18 05:02:12.156+07
96ab224c-e727-455a-a2d9-de6382bdbc5d	09:30	10:00	2bf4e838-99c0-4d40-ba2a-66eb282a465e	2021-06-18 05:02:12.156+07	2021-06-18 05:02:12.156+07
65df4984-171c-4361-9e0c-2c050250b32e	08:30	09:00	bc83da6f-b124-4fad-90f4-bd4bcf65c951	2021-06-18 05:02:12.16+07	2021-06-18 05:02:12.16+07
5d4e7e24-2ab3-49fd-a9f7-1fe2d1880bce	09:30	10:00	bc83da6f-b124-4fad-90f4-bd4bcf65c951	2021-06-18 05:02:12.161+07	2021-06-18 05:02:12.161+07
bdb36be4-936a-40fe-9445-1ab9c7d13e98	08:00	08:30	1ea689a8-c795-45bb-a0e6-270b295a0f82	2021-06-18 05:02:12.166+07	2021-06-18 05:02:12.166+07
aabb666d-e813-4bec-8224-de72e41dd95c	09:00	09:30	bc83da6f-b124-4fad-90f4-bd4bcf65c951	2021-06-18 05:02:12.16+07	2021-06-18 05:02:12.16+07
fbea3b02-e10a-4469-a7c0-8ffe63022a36	08:30	09:00	1ea689a8-c795-45bb-a0e6-270b295a0f82	2021-06-18 05:02:12.166+07	2021-06-18 05:02:12.166+07
1cf097d0-e5fc-4d7e-90f8-bb7577b9d5ac	09:00	09:30	1ea689a8-c795-45bb-a0e6-270b295a0f82	2021-06-18 05:02:12.167+07	2021-06-18 05:02:12.167+07
06d3b74d-5590-4496-9b82-211a715f3aaa	09:30	10:00	1ea689a8-c795-45bb-a0e6-270b295a0f82	2021-06-18 05:02:12.167+07	2021-06-18 05:02:12.167+07
3ab0f5dc-9647-4301-9bb4-7a44723a71b1	08:00	08:30	8947375a-9480-487b-a29d-4e091ae8ecdf	2021-06-18 05:02:12.171+07	2021-06-18 05:02:12.171+07
c73c399c-23a8-4ea8-ba8c-f33b05fc45e7	08:30	09:00	8947375a-9480-487b-a29d-4e091ae8ecdf	2021-06-18 05:02:12.171+07	2021-06-18 05:02:12.171+07
819ed493-5d59-491a-ae9e-18e87deb478d	09:00	09:30	8947375a-9480-487b-a29d-4e091ae8ecdf	2021-06-18 05:02:12.171+07	2021-06-18 05:02:12.171+07
d3f83eb8-cd5d-4d01-85a9-8ce588cffa80	09:30	10:00	8947375a-9480-487b-a29d-4e091ae8ecdf	2021-06-18 05:02:12.171+07	2021-06-18 05:02:12.171+07
1267990b-3d92-496e-820a-d0f1b4ffeec2	08:00	08:30	92b52ac5-bf90-4c9f-9334-b9bbe2804324	2021-06-18 05:02:12.18+07	2021-06-18 05:02:12.18+07
18529631-16c7-4ce0-92e9-dcbc94945de2	08:30	09:00	92b52ac5-bf90-4c9f-9334-b9bbe2804324	2021-06-18 05:02:12.182+07	2021-06-18 05:02:12.182+07
936700a9-0f23-41e2-a695-97a908994dba	09:00	09:30	92b52ac5-bf90-4c9f-9334-b9bbe2804324	2021-06-18 05:02:12.182+07	2021-06-18 05:02:12.182+07
13c223ad-886d-42dc-88a9-7dd1d460d0a2	09:30	10:00	92b52ac5-bf90-4c9f-9334-b9bbe2804324	2021-06-18 05:02:12.183+07	2021-06-18 05:02:12.183+07
b35fe1c5-a47f-4321-adc7-128029499f82	06:00	06:30	9bd9b651-078b-4b5f-b149-521916099bb9	2021-06-18 05:02:28.312+07	2021-06-18 05:02:28.312+07
fce8c60a-2a67-496d-adbe-2eaeba3be0ba	06:30	07:00	9bd9b651-078b-4b5f-b149-521916099bb9	2021-06-18 05:02:28.313+07	2021-06-18 05:02:28.313+07
faad6b22-2e60-4bbf-86cb-5cbf99a56152	06:00	06:30	c4c88d6c-ba2c-4d3e-b657-4a005c7417ef	2021-06-18 05:02:28.399+07	2021-06-18 05:02:28.399+07
ef646694-0686-4265-903f-8eda468ef300	07:00	07:30	9bd9b651-078b-4b5f-b149-521916099bb9	2021-06-18 05:02:28.313+07	2021-06-18 05:02:28.313+07
487e7010-5911-41e9-bec4-0a261267d8c9	07:30	08:00	9bd9b651-078b-4b5f-b149-521916099bb9	2021-06-18 05:02:28.313+07	2021-06-18 05:02:28.313+07
88e709cb-5b7a-4ac0-ac62-a7bc363ed4b8	06:30	07:00	c4c88d6c-ba2c-4d3e-b657-4a005c7417ef	2021-06-18 05:02:28.399+07	2021-06-18 05:02:28.399+07
80804401-d64e-4730-a562-70c630ec7971	07:00	07:30	c4c88d6c-ba2c-4d3e-b657-4a005c7417ef	2021-06-18 05:02:28.399+07	2021-06-18 05:02:28.399+07
0a9f81df-a942-4955-a52b-f78290366cd4	07:30	08:00	c4c88d6c-ba2c-4d3e-b657-4a005c7417ef	2021-06-18 05:02:28.399+07	2021-06-18 05:02:28.399+07
c10729cc-bdd5-41c9-a5aa-c51f461575dd	06:00	06:30	c24748e0-af14-42a4-852f-9d6cf1ff69f5	2021-06-18 05:02:28.402+07	2021-06-18 05:02:28.402+07
6dc561e5-8cef-4fa0-bc4a-f42642dbc2c5	06:30	07:00	c24748e0-af14-42a4-852f-9d6cf1ff69f5	2021-06-18 05:02:28.402+07	2021-06-18 05:02:28.402+07
7e87d469-a1fc-4200-9ef0-f7267ec996f2	06:00	06:30	62912983-8d78-44c8-a6da-85847ac8dac7	2021-06-18 05:02:28.502+07	2021-06-18 05:02:28.502+07
e739b991-e3a6-4956-8a9a-7543008f8b7f	06:00	06:30	cb1470e5-3cdd-4501-970a-9205521a54c5	2021-06-18 05:02:28.554+07	2021-06-18 05:02:28.554+07
aa0b9800-66b0-44e5-9e59-a083b25ef13c	06:00	06:30	fd0bfe69-f560-4d33-b068-44bc03d3238a	2021-06-18 05:02:28.56+07	2021-06-18 05:02:28.56+07
425ac8ee-0f02-4e9c-86d7-f2f6169f0bdc	06:30	07:00	5ecfd019-0113-4f62-9627-d0ff08ee26b4	2021-06-18 05:02:28.564+07	2021-06-18 05:02:28.564+07
1c3a7b4c-f787-43fa-9919-421b05069193	07:00	07:30	886fbe11-a7a5-4833-9dd7-290bbc507848	2021-06-18 05:02:28.568+07	2021-06-18 05:02:28.568+07
ea2fcac6-eab2-42fb-8c01-1f839fb7abfc	07:30	08:00	12e4ed7b-8add-4b73-9422-564cf4b14056	2021-06-18 05:02:28.571+07	2021-06-18 05:02:28.571+07
61178126-1b0f-4399-8c06-9ff6418f5fed	07:00	07:30	c24748e0-af14-42a4-852f-9d6cf1ff69f5	2021-06-18 05:02:28.402+07	2021-06-18 05:02:28.402+07
5f9fe6c1-e563-4086-891d-8f824f297f90	07:30	08:00	62912983-8d78-44c8-a6da-85847ac8dac7	2021-06-18 05:02:28.503+07	2021-06-18 05:02:28.503+07
6e6f5483-dc03-4db7-b437-2ba56d656cb0	06:30	07:00	fd0bfe69-f560-4d33-b068-44bc03d3238a	2021-06-18 05:02:28.56+07	2021-06-18 05:02:28.56+07
e402f3f1-a1e8-45f2-8d94-4fa8d5ac87b1	07:00	07:30	5ecfd019-0113-4f62-9627-d0ff08ee26b4	2021-06-18 05:02:28.564+07	2021-06-18 05:02:28.564+07
a335c830-27d0-4542-abfc-d6da27316c63	07:30	08:00	886fbe11-a7a5-4833-9dd7-290bbc507848	2021-06-18 05:02:28.568+07	2021-06-18 05:02:28.568+07
d01e428b-1dda-4d20-b815-8595ce91b3d6	06:00	06:30	6033540f-9b92-4bbd-94a6-3f8429ea562c	2021-06-18 05:02:28.58+07	2021-06-18 05:02:28.58+07
dcdef0db-3ab3-4514-9a4c-b4bb9fcdd001	07:30	08:00	c24748e0-af14-42a4-852f-9d6cf1ff69f5	2021-06-18 05:02:28.402+07	2021-06-18 05:02:28.402+07
f264b8b0-8d16-4f00-b40c-db7004f45a04	06:30	07:00	cb1470e5-3cdd-4501-970a-9205521a54c5	2021-06-18 05:02:28.554+07	2021-06-18 05:02:28.554+07
18a6e981-cc4b-49b4-8555-55a0f7e12bff	07:00	07:30	fd0bfe69-f560-4d33-b068-44bc03d3238a	2021-06-18 05:02:28.561+07	2021-06-18 05:02:28.561+07
93bf603b-4f99-46d7-a8a6-1e6fe5b0b7aa	07:30	08:00	5ecfd019-0113-4f62-9627-d0ff08ee26b4	2021-06-18 05:02:28.565+07	2021-06-18 05:02:28.565+07
c908fff7-fea3-4d1f-9805-01bad5186188	06:00	06:30	12e4ed7b-8add-4b73-9422-564cf4b14056	2021-06-18 05:02:28.57+07	2021-06-18 05:02:28.57+07
0ad2b6ad-0374-4061-b285-afecea16e810	06:30	07:00	6033540f-9b92-4bbd-94a6-3f8429ea562c	2021-06-18 05:02:28.58+07	2021-06-18 05:02:28.58+07
d3606f44-bf85-44d1-a2cf-418d2da96d3c	06:30	07:00	62912983-8d78-44c8-a6da-85847ac8dac7	2021-06-18 05:02:28.502+07	2021-06-18 05:02:28.502+07
dccdb54f-f440-4fbb-b3de-ad07fa9f3cf5	07:00	07:30	cb1470e5-3cdd-4501-970a-9205521a54c5	2021-06-18 05:02:28.555+07	2021-06-18 05:02:28.555+07
f68cf3b5-13a6-4155-8357-65142b21098e	07:30	08:00	fd0bfe69-f560-4d33-b068-44bc03d3238a	2021-06-18 05:02:28.561+07	2021-06-18 05:02:28.561+07
1e307600-39bf-42b6-8d09-a1bd4776b67c	06:00	06:30	886fbe11-a7a5-4833-9dd7-290bbc507848	2021-06-18 05:02:28.568+07	2021-06-18 05:02:28.568+07
b35c951f-4b1d-46f4-beb6-fd5cc90d7120	06:30	07:00	12e4ed7b-8add-4b73-9422-564cf4b14056	2021-06-18 05:02:28.57+07	2021-06-18 05:02:28.57+07
ecc78570-e62e-4ff8-b94a-36bad3f70ad5	07:00	07:30	6033540f-9b92-4bbd-94a6-3f8429ea562c	2021-06-18 05:02:28.58+07	2021-06-18 05:02:28.58+07
d3d29d72-95cb-4cb5-828c-c34b03a1ac2b	07:00	07:30	62912983-8d78-44c8-a6da-85847ac8dac7	2021-06-18 05:02:28.502+07	2021-06-18 05:02:28.502+07
40d016e7-8e5d-4e3e-88b3-5a1cd461da90	07:30	08:00	cb1470e5-3cdd-4501-970a-9205521a54c5	2021-06-18 05:02:28.555+07	2021-06-18 05:02:28.555+07
86983288-131d-41eb-8608-2aca2d03f7ac	06:00	06:30	5ecfd019-0113-4f62-9627-d0ff08ee26b4	2021-06-18 05:02:28.564+07	2021-06-18 05:02:28.564+07
33004c54-a70a-467b-a95b-e3d9b270d614	06:30	07:00	886fbe11-a7a5-4833-9dd7-290bbc507848	2021-06-18 05:02:28.568+07	2021-06-18 05:02:28.568+07
c52d0783-955b-4d30-be64-d0d939acb1df	07:00	07:30	12e4ed7b-8add-4b73-9422-564cf4b14056	2021-06-18 05:02:28.57+07	2021-06-18 05:02:28.57+07
b44c601d-f561-4582-b112-f7f72f1563d9	07:30	08:00	6033540f-9b92-4bbd-94a6-3f8429ea562c	2021-06-18 05:02:28.581+07	2021-06-18 05:02:28.581+07
47acd396-33ee-4d38-bf63-8a620039dae8	16:00	16:30	42424fd5-1cd1-4b83-90d6-eb757577fd75	2021-06-18 05:02:51.385+07	2021-06-18 05:02:51.385+07
849bb0ca-1eda-4414-87b6-5241c68886e5	16:30	17:00	42424fd5-1cd1-4b83-90d6-eb757577fd75	2021-06-18 05:02:51.385+07	2021-06-18 05:02:51.385+07
924c1948-8d1d-47f6-a76c-4e358b4d9c57	17:00	17:30	42424fd5-1cd1-4b83-90d6-eb757577fd75	2021-06-18 05:02:51.385+07	2021-06-18 05:02:51.385+07
95e84743-a488-4db2-a073-1178d3b3dd84	17:30	18:00	42424fd5-1cd1-4b83-90d6-eb757577fd75	2021-06-18 05:02:51.385+07	2021-06-18 05:02:51.385+07
3f5a0680-416e-4414-9249-223cec16bd78	08:00	08:30	74c18987-9801-4892-8bf5-c16cf6295439	2021-06-18 05:11:48.422+07	2021-06-18 05:11:48.422+07
bbf0f9f5-80a2-4b6f-a312-87a86ea63b39	08:30	09:00	74c18987-9801-4892-8bf5-c16cf6295439	2021-06-18 05:11:48.422+07	2021-06-18 05:11:48.422+07
22bf8032-9210-4d01-88b6-e6d38129b616	09:00	09:30	74c18987-9801-4892-8bf5-c16cf6295439	2021-06-18 05:11:48.424+07	2021-06-18 05:11:48.424+07
e7323ce7-346f-4257-bb19-11e0e79e671f	09:30	10:00	74c18987-9801-4892-8bf5-c16cf6295439	2021-06-18 05:11:48.424+07	2021-06-18 05:11:48.424+07
5021d3c5-11cc-49d7-a2ce-0a3d4ab18d98	08:00	08:30	27eeaa25-3bb0-4684-8714-b006d537b3be	2021-06-18 05:11:48.51+07	2021-06-18 05:11:48.51+07
8e9b3692-3934-4491-82ed-c84f6b63b0b0	08:30	09:00	27eeaa25-3bb0-4684-8714-b006d537b3be	2021-06-18 05:11:48.51+07	2021-06-18 05:11:48.51+07
d6f3ca3c-4e9f-4abb-a623-dfdcb955b86b	09:00	09:30	27eeaa25-3bb0-4684-8714-b006d537b3be	2021-06-18 05:11:48.51+07	2021-06-18 05:11:48.51+07
6364e53a-ee3e-4a1d-8529-0f9f6d2b270a	09:30	10:00	27eeaa25-3bb0-4684-8714-b006d537b3be	2021-06-18 05:11:48.511+07	2021-06-18 05:11:48.511+07
2dfaa1bb-9a33-4f6a-8f7e-7324be461d9b	08:00	08:30	95c98fa3-b28f-4e84-8e7a-664046e7fa37	2021-06-18 05:11:48.515+07	2021-06-18 05:11:48.515+07
c4640193-ef88-4c44-811b-2cef4b5b032f	08:30	09:00	95c98fa3-b28f-4e84-8e7a-664046e7fa37	2021-06-18 05:11:48.515+07	2021-06-18 05:11:48.515+07
aa1ea649-d07d-418e-b5a6-216330d0b783	09:00	09:30	95c98fa3-b28f-4e84-8e7a-664046e7fa37	2021-06-18 05:11:48.516+07	2021-06-18 05:11:48.516+07
1474eb52-103b-480f-a5a3-e9614365532c	09:30	10:00	95c98fa3-b28f-4e84-8e7a-664046e7fa37	2021-06-18 05:11:48.516+07	2021-06-18 05:11:48.516+07
391c9b0d-3a42-4926-8219-13ee515ca760	08:00	08:30	d57b2b5f-ee29-49ff-9f13-6afe4690e971	2021-06-18 05:11:48.526+07	2021-06-18 05:11:48.526+07
12ac6831-a57d-43c7-b28d-030fb0604cd8	08:30	09:00	d57b2b5f-ee29-49ff-9f13-6afe4690e971	2021-06-18 05:11:48.526+07	2021-06-18 05:11:48.526+07
295fb17b-5245-4b0f-9bb7-00286169131b	09:00	09:30	d57b2b5f-ee29-49ff-9f13-6afe4690e971	2021-06-18 05:11:48.527+07	2021-06-18 05:11:48.527+07
3cd88354-68d2-4b7b-9952-5942d6b8c57c	09:30	10:00	d57b2b5f-ee29-49ff-9f13-6afe4690e971	2021-06-18 05:11:48.527+07	2021-06-18 05:11:48.527+07
8e92dd4d-94be-4dd0-af02-ef42be2d87e6	08:00	08:30	aa528adb-56fd-4a88-8fa9-6077cc28d505	2021-06-18 05:11:48.53+07	2021-06-18 05:11:48.53+07
15c9fc85-319f-4c60-b871-3f7dbf1aa18f	08:30	09:00	aa528adb-56fd-4a88-8fa9-6077cc28d505	2021-06-18 05:11:48.531+07	2021-06-18 05:11:48.531+07
dbfa7d81-1b12-4516-b648-67924616f871	09:00	09:30	aa528adb-56fd-4a88-8fa9-6077cc28d505	2021-06-18 05:11:48.531+07	2021-06-18 05:11:48.531+07
52e4e63f-30f1-49ae-a89c-af87a0db1488	09:30	10:00	aa528adb-56fd-4a88-8fa9-6077cc28d505	2021-06-18 05:11:48.531+07	2021-06-18 05:11:48.531+07
53928312-f3c2-4348-923f-5935f4a0bb63	08:00	08:30	2be2187a-b2ad-4fa8-b246-33166be37147	2021-06-18 05:11:48.535+07	2021-06-18 05:11:48.535+07
fabfb408-8d04-4bab-b811-2f6ff255c82c	08:30	09:00	2be2187a-b2ad-4fa8-b246-33166be37147	2021-06-18 05:11:48.537+07	2021-06-18 05:11:48.537+07
f58bc5e8-d4cc-4da0-9dbd-369af0385f05	09:00	09:30	2be2187a-b2ad-4fa8-b246-33166be37147	2021-06-18 05:11:48.537+07	2021-06-18 05:11:48.537+07
57ae8374-d1e7-4dff-b9dd-78a7e0fb1583	09:30	10:00	2be2187a-b2ad-4fa8-b246-33166be37147	2021-06-18 05:11:48.537+07	2021-06-18 05:11:48.537+07
7094e0bd-de5e-4246-91ef-5bb0ac4fef9d	08:00	08:30	768bbf22-c70e-4d62-9aac-733587fa9672	2021-06-18 05:11:48.542+07	2021-06-18 05:11:48.542+07
30ef31b6-7287-4b24-8dca-da18cb637097	08:30	09:00	768bbf22-c70e-4d62-9aac-733587fa9672	2021-06-18 05:11:48.542+07	2021-06-18 05:11:48.542+07
b175d80e-f4b8-4b8f-aec2-8605f3aa0ff2	09:00	09:30	768bbf22-c70e-4d62-9aac-733587fa9672	2021-06-18 05:11:48.543+07	2021-06-18 05:11:48.543+07
98a2f49d-735d-44ce-86f2-bde90b304551	09:30	10:00	768bbf22-c70e-4d62-9aac-733587fa9672	2021-06-18 05:11:48.543+07	2021-06-18 05:11:48.543+07
26d456f0-e563-40c5-94fc-cbcd21ba3768	08:00	08:30	35c386d5-b6de-4589-b15f-24f27b2691fc	2021-06-18 05:11:48.549+07	2021-06-18 05:11:48.549+07
519f39b3-9d28-4869-8c63-166e7e4b9f4b	08:30	09:00	35c386d5-b6de-4589-b15f-24f27b2691fc	2021-06-18 05:11:48.55+07	2021-06-18 05:11:48.55+07
9c9ac249-8450-4f53-a217-6aad34b6bdb3	09:00	09:30	35c386d5-b6de-4589-b15f-24f27b2691fc	2021-06-18 05:11:48.55+07	2021-06-18 05:11:48.55+07
3a19800a-fced-4520-b6f3-969a30e249b6	09:30	10:00	35c386d5-b6de-4589-b15f-24f27b2691fc	2021-06-18 05:11:48.55+07	2021-06-18 05:11:48.55+07
1554ba37-c02e-4da5-97b9-ffb4c09e0dc8	08:00	08:30	224fbac5-875c-4d0f-bd23-a5e12d5ffd19	2021-06-18 05:11:48.555+07	2021-06-18 05:11:48.555+07
590e776f-1cdb-4aa7-88c0-4978c48ea6f5	08:30	09:00	224fbac5-875c-4d0f-bd23-a5e12d5ffd19	2021-06-18 05:11:48.555+07	2021-06-18 05:11:48.555+07
dbfa4e08-4ea6-4c0d-a0cc-9b704eefad30	09:00	09:30	224fbac5-875c-4d0f-bd23-a5e12d5ffd19	2021-06-18 05:11:48.556+07	2021-06-18 05:11:48.556+07
b0a809a7-5c7b-47e7-abae-e40801914618	09:30	10:00	224fbac5-875c-4d0f-bd23-a5e12d5ffd19	2021-06-18 05:11:48.556+07	2021-06-18 05:11:48.556+07
25dfb20a-6c27-4b5d-bac1-f8bfbc18c5ef	08:00	08:30	ec36cc42-b4f3-4aab-9e82-50f104264179	2021-06-18 05:11:48.559+07	2021-06-18 05:11:48.559+07
0a9ebce2-de3a-421d-8309-665580e4f9d5	08:30	09:00	ec36cc42-b4f3-4aab-9e82-50f104264179	2021-06-18 05:11:48.56+07	2021-06-18 05:11:48.56+07
a1baf8c4-efde-4090-b9cf-833544a6dfdd	09:00	09:30	ec36cc42-b4f3-4aab-9e82-50f104264179	2021-06-18 05:11:48.56+07	2021-06-18 05:11:48.56+07
b894736a-5ebb-4633-b62c-94b476ca29eb	09:30	10:00	ec36cc42-b4f3-4aab-9e82-50f104264179	2021-06-18 05:11:48.56+07	2021-06-18 05:11:48.56+07
b80c706c-89c2-4aa0-b624-2d26541f7e60	08:00	08:30	2a51224d-bc82-41b2-8eb6-f509408c8c2b	2021-06-18 05:11:48.564+07	2021-06-18 05:11:48.564+07
3cc1bee2-1bb9-47af-8f79-2616df72ed33	08:30	09:00	2a51224d-bc82-41b2-8eb6-f509408c8c2b	2021-06-18 05:11:48.564+07	2021-06-18 05:11:48.564+07
a0a3f8b5-e06f-4b84-8a19-f13ce7006380	09:00	09:30	2a51224d-bc82-41b2-8eb6-f509408c8c2b	2021-06-18 05:11:48.564+07	2021-06-18 05:11:48.564+07
d0530a5b-9b6c-4c7e-8e87-c99633041be2	09:30	10:00	2a51224d-bc82-41b2-8eb6-f509408c8c2b	2021-06-18 05:11:48.564+07	2021-06-18 05:11:48.564+07
9f00663a-b3d8-4471-8022-42528f9e3cb4	08:00	08:30	0e4fe7ef-c111-46b2-b77e-1b13732f97f3	2021-06-18 05:11:48.57+07	2021-06-18 05:11:48.57+07
969181c2-621d-4fea-86ca-6ddb76603f17	08:30	09:00	0e4fe7ef-c111-46b2-b77e-1b13732f97f3	2021-06-18 05:11:48.57+07	2021-06-18 05:11:48.57+07
6532e66f-32f2-4036-bfba-a765152be0a9	09:00	09:30	0e4fe7ef-c111-46b2-b77e-1b13732f97f3	2021-06-18 05:11:48.57+07	2021-06-18 05:11:48.57+07
96ed8346-4c7a-4f48-8fc7-c2e1a1d48a35	09:30	10:00	0e4fe7ef-c111-46b2-b77e-1b13732f97f3	2021-06-18 05:11:48.571+07	2021-06-18 05:11:48.571+07
f1d7c3e3-873f-4df7-97d5-3949a0658674	08:00	08:30	7ab336e1-a7a7-47db-9a68-939514fea4f6	2021-06-18 05:11:48.577+07	2021-06-18 05:11:48.577+07
648cd1e1-1057-47bc-b321-874756c1cc25	08:30	09:00	7ab336e1-a7a7-47db-9a68-939514fea4f6	2021-06-18 05:11:48.577+07	2021-06-18 05:11:48.577+07
d28635bb-2b9a-4984-b720-f5fccfaf10f9	09:00	09:30	7ab336e1-a7a7-47db-9a68-939514fea4f6	2021-06-18 05:11:48.577+07	2021-06-18 05:11:48.577+07
6475111d-a46a-4135-80e3-bfbd33775dca	09:30	10:00	7ab336e1-a7a7-47db-9a68-939514fea4f6	2021-06-18 05:11:48.577+07	2021-06-18 05:11:48.577+07
3ab57d7d-3ffe-4dc5-91fa-b57dcee8440c	14:00	14:30	c975b40f-73a0-441e-98e9-c6f263a30864	2021-06-18 05:12:22.7+07	2021-06-18 05:12:22.7+07
fce4720b-34a0-45d4-8276-26368e1332bf	14:30	15:00	c975b40f-73a0-441e-98e9-c6f263a30864	2021-06-18 05:12:22.701+07	2021-06-18 05:12:22.701+07
efea8c02-13fb-4d83-af09-540dd0a45d10	14:00	14:30	9de5c53f-dbe0-42a3-bca4-09cd23e2c844	2021-06-18 05:12:22.704+07	2021-06-18 05:12:22.704+07
29eb8cba-04f8-49fe-ad74-f7eabe4843e3	14:30	15:00	9de5c53f-dbe0-42a3-bca4-09cd23e2c844	2021-06-18 05:12:22.704+07	2021-06-18 05:12:22.704+07
\.


--
-- TOC entry 3195 (class 0 OID 41800)
-- Dependencies: 211
-- Data for Name: Schedules; Type: TABLE DATA; Schema: public; Owner: livetutor
--

COPY public."Schedules" (id, date, "startTime", "endTime", "tutorId", "createdAt", "updatedAt") FROM stdin;
d7ec1364-8897-41fa-9013-c39983410804	2021-06-23	15:00	20:00	c616bfac-c701-484c-8c3f-f914639be512	2021-06-18 03:50:11.081+07	2021-06-18 03:50:11.081+07
70b12e80-af1c-4532-a887-b167430167a2	2021-06-19	16:00	19:00	0d7d4348-cf7e-4b6a-9a01-1d88f283e910	2021-06-18 03:57:24.176+07	2021-06-18 03:57:24.176+07
6f480ca8-24cd-45c5-8a19-5525c6c584db	2021-06-20	16:00	19:00	0d7d4348-cf7e-4b6a-9a01-1d88f283e910	2021-06-18 03:57:24.184+07	2021-06-18 03:57:24.184+07
a0c54ab6-73dd-4cd2-8506-c2d0e372b5f0	2021-06-21	16:00	19:00	0d7d4348-cf7e-4b6a-9a01-1d88f283e910	2021-06-18 03:57:24.193+07	2021-06-18 03:57:24.193+07
84a97d79-fdc3-4ee3-b499-0929cf152259	2021-06-22	16:00	19:00	0d7d4348-cf7e-4b6a-9a01-1d88f283e910	2021-06-18 03:57:24.197+07	2021-06-18 03:57:24.197+07
78701819-1390-4237-a81e-abef133a2781	2021-06-23	16:00	19:00	0d7d4348-cf7e-4b6a-9a01-1d88f283e910	2021-06-18 03:57:24.2+07	2021-06-18 03:57:24.2+07
fdc625ab-ad14-4ae8-bde1-2fb53cf1eefd	2021-06-24	16:00	19:00	0d7d4348-cf7e-4b6a-9a01-1d88f283e910	2021-06-18 03:57:24.204+07	2021-06-18 03:57:24.204+07
61766dbe-bd80-4b6e-870d-840db60574f5	2021-06-25	16:00	19:00	0d7d4348-cf7e-4b6a-9a01-1d88f283e910	2021-06-18 03:57:24.208+07	2021-06-18 03:57:24.208+07
2195ca9f-4226-4cc0-a184-47e4f2ee549b	2021-06-27	16:00	19:00	0d7d4348-cf7e-4b6a-9a01-1d88f283e910	2021-06-18 03:57:24.217+07	2021-06-18 03:57:24.217+07
75912ebf-35fb-4333-b5c1-6a77d4f66211	2021-06-26	16:00	19:00	0d7d4348-cf7e-4b6a-9a01-1d88f283e910	2021-06-18 03:57:24.213+07	2021-06-18 03:57:24.213+07
8bb81bc3-315e-4175-b0bc-be526dd1d82a	2021-06-28	16:00	19:00	0d7d4348-cf7e-4b6a-9a01-1d88f283e910	2021-06-18 03:57:24.22+07	2021-06-18 03:57:24.22+07
f2148574-dc89-4781-8628-05799f44d636	2021-06-30	16:00	19:00	0d7d4348-cf7e-4b6a-9a01-1d88f283e910	2021-06-18 03:57:24.233+07	2021-06-18 03:57:24.233+07
075fc746-814e-4611-97de-0c2754a24c8d	2021-06-29	16:00	19:00	0d7d4348-cf7e-4b6a-9a01-1d88f283e910	2021-06-18 03:57:24.223+07	2021-06-18 03:57:24.223+07
508d99ca-79c4-40c5-b04d-e51e6fed7b53	2021-06-19	02:00	06:30	c616bfac-c701-484c-8c3f-f914639be512	2021-06-18 03:58:00.035+07	2021-06-18 03:58:00.035+07
c070240f-7d97-4408-8e0e-88ee83823531	2021-06-20	02:00	06:30	c616bfac-c701-484c-8c3f-f914639be512	2021-06-18 03:58:00.038+07	2021-06-18 03:58:00.038+07
c299fec6-bb03-4abb-8c0b-8e043d061cbd	2021-06-21	02:00	06:30	c616bfac-c701-484c-8c3f-f914639be512	2021-06-18 03:58:00.05+07	2021-06-18 03:58:00.05+07
487827c8-6595-4671-8d4b-bf4a5119070f	2021-06-22	02:00	06:30	c616bfac-c701-484c-8c3f-f914639be512	2021-06-18 03:58:00.066+07	2021-06-18 03:58:00.066+07
76264bb3-fff3-4e6f-8d20-57b9a044212c	2021-06-23	02:00	06:30	c616bfac-c701-484c-8c3f-f914639be512	2021-06-18 03:58:00.085+07	2021-06-18 03:58:00.085+07
5d401606-cab4-4ac3-8e43-88248ed22de0	2021-06-24	02:00	06:30	c616bfac-c701-484c-8c3f-f914639be512	2021-06-18 03:58:00.088+07	2021-06-18 03:58:00.088+07
206f98fa-34b7-4088-8e4f-b79a0a2f84b3	2021-06-26	02:00	06:30	c616bfac-c701-484c-8c3f-f914639be512	2021-06-18 03:58:00.107+07	2021-06-18 03:58:00.107+07
7f0d7023-d5c0-489f-a651-ba549c8d6655	2021-06-25	02:00	06:30	c616bfac-c701-484c-8c3f-f914639be512	2021-06-18 03:58:00.102+07	2021-06-18 03:58:00.102+07
8adf577e-cc0d-45e5-b236-05cd6d8d8413	2021-06-28	02:00	06:30	c616bfac-c701-484c-8c3f-f914639be512	2021-06-18 03:58:00.202+07	2021-06-18 03:58:00.202+07
c2645d1d-0cb2-4070-a62b-496e9e7ae92d	2021-06-27	02:00	06:30	c616bfac-c701-484c-8c3f-f914639be512	2021-06-18 03:58:00.115+07	2021-06-18 03:58:00.115+07
46629bf1-0f5c-4c66-ad9f-761291df2d15	2021-06-29	02:00	06:30	c616bfac-c701-484c-8c3f-f914639be512	2021-06-18 03:58:00.206+07	2021-06-18 03:58:00.206+07
bd716ebe-4fbf-49dd-930b-db554c4de3e0	2021-06-30	02:00	06:30	c616bfac-c701-484c-8c3f-f914639be512	2021-06-18 03:58:00.307+07	2021-06-18 03:58:00.307+07
d2c19572-4cc7-4dd8-b9ba-276b12dd5ad5	2021-06-29	20:00	22:00	c616bfac-c701-484c-8c3f-f914639be512	2021-06-18 03:58:15.365+07	2021-06-18 03:58:15.365+07
d6bdd917-f917-422f-b6a4-27fd9c603b41	2021-06-29	06:30	08:00	c616bfac-c701-484c-8c3f-f914639be512	2021-06-18 03:58:36.893+07	2021-06-18 03:58:36.893+07
8a395702-74be-4403-aa98-c86ff63ce9d2	2021-06-19	20:00	21:00	8aa24fdf-f527-46d8-8523-c21f477c9edf	2021-06-18 04:17:54.704+07	2021-06-18 04:17:54.704+07
27d98ad6-be29-4f76-a3ca-5c129ce4206d	2021-06-20	20:00	21:00	8aa24fdf-f527-46d8-8523-c21f477c9edf	2021-06-18 04:17:54.717+07	2021-06-18 04:17:54.717+07
56ae52aa-d2b1-4ccd-a49d-ed7b7f357b50	2021-06-21	20:00	21:00	8aa24fdf-f527-46d8-8523-c21f477c9edf	2021-06-18 04:17:54.726+07	2021-06-18 04:17:54.726+07
04b68c42-41df-405d-96cb-1772c44abab2	2021-06-22	20:00	21:00	8aa24fdf-f527-46d8-8523-c21f477c9edf	2021-06-18 04:17:54.745+07	2021-06-18 04:17:54.745+07
95065f18-ab7e-40f0-ab41-10d9c8d8cbe3	2021-06-23	20:00	21:00	8aa24fdf-f527-46d8-8523-c21f477c9edf	2021-06-18 04:17:54.749+07	2021-06-18 04:17:54.749+07
3bbcce63-0bab-414e-9a6c-752a9c141a48	2021-06-24	20:00	21:00	8aa24fdf-f527-46d8-8523-c21f477c9edf	2021-06-18 04:17:54.79+07	2021-06-18 04:17:54.79+07
97f20304-66e7-48db-9e76-1c260b896f10	2021-06-25	20:00	21:00	8aa24fdf-f527-46d8-8523-c21f477c9edf	2021-06-18 04:17:54.807+07	2021-06-18 04:17:54.807+07
73290c21-cd0f-45d1-aeb2-0a257b8fcdd6	2021-06-26	20:00	21:00	8aa24fdf-f527-46d8-8523-c21f477c9edf	2021-06-18 04:17:54.833+07	2021-06-18 04:17:54.833+07
7781041f-7a06-451e-a4f5-483b97f0dbd9	2021-06-27	20:00	21:00	8aa24fdf-f527-46d8-8523-c21f477c9edf	2021-06-18 04:17:54.847+07	2021-06-18 04:17:54.847+07
65a88372-bf76-46c0-ae0c-1b566b6a6523	2021-06-28	20:00	21:00	8aa24fdf-f527-46d8-8523-c21f477c9edf	2021-06-18 04:17:54.853+07	2021-06-18 04:17:54.853+07
742462ea-55e5-42ad-99c2-d830ceba64f9	2021-06-30	20:00	21:00	8aa24fdf-f527-46d8-8523-c21f477c9edf	2021-06-18 04:17:54.86+07	2021-06-18 04:17:54.86+07
5a2a3737-1629-4000-ac26-3e52015911a9	2021-06-29	20:00	21:00	8aa24fdf-f527-46d8-8523-c21f477c9edf	2021-06-18 04:17:54.856+07	2021-06-18 04:17:54.856+07
96f42007-3898-484d-a92c-3fed4b535675	2021-06-19	19:00	21:00	08d34ffc-e19c-40d3-8265-55044d5ed68e	2021-06-18 04:23:18.518+07	2021-06-18 04:23:18.518+07
e420f361-b484-49f9-beec-bb44cfb94950	2021-06-19	21:30	22:00	08d34ffc-e19c-40d3-8265-55044d5ed68e	2021-06-18 04:24:04.058+07	2021-06-18 04:24:04.058+07
5c36b47d-f7a1-4f15-9a1f-5046ab0e7cca	2021-06-20	10:00	12:00	08d34ffc-e19c-40d3-8265-55044d5ed68e	2021-06-18 04:24:14.371+07	2021-06-18 04:24:14.371+07
5d42c94a-cd40-46b4-ab93-ecf8d64e6148	2021-06-21	16:00	17:00	08d34ffc-e19c-40d3-8265-55044d5ed68e	2021-06-18 04:24:23.26+07	2021-06-18 04:24:23.26+07
8be4ef59-dd8d-4a5e-8eac-7fb06904ab21	2021-06-22	16:00	17:00	08d34ffc-e19c-40d3-8265-55044d5ed68e	2021-06-18 04:24:29.202+07	2021-06-18 04:24:29.202+07
a9da0030-ed1c-48dc-b1a5-e257b8942a61	2021-06-23	16:00	17:00	08d34ffc-e19c-40d3-8265-55044d5ed68e	2021-06-18 04:24:29.205+07	2021-06-18 04:24:29.205+07
5973837a-ef84-4768-a7db-8e7cc01fff2b	2021-06-24	16:00	17:00	08d34ffc-e19c-40d3-8265-55044d5ed68e	2021-06-18 04:24:29.209+07	2021-06-18 04:24:29.209+07
0d53fa2b-2ddf-4a0a-a35d-ef3e3eae6dee	2021-06-25	16:00	17:00	08d34ffc-e19c-40d3-8265-55044d5ed68e	2021-06-18 04:24:29.212+07	2021-06-18 04:24:29.212+07
2c2f7a7f-5ca7-404d-9b13-cc67c5c1594f	2021-06-26	16:00	17:00	08d34ffc-e19c-40d3-8265-55044d5ed68e	2021-06-18 04:24:29.214+07	2021-06-18 04:24:29.214+07
3070e429-6a0f-4d81-8a90-08e5a6a8a93f	2021-06-27	16:00	17:00	08d34ffc-e19c-40d3-8265-55044d5ed68e	2021-06-18 04:24:29.217+07	2021-06-18 04:24:29.217+07
a0a6db58-7d7b-411a-866c-928b8d567e2d	2021-06-28	16:00	17:00	08d34ffc-e19c-40d3-8265-55044d5ed68e	2021-06-18 04:24:29.22+07	2021-06-18 04:24:29.22+07
a6be3bd6-45fc-4607-b68b-21bfe9c952a4	2021-06-29	16:00	17:00	08d34ffc-e19c-40d3-8265-55044d5ed68e	2021-06-18 04:24:29.224+07	2021-06-18 04:24:29.224+07
6d9a7509-0606-4dc2-b167-dcd19c369a5f	2021-06-30	16:00	17:00	08d34ffc-e19c-40d3-8265-55044d5ed68e	2021-06-18 04:24:29.228+07	2021-06-18 04:24:29.228+07
c246c786-2023-4480-bc61-04ddc4833bab	2021-06-21	17:00	19:00	08d34ffc-e19c-40d3-8265-55044d5ed68e	2021-06-18 04:24:44.958+07	2021-06-18 04:24:44.958+07
6786506a-a9d8-40e1-8741-79957f256b7a	2021-06-26	17:00	19:00	08d34ffc-e19c-40d3-8265-55044d5ed68e	2021-06-18 04:24:44.961+07	2021-06-18 04:24:44.961+07
f2b6a571-e00e-442c-9297-30a85f81ef03	2021-06-23	17:00	19:00	08d34ffc-e19c-40d3-8265-55044d5ed68e	2021-06-18 04:24:44.963+07	2021-06-18 04:24:44.963+07
4a7c3903-9bba-49c6-a9e7-c928db59f3b8	2021-06-22	17:00	19:00	08d34ffc-e19c-40d3-8265-55044d5ed68e	2021-06-18 04:24:44.966+07	2021-06-18 04:24:44.966+07
9fe61e91-7048-4607-9515-dae11265be07	2021-06-24	17:00	19:00	08d34ffc-e19c-40d3-8265-55044d5ed68e	2021-06-18 04:24:44.968+07	2021-06-18 04:24:44.968+07
7b7b10b4-7b3e-4d15-bb47-908a123ca2b5	2021-06-25	17:00	19:00	08d34ffc-e19c-40d3-8265-55044d5ed68e	2021-06-18 04:24:44.972+07	2021-06-18 04:24:44.972+07
b12323be-f16e-4922-a813-6858ac5ca3c8	2021-06-27	17:00	19:00	08d34ffc-e19c-40d3-8265-55044d5ed68e	2021-06-18 04:24:44.976+07	2021-06-18 04:24:44.976+07
759e2109-61ca-4df9-ba87-09fde7cad1fc	2021-06-28	17:00	19:00	08d34ffc-e19c-40d3-8265-55044d5ed68e	2021-06-18 04:24:44.979+07	2021-06-18 04:24:44.979+07
a0f12474-1162-4146-bed5-ae569ad3e7c2	2021-06-29	17:00	19:00	08d34ffc-e19c-40d3-8265-55044d5ed68e	2021-06-18 04:24:44.982+07	2021-06-18 04:24:44.982+07
a04bd4db-f3e5-49ee-a043-55ffa7418e64	2021-06-30	17:00	19:00	08d34ffc-e19c-40d3-8265-55044d5ed68e	2021-06-18 04:24:44.985+07	2021-06-18 04:24:44.985+07
3da236f4-960c-4686-ac10-680020cfbbd4	2021-07-01	04:00	05:00	08d34ffc-e19c-40d3-8265-55044d5ed68e	2021-06-18 04:25:10.945+07	2021-06-18 04:25:10.945+07
dc40b46e-1746-4e1f-8544-a6a50752c49d	2021-06-19	10:00	12:00	0712174d-c389-4286-af91-8a6b1beb9077	2021-06-18 04:25:50.971+07	2021-06-18 04:25:50.971+07
4f74849b-e534-4bc0-aa5d-65147e631e82	2021-06-20	10:00	12:00	0712174d-c389-4286-af91-8a6b1beb9077	2021-06-18 04:25:50.984+07	2021-06-18 04:25:50.984+07
4081b3cf-ea98-44b7-8b9d-e9e7d8f2049e	2021-06-21	10:00	12:00	0712174d-c389-4286-af91-8a6b1beb9077	2021-06-18 04:25:50.993+07	2021-06-18 04:25:50.993+07
d98f3178-7bff-4ea0-b660-c37a9068b5fe	2021-06-22	20:00	21:30	0712174d-c389-4286-af91-8a6b1beb9077	2021-06-18 04:26:26.598+07	2021-06-18 04:26:26.598+07
3bbe2bb7-5475-45fe-b165-48675bd8ccdb	2021-06-23	20:00	21:30	0712174d-c389-4286-af91-8a6b1beb9077	2021-06-18 04:26:26.602+07	2021-06-18 04:26:26.602+07
15258116-cff8-412a-9bef-f040a4788e27	2021-06-22	21:30	23:30	0712174d-c389-4286-af91-8a6b1beb9077	2021-06-18 04:26:49.591+07	2021-06-18 04:26:49.591+07
7721a531-436a-417f-a85c-8b0c4e0101f6	2021-06-23	21:30	23:30	0712174d-c389-4286-af91-8a6b1beb9077	2021-06-18 04:26:49.601+07	2021-06-18 04:26:49.601+07
1e061300-ebae-4d56-966e-1cc63df0b1b1	2021-06-24	21:30	23:30	0712174d-c389-4286-af91-8a6b1beb9077	2021-06-18 04:26:49.605+07	2021-06-18 04:26:49.605+07
1f1b368e-141e-48ed-8853-7eae3f5490c0	2021-06-25	21:30	23:30	0712174d-c389-4286-af91-8a6b1beb9077	2021-06-18 04:26:49.619+07	2021-06-18 04:26:49.619+07
31583053-ad70-4e2e-91c5-03384e4433ca	2021-06-26	07:00	09:00	0712174d-c389-4286-af91-8a6b1beb9077	2021-06-18 04:27:11.178+07	2021-06-18 04:27:11.178+07
45846148-deba-48c4-8235-a324b13f3143	2021-06-19	16:00	18:00	a57371e1-07d7-403f-bd71-fa2f14c7c537	2021-06-18 04:43:13.17+07	2021-06-18 04:43:13.17+07
fcc3c8cf-28eb-4f78-bdbb-4366d8a3d8c9	2021-06-23	16:00	18:00	a57371e1-07d7-403f-bd71-fa2f14c7c537	2021-06-18 04:43:13.178+07	2021-06-18 04:43:13.178+07
0a88e9eb-d3de-479d-bf9e-7ac64fce481f	2021-06-22	16:00	18:00	a57371e1-07d7-403f-bd71-fa2f14c7c537	2021-06-18 04:43:13.182+07	2021-06-18 04:43:13.182+07
d5ad3f60-bcf9-449e-a8c1-e676c28e3ffc	2021-06-18	16:00	18:00	a57371e1-07d7-403f-bd71-fa2f14c7c537	2021-06-18 04:43:13.185+07	2021-06-18 04:43:13.185+07
46add844-d2c4-430a-b4b1-6e865ad783ac	2021-06-20	16:00	18:00	a57371e1-07d7-403f-bd71-fa2f14c7c537	2021-06-18 04:43:13.186+07	2021-06-18 04:43:13.186+07
65d206f4-4a92-4035-9bca-077f4cc2cce9	2021-06-21	16:00	18:00	a57371e1-07d7-403f-bd71-fa2f14c7c537	2021-06-18 04:43:13.188+07	2021-06-18 04:43:13.188+07
42f80cc7-7703-4dd7-b696-423af34437a7	2021-06-24	16:00	18:00	a57371e1-07d7-403f-bd71-fa2f14c7c537	2021-06-18 04:43:13.19+07	2021-06-18 04:43:13.19+07
07f15f8c-4029-4715-a2e2-ae4f32295dd8	2021-06-25	16:00	18:00	a57371e1-07d7-403f-bd71-fa2f14c7c537	2021-06-18 04:43:13.194+07	2021-06-18 04:43:13.194+07
8b3f87a9-817a-4604-a8c2-e3b69c45c2b0	2021-06-26	16:00	18:00	a57371e1-07d7-403f-bd71-fa2f14c7c537	2021-06-18 04:43:13.199+07	2021-06-18 04:43:13.199+07
c28b7bd8-276e-4ad7-8b0f-e6a9e8ae14f8	2021-06-27	16:00	18:00	a57371e1-07d7-403f-bd71-fa2f14c7c537	2021-06-18 04:43:13.201+07	2021-06-18 04:43:13.201+07
1c8dd612-465c-40ac-b331-0d8ac743fb04	2021-06-28	16:00	18:00	a57371e1-07d7-403f-bd71-fa2f14c7c537	2021-06-18 04:43:13.203+07	2021-06-18 04:43:13.203+07
d01d8472-dda7-4c10-9530-6bcf566a8f95	2021-06-29	16:00	18:00	a57371e1-07d7-403f-bd71-fa2f14c7c537	2021-06-18 04:43:13.204+07	2021-06-18 04:43:13.204+07
0aab4e61-24f9-44b7-be16-e459c3cc10ce	2021-06-22	22:00	23:00	a57371e1-07d7-403f-bd71-fa2f14c7c537	2021-06-18 04:43:26.424+07	2021-06-18 04:43:26.424+07
c695d922-d974-47ab-8794-1c3c4d99f41e	2021-06-22	19:00	20:00	a57371e1-07d7-403f-bd71-fa2f14c7c537	2021-06-18 04:43:36.343+07	2021-06-18 04:43:36.343+07
fd4a6c47-e3d7-4e74-87ad-40a59ddb02d4	2021-06-19	20:00	21:00	a57371e1-07d7-403f-bd71-fa2f14c7c537	2021-06-18 04:44:02.984+07	2021-06-18 04:44:02.984+07
0bf20843-1928-49e5-9898-3247164b9428	2021-06-28	11:00	12:00	a57371e1-07d7-403f-bd71-fa2f14c7c537	2021-06-18 04:44:16.769+07	2021-06-18 04:44:16.769+07
bc94b130-eea2-46f9-a638-1acf6e109a83	2021-06-19	19:00	21:00	02ed45b7-b427-4f24-8705-d182b7199e1a	2021-06-18 04:46:51.276+07	2021-06-18 04:46:51.276+07
bb8be244-c8ad-4eff-bba0-8f6071942703	2021-06-19	22:00	23:00	02ed45b7-b427-4f24-8705-d182b7199e1a	2021-06-18 04:47:00.26+07	2021-06-18 04:47:00.26+07
3d506609-2928-43f5-a849-e9d141bcb91e	2021-06-19	13:00	15:00	02ed45b7-b427-4f24-8705-d182b7199e1a	2021-06-18 04:47:11.848+07	2021-06-18 04:47:11.848+07
2bf4da18-bced-47dc-8a31-6bbf9240fb7d	2021-06-20	09:00	11:00	02ed45b7-b427-4f24-8705-d182b7199e1a	2021-06-18 04:47:31.738+07	2021-06-18 04:47:31.738+07
92100587-5662-4797-b821-c13f0a63e60c	2021-06-21	09:00	11:00	02ed45b7-b427-4f24-8705-d182b7199e1a	2021-06-18 04:47:31.748+07	2021-06-18 04:47:31.748+07
e6cf4fd3-08a9-446d-806d-153d98be54c3	2021-06-22	09:00	11:00	02ed45b7-b427-4f24-8705-d182b7199e1a	2021-06-18 04:47:31.757+07	2021-06-18 04:47:31.757+07
dd8df5e1-0cae-4101-8ceb-aa753ec8a4da	2021-06-22	14:00	15:00	02ed45b7-b427-4f24-8705-d182b7199e1a	2021-06-18 04:47:49.069+07	2021-06-18 04:47:49.069+07
397c251d-fb0e-41a1-8fa3-2e6916f4882f	2021-06-23	07:00	08:00	02ed45b7-b427-4f24-8705-d182b7199e1a	2021-06-18 04:48:08.446+07	2021-06-18 04:48:08.446+07
6682c067-7daa-412b-82dc-cbcb0375c21b	2021-06-24	07:00	08:00	02ed45b7-b427-4f24-8705-d182b7199e1a	2021-06-18 04:48:08.457+07	2021-06-18 04:48:08.457+07
d84e3c6f-df86-47cb-826d-1f1bed2c4a0e	2021-06-25	07:00	08:00	02ed45b7-b427-4f24-8705-d182b7199e1a	2021-06-18 04:48:08.462+07	2021-06-18 04:48:08.462+07
fb342fe6-ccd8-447b-9fb7-64ddf0e8d4ca	2021-06-26	07:00	08:00	02ed45b7-b427-4f24-8705-d182b7199e1a	2021-06-18 04:48:08.475+07	2021-06-18 04:48:08.475+07
bca5a9e9-413f-4460-9c4b-e6c507a23b66	2021-06-27	07:00	08:00	02ed45b7-b427-4f24-8705-d182b7199e1a	2021-06-18 04:48:08.483+07	2021-06-18 04:48:08.483+07
0e3178f5-02d7-4f33-b1d7-a674ce1dd7c8	2021-06-29	07:00	08:00	02ed45b7-b427-4f24-8705-d182b7199e1a	2021-06-18 04:48:08.502+07	2021-06-18 04:48:08.502+07
08c2e5a8-4c84-45be-89e5-ec7ba878cc02	2021-06-28	07:00	08:00	02ed45b7-b427-4f24-8705-d182b7199e1a	2021-06-18 04:48:08.494+07	2021-06-18 04:48:08.494+07
f3e04d82-cc17-4d52-a267-91fffc45400f	2021-06-30	07:00	08:00	02ed45b7-b427-4f24-8705-d182b7199e1a	2021-06-18 04:48:08.506+07	2021-06-18 04:48:08.506+07
33bfc837-666b-413e-98f4-504ee86f2808	2021-06-18	07:00	09:00	0728421c-15d0-4a81-8382-a23fb30d6500	2021-06-18 04:56:50.484+07	2021-06-18 04:56:50.484+07
e20fce8f-6a3f-492a-b457-bfb550aa706f	2021-06-19	07:00	09:00	0728421c-15d0-4a81-8382-a23fb30d6500	2021-06-18 04:56:50.488+07	2021-06-18 04:56:50.488+07
bd1a8d26-84e0-4b1f-a840-46395fb0bce7	2021-06-20	07:00	09:00	0728421c-15d0-4a81-8382-a23fb30d6500	2021-06-18 04:56:50.491+07	2021-06-18 04:56:50.491+07
40d6b009-577c-440d-86e3-bacdf9b0a562	2021-06-21	07:00	09:00	0728421c-15d0-4a81-8382-a23fb30d6500	2021-06-18 04:56:50.493+07	2021-06-18 04:56:50.493+07
d77434fd-bc7e-4737-8100-cb8063b1b993	2021-06-22	07:00	09:00	0728421c-15d0-4a81-8382-a23fb30d6500	2021-06-18 04:56:50.496+07	2021-06-18 04:56:50.496+07
8451cfae-cb9b-414e-bade-d82727d23fde	2021-06-23	07:00	09:00	0728421c-15d0-4a81-8382-a23fb30d6500	2021-06-18 04:56:50.499+07	2021-06-18 04:56:50.499+07
31e3b099-50b0-4830-96eb-fc725e8fc329	2021-06-24	07:00	09:00	0728421c-15d0-4a81-8382-a23fb30d6500	2021-06-18 04:56:50.502+07	2021-06-18 04:56:50.502+07
a6a1a059-6f9b-4b48-8dfc-b32a09ee481e	2021-06-25	07:00	09:00	0728421c-15d0-4a81-8382-a23fb30d6500	2021-06-18 04:56:50.504+07	2021-06-18 04:56:50.504+07
60f8f3a9-a8a0-43a3-bafa-c0757d482ab0	2021-06-26	07:00	09:00	0728421c-15d0-4a81-8382-a23fb30d6500	2021-06-18 04:56:50.508+07	2021-06-18 04:56:50.508+07
c68f607e-f81f-429f-8039-6e4dc5098bbd	2021-06-27	07:00	09:00	0728421c-15d0-4a81-8382-a23fb30d6500	2021-06-18 04:56:50.514+07	2021-06-18 04:56:50.514+07
7bd6d638-bbab-4764-903b-57d61127855d	2021-06-29	07:00	09:00	0728421c-15d0-4a81-8382-a23fb30d6500	2021-06-18 04:56:50.519+07	2021-06-18 04:56:50.519+07
0368487a-53b7-4b0f-aafd-edaed78df01b	2021-06-28	07:00	09:00	0728421c-15d0-4a81-8382-a23fb30d6500	2021-06-18 04:56:50.516+07	2021-06-18 04:56:50.516+07
b2c6b0bb-c6c9-471f-a262-31f9c6fa2ab6	2021-06-30	07:00	09:00	0728421c-15d0-4a81-8382-a23fb30d6500	2021-06-18 04:56:50.523+07	2021-06-18 04:56:50.523+07
d37f57c7-270b-42d4-bd17-5984218d698a	2021-06-23	21:00	22:00	0728421c-15d0-4a81-8382-a23fb30d6500	2021-06-18 04:57:01.138+07	2021-06-18 04:57:01.138+07
0ec70a75-bfa6-4ad2-8922-e2b8ec45b58f	2021-06-29	16:00	17:00	0728421c-15d0-4a81-8382-a23fb30d6500	2021-06-18 04:57:10.931+07	2021-06-18 04:57:10.931+07
32d73b5e-a57a-449f-a3c3-ac181d5971f9	2021-06-27	17:00	18:00	0728421c-15d0-4a81-8382-a23fb30d6500	2021-06-18 04:57:22.131+07	2021-06-18 04:57:22.131+07
90bcd78c-86f4-4c25-862e-43b9012161cb	2021-06-18	08:00	10:00	c6e0dd89-bc9d-45f2-87d4-975fd07ff8ba	2021-06-18 04:59:17.453+07	2021-06-18 04:59:17.453+07
5bc6e1f9-ee61-4061-a85f-46135b8ab19a	2021-06-19	08:00	10:00	c6e0dd89-bc9d-45f2-87d4-975fd07ff8ba	2021-06-18 04:59:17.461+07	2021-06-18 04:59:17.461+07
280e0c9c-6c41-4f7a-9d2c-878de4651882	2021-06-20	08:00	10:00	c6e0dd89-bc9d-45f2-87d4-975fd07ff8ba	2021-06-18 04:59:17.471+07	2021-06-18 04:59:17.471+07
41e64f87-6df6-4fed-bbf3-cb9bb6d3336e	2021-06-21	08:00	10:00	c6e0dd89-bc9d-45f2-87d4-975fd07ff8ba	2021-06-18 04:59:17.475+07	2021-06-18 04:59:17.475+07
e1b242ed-70ec-4dd8-8b58-706dfc3e2460	2021-06-22	08:00	10:00	c6e0dd89-bc9d-45f2-87d4-975fd07ff8ba	2021-06-18 04:59:17.484+07	2021-06-18 04:59:17.484+07
122e04d7-9215-41fe-aab3-44dd358bc434	2021-06-23	08:00	10:00	c6e0dd89-bc9d-45f2-87d4-975fd07ff8ba	2021-06-18 04:59:17.491+07	2021-06-18 04:59:17.491+07
2997aaa3-31bc-458e-941f-35c66c8e8aa8	2021-06-24	08:00	10:00	c6e0dd89-bc9d-45f2-87d4-975fd07ff8ba	2021-06-18 04:59:17.496+07	2021-06-18 04:59:17.496+07
31ad59b0-67ff-46d3-a59c-9de3ea6403b5	2021-06-25	08:00	10:00	c6e0dd89-bc9d-45f2-87d4-975fd07ff8ba	2021-06-18 04:59:17.509+07	2021-06-18 04:59:17.509+07
88033f99-4135-4729-8b16-6bfdae02f0e6	2021-06-22	13:00	14:00	c6e0dd89-bc9d-45f2-87d4-975fd07ff8ba	2021-06-18 04:59:33.794+07	2021-06-18 04:59:33.794+07
19bb3447-5931-4339-b977-acff7a6d3f37	2021-06-23	13:00	14:00	c6e0dd89-bc9d-45f2-87d4-975fd07ff8ba	2021-06-18 04:59:33.802+07	2021-06-18 04:59:33.802+07
b81a03ea-7b73-4ebe-aee4-1bddd0645828	2021-06-24	13:00	14:00	c6e0dd89-bc9d-45f2-87d4-975fd07ff8ba	2021-06-18 04:59:33.813+07	2021-06-18 04:59:33.813+07
0c33bff7-fa83-435e-a1aa-4153d33de8c4	2021-06-25	13:00	14:00	c6e0dd89-bc9d-45f2-87d4-975fd07ff8ba	2021-06-18 04:59:33.824+07	2021-06-18 04:59:33.824+07
6ed6da8e-e505-4c38-a679-50ce97627d1c	2021-06-26	13:00	14:00	c6e0dd89-bc9d-45f2-87d4-975fd07ff8ba	2021-06-18 04:59:33.839+07	2021-06-18 04:59:33.839+07
73cdad67-548c-4a90-b2b0-3d961c35c802	2021-06-28	13:00	14:00	c6e0dd89-bc9d-45f2-87d4-975fd07ff8ba	2021-06-18 04:59:33.861+07	2021-06-18 04:59:33.861+07
c3c1d42e-7fcb-495e-8a12-078d96a9a767	2021-06-27	13:00	14:00	c6e0dd89-bc9d-45f2-87d4-975fd07ff8ba	2021-06-18 04:59:33.845+07	2021-06-18 04:59:33.845+07
a09cf400-f9cd-4c9d-822a-50017ac5a260	2021-06-30	13:00	14:00	c6e0dd89-bc9d-45f2-87d4-975fd07ff8ba	2021-06-18 04:59:33.971+07	2021-06-18 04:59:33.971+07
16371d30-c502-4680-ab3c-43d3bc06f20e	2021-06-29	13:00	14:00	c6e0dd89-bc9d-45f2-87d4-975fd07ff8ba	2021-06-18 04:59:33.933+07	2021-06-18 04:59:33.933+07
2a4c34af-db51-4b68-b97d-e07011323333	2021-06-18	08:00	10:00	ed6fd0c2-ed38-430a-ae55-a9e6a460b239	2021-06-18 05:02:12.095+07	2021-06-18 05:02:12.095+07
2bf4e838-99c0-4d40-ba2a-66eb282a465e	2021-06-19	08:00	10:00	ed6fd0c2-ed38-430a-ae55-a9e6a460b239	2021-06-18 05:02:12.098+07	2021-06-18 05:02:12.098+07
bc83da6f-b124-4fad-90f4-bd4bcf65c951	2021-06-20	08:00	10:00	ed6fd0c2-ed38-430a-ae55-a9e6a460b239	2021-06-18 05:02:12.108+07	2021-06-18 05:02:12.108+07
1ea689a8-c795-45bb-a0e6-270b295a0f82	2021-06-21	08:00	10:00	ed6fd0c2-ed38-430a-ae55-a9e6a460b239	2021-06-18 05:02:12.119+07	2021-06-18 05:02:12.119+07
8947375a-9480-487b-a29d-4e091ae8ecdf	2021-06-22	08:00	10:00	ed6fd0c2-ed38-430a-ae55-a9e6a460b239	2021-06-18 05:02:12.137+07	2021-06-18 05:02:12.137+07
92b52ac5-bf90-4c9f-9334-b9bbe2804324	2021-06-23	08:00	10:00	ed6fd0c2-ed38-430a-ae55-a9e6a460b239	2021-06-18 05:02:12.149+07	2021-06-18 05:02:12.149+07
9bd9b651-078b-4b5f-b149-521916099bb9	2021-06-21	06:00	08:00	ed6fd0c2-ed38-430a-ae55-a9e6a460b239	2021-06-18 05:02:28.231+07	2021-06-18 05:02:28.231+07
c4c88d6c-ba2c-4d3e-b657-4a005c7417ef	2021-06-22	06:00	08:00	ed6fd0c2-ed38-430a-ae55-a9e6a460b239	2021-06-18 05:02:28.237+07	2021-06-18 05:02:28.237+07
c24748e0-af14-42a4-852f-9d6cf1ff69f5	2021-06-23	06:00	08:00	ed6fd0c2-ed38-430a-ae55-a9e6a460b239	2021-06-18 05:02:28.245+07	2021-06-18 05:02:28.245+07
62912983-8d78-44c8-a6da-85847ac8dac7	2021-06-24	06:00	08:00	ed6fd0c2-ed38-430a-ae55-a9e6a460b239	2021-06-18 05:02:28.254+07	2021-06-18 05:02:28.254+07
cb1470e5-3cdd-4501-970a-9205521a54c5	2021-06-25	06:00	08:00	ed6fd0c2-ed38-430a-ae55-a9e6a460b239	2021-06-18 05:02:28.258+07	2021-06-18 05:02:28.258+07
fd0bfe69-f560-4d33-b068-44bc03d3238a	2021-06-27	06:00	08:00	ed6fd0c2-ed38-430a-ae55-a9e6a460b239	2021-06-18 05:02:28.269+07	2021-06-18 05:02:28.269+07
5ecfd019-0113-4f62-9627-d0ff08ee26b4	2021-06-26	06:00	08:00	ed6fd0c2-ed38-430a-ae55-a9e6a460b239	2021-06-18 05:02:28.267+07	2021-06-18 05:02:28.267+07
886fbe11-a7a5-4833-9dd7-290bbc507848	2021-06-28	06:00	08:00	ed6fd0c2-ed38-430a-ae55-a9e6a460b239	2021-06-18 05:02:28.299+07	2021-06-18 05:02:28.299+07
12e4ed7b-8add-4b73-9422-564cf4b14056	2021-06-30	06:00	08:00	ed6fd0c2-ed38-430a-ae55-a9e6a460b239	2021-06-18 05:02:28.309+07	2021-06-18 05:02:28.309+07
6033540f-9b92-4bbd-94a6-3f8429ea562c	2021-06-29	06:00	08:00	ed6fd0c2-ed38-430a-ae55-a9e6a460b239	2021-06-18 05:02:28.303+07	2021-06-18 05:02:28.303+07
42424fd5-1cd1-4b83-90d6-eb757577fd75	2021-06-23	16:00	18:00	ed6fd0c2-ed38-430a-ae55-a9e6a460b239	2021-06-18 05:02:51.376+07	2021-06-18 05:02:51.376+07
74c18987-9801-4892-8bf5-c16cf6295439	2021-06-18	08:00	10:00	42c2a84a-163b-44d7-9a72-b136f85b594e	2021-06-18 05:11:48.084+07	2021-06-18 05:11:48.084+07
27eeaa25-3bb0-4684-8714-b006d537b3be	2021-06-19	08:00	10:00	42c2a84a-163b-44d7-9a72-b136f85b594e	2021-06-18 05:11:48.092+07	2021-06-18 05:11:48.092+07
95c98fa3-b28f-4e84-8e7a-664046e7fa37	2021-06-21	08:00	10:00	42c2a84a-163b-44d7-9a72-b136f85b594e	2021-06-18 05:11:48.11+07	2021-06-18 05:11:48.11+07
d57b2b5f-ee29-49ff-9f13-6afe4690e971	2021-06-20	08:00	10:00	42c2a84a-163b-44d7-9a72-b136f85b594e	2021-06-18 05:11:48.099+07	2021-06-18 05:11:48.099+07
aa528adb-56fd-4a88-8fa9-6077cc28d505	2021-06-23	08:00	10:00	42c2a84a-163b-44d7-9a72-b136f85b594e	2021-06-18 05:11:48.138+07	2021-06-18 05:11:48.138+07
768bbf22-c70e-4d62-9aac-733587fa9672	2021-06-22	08:00	10:00	42c2a84a-163b-44d7-9a72-b136f85b594e	2021-06-18 05:11:48.125+07	2021-06-18 05:11:48.125+07
2be2187a-b2ad-4fa8-b246-33166be37147	2021-06-24	08:00	10:00	42c2a84a-163b-44d7-9a72-b136f85b594e	2021-06-18 05:11:48.16+07	2021-06-18 05:11:48.16+07
35c386d5-b6de-4589-b15f-24f27b2691fc	2021-06-25	08:00	10:00	42c2a84a-163b-44d7-9a72-b136f85b594e	2021-06-18 05:11:48.173+07	2021-06-18 05:11:48.173+07
224fbac5-875c-4d0f-bd23-a5e12d5ffd19	2021-06-26	08:00	10:00	42c2a84a-163b-44d7-9a72-b136f85b594e	2021-06-18 05:11:48.176+07	2021-06-18 05:11:48.176+07
ec36cc42-b4f3-4aab-9e82-50f104264179	2021-06-28	08:00	10:00	42c2a84a-163b-44d7-9a72-b136f85b594e	2021-06-18 05:11:48.183+07	2021-06-18 05:11:48.183+07
2a51224d-bc82-41b2-8eb6-f509408c8c2b	2021-06-27	08:00	10:00	42c2a84a-163b-44d7-9a72-b136f85b594e	2021-06-18 05:11:48.18+07	2021-06-18 05:11:48.18+07
0e4fe7ef-c111-46b2-b77e-1b13732f97f3	2021-06-30	08:00	10:00	42c2a84a-163b-44d7-9a72-b136f85b594e	2021-06-18 05:11:48.349+07	2021-06-18 05:11:48.349+07
7ab336e1-a7a7-47db-9a68-939514fea4f6	2021-06-29	08:00	10:00	42c2a84a-163b-44d7-9a72-b136f85b594e	2021-06-18 05:11:48.26+07	2021-06-18 05:11:48.26+07
c975b40f-73a0-441e-98e9-c6f263a30864	2021-06-22	14:00	15:00	42c2a84a-163b-44d7-9a72-b136f85b594e	2021-06-18 05:12:22.687+07	2021-06-18 05:12:22.687+07
9de5c53f-dbe0-42a3-bca4-09cd23e2c844	2021-06-23	14:00	15:00	42c2a84a-163b-44d7-9a72-b136f85b594e	2021-06-18 05:12:22.697+07	2021-06-18 05:12:22.697+07
\.


--
-- TOC entry 3196 (class 0 OID 41808)
-- Dependencies: 212
-- Data for Name: SequelizeMeta; Type: TABLE DATA; Schema: public; Owner: livetutor
--

COPY public."SequelizeMeta" (name) FROM stdin;
20201209155808-user.js
20201219073158-role.js
20201219082620-user-role.js
20201219082621-tutor.js
20201219082631-course.js
20210203133326-create-favorite-tutor.js
20210203133326-message.js
20210203133328-schedule.js
20210203133329-scheduleDetail.js
20210203133330-booking.js
20210203133330-call-session.js
20210203133332-topic.js
20210203133333-tutor-feedback.js
20210203133334-major.js
20210203133335-subMajor.js
20210203133336-wallet.js
20210203133337-transaction.js
20210203133338-fee.js
20210203133338-type.js
20210203133339-category.js
20201219073159-refresh-token.js
\.


--
-- TOC entry 3197 (class 0 OID 41811)
-- Dependencies: 213
-- Data for Name: SubMajors; Type: TABLE DATA; Schema: public; Owner: livetutor
--

COPY public."SubMajors" (id, "majorId", key, "englishName", "vietnameseName", "createdAt", "updatedAt") FROM stdin;
\.


--
-- TOC entry 3198 (class 0 OID 41819)
-- Dependencies: 214
-- Data for Name: Topics; Type: TABLE DATA; Schema: public; Owner: livetutor
--

COPY public."Topics" (id, "courseId", name, description, "orderCourse", "videoUrl", "createdAt", "updatedAt") FROM stdin;
\.


--
-- TOC entry 3199 (class 0 OID 41827)
-- Dependencies: 215
-- Data for Name: Transactions; Type: TABLE DATA; Schema: public; Owner: livetutor
--

COPY public."Transactions" (id, "walletId", "bookingId", price, status, type, "createdAt", "updatedAt") FROM stdin;
40643ed0-7750-4b75-ad9a-67b8ebdcc411	a8bf1a03-ce19-435b-beaa-c0cac14a3a32	\N	200000	success	deposit	2021-06-18 04:15:26.708+07	2021-06-18 04:15:26.708+07
7f6cfe75-7b3e-4941-b40d-95b834799dbc	a8bf1a03-ce19-435b-beaa-c0cac14a3a32	\N	1200000	success	deposit	2021-06-18 04:16:04.593+07	2021-06-18 04:16:04.593+07
1a86ba84-6423-4098-a16e-589bc44024ef	a8bf1a03-ce19-435b-beaa-c0cac14a3a32	c3f3a968-4e74-4964-b14b-2dd5da707ffd	-100000	success	buy	2021-06-18 04:18:10.535+07	2021-06-18 04:18:10.535+07
59e1a890-e911-4ad0-b2f1-1e54e5fa2cde	450272f0-00bb-4d6a-88fb-369f9b176359	c3f3a968-4e74-4964-b14b-2dd5da707ffd	100000	success	sell	2021-06-18 04:18:10.539+07	2021-06-18 04:18:10.539+07
28273867-3306-4bed-b759-45b3b76784b7	a8bf1a03-ce19-435b-beaa-c0cac14a3a32	64912c66-68d7-4928-8dc5-b06975f90371	-100000	success	buy	2021-06-18 04:18:23.89+07	2021-06-18 04:18:23.89+07
2fc2e73f-4d9e-48d9-9fc9-6abab81ffe37	450272f0-00bb-4d6a-88fb-369f9b176359	64912c66-68d7-4928-8dc5-b06975f90371	100000	success	sell	2021-06-18 04:18:23.894+07	2021-06-18 04:18:23.894+07
091e5cae-3d23-4697-a489-2823192c5ed1	a8bf1a03-ce19-435b-beaa-c0cac14a3a32	b92d9839-2be8-43ca-8c8c-01a9c6a69d63	-100000	success	buy	2021-06-18 04:21:21.589+07	2021-06-18 04:21:21.589+07
88fd9382-a08f-4090-b9dc-912a25c9351f	a8bf1a03-ce19-435b-beaa-c0cac14a3a32	e33b12c8-cbc3-4d48-b809-769f80dccb84	-100000	success	buy	2021-06-18 04:21:21.59+07	2021-06-18 04:21:21.59+07
c1f280c9-a4fc-442b-95b5-197b74cab57d	a8bf1a03-ce19-435b-beaa-c0cac14a3a32	8c53465e-cb8b-4be5-997c-9b3cedd922ec	-100000	success	buy	2021-06-18 04:21:21.59+07	2021-06-18 04:21:21.59+07
02c2041c-a9e7-4ab6-b0ad-e495d67fa171	94e96d02-46ef-4374-82f6-526f0e729e72	b92d9839-2be8-43ca-8c8c-01a9c6a69d63	100000	success	sell	2021-06-18 04:21:21.598+07	2021-06-18 04:21:21.598+07
9cac774f-5509-4ced-866f-89d5154d3f18	94e96d02-46ef-4374-82f6-526f0e729e72	e33b12c8-cbc3-4d48-b809-769f80dccb84	100000	success	sell	2021-06-18 04:21:21.598+07	2021-06-18 04:21:21.598+07
88f7314c-b707-4db9-8466-8395b3df4e8b	94e96d02-46ef-4374-82f6-526f0e729e72	8c53465e-cb8b-4be5-997c-9b3cedd922ec	100000	success	sell	2021-06-18 04:21:21.598+07	2021-06-18 04:21:21.598+07
178fd8c9-4e35-4dc0-9173-8075174d5da0	a8bf1a03-ce19-435b-beaa-c0cac14a3a32	cec9d19e-42ba-4904-851a-6fa6fd39b88f	-100000	success	buy	2021-06-18 04:22:10.657+07	2021-06-18 04:22:10.657+07
040df95d-9e25-45ee-98b5-5d75a5a1277d	a8bf1a03-ce19-435b-beaa-c0cac14a3a32	00fe334c-4b8c-4b92-80f3-27df75b3d9b7	-100000	success	buy	2021-06-18 04:22:10.657+07	2021-06-18 04:22:10.657+07
5d100c86-2f17-496a-9f9e-6d0265ef4292	8f468c49-e180-41b3-bbef-163a6ae234b8	cec9d19e-42ba-4904-851a-6fa6fd39b88f	100000	success	sell	2021-06-18 04:22:10.662+07	2021-06-18 04:22:10.662+07
bc95fd94-b3a2-45bb-bb37-54cdc2e95e25	8f468c49-e180-41b3-bbef-163a6ae234b8	00fe334c-4b8c-4b92-80f3-27df75b3d9b7	100000	success	sell	2021-06-18 04:22:10.662+07	2021-06-18 04:22:10.662+07
9a33fee1-d97d-4a8b-b374-ccc9c96a6f5e	a2b70b3d-481e-4c73-b0a0-f05c1479323d	\N	3000000	success	deposit	2021-06-18 04:28:38.621+07	2021-06-18 04:28:38.621+07
31fd2392-ca16-4ff7-a9c0-98c13259cab1	0a66301d-f7d1-4e6d-87a6-3081b807b574	\N	10000000	success	deposit	2021-06-18 04:30:51.58+07	2021-06-18 04:30:51.58+07
4f8adbcb-fed5-48ab-8108-6610d5c0848e	a8bf1a03-ce19-435b-beaa-c0cac14a3a32	49e0fc82-d577-4bc4-a71d-dc5f18ca40d8	-100000	success	buy	2021-06-18 04:45:57.633+07	2021-06-18 04:45:57.633+07
1f24b049-6c26-44ca-bf39-eb81f73624cd	a8bf1a03-ce19-435b-beaa-c0cac14a3a32	43f1659e-ce33-42f6-9e77-0f1b189c1c5f	-100000	success	buy	2021-06-18 04:45:57.633+07	2021-06-18 04:45:57.633+07
f3f7b767-536d-4724-be05-e80e70a43a7d	0a66301d-f7d1-4e6d-87a6-3081b807b574	49e0fc82-d577-4bc4-a71d-dc5f18ca40d8	100000	success	sell	2021-06-18 04:45:57.642+07	2021-06-18 04:45:57.642+07
e0115a57-dd32-4be4-85a6-080a3942309f	0a66301d-f7d1-4e6d-87a6-3081b807b574	43f1659e-ce33-42f6-9e77-0f1b189c1c5f	100000	success	sell	2021-06-18 04:45:57.642+07	2021-06-18 04:45:57.642+07
4a080ee7-9aed-4da7-93fc-04f370c9f665	a8bf1a03-ce19-435b-beaa-c0cac14a3a32	2f19c5de-9d79-4c5a-8a3e-8a397d05692a	-100000	success	buy	2021-06-18 04:48:30.217+07	2021-06-18 04:48:30.217+07
8f358136-55bf-4e86-b1ca-26ec917bfaf3	357d50ba-2377-4c1a-8690-9825f285a8ab	2f19c5de-9d79-4c5a-8a3e-8a397d05692a	100000	success	sell	2021-06-18 04:48:30.222+07	2021-06-18 04:48:30.222+07
433c9310-26df-4576-9e32-d77e4b7883ac	a8bf1a03-ce19-435b-beaa-c0cac14a3a32	75189681-8ff2-4fee-93a6-89ec7ffed4f0	-100000	success	buy	2021-06-18 04:48:44.178+07	2021-06-18 04:48:44.178+07
fbc7383f-3ec0-4c67-8339-afbde88638d1	357d50ba-2377-4c1a-8690-9825f285a8ab	75189681-8ff2-4fee-93a6-89ec7ffed4f0	100000	success	sell	2021-06-18 04:48:44.182+07	2021-06-18 04:48:44.182+07
b63eb0fe-018a-4edd-bbce-2253691dac52	a8bf1a03-ce19-435b-beaa-c0cac14a3a32	ee0f75d6-80a7-4c05-ab94-637dcbb6f269	-100000	success	buy	2021-06-18 04:48:53.737+07	2021-06-18 04:48:53.737+07
fe83396b-9ff1-4376-9d98-07d386454bc6	357d50ba-2377-4c1a-8690-9825f285a8ab	ee0f75d6-80a7-4c05-ab94-637dcbb6f269	100000	success	sell	2021-06-18 04:48:53.741+07	2021-06-18 04:48:53.741+07
153cfd43-3d97-47b2-8344-8c9990bfac53	c04852a8-9969-44dc-ac0f-df8e09418046	\N	4000000	success	deposit	2021-06-18 04:52:16.455+07	2021-06-18 04:52:16.455+07
795c5b8a-6d2a-4f40-bb32-fbb66ced3093	c04852a8-9969-44dc-ac0f-df8e09418046	b084a097-aa8a-4ee5-8dc5-1bf9b4f8b92b	-100000	success	buy	2021-06-18 04:52:31.685+07	2021-06-18 04:52:31.685+07
15be6017-9ea4-4a5c-99ba-27d83992d444	c04852a8-9969-44dc-ac0f-df8e09418046	f1c21c05-3a5f-49ba-8319-9757ee282b68	-100000	success	buy	2021-06-18 04:52:31.685+07	2021-06-18 04:52:31.685+07
6eec4096-2ccb-4e19-bbc4-742f004d7363	357d50ba-2377-4c1a-8690-9825f285a8ab	b084a097-aa8a-4ee5-8dc5-1bf9b4f8b92b	100000	success	sell	2021-06-18 04:52:31.69+07	2021-06-18 04:52:31.69+07
402b771a-2739-4807-ae3d-8b689b451a2f	357d50ba-2377-4c1a-8690-9825f285a8ab	f1c21c05-3a5f-49ba-8319-9757ee282b68	100000	success	sell	2021-06-18 04:52:31.69+07	2021-06-18 04:52:31.69+07
15024224-1b09-4e20-991e-d6d1ed99075c	c04852a8-9969-44dc-ac0f-df8e09418046	ca73fa3d-a030-4eaf-a5eb-1f7b9fdcc035	-100000	success	buy	2021-06-18 04:52:43.4+07	2021-06-18 04:52:43.4+07
e24a8291-8420-4625-9fae-88997b582781	357d50ba-2377-4c1a-8690-9825f285a8ab	ca73fa3d-a030-4eaf-a5eb-1f7b9fdcc035	100000	success	sell	2021-06-18 04:52:43.405+07	2021-06-18 04:52:43.405+07
0773ab29-2317-4cc3-8050-4cbf0bbbd1d2	c04852a8-9969-44dc-ac0f-df8e09418046	e542a757-740c-48da-8f4c-ef291fe65882	-100000	success	buy	2021-06-18 04:52:57.864+07	2021-06-18 04:52:57.864+07
323c1ea2-df44-4469-aec8-d06d45e4d52b	357d50ba-2377-4c1a-8690-9825f285a8ab	e542a757-740c-48da-8f4c-ef291fe65882	100000	success	sell	2021-06-18 04:52:57.867+07	2021-06-18 04:52:57.867+07
cf6c2d34-0285-4c1f-bb6f-49e6cbd5e7b9	c04852a8-9969-44dc-ac0f-df8e09418046	9cf17360-2eb9-4cdd-a7bb-374104a9c344	-100000	success	buy	2021-06-18 04:53:09.988+07	2021-06-18 04:53:09.988+07
c7e210fa-e82d-4fb1-abb9-34184361fde9	357d50ba-2377-4c1a-8690-9825f285a8ab	9cf17360-2eb9-4cdd-a7bb-374104a9c344	100000	success	sell	2021-06-18 04:53:09.993+07	2021-06-18 04:53:09.993+07
9d36b3a0-5703-476c-84f7-a655d9cc5310	c04852a8-9969-44dc-ac0f-df8e09418046	f81fc486-ad04-41a8-9a9c-a5b73447ce2a	-100000	success	buy	2021-06-18 04:53:32.536+07	2021-06-18 04:53:32.536+07
6afb3236-d93e-4c77-8c8b-f99210b997e4	c04852a8-9969-44dc-ac0f-df8e09418046	6c66ba74-5e8e-4497-a237-c94cec9c449f	-100000	success	buy	2021-06-18 04:53:32.536+07	2021-06-18 04:53:32.536+07
255579f1-bce4-4ccf-9d12-f571804411fa	0a66301d-f7d1-4e6d-87a6-3081b807b574	f81fc486-ad04-41a8-9a9c-a5b73447ce2a	100000	success	sell	2021-06-18 04:53:32.543+07	2021-06-18 04:53:32.543+07
ba7371aa-905e-419d-b260-50a77a43428c	0a66301d-f7d1-4e6d-87a6-3081b807b574	6c66ba74-5e8e-4497-a237-c94cec9c449f	100000	success	sell	2021-06-18 04:53:32.544+07	2021-06-18 04:53:32.544+07
20f860e0-b55f-43eb-8d0e-1d59de67970d	c04852a8-9969-44dc-ac0f-df8e09418046	1a11e57c-db2a-4994-a39e-49b0e8f767e0	-100000	success	buy	2021-06-18 04:53:58.901+07	2021-06-18 04:53:58.901+07
04b9c005-34a1-44e6-ab27-c1da71f5dd84	c04852a8-9969-44dc-ac0f-df8e09418046	a0a439ae-ec23-4a49-8dab-afb16ff7dfaf	-100000	success	buy	2021-06-18 04:53:58.901+07	2021-06-18 04:53:58.901+07
6edd0c72-bff4-4fce-b1e2-0355d73930bc	6c8384f3-52da-45df-8a34-b80d88dbf147	1a11e57c-db2a-4994-a39e-49b0e8f767e0	100000	success	sell	2021-06-18 04:53:58.908+07	2021-06-18 04:53:58.908+07
ec88a060-20b4-404e-b721-8d9594949ead	6c8384f3-52da-45df-8a34-b80d88dbf147	a0a439ae-ec23-4a49-8dab-afb16ff7dfaf	100000	success	sell	2021-06-18 04:53:58.909+07	2021-06-18 04:53:58.909+07
c8520b65-c202-4a28-9bf7-b9a3eafe480c	c04852a8-9969-44dc-ac0f-df8e09418046	5e5d03e0-2648-4575-9e4f-2155ba3d1673	-100000	success	buy	2021-06-18 04:54:26.165+07	2021-06-18 04:54:26.165+07
93186625-0fd1-49b4-b33d-cab613ea72e7	6c8384f3-52da-45df-8a34-b80d88dbf147	5e5d03e0-2648-4575-9e4f-2155ba3d1673	100000	success	sell	2021-06-18 04:54:26.171+07	2021-06-18 04:54:26.171+07
c7be1bbf-304e-4d6c-ab71-4af18d0b37b3	c04852a8-9969-44dc-ac0f-df8e09418046	f791a6fb-f69c-4e61-af99-1b0a295be445	-100000	success	buy	2021-06-18 04:57:34.392+07	2021-06-18 04:57:34.392+07
c713b863-39b3-41b2-a0ec-c78160d19fa6	c04852a8-9969-44dc-ac0f-df8e09418046	3619e3ee-82a4-4129-975a-41d63fa83949	-100000	success	buy	2021-06-18 04:57:34.392+07	2021-06-18 04:57:34.392+07
4010713f-0baf-4d97-ae6a-2e0a000fa111	5dcbec92-551d-4ebf-96b1-73ca53262dfb	f791a6fb-f69c-4e61-af99-1b0a295be445	100000	success	sell	2021-06-18 04:57:34.398+07	2021-06-18 04:57:34.398+07
6b91bd6c-7943-466a-bd4d-077600dfb721	5dcbec92-551d-4ebf-96b1-73ca53262dfb	3619e3ee-82a4-4129-975a-41d63fa83949	100000	success	sell	2021-06-18 04:57:34.399+07	2021-06-18 04:57:34.399+07
0e227371-0785-44a3-91f1-52d7838753f0	c04852a8-9969-44dc-ac0f-df8e09418046	77d59126-afc3-487f-b075-66949923c1b4	-100000	success	buy	2021-06-18 04:57:39.783+07	2021-06-18 04:57:39.783+07
e8e0624b-ccf4-4e87-819b-9e558d94f937	5dcbec92-551d-4ebf-96b1-73ca53262dfb	77d59126-afc3-487f-b075-66949923c1b4	100000	success	sell	2021-06-18 04:57:39.787+07	2021-06-18 04:57:39.787+07
e5fb3db2-932a-4b60-9abe-62ec10625384	c04852a8-9969-44dc-ac0f-df8e09418046	50b3dca3-8575-45cd-b922-94f54a175613	-100000	success	buy	2021-06-18 04:57:56.643+07	2021-06-18 04:57:56.643+07
3bd9ccf5-0899-473e-873e-8b219f296157	c04852a8-9969-44dc-ac0f-df8e09418046	b44bf4cb-a18c-4972-81a6-c6a2914c891a	-100000	success	buy	2021-06-18 04:57:56.644+07	2021-06-18 04:57:56.644+07
76ef6643-22a0-4db6-87ec-14ee3db2409c	5dcbec92-551d-4ebf-96b1-73ca53262dfb	50b3dca3-8575-45cd-b922-94f54a175613	100000	success	sell	2021-06-18 04:57:56.65+07	2021-06-18 04:57:56.65+07
4dc15751-4d3c-4842-a588-92d4e02862a2	5dcbec92-551d-4ebf-96b1-73ca53262dfb	b44bf4cb-a18c-4972-81a6-c6a2914c891a	100000	success	sell	2021-06-18 04:57:56.65+07	2021-06-18 04:57:56.65+07
ece39b6c-c25d-4884-818c-a14bc7e617a9	c04852a8-9969-44dc-ac0f-df8e09418046	43b6484f-f9f4-453f-9b1e-818d8a668857	-100000	success	buy	2021-06-18 04:58:06.041+07	2021-06-18 04:58:06.041+07
a2ae3307-f9fc-4bc0-a672-ec6da9948be3	c04852a8-9969-44dc-ac0f-df8e09418046	e4b9618e-107b-4fae-8c5f-27ac0c527224	-100000	success	buy	2021-06-18 04:58:06.041+07	2021-06-18 04:58:06.041+07
7fdabeab-cbd5-4cf4-a411-5bc6c870da29	5dcbec92-551d-4ebf-96b1-73ca53262dfb	43b6484f-f9f4-453f-9b1e-818d8a668857	100000	success	sell	2021-06-18 04:58:06.045+07	2021-06-18 04:58:06.045+07
f6255e1f-a8e8-457d-916b-7cf589505c53	5dcbec92-551d-4ebf-96b1-73ca53262dfb	e4b9618e-107b-4fae-8c5f-27ac0c527224	100000	success	sell	2021-06-18 04:58:06.046+07	2021-06-18 04:58:06.046+07
a0ffe8b4-3e82-4891-be81-02abf837d96a	c04852a8-9969-44dc-ac0f-df8e09418046	2577f1ab-b546-4c82-b891-d0abe16f9fa4	-100000	success	buy	2021-06-18 05:00:25.75+07	2021-06-18 05:00:25.75+07
f44dd7bc-7ecd-445d-b5e7-a5226e6dcc76	c04852a8-9969-44dc-ac0f-df8e09418046	bf38180b-175c-4759-8c07-289e96530dfe	-100000	success	buy	2021-06-18 05:00:25.75+07	2021-06-18 05:00:25.75+07
d607a60f-6deb-4cfd-bbbd-30e73ae14043	14e03d38-2da2-4206-b5f3-142063fd9a3a	2577f1ab-b546-4c82-b891-d0abe16f9fa4	100000	success	sell	2021-06-18 05:00:25.757+07	2021-06-18 05:00:25.757+07
23742ea0-018d-44b6-8ad4-854ac892363a	14e03d38-2da2-4206-b5f3-142063fd9a3a	bf38180b-175c-4759-8c07-289e96530dfe	100000	success	sell	2021-06-18 05:00:25.757+07	2021-06-18 05:00:25.757+07
260f4a41-6b02-4c75-a5b5-8232564fb59a	c04852a8-9969-44dc-ac0f-df8e09418046	474144ad-d3c9-4c96-90c9-493781d598d8	-100000	success	buy	2021-06-18 05:00:43.121+07	2021-06-18 05:00:43.121+07
a8720b3d-5b75-4dfe-b30e-02275b50c256	14e03d38-2da2-4206-b5f3-142063fd9a3a	474144ad-d3c9-4c96-90c9-493781d598d8	100000	success	sell	2021-06-18 05:00:43.125+07	2021-06-18 05:00:43.125+07
6a77fa94-48c8-4f9e-bbef-839df194c530	c04852a8-9969-44dc-ac0f-df8e09418046	d49f52f6-07f8-440a-84fc-dbc21cf87d48	-100000	success	buy	2021-06-18 05:00:53.199+07	2021-06-18 05:00:53.199+07
74c86d82-225c-4f4d-b64c-e2894f821eae	c04852a8-9969-44dc-ac0f-df8e09418046	820ef9c6-2e82-4ea0-af6a-2663fda7a456	-100000	success	buy	2021-06-18 05:00:53.199+07	2021-06-18 05:00:53.199+07
b687e582-751a-4a58-a3b4-b6a806897478	14e03d38-2da2-4206-b5f3-142063fd9a3a	d49f52f6-07f8-440a-84fc-dbc21cf87d48	100000	success	sell	2021-06-18 05:00:53.206+07	2021-06-18 05:00:53.206+07
221fb323-a168-4cac-8b51-08c1f94c290a	14e03d38-2da2-4206-b5f3-142063fd9a3a	820ef9c6-2e82-4ea0-af6a-2663fda7a456	100000	success	sell	2021-06-18 05:00:53.206+07	2021-06-18 05:00:53.206+07
952af9f2-eab9-47d1-a51a-5a4bdeddd2e5	c04852a8-9969-44dc-ac0f-df8e09418046	febd772f-3e3b-4cf9-89b0-c2acaae74913	-100000	success	buy	2021-06-18 05:03:15.471+07	2021-06-18 05:03:15.471+07
de42bfdc-afb8-4a6a-b294-2b3df90d915c	c04852a8-9969-44dc-ac0f-df8e09418046	a95a470e-8a13-41ad-afb2-705a82449216	-100000	success	buy	2021-06-18 05:03:15.472+07	2021-06-18 05:03:15.472+07
c96897d1-e14c-47fc-b9f8-144b9ad718fa	e6c20011-8b8a-4b72-933a-2923fc6f0c34	febd772f-3e3b-4cf9-89b0-c2acaae74913	100000	success	sell	2021-06-18 05:03:15.48+07	2021-06-18 05:03:15.48+07
de236624-e013-40df-994a-68476d6c7ad1	e6c20011-8b8a-4b72-933a-2923fc6f0c34	a95a470e-8a13-41ad-afb2-705a82449216	100000	success	sell	2021-06-18 05:03:15.48+07	2021-06-18 05:03:15.48+07
21854263-e82f-4f57-9b0b-888df8248ebd	c04852a8-9969-44dc-ac0f-df8e09418046	4a2b2fa0-5065-484a-b637-2101ca2acc66	-100000	success	buy	2021-06-18 05:03:28.842+07	2021-06-18 05:03:28.842+07
32cd5dbd-9e78-4dd7-bb22-e7f57a04f094	c04852a8-9969-44dc-ac0f-df8e09418046	725ca5cd-6786-435a-97e1-101cc68b9a3e	-100000	success	buy	2021-06-18 05:03:28.842+07	2021-06-18 05:03:28.842+07
4bd9997f-8d62-49c2-be20-26646c4656d0	e6c20011-8b8a-4b72-933a-2923fc6f0c34	4a2b2fa0-5065-484a-b637-2101ca2acc66	100000	success	sell	2021-06-18 05:03:28.848+07	2021-06-18 05:03:28.848+07
4c5e77a6-09c5-498c-98b1-1b6d4ffef68c	e6c20011-8b8a-4b72-933a-2923fc6f0c34	725ca5cd-6786-435a-97e1-101cc68b9a3e	100000	success	sell	2021-06-18 05:03:28.848+07	2021-06-18 05:03:28.848+07
5259b9b1-54f8-448b-b9ac-13fa7ed77326	c04852a8-9969-44dc-ac0f-df8e09418046	ffbbe8cd-a851-44d5-be1c-b413d8c6e513	-100000	success	buy	2021-06-18 05:03:44.944+07	2021-06-18 05:03:44.944+07
2060a78f-6bf7-49da-8d57-87aebb68c650	c04852a8-9969-44dc-ac0f-df8e09418046	56c4e787-bbf4-4eea-9d0e-38f566a76abd	-100000	success	buy	2021-06-18 05:03:44.945+07	2021-06-18 05:03:44.945+07
92bf11d8-5222-42d1-8583-d8f6fda83596	e6c20011-8b8a-4b72-933a-2923fc6f0c34	ffbbe8cd-a851-44d5-be1c-b413d8c6e513	100000	success	sell	2021-06-18 05:03:44.951+07	2021-06-18 05:03:44.951+07
f898f95f-b4d8-4598-bb97-0761160e47b3	e6c20011-8b8a-4b72-933a-2923fc6f0c34	56c4e787-bbf4-4eea-9d0e-38f566a76abd	100000	success	sell	2021-06-18 05:03:44.951+07	2021-06-18 05:03:44.951+07
e70d6b4f-4680-4155-8e96-c2dfd19ed0b1	706c5fac-993f-421d-9359-ad2eaa4a42d8	\N	5000000	success	deposit	2021-06-18 05:05:11.208+07	2021-06-18 05:05:11.208+07
681b0561-2a72-4447-96c0-a987cc89adb8	706c5fac-993f-421d-9359-ad2eaa4a42d8	607439ca-dde4-4814-bd20-55a11033a9a5	-100000	success	buy	2021-06-18 05:05:40.79+07	2021-06-18 05:05:40.79+07
ea805f85-0395-4cff-9a5d-0c524257f111	706c5fac-993f-421d-9359-ad2eaa4a42d8	e8607d12-3281-4307-a1af-24254bb8b92e	-100000	success	buy	2021-06-18 05:05:40.79+07	2021-06-18 05:05:40.79+07
7b701837-ba2e-4b72-ac6d-5ac2535f2c42	0a66301d-f7d1-4e6d-87a6-3081b807b574	607439ca-dde4-4814-bd20-55a11033a9a5	100000	success	sell	2021-06-18 05:05:40.797+07	2021-06-18 05:05:40.797+07
39f48721-326b-4f45-a491-244baf557678	0a66301d-f7d1-4e6d-87a6-3081b807b574	e8607d12-3281-4307-a1af-24254bb8b92e	100000	success	sell	2021-06-18 05:05:40.797+07	2021-06-18 05:05:40.797+07
6603c33a-e6ad-4129-820a-4d70e7d340ea	706c5fac-993f-421d-9359-ad2eaa4a42d8	cffca1e0-8898-4354-b1ab-d0a2637cd963	-100000	success	buy	2021-06-18 05:05:52.697+07	2021-06-18 05:05:52.697+07
01a82666-6576-44f5-b713-cfb5c32a20ff	706c5fac-993f-421d-9359-ad2eaa4a42d8	372f2ff7-fdba-4496-b827-33be72be1ae0	-100000	success	buy	2021-06-18 05:05:52.697+07	2021-06-18 05:05:52.697+07
e305d23a-795a-4311-a78d-c4ade44dfc36	0a66301d-f7d1-4e6d-87a6-3081b807b574	cffca1e0-8898-4354-b1ab-d0a2637cd963	100000	success	sell	2021-06-18 05:05:52.704+07	2021-06-18 05:05:52.704+07
a3b6c30a-f88d-4665-81fc-2ef34b7f63fd	0a66301d-f7d1-4e6d-87a6-3081b807b574	372f2ff7-fdba-4496-b827-33be72be1ae0	100000	success	sell	2021-06-18 05:05:52.704+07	2021-06-18 05:05:52.704+07
d13557b8-11ee-49c1-a491-c0a3bfe18747	706c5fac-993f-421d-9359-ad2eaa4a42d8	94ba38c1-fcad-4bd8-9995-be34fb869342	-100000	success	buy	2021-06-18 05:06:02.702+07	2021-06-18 05:06:02.702+07
694d4579-227b-4522-bbca-5e3bb8577e7b	706c5fac-993f-421d-9359-ad2eaa4a42d8	2d7aa9c4-6e03-4208-be44-fbe4d10df2f6	-100000	success	buy	2021-06-18 05:06:02.702+07	2021-06-18 05:06:02.702+07
68fb83f4-6f8b-4de3-bd6b-238a76024231	0a66301d-f7d1-4e6d-87a6-3081b807b574	94ba38c1-fcad-4bd8-9995-be34fb869342	100000	success	sell	2021-06-18 05:06:02.708+07	2021-06-18 05:06:02.708+07
1969c6fb-7019-447f-ab7d-ccfb9b704eab	0a66301d-f7d1-4e6d-87a6-3081b807b574	2d7aa9c4-6e03-4208-be44-fbe4d10df2f6	100000	success	sell	2021-06-18 05:06:02.709+07	2021-06-18 05:06:02.709+07
de83e693-5af4-4da7-a0dc-169109c703bc	706c5fac-993f-421d-9359-ad2eaa4a42d8	5971c1a0-6855-49d7-aebd-caa7880557d8	-100000	success	buy	2021-06-18 05:07:35.764+07	2021-06-18 05:07:35.764+07
0f0069a8-a5b3-464f-bd99-a36478a0d8a3	706c5fac-993f-421d-9359-ad2eaa4a42d8	3170b699-c716-46fe-9c1c-bc051d3549c7	-100000	success	buy	2021-06-18 05:07:35.764+07	2021-06-18 05:07:35.764+07
b820d69a-9655-4e20-9668-8eb567aeb829	0a66301d-f7d1-4e6d-87a6-3081b807b574	5971c1a0-6855-49d7-aebd-caa7880557d8	100000	success	sell	2021-06-18 05:07:35.771+07	2021-06-18 05:07:35.771+07
d0999479-1ba1-4729-8528-bcdce0271347	0a66301d-f7d1-4e6d-87a6-3081b807b574	3170b699-c716-46fe-9c1c-bc051d3549c7	100000	success	sell	2021-06-18 05:07:35.772+07	2021-06-18 05:07:35.772+07
a2fac469-49c8-482f-ab3f-c346de94285f	706c5fac-993f-421d-9359-ad2eaa4a42d8	8ad560cd-d230-4b81-8d39-7c39968f9e27	-100000	success	buy	2021-06-18 05:07:48.208+07	2021-06-18 05:07:48.208+07
9834525d-0ec6-4727-9c74-61cbe0ea2a97	706c5fac-993f-421d-9359-ad2eaa4a42d8	b985361e-0512-4795-aeac-da9c4a6e4af6	-100000	success	buy	2021-06-18 05:07:48.209+07	2021-06-18 05:07:48.209+07
0db7539f-9c48-4d20-b5b5-21b806432fb7	e6c20011-8b8a-4b72-933a-2923fc6f0c34	8ad560cd-d230-4b81-8d39-7c39968f9e27	100000	success	sell	2021-06-18 05:07:48.212+07	2021-06-18 05:07:48.212+07
1a203aea-2b50-41ce-a077-5feae6f6459c	e6c20011-8b8a-4b72-933a-2923fc6f0c34	b985361e-0512-4795-aeac-da9c4a6e4af6	100000	success	sell	2021-06-18 05:07:48.212+07	2021-06-18 05:07:48.212+07
86defa39-2e5c-4384-8c66-9b8d4ea74021	706c5fac-993f-421d-9359-ad2eaa4a42d8	4621ea87-2cf1-4169-a073-cba987d87f24	-100000	success	buy	2021-06-18 05:07:56.313+07	2021-06-18 05:07:56.313+07
350052f3-b7e6-4143-ae5f-26a2e2fd78d5	706c5fac-993f-421d-9359-ad2eaa4a42d8	2e0efeba-60ef-4033-bdbb-1a66bac5d67d	-100000	success	buy	2021-06-18 05:07:56.313+07	2021-06-18 05:07:56.313+07
0c05ab02-9cab-4910-93c9-da4953481726	e6c20011-8b8a-4b72-933a-2923fc6f0c34	4621ea87-2cf1-4169-a073-cba987d87f24	100000	success	sell	2021-06-18 05:07:56.32+07	2021-06-18 05:07:56.32+07
bdacecb5-02ae-47b0-b1b6-2cf3900689fc	e6c20011-8b8a-4b72-933a-2923fc6f0c34	2e0efeba-60ef-4033-bdbb-1a66bac5d67d	100000	success	sell	2021-06-18 05:07:56.32+07	2021-06-18 05:07:56.32+07
a3b09b89-5fa3-4dac-868b-092ea20eb554	a27e66a5-1433-4d1b-bfb0-d48c59677b4c	\N	9000000	success	deposit	2021-06-18 05:09:39.614+07	2021-06-18 05:09:39.614+07
6c9e1e93-3f27-4163-b348-c1129d977c36	a27e66a5-1433-4d1b-bfb0-d48c59677b4c	9f40abfd-3e98-4a54-b71c-35047f284a86	-100000	success	buy	2021-06-18 05:09:52.534+07	2021-06-18 05:09:52.534+07
edfae84e-2d3a-49fb-bc81-655c799a504d	a27e66a5-1433-4d1b-bfb0-d48c59677b4c	2d9530c7-d255-4111-a986-9601cae32c9c	-100000	success	buy	2021-06-18 05:09:52.535+07	2021-06-18 05:09:52.535+07
93179de6-7a63-4bd3-8575-ae8f4543c7bd	14e03d38-2da2-4206-b5f3-142063fd9a3a	9f40abfd-3e98-4a54-b71c-35047f284a86	100000	success	sell	2021-06-18 05:09:52.54+07	2021-06-18 05:09:52.54+07
55f628c5-0f60-42d8-a5f1-3f56bae3b29b	14e03d38-2da2-4206-b5f3-142063fd9a3a	2d9530c7-d255-4111-a986-9601cae32c9c	100000	success	sell	2021-06-18 05:09:52.54+07	2021-06-18 05:09:52.54+07
8287b24e-956b-4ea8-b10d-34640cf3156d	a27e66a5-1433-4d1b-bfb0-d48c59677b4c	e6ec280d-5216-4f03-9d17-6584bc7208aa	-100000	success	buy	2021-06-18 05:09:58.911+07	2021-06-18 05:09:58.911+07
a64bca32-9066-4de5-9fb7-3365666443ac	a27e66a5-1433-4d1b-bfb0-d48c59677b4c	04a9ebce-6879-467f-9338-a86734fc26d1	-100000	success	buy	2021-06-18 05:09:58.911+07	2021-06-18 05:09:58.911+07
4e2073b0-47a5-4d1e-877f-28ed471718c4	14e03d38-2da2-4206-b5f3-142063fd9a3a	e6ec280d-5216-4f03-9d17-6584bc7208aa	100000	success	sell	2021-06-18 05:09:58.916+07	2021-06-18 05:09:58.916+07
07e1820a-7f81-4026-aceb-7c0e8c2d4ca7	14e03d38-2da2-4206-b5f3-142063fd9a3a	04a9ebce-6879-467f-9338-a86734fc26d1	100000	success	sell	2021-06-18 05:09:58.917+07	2021-06-18 05:09:58.917+07
164bcd2f-5fc0-49ef-9d8f-611a341843ea	a27e66a5-1433-4d1b-bfb0-d48c59677b4c	41f41727-b586-49ef-ac0a-358421c5776d	-100000	success	buy	2021-06-18 05:10:12.632+07	2021-06-18 05:10:12.632+07
7f196eb7-15da-4859-b211-aa78d6d98e0a	a27e66a5-1433-4d1b-bfb0-d48c59677b4c	1da5e622-601b-465d-9411-ac87ee529374	-100000	success	buy	2021-06-18 05:10:12.632+07	2021-06-18 05:10:12.632+07
e859fe3b-b8cf-4c67-8ead-d243b0503206	357d50ba-2377-4c1a-8690-9825f285a8ab	41f41727-b586-49ef-ac0a-358421c5776d	100000	success	sell	2021-06-18 05:10:12.635+07	2021-06-18 05:10:12.635+07
6553db4c-9c66-4576-9e96-291d76045cc6	357d50ba-2377-4c1a-8690-9825f285a8ab	1da5e622-601b-465d-9411-ac87ee529374	100000	success	sell	2021-06-18 05:10:12.635+07	2021-06-18 05:10:12.635+07
2dd395b4-bfde-4a83-8dfa-625a79778507	5b6ff287-30b6-495b-a194-1a034851b567	\N	3000000	success	deposit	2021-06-18 05:14:44.785+07	2021-06-18 05:14:44.785+07
dfd31bdf-ed48-44a7-bc6c-a25a581ec9b8	5b6ff287-30b6-495b-a194-1a034851b567	5caa49a0-1815-4feb-ad70-7f96da60253d	-100000	success	buy	2021-06-18 05:15:26.66+07	2021-06-18 05:15:26.66+07
9974bb22-6b5c-498f-b3f7-26d469bdc844	5b6ff287-30b6-495b-a194-1a034851b567	627e6da7-4fed-48c0-996a-335c267e4974	-100000	success	buy	2021-06-18 05:15:26.66+07	2021-06-18 05:15:26.66+07
8d9181a9-b997-4d67-ae8a-566e3782ded0	a2b70b3d-481e-4c73-b0a0-f05c1479323d	5caa49a0-1815-4feb-ad70-7f96da60253d	100000	success	sell	2021-06-18 05:15:26.665+07	2021-06-18 05:15:26.665+07
fa54724d-0464-48cc-8fde-e06e154b4875	a2b70b3d-481e-4c73-b0a0-f05c1479323d	627e6da7-4fed-48c0-996a-335c267e4974	100000	success	sell	2021-06-18 05:15:26.665+07	2021-06-18 05:15:26.665+07
5a6673af-268c-4d38-bb73-f9efc2c03b7a	5b6ff287-30b6-495b-a194-1a034851b567	8eac286a-41f4-4898-93d4-3070b52ad439	-100000	success	buy	2021-06-18 05:15:39.941+07	2021-06-18 05:15:39.941+07
095cbf96-be23-4a87-a519-c4797803570c	5b6ff287-30b6-495b-a194-1a034851b567	d2608c66-56dc-4a31-a71f-4089544d42e1	-100000	success	buy	2021-06-18 05:15:39.941+07	2021-06-18 05:15:39.941+07
b2d65b84-9307-4998-83f7-7b79c5b12ad6	5dcbec92-551d-4ebf-96b1-73ca53262dfb	8eac286a-41f4-4898-93d4-3070b52ad439	100000	success	sell	2021-06-18 05:15:39.946+07	2021-06-18 05:15:39.946+07
a7545902-b65b-4e6b-8b78-5044882350d2	5dcbec92-551d-4ebf-96b1-73ca53262dfb	d2608c66-56dc-4a31-a71f-4089544d42e1	100000	success	sell	2021-06-18 05:15:39.946+07	2021-06-18 05:15:39.946+07
19514208-e5f2-4e58-ab79-bd23952453c3	5b6ff287-30b6-495b-a194-1a034851b567	7e92e4c2-810a-4da5-918a-901f2d3f805c	-100000	success	buy	2021-06-18 05:15:58.07+07	2021-06-18 05:15:58.07+07
827e2651-ab65-4ec0-bb3f-12bf6d551aa1	5b6ff287-30b6-495b-a194-1a034851b567	fc141146-23ee-4c73-b0ff-13127ceaf4e9	-100000	success	buy	2021-06-18 05:15:58.07+07	2021-06-18 05:15:58.07+07
e0251b24-328f-4759-a139-4420a43af5c0	80f2de40-8038-4396-b329-82e20fea9ab1	7e92e4c2-810a-4da5-918a-901f2d3f805c	100000	success	sell	2021-06-18 05:15:58.074+07	2021-06-18 05:15:58.074+07
fdb1486f-e39b-40f1-9652-57971b6c538b	80f2de40-8038-4396-b329-82e20fea9ab1	fc141146-23ee-4c73-b0ff-13127ceaf4e9	100000	success	sell	2021-06-18 05:15:58.074+07	2021-06-18 05:15:58.074+07
482c4975-50ca-407f-9770-5cb83502328b	5b6ff287-30b6-495b-a194-1a034851b567	3317243a-08b3-45a5-9327-ece17d04edd1	-100000	success	buy	2021-06-18 05:16:06.459+07	2021-06-18 05:16:06.459+07
1bdda864-ac12-4b59-a6b1-735c20b7dcff	5b6ff287-30b6-495b-a194-1a034851b567	585348e4-cf14-455f-a0ee-9ec0853ab4e9	-100000	success	buy	2021-06-18 05:16:06.459+07	2021-06-18 05:16:06.459+07
d666954a-7116-418a-a33d-26bb55422535	80f2de40-8038-4396-b329-82e20fea9ab1	3317243a-08b3-45a5-9327-ece17d04edd1	100000	success	sell	2021-06-18 05:16:06.465+07	2021-06-18 05:16:06.465+07
12e4b5a9-30d0-4e0e-91f0-806add39eefe	80f2de40-8038-4396-b329-82e20fea9ab1	585348e4-cf14-455f-a0ee-9ec0853ab4e9	100000	success	sell	2021-06-18 05:16:06.465+07	2021-06-18 05:16:06.465+07
\.


--
-- TOC entry 3200 (class 0 OID 41835)
-- Dependencies: 216
-- Data for Name: TutorFeedbacks; Type: TABLE DATA; Schema: public; Owner: livetutor
--

COPY public."TutorFeedbacks" (id, "sessionId", "firstId", "secondId", rating, content, "createdAt", "updatedAt") FROM stdin;
c02aac90-4a8c-4762-81ba-ae611bf23a1e	7800b820-32b1-4647-9c13-fc16643a8d02	5df1c8dd-1939-4fdd-b01d-d03d28ad67eb	02ed45b7-b427-4f24-8705-d182b7199e1a	5	Tuyệt vời	2021-06-25 03:15:07.681+07	2021-06-25 03:15:07.681+07
4525c41b-4291-4dcd-a785-db4a5cb44b9d	ad77bb75-454d-4d1b-a848-eea1d7bfb130	846710e2-e0f4-4f11-b6aa-54efe4fbe455	02ed45b7-b427-4f24-8705-d182b7199e1a	5	2232	2021-06-25 03:16:32.412+07	2021-06-25 03:16:32.412+07
b11b7aad-9105-4ca4-b739-601c455c286d	ef79b9da-5949-4bfc-bd98-82192b7fe4af	74655b72-3b14-463e-98b6-a2f64a459aa9	02ed45b7-b427-4f24-8705-d182b7199e1a	5	proooo	2021-06-25 03:17:23.058+07	2021-06-25 03:17:23.058+07
0bea3bb9-7499-43dd-9a16-ed71864feb8b	2add1213-eaec-4fb4-9fda-415aaf555d6d	04ef870e-60cc-4822-9b6d-67c8143d2029	02ed45b7-b427-4f24-8705-d182b7199e1a	5	abc	2021-06-25 03:18:15.956+07	2021-06-25 03:18:15.956+07
ab6d0e29-7073-4ced-83a9-9d2bb97f0a7e	45be1221-fee3-4fd7-a871-c74b3ee2ed6c	04ef870e-60cc-4822-9b6d-67c8143d2029	0d7d4348-cf7e-4b6a-9a01-1d88f283e910	5	ádasdsad	2021-06-25 03:19:32.954+07	2021-06-25 03:19:32.954+07
d546d796-bc51-4de9-bb10-c4676b0aea19	eb62fa84-69e4-415a-9ec4-4c980bc0f4bd	846710e2-e0f4-4f11-b6aa-54efe4fbe455	0d7d4348-cf7e-4b6a-9a01-1d88f283e910	5	123123	2021-06-25 03:20:40.418+07	2021-06-25 03:20:40.418+07
d6eecc88-3ffd-48db-a0ab-def7ce1f5861	d07deb91-a3ca-4970-bcda-a9691d78bb0c	846710e2-e0f4-4f11-b6aa-54efe4fbe455	02ed45b7-b427-4f24-8705-d182b7199e1a	4	dqdqd	2021-06-25 03:21:32.558+07	2021-06-25 03:21:32.558+07
8ffbf043-2f5c-4829-b448-227a27cfda50	d9011256-57ea-4560-b7ec-d67b4d42ab9b	846710e2-e0f4-4f11-b6aa-54efe4fbe455	c6e0dd89-bc9d-45f2-87d4-975fd07ff8ba	5	123123	2021-06-25 03:22:18.716+07	2021-06-25 03:22:18.716+07
09d59194-9a5a-4ca3-aacb-c4e774a22bc5	66f8359d-5906-41d1-b528-effa8822beac	74655b72-3b14-463e-98b6-a2f64a459aa9	c6e0dd89-bc9d-45f2-87d4-975fd07ff8ba	5	Dạy siêu hay	2021-06-25 03:23:01.732+07	2021-06-25 03:23:01.732+07
e846eda6-7202-4ab7-80fc-6f161d2dc4ab	8b1ccf34-4fba-452f-8ddd-8ed2b5d6d719	74655b72-3b14-463e-98b6-a2f64a459aa9	a57371e1-07d7-403f-bd71-fa2f14c7c537	5	Siêu víp	2021-06-25 03:58:10.382+07	2021-06-25 03:58:10.382+07
\.


--
-- TOC entry 3201 (class 0 OID 41843)
-- Dependencies: 217
-- Data for Name: Tutors; Type: TABLE DATA; Schema: public; Owner: livetutor
--

COPY public."Tutors" (id, "userId", video, bio, languages, specialties, resume, education, experience, accent, "targetStudent", profession, interests, "isActivated", "createdAt", "updatedAt") FROM stdin;
162c019b-82f7-4ba2-aef9-db81442731e8	42c2a84a-163b-44d7-9a72-b136f85b594e	https://api.livetutor.live/video/42c2a84a-163b-44d7-9a72-b136f85b594evideo1623933524577.com - What Happens In One Minute.mp4	Thầy tin rằng với hơn 10 năm kinh nghiệm trong nghề lập trình ở nhiều công ty và trải qua nhiều dự án lớn nhỏ khác nhau, những gì thầy truyền đạt cho các em đều là những thứ các em thực sự cần khi đi làm thực tế. Thầy sẽ giúp các em học nhanh hơn, đỡ vất vả hơn và học đúng trọng tâm thị trường cần.\nThầy tin chắc rằng trong vòng 3-6 tháng, một người chưa biết gì lập trình có thể kiếm được tiền từ lập trình nếu học đúng cách và đủ chăm chỉ.	{"english,italian,united kingdom,indonesia"}	{"of,hc,ds,fl"}	\N	Cựu sinh viên ĐH Bách Khoa Hà Nội.\nTốt nghiệp khoa kỹ nghệ phần mềm (software engineering) tại ĐH FPT\nCEO & Founder của Gia Sư Bảo Châu - Trung tâm có số lượng gia sư giỏi lớn nhất Việt Nam	- Cựu giảng viên tại trung tâm đào tạo lập trình CodeGym\n- Hiện tại đang là Senior Web Developer làm việc remote cho tập đoàn Shopinvest tại Pháp. Đây là một trong những tập đoàn thương mại điện tử lớn nhất của Pháp với hệ thống nhiều website bán hàng lớn như: rueducommerce.fr, 3suisses.fr, mencorner.com, bijourama.com...	\N	Intermediate	Teacher	Hiện tại thầy nhận dạy offline tại nhà riêng hoặc dạy online với thời gian linh hoạt sáng, chiều, tối từ thứ 2 đến thứ 7.\nThầy hiện cũng đang dạy các nhóm nhỏ về PHP/Laravel/Javascript cho các bạn mới bắt đầu. Thầy có thể hỗ trợ để các em có thể tham gia vào các nhóm này để học hiệu quả hơn, tiết kiệm chi phí hơn.\nThầy tin rằng với hơn 10 năm kinh nghiệm trong nghề lập trình ở nhiều công ty và trải qua nhiều dự án lớn nhỏ khác nhau, những gì thầy truyền đạt cho các em đều là những thứ các em thực sự cần khi đi làm thực tế. Thầy sẽ giúp các em học nhanh hơn, đỡ vất vả hơn và học đúng trọng tâm thị trường cần.	t	2021-06-17 19:38:44.776+07	2021-06-18 02:31:31.76+07
27ef7ca8-ba9f-45e2-9e79-b741423fa660	ed6fd0c2-ed38-430a-ae55-a9e6a460b239	https://api.livetutor.live/video/ed6fd0c2-ed38-430a-ae55-a9e6a460b239video1623957239312.mp4	Tôi tên là Lưu Khánh Phương. Quê quán ở Quảng Nam,tôi đã tốt nghiệp ĐH Ngoại Ngữ Huế tháng 5 năm 2016. Ngành ngôn ngữ Anh, chuyên ngành cử nhân tiếng Anh. Hiện đang có kinh nghiệm dạy tiếng Anh được 4 năm.	{"english,spanish"}	{"bs,it,hc,mt,of"}	\N	Đạt Top Teacher liên tiếp tại trung tâm anh ngữ SAS\nGiáo viên dạy tiếng Anh ở trung tâm Anh Ngữ SAS Đà Nẵng	Kinh nghiệm dạy:\n- 9 tháng dạy tiếng Anh cho trẻ em ở Hà Nội tại trung tâm Anh Ngữ Dreams\n- 2/2017 đến 2/2018, đang là giáo viên dạy tiếng Anh ở trung tâm Anh Ngữ IRIS Đà Nẵng\n- 3/2017 đến nay, đang là giáo viên dạy tiếng Anh ONLINE ở trung tâm Anh Ngữ PICCABOO Đà Nẵng.\n- 4/2018 đến nay, đang là giáo viên dạy tiếng Anh ở trung tâm Anh Ngữ SAS Đà Nẵng\n- Đạt Top Teacher liên tiếp tại trung tâm anh ngữ SAS	\N	Advanced	Globetech\r\nTranscription and Grading Analyst.\r\n\r\nVoxpro\r\nCustomer Service Specialist for an online retailer.\r\n\r\nIllustrator\r\nSelf Employed freelance commercial illustrator.	Trong suốt những năm được học và dạy tiếng Anh, tôi tự tin mình có thể bồi dưỡng và dạy các học sinh ở mọi lứa tuổi. Đặc biệt, thế mạnh của tôi là dạy ôn thi đại học, anh văn giao tiếp và có thể giúp đỡ nâng cao được những học sinh bị mất căn bản. Hơn nữa, trong suốt cấp 2 và 3, tôi đều trong top học sinh giỏi văn của trường.\n\nBằng kinh nghiệm và trách nhiệm của 1 giáo viên, tôi tin rằng mình sẽ mang đến những hiệu quả rõ rệt cho các em học sinh, sinh viên tương lai.	t	2021-06-18 02:14:01.958+07	2021-06-18 02:31:40.245+07
41da1af7-847f-4540-b5fc-2693785c9738	0728421c-15d0-4a81-8382-a23fb30d6500	https://api.livetutor.live/video/0728421c-15d0-4a81-8382-a23fb30d6500video1623956191864.com - YingYing Lu 1min SelfIntroduction.mp4	Em hiện đã tốt nghiệp trường Đại học Sư Phạm Hà Nội chuyên ngành sư phạm Âm Nhạc.\nTính đến nay em đã có kinh nghiệm 4 năm dạy tại trung tâm cũng như gia sư. Ngoài những điều được học tại trường về chuyên môn cũng như những kĩ năng về sư phạm, em luôn tìm hiểu những phương pháp dạy học sáng tạo mới phù hợp với những đối tượng học sinh, đặc biệt là với trẻ em.	{"united kingdom,brazil,indonesia"}	{"mt,ds"}	\N	Tốt nghiệp ĐH. Sư Phạm	Trong 4 năm học tại trường ĐHSPHN, em luôn cố gắng trau dồi bản thân, tích cực tham gia những hoạt động ngoại khóa bên ngoài để tích lũy thêm những kinh nghiệm cho bản thân và cũng 1 phần chia sẻ kinh nghiệm với học sinh. Để học tập không chỉ là thầy và trò, mà còn có thể là những người bạn!	\N	Intermediate	Teacher	Ngoài Piano, em còn có thể chơi thêm những nhạc cụ khác như keyboard, đàn Tranh, Guitar, ukulele. Mong muốn những sự hiểu biết này có thể mang đến những nguồn cảm hứng mới cho học sinh của mình.	t	2021-06-18 01:56:34.455+07	2021-06-18 02:31:36.386+07
45bc6d10-eddf-40e5-af24-320eb94b915c	c616bfac-c701-484c-8c3f-f914639be512	https://api.livetutor.live/video/c616bfac-c701-484c-8c3f-f914639be512video1623351190279.com - For Milo AWARD WINNING 1 Minute Short film 2020.mp4	Em đã tốt nghiệp đại học và hiện đang học thạc sĩ Toán học tại trường Đại học sư phạm Hà Nội. Em yêu thích công việc gia sư và mong muốn dùng những kiến thức cũng như phương pháp dạy của mình để giúp đỡ các em học sinh.	{"vietnamese,france,englishm,united kingdom"}	{"mt,fl,it,hc"}	\N	Tốt nghiệp cấp 3\n	Em đã có kinh nghiệm gia sư cho các em học sinh có lực học trung bình, trung bình khá, khá các lớp 6,7,8,9 và các em đều tiến bộ rõ rệt. Quan điểm của em đó là không có gì là không thể chỉ cần cố gắng. 	\N	Intermediate	Tutor	Em rất yêu thích công việc giảng dạy, đúng với chuyên ngành em đang theo học	t	2021-06-11 01:53:10.432+07	2021-06-18 02:31:43.273+07
4849d58b-23c7-4758-87cd-bf88ebb22969	c6e0dd89-bc9d-45f2-87d4-975fd07ff8ba	https://api.livetutor.live/video/c6e0dd89-bc9d-45f2-87d4-975fd07ff8bavideo1623956580739.mp4	Mình là sinh viên đã tốt nghiệp khoa Pháp trường Đại học Hà Nội. Thông thạo tiếng Anh, tiếng Pháp và tiếng Tây Ban Nha	{english}	{"of,hc,it,ds,fl"}	\N	C1 CEFR của châu Âu tiếng Pháp\nHọc tập bên Pháp 1 năm rưỡi	Mình có kinh nghiệm dạy 2 năm và chuyên về ngữ pháp và phát âm, đủ trình độ từ tiểu học -> cấp 3, đã từng làm ở trung tâm MS. Hoa Giao tiếp.\nCòn với tiếng Pháp, trong gần 4 năm qua mình đã giúp hàng chục học sinh thực hiện được ước mơ du học Pháp với tấm bằng TCF và DELF trên tay. Mình thực sự tự tin về khả năng phát âm và giao tiếp cả tiếng Anh lẫn tiếng Pháp.	\N	Advanced	teacher	Với mình, dạy học không chỉ đơn giản là truyền đạt kiến thức mà đó còn là trách nhiệm đánh thức niềm đam mê ngoại ngữ với người học, làm sao để cho học viên thấy hứng thú và muốn học chứ không cảm thấy ép buộc nặng nề, để học viên khám phá về những nét đẹp thật sự của thứ tiếng mà họ đang học.	t	2021-06-18 02:03:03.438+07	2021-06-18 02:31:38.373+07
6703deaa-7a79-4796-ba10-187cc849caf7	0712174d-c389-4286-af91-8a6b1beb9077	https://api.livetutor.live/video/0712174d-c389-4286-af91-8a6b1beb9077video1623943598898.com - Introduce Yourself  Talk About Yourself  Ask About What Others Like  English Speaking Practice.mp4	Mình hiện đang là sinh viên trường đại học Hà Nội ngành ngôn ngữ Anh, khoa Tiếng Anh	{"vietnamese,united states,united kingdom,new Zealand"}	{"bs,it"}	\N	- Thủ khoa xuất sắc kì thi Thạc sĩ Đại học Ngoại Thương năm 2020\n- Điểm thi THPT Quốc gia 2015 : 27.5 điểm khối A1 & 26.25 điểm khối D1 (Toán: 9.75; Lý: 8.0; Anh: 9.75; Văn: 7.75)\n- Giải Ba kì thi HSG cấp tỉnh môn Toán lớp 9 năm học 2011-2012,\n- Thi đỗ 3 trường chuyên trong kì thi Tuyển sinh vào 10 năm học 2012-2013: Chuyên Toán- THPT chuyên ĐHSP HN (10 điểm Toán), Chuyên Anh - THPT chuyên Ngoại Ngữ ĐHQG (9 điểm Toán), Chuyên Toán - THPT chuyên Lê Hồng Phong NĐ (10 điểm Toán),\n- Giải Nhì hùng biện tiếng Anh cấp tỉnh lớp 11,\n- Giải thưởng Hoa Trạng Nguyên 2015 dành cho những thí sinh xuất sắc của kì thi THPT Quốc gia.	- Hơn 9 năm trực tiếp đứng lớp, giảng dạy ngoài giờ tại nhà môn Toán (ôn thi cấp III & luyện thi ĐH) cho các nhóm 5-10-20 học sinh. Nhiều học sinh đỗ vào các trường THPT chuyên & công lập danh tiếng, nhiều học sinh yếu kém tiến bộ lên rõ rệt, thi đạt điểm khá giỏi chỉ sau một học kì. Lối truyền đạt hóm hỉnh, giàu hình ảnh, sáng tạo, dễ hiểu của mình khiến nhiều học sinh hứng thú học, nhiều phụ huynh tín nhiệm.\n- Trong năm học 2019-2020 này, mình đang trực tiếp đứng lớp dạy thêm tại nhà các nhóm Toán 9 (15hs), Toán 10 (10hs), Toán 11 (15hs), Toán 12 (15hs),\n- Có một số Clip dạy online trên Youtube nhận hàng chục ngàn lượt xem, được nhiều học sinh đón nhận hưởng ứng, có tài khoản Facebook riêng để quản lý nhóm học & trao đổi công việc học tập với học sinh.	\N	Beginner	Software engineer	Tôi nhận ra Tiếng Anh là đam mê, khiến tôi hết mình về nó. Nhờ có một nền tảng ngữ pháp chắc chắn và sự chủ động, luôn cố gắng cải thiện ngoại ngữ bằng nhiều cách, tôi giờ có thể tự tin giao tiếp, phát âm tiếng anh chuẩn với một vốn từ tiếng anh phong phú và kiến thức bên lề về văn hóa thế giới.	t	2021-06-17 22:26:41.576+07	2021-06-18 02:31:41.828+07
6e0dc67b-1dc9-44d9-9d22-3db18325a2ca	8aa24fdf-f527-46d8-8523-c21f477c9edf	https://api.livetutor.live/video/8aa24fdf-f527-46d8-8523-c21f477c9edfvideo1623867145123.com - For Milo AWARD WINNING 1 Minute Short film 2020.mp4	Du học sinh đã tốt nghiệp loại giỏi ngành Mechanical Engineering trường University College London (UCL) tại Anh Quốc. Nhận dạy toán tiếng Anh và các môn tự nhiên bằng tiếng Anh từ trình độ căn bản tới IGCSE, AS Level, A-Level, IB và SAT. Dạy nhạc lý, piano và guitar bằng tiếng Anh.	{"vietnamese,english,hong kong"}	{"it,hc,ds,bs"}	\N	IGCSE: Maths, Combined or Co-ordinated Science, Physics, Chemistry, Biology\nA-Level: Maths, Further Maths, Physics\nIB: Maths, Physics\nSAT: Maths	- Giải vàng cuộc thi toán học UK Senior Mathematical Challenge\n- Giải Merit (Top 100) cuộc thi British Physics Olympiad A2 Challenge (cuộc thi Vật Lý toàn nước Anh)	\N	Intermediate	Senior Programmer	Quan điểm của tôi là không có học sinh dốt , chỉ có học sinh lười và cũng chỉ có thầy cô không đủ giỏi mà thôi. Một giáo viên tốt phải là ngườ	t	2021-06-17 01:12:27.754+07	2021-06-18 02:31:46.998+07
981037f9-e9f1-41d4-98cc-5959cce7a3fc	a57371e1-07d7-403f-bd71-fa2f14c7c537	https://api.livetutor.live/video/a57371e1-07d7-403f-bd71-fa2f14c7c537video1623954887833.mp4	Từng là học sinh chuyên Sinh học - trường THPT chuyên Vĩnh Phúc , Vĩnh Phúc, và có điểm thi đầu vào cao nhất chuyên Sinh khóa 2012-2015. Hiện nay đang là sinh viên trường đại học Y Hà Nội , hệ Bác sĩ đa khoa .	{"vietnamese,english"}	{"mt,bs,ds,it"}	\N	Studies International hospitality management at British University Vietnam	+ Tôi đã gia sư cho em Thảo - lớp 11 chuyên Sinh ĐH Khoa học tự nhiên. Từ một học sinh không có cảm hứng về học sinh giỏi sinh học, qua quá trình học tập với tôi, vừa qua em đã đạt giải Nhì HSG Quốc gia năm 2017 và tiếp tục vào vòng 2 ôn luyện thi chọn đội tuyển Olympic quốc tế.\nVừa qua, kết quả là em Thảo đã lọt vào 4 học sinh đội tuyển dự thi Olympic Sinh học quốc tế 2017 tại Vương quốc Anh. Đó là sự nỗ lực không ngừng nghỉ của tôi và bản thân Thảo, hy vọng Thảo sẽ đoạt được kết quả cao nhất trong chuyến đi xuất ngoại đầu tiên.\n+ Tôi đã kèm kiến thức và truyền cảm hứng môn Sinh học cho em Nhi (nhà ở Royal City) và em Tâm Anh (nhà ở Ciputra - Hà Nội) đều bắt đầu học từ cuối năm lớp 9. Hai em đều có quyết tâm cao và cố gắng học hỏi từ thầy cô và tôi trong suốt quá trình giảng dạy.\nKết quả:	\N	Intermediate	none	Với niềm đam mê và nhiệt huyết với môn Sinh học, tôi có thể truyền dạy kinh nghiệm học tập , thi cử cho học sinh , đặc biệt luyện học sinh tham dự đội tuyển thi học sinh giỏi các cấp ,và học sinh lớp 9 luyện thi vào các trường THPT Chuyên.\nNgoài ra hiện nay, tôi có thể bổ sung kiến thức cho các em học sinh có kế hoạch hoặc chuẩn bị du học tùy theo chương mình mà các em sẽ theo học. Sự chuẩn bị kiến thức ở Việt Nam sẽ là một trong những hành trang giúp các em tự tin khi bước sang môi trường học tập mới.	t	2021-06-18 01:34:49.363+07	2021-06-18 02:31:48.582+07
9aef4ca2-24bb-4600-a6f5-fb10814f1e31	02ed45b7-b427-4f24-8705-d182b7199e1a	https://api.livetutor.live/video/02ed45b7-b427-4f24-8705-d182b7199e1avideo1623955891592.mp4	Mình tên là Ngọc Chi. Hiện tại đã tốt nghiệp loại Giỏi trường ĐH Ngoại Thương HN . Trong suốt 12 năm liền mình đều là học sinh khá giỏi . Từ bé đến lớn , mình đã rất yêu thích và đam mê học tiếng anh và tìm tòi các phương pháp học sao cho hiệu quả nhất.	{"vietnamese,english,south korea"}	{"ds,bs,hc,it"}	\N	Graduate in University of Technology and Information	none	\N	Intermediate	Student	Hiện tại thì bên cạnh việc dạy các bạn học sinh theo các khối lớp thì mình cũng mở rộng lứa tuổi của các đối tượng hơn và đa dạng môn học hơn : Có thể là các bạn sinh viên, người đi làm có mong muốn cải thiện khả năng tiếng anh, luyện tiếng anh giao tiếp, luyện ôn thi các chứng chỉ tiếng anh Toeic, Ielts, hay công chức. Mình đã đạt chứng chỉ 6.5 Ielts và có thể nhận dạy các bạn bắt đầu tiếp cận với Ielts.	t	2021-06-18 01:51:34.121+07	2021-06-18 02:31:27.518+07
b3be0106-189a-4fba-9c36-2cee0442ce28	08d34ffc-e19c-40d3-8265-55044d5ed68e	https://api.livetutor.live/video/08d34ffc-e19c-40d3-8265-55044d5ed68evideo1623942938219.com - What Happens In One Minute.mp4	Xin chào, mình là Thư, mình đang là sinh viên năm 3 chuyên ngành Kiến Trúc trường Đại học Kiến Trúc Thành phố Hồ Chí Minh.	{"vietnamese,france,taiwan"}	{"of,bs,ds,fl"}	\N	- Chứng chỉ TOEIC 875/990 (Đọc 485/495)	none	\N	Intermediate	none	Mình thích đọc sách, đi du lịch, tìm hiểu về tính cách con người, chạy bộ, và yêu ngôn ngữ. Mình tin các môn năng khiếu ( vẽ, viết, chụp ảnh,...) là thứ không thể thiếu để sống trong cuộc sống trọn vẹn và màu sắc. Mình luôn nổ lực ứng dụng nghệ thuật vào trong cuộc sống, đặc biệt là trong tập và làm việc.\nMình kiên nhẫn, thoải mái trong buổi học và luôn nổ lực để có được buổi học đầy niềm vui.	t	2021-06-17 22:15:38.39+07	2021-06-18 02:31:34.188+07
b6d32be6-d8c8-48e4-b1d3-fd5f3f24797c	0d7d4348-cf7e-4b6a-9a01-1d88f283e910	https://api.livetutor.live/video/0d7d4348-cf7e-4b6a-9a01-1d88f283e910video1623865846484.com - For Milo AWARD WINNING 1 Minute Short film 2020.mp4	Mình xin tự giới thiệu, mình là Nguyễn Ngọc Nguyên biệt danh là Hoài Bảo, sinh viên năm 4 ĐH Ngoại thương.	{"united states,hong kong,vietnamese,united kingdom,english"}	{"ds,bs,of,it"}	\N	Project Management Certifications	Gần 2 năm đầu đại học mình đã làm trợ giảng, tuy công việc chính là quản lý nhưng mình vẫn thường xuyên dạy các em ở nhiều lứa tuổi khác nhau. Bên cạnh đó, mình là thành viên của 1 CLB dẫn tour cho khách nước ngoài, giúp mình có cơ hội tiếp xúc với người bản xứ thường xuyên, nâng cao kĩ năng nghe-nói.\nKỳ thi THPT 2018 vừa rồi, mình có dạy 1 em lớp 12. Em này bỏ hóa để học tiếng Anh trước lúc thi chỉ hơn 1 tháng. Do chỉ còn 1 tháng, mình chỉ có thể tập trung vào các phương pháp và cách làm bài, nhưng cũng phần nào đã giúp em ấy tăng từ 5-5,5 điểm lên thành 7.4 điểm, một điểm số khá khi đề năm nay khá khó.	\N	Intermediate	none	Trong quá trình dạy, mình hướng người học làm trung tâm, xem mình chỉ là người đồng hành, mỗi buổi học mình sẽ giúp người học hiểu rõ bản chất của một vấn đề, sau đó mở rộng ra các vấn đề có liên quan. Ví dụ như cách học từ vựng, không nên chỉ biết nghĩa của từ đó mà nên học đúng cách phát âm, các từ liên quan (danh từ, động từ, tính từ...), các ví dụ, ngữ cảnh thích hợp. Theo mình đây là một trong những cách học toàn diện, phát triển kĩ năng nghe-nói-đọc-viết.	t	2021-06-17 00:50:48.969+07	2021-06-18 02:31:45.599+07
\.


--
-- TOC entry 3202 (class 0 OID 41851)
-- Dependencies: 218
-- Data for Name: Types; Type: TABLE DATA; Schema: public; Owner: livetutor
--

COPY public."Types" (id, title, "createdAt", "updatedAt") FROM stdin;
128a2815-e6ab-468f-bf03-0cf2dac33dbf	languages	2021-06-10 21:41:32.609363+07	2021-06-10 21:41:32.609363+07
e49cbe3d-2892-4816-b81d-bccf5bbe77e1	specialties	2021-06-10 21:41:32.609363+07	2021-06-10 21:41:32.609363+07
f68b5af3-60ca-430e-b595-f9de8641547c	languages	2021-06-25 03:59:06.760414+07	2021-06-25 03:59:06.760414+07
babdb4f8-6f1f-4563-9d2f-97272a1b1eac	specialties	2021-06-25 03:59:06.760414+07	2021-06-25 03:59:06.760414+07
\.


--
-- TOC entry 3203 (class 0 OID 41856)
-- Dependencies: 219
-- Data for Name: UserRoles; Type: TABLE DATA; Schema: public; Owner: livetutor
--

COPY public."UserRoles" ("userId", "roleId", "createdAt", "updatedAt") FROM stdin;
8e323ef4-c845-4d64-abd0-b19a23999beb	90ae8b64-b728-4457-bf17-f9e5c0f14198	2021-06-10 21:57:03.986+07	2021-06-10 21:57:03.986+07
a018da69-8ea6-4ece-b9f0-2641774892be	90ae8b64-b728-4457-bf17-f9e5c0f14198	2021-06-10 21:57:43.472+07	2021-06-10 21:57:43.472+07
1888758a-4773-4bb9-a038-db93dd4c82e2	90ae8b64-b728-4457-bf17-f9e5c0f14198	2021-06-10 21:58:48.021+07	2021-06-10 21:58:48.021+07
a60ddc2b-16da-4c5b-abb0-19d452ff5203	90ae8b64-b728-4457-bf17-f9e5c0f14198	2021-06-10 21:59:26.296+07	2021-06-10 21:59:26.296+07
5df1c8dd-1939-4fdd-b01d-d03d28ad67eb	90ae8b64-b728-4457-bf17-f9e5c0f14198	2021-06-10 21:59:48.427+07	2021-06-10 21:59:48.427+07
c82580b5-5dc7-4e18-b8fc-6b410c8ebe51	90ae8b64-b728-4457-bf17-f9e5c0f14198	2021-06-10 22:00:07.526+07	2021-06-10 22:00:07.526+07
846710e2-e0f4-4f11-b6aa-54efe4fbe455	90ae8b64-b728-4457-bf17-f9e5c0f14198	2021-06-10 22:00:24.62+07	2021-06-10 22:00:24.62+07
34e95981-3426-4103-9bfd-df43464723d0	90ae8b64-b728-4457-bf17-f9e5c0f14198	2021-06-10 22:00:48.168+07	2021-06-10 22:00:48.168+07
74655b72-3b14-463e-98b6-a2f64a459aa9	90ae8b64-b728-4457-bf17-f9e5c0f14198	2021-06-10 22:01:21.919+07	2021-06-10 22:01:21.919+07
fbf670b6-6a3d-45b1-9711-08de91ac7181	90ae8b64-b728-4457-bf17-f9e5c0f14198	2021-06-10 22:01:55.448+07	2021-06-10 22:01:55.448+07
334e6677-19e0-4f6f-855a-6c948b9ff5e7	90ae8b64-b728-4457-bf17-f9e5c0f14198	2021-06-10 22:02:19.077+07	2021-06-10 22:02:19.077+07
04ef870e-60cc-4822-9b6d-67c8143d2029	90ae8b64-b728-4457-bf17-f9e5c0f14198	2021-06-10 22:02:56.749+07	2021-06-10 22:02:56.749+07
28aa82c9-5b56-4a14-88a4-019dc2e67472	90ae8b64-b728-4457-bf17-f9e5c0f14198	2021-06-10 22:03:36.08+07	2021-06-10 22:03:36.08+07
b7d11f54-cb5b-4c82-9939-ee766159f5e6	90ae8b64-b728-4457-bf17-f9e5c0f14198	2021-06-10 22:03:58.947+07	2021-06-10 22:03:58.947+07
06ad33bf-9aeb-4b69-ba27-45b06f6177e2	90ae8b64-b728-4457-bf17-f9e5c0f14198	2021-06-10 22:04:27.907+07	2021-06-10 22:04:27.907+07
c616bfac-c701-484c-8c3f-f914639be512	90ae8b64-b728-4457-bf17-f9e5c0f14198	2021-06-10 22:05:07.927+07	2021-06-10 22:05:07.927+07
0d7d4348-cf7e-4b6a-9a01-1d88f283e910	90ae8b64-b728-4457-bf17-f9e5c0f14198	2021-06-10 22:05:23.853+07	2021-06-10 22:05:23.853+07
8aa24fdf-f527-46d8-8523-c21f477c9edf	90ae8b64-b728-4457-bf17-f9e5c0f14198	2021-06-10 22:05:45.168+07	2021-06-10 22:05:45.168+07
42c2a84a-163b-44d7-9a72-b136f85b594e	90ae8b64-b728-4457-bf17-f9e5c0f14198	2021-06-10 22:08:06.974+07	2021-06-10 22:08:06.974+07
08d34ffc-e19c-40d3-8265-55044d5ed68e	90ae8b64-b728-4457-bf17-f9e5c0f14198	2021-06-10 22:08:18.589+07	2021-06-10 22:08:18.589+07
0712174d-c389-4286-af91-8a6b1beb9077	90ae8b64-b728-4457-bf17-f9e5c0f14198	2021-06-10 22:08:25.744+07	2021-06-10 22:08:25.744+07
a57371e1-07d7-403f-bd71-fa2f14c7c537	90ae8b64-b728-4457-bf17-f9e5c0f14198	2021-06-10 22:08:35.184+07	2021-06-10 22:08:35.184+07
02ed45b7-b427-4f24-8705-d182b7199e1a	90ae8b64-b728-4457-bf17-f9e5c0f14198	2021-06-10 22:08:40.388+07	2021-06-10 22:08:40.388+07
0728421c-15d0-4a81-8382-a23fb30d6500	90ae8b64-b728-4457-bf17-f9e5c0f14198	2021-06-10 22:08:46.681+07	2021-06-10 22:08:46.681+07
c6e0dd89-bc9d-45f2-87d4-975fd07ff8ba	90ae8b64-b728-4457-bf17-f9e5c0f14198	2021-06-10 22:08:56.53+07	2021-06-10 22:08:56.53+07
ed6fd0c2-ed38-430a-ae55-a9e6a460b239	90ae8b64-b728-4457-bf17-f9e5c0f14198	2021-06-10 22:09:11.417+07	2021-06-10 22:09:11.417+07
c616bfac-c701-484c-8c3f-f914639be512	6f24a66a-421f-4165-bb41-e0e3603a2460	2021-06-11 01:53:10.459+07	2021-06-11 01:53:10.459+07
0d7d4348-cf7e-4b6a-9a01-1d88f283e910	6f24a66a-421f-4165-bb41-e0e3603a2460	2021-06-17 00:50:48.984+07	2021-06-17 00:50:48.984+07
8aa24fdf-f527-46d8-8523-c21f477c9edf	6f24a66a-421f-4165-bb41-e0e3603a2460	2021-06-17 01:12:27.762+07	2021-06-17 01:12:27.762+07
42c2a84a-163b-44d7-9a72-b136f85b594e	6f24a66a-421f-4165-bb41-e0e3603a2460	2021-06-17 19:38:44.793+07	2021-06-17 19:38:44.793+07
08d34ffc-e19c-40d3-8265-55044d5ed68e	6f24a66a-421f-4165-bb41-e0e3603a2460	2021-06-17 22:15:38.403+07	2021-06-17 22:15:38.403+07
0712174d-c389-4286-af91-8a6b1beb9077	6f24a66a-421f-4165-bb41-e0e3603a2460	2021-06-17 22:26:41.586+07	2021-06-17 22:26:41.586+07
a57371e1-07d7-403f-bd71-fa2f14c7c537	6f24a66a-421f-4165-bb41-e0e3603a2460	2021-06-18 01:34:49.385+07	2021-06-18 01:34:49.385+07
02ed45b7-b427-4f24-8705-d182b7199e1a	6f24a66a-421f-4165-bb41-e0e3603a2460	2021-06-18 01:51:34.132+07	2021-06-18 01:51:34.132+07
0728421c-15d0-4a81-8382-a23fb30d6500	6f24a66a-421f-4165-bb41-e0e3603a2460	2021-06-18 01:56:34.467+07	2021-06-18 01:56:34.467+07
c6e0dd89-bc9d-45f2-87d4-975fd07ff8ba	6f24a66a-421f-4165-bb41-e0e3603a2460	2021-06-18 02:03:03.449+07	2021-06-18 02:03:03.449+07
ed6fd0c2-ed38-430a-ae55-a9e6a460b239	6f24a66a-421f-4165-bb41-e0e3603a2460	2021-06-18 02:14:01.97+07	2021-06-18 02:14:01.97+07
62d78dd0-ecbf-40ef-89dc-feeff3f8c5b2	a31e0f43-d0f5-4046-8eb9-837e001b62b6	2021-06-18 02:23:14.728+07	2021-06-18 02:23:14.728+07
\.


--
-- TOC entry 3204 (class 0 OID 41861)
-- Dependencies: 220
-- Data for Name: Users; Type: TABLE DATA; Schema: public; Owner: livetutor
--

COPY public."Users" (id, email, google, facebook, password, avatar, name, country, phone, language, birthday, "isActivated", "requestPassword", "createdAt", "updatedAt", "deletedAt") FROM stdin;
8e323ef4-c845-4d64-abd0-b19a23999beb	student@yopmail.com	\N	\N	$2a$12$uEYawgRlADcyvXqSAp1R2.la301hwgf8HvjXtbGDykZ2C5z719x8K	https://www.alliancerehabmed.com/wp-content/uploads/icon-avatar-default.png	\N	\N	\N	\N	\N	t	f	2021-06-10 21:57:03.503+07	2021-06-10 21:57:29.518+07	\N
a018da69-8ea6-4ece-b9f0-2641774892be	student1@gmail.com	\N	\N	$2a$12$R/5npD.bkPEBCHcGEEZjqO0ooNJpUEJvmTsyjk7qLVlkJErHryA4O	https://www.alliancerehabmed.com/wp-content/uploads/icon-avatar-default.png	\N	\N	\N	\N	\N	f	f	2021-06-10 21:57:42.932+07	2021-06-10 21:57:42.932+07	\N
1888758a-4773-4bb9-a038-db93dd4c82e2	ltstudent1@gmail.com	\N	\N	$2a$12$9Up.cr4gTWDj36L/bu2ONOdcN91ZFlfrYH67Fni8T.VU9SGebmLue	https://www.alliancerehabmed.com/wp-content/uploads/icon-avatar-default.png	\N	\N	\N	\N	\N	f	f	2021-06-10 21:58:47.569+07	2021-06-10 21:58:47.569+07	\N
a60ddc2b-16da-4c5b-abb0-19d452ff5203	ltstudent1@yomail.com	\N	\N	$2a$12$dnuNoZdwz2wG0UibArdNyetBhZSYnzlvY4Z81Qq5inz5zcnO1h3um	https://www.alliancerehabmed.com/wp-content/uploads/icon-avatar-default.png	\N	\N	\N	\N	\N	f	f	2021-06-10 21:59:25.712+07	2021-06-10 21:59:25.712+07	\N
c82580b5-5dc7-4e18-b8fc-6b410c8ebe51	ltstudent2@yomail.com	\N	\N	$2a$12$dPcSudUOL6R9sCgp1lCwW.taNxyO0EOJcq.Qtfg1QEJwZykra5.AK	https://www.alliancerehabmed.com/wp-content/uploads/icon-avatar-default.png	\N	\N	\N	\N	\N	f	f	2021-06-10 22:00:06.994+07	2021-06-10 22:00:06.994+07	\N
b7d11f54-cb5b-4c82-9939-ee766159f5e6	ltstudent9@yopmail.com	\N	\N	$2a$12$zD3Pyogf4aJPl1T/znnfeudv4Cyvep8lq0sr2uSWN9ZLRjoVzNuXe	https://www.alliancerehabmed.com/wp-content/uploads/icon-avatar-default.png	\N	\N	\N	\N	\N	t	f	2021-06-10 22:03:58.328+07	2021-06-10 22:04:15.42+07	\N
06ad33bf-9aeb-4b69-ba27-45b06f6177e2	ltstudent10@yopmail.com	\N	\N	$2a$12$gqYpqeRMTXcQCFxj.hxFhO9n7m4JbrD6nnq.rviL2VEVSHmIt4g5y	https://www.alliancerehabmed.com/wp-content/uploads/icon-avatar-default.png	\N	\N	\N	\N	\N	t	f	2021-06-10 22:04:27.196+07	2021-06-10 22:04:38.26+07	\N
62d78dd0-ecbf-40ef-89dc-feeff3f8c5b2	admin@gmail.com	\N	\N	$2a$12$/gdFOaxjOzkXRn6lUaglUeaNEC50ys07qbAMHJ9UahYC.AUUZv1Ii	https://www.alliancerehabmed.com/wp-content/uploads/icon-avatar-default.png	\N	\N	\N	\N	\N	t	f	2021-06-18 02:23:14.142+07	2021-06-18 02:23:14.142+07	\N
02ed45b7-b427-4f24-8705-d182b7199e1a	lttutor7@yopmail.com	\N	\N	$2a$12$2uzxwLu2bAi156fD8Ihf9eOSORO0MzkmMJup.l9dsexjUF4Q5tVdq	https://api.livetutor.live/avatar/02ed45b7-b427-4f24-8705-d182b7199e1aavatar1623955891558.png	Lê Anh Quân	VN	\N	\N	1993/02/11	t	f	2021-06-10 22:08:39.664+07	2021-06-18 01:51:34.106+07	\N
04ef870e-60cc-4822-9b6d-67c8143d2029	ltstudent7@yopmail.com	\N	\N	$2a$12$hvGCQ0eYTE2jB2AZhjZbJOjELOG6KmewS.x.Q/kFfO3tFLCJMLzyG	https://api.livetutor.live/avatar/04ef870e-60cc-4822-9b6d-67c8143d2029avatar1623962794175.jpg	Thái Thị Gia Sư	AL	063623521	\N	1999/12/08	t	f	2021-06-10 22:02:56.11+07	2021-06-18 03:46:54.271+07	\N
0712174d-c389-4286-af91-8a6b1beb9077	lttutor5@yopmail.com	\N	\N	$2a$12$oSTmK1A6EG1dieCwuQwt9OCGJGMrG5.UV86U6H46F/48e.UZnT.2G	https://api.livetutor.live/avatar/0712174d-c389-4286-af91-8a6b1beb9077avatar1623943598891.jpg	Lê Thị Thanh Tâm	AR	\N	\N	1993/02/03	t	f	2021-06-10 22:08:25.21+07	2021-06-17 22:26:41.568+07	\N
0728421c-15d0-4a81-8382-a23fb30d6500	lttutor8@yopmail.com	\N	\N	$2a$12$mDmxUx.AVxp.xIc3a.hfOOBjiJjHl31jXbu/AErWVswvs9OikdyZm	https://api.livetutor.live/avatar/0728421c-15d0-4a81-8382-a23fb30d6500avatar1623956191864.jpg	Lê Văn Tài	AD	\N	\N	1993/06/12	t	f	2021-06-10 22:08:46.131+07	2021-06-18 01:56:34.448+07	\N
08d34ffc-e19c-40d3-8265-55044d5ed68e	lttutor4@yopmail.com	\N	\N	$2a$12$sRUuar4hoJVpHTk0Qc5GeeeEMeDG.g/mtDNOqvut2yVqsFxijX5D2	https://api.livetutor.live/avatar/08d34ffc-e19c-40d3-8265-55044d5ed68eavatar1623942938107.jpg	Nguyễn Hữu Gia Trí	VN	\N	\N	1998/02/11	t	f	2021-06-10 22:08:18.014+07	2021-06-17 22:15:38.338+07	\N
0d7d4348-cf7e-4b6a-9a01-1d88f283e910	lttutor1@yopmail.com	\N	\N	$2a$12$7jbsovjuWXpvNZgHLOyss.W/QOsG52k54sxqi70dI2s6lVm6SVInu	https://api.livetutor.live/avatar/0d7d4348-cf7e-4b6a-9a01-1d88f283e910avatar1623865846481.jpg	Hoài Bảo	VN	\N	\N	1999/12/02	t	f	2021-06-10 22:05:23.193+07	2021-06-17 00:50:48.951+07	\N
28aa82c9-5b56-4a14-88a4-019dc2e67472	ltstudent8@yopmail.com	\N	\N	$2a$12$hozXIKDLw1.Osj9wQAYib.WFu5UWS6NxPdpzbductbMwa9897PFKW	https://api.livetutor.live/avatar/28aa82c9-5b56-4a14-88a4-019dc2e67472avatar1623962842800.jpg	Trần Thị Cẩm Tú	DZ	0655479989	\N	1999/04/05	t	f	2021-06-10 22:03:35.489+07	2021-06-18 03:47:50.356+07	\N
334e6677-19e0-4f6f-855a-6c948b9ff5e7	ltstudent6@yopmail.com	\N	\N	$2a$12$VN3jsTVWHviznE7wy5p55u2D7yGGOqAzP9XXtrDypDCqeahnfTbqe	https://api.livetutor.live/avatar/334e6677-19e0-4f6f-855a-6c948b9ff5e7avatar1623962310318.jpg	Trần thị Nene	NG	\N	\N	1999/12/01	t	f	2021-06-10 22:02:18.228+07	2021-06-18 03:38:47.798+07	\N
34e95981-3426-4103-9bfd-df43464723d0	ltstudent3@yopmail.com	\N	\N	$2a$12$4CcP0BbmLT4uUInsg2JsaOa46pFfItCCY.wo3o16mzWRFrkymAEdK	https://api.livetutor.live/avatar/34e95981-3426-4103-9bfd-df43464723d0avatar1623959734942.jpg	Chung Minh Chánh	AS	06351661619	\N	1999/05/12	t	f	2021-06-10 22:00:47.482+07	2021-06-18 02:55:56.155+07	\N
42c2a84a-163b-44d7-9a72-b136f85b594e	lttutor3@yopmail.com	\N	\N	$2a$12$SLXddrLB0aw96g4y4QLVUuYo7.tpGXnRpcQozwmazt/HXVF2trr7y	https://api.livetutor.live/avatar/42c2a84a-163b-44d7-9a72-b136f85b594eavatar1623933522141.jpg	Nguyễn Trần Thiên Thanh	AS	\N	\N	1999/09/24	t	f	2021-06-10 22:08:06.468+07	2021-06-17 19:38:44.759+07	\N
5df1c8dd-1939-4fdd-b01d-d03d28ad67eb	ltstudent1@yopmail.com	\N	\N	$2a$12$PZ/5mlWmfrVYIWVzQEgIh..50lu7pNa6lxMHwDB4nMjnNZbh1be2K	https://api.livetutor.live/avatar/5df1c8dd-1939-4fdd-b01d-d03d28ad67ebavatar1623959503420.jpg	Hà Phùng Quan Vũ	VN	0993897999	\N	1999/12/08	t	f	2021-06-10 21:59:47.949+07	2021-06-18 02:52:15.419+07	\N
74655b72-3b14-463e-98b6-a2f64a459aa9	ltstudent4@yopmail.com	\N	\N	$2a$12$HUrjWg1emMBs8ZhVKEcBteSHIQm/2IE5G8BOob3/sh07jcw/CIbB2	https://api.livetutor.live/avatar/74655b72-3b14-463e-98b6-a2f64a459aa9avatar1623961104711.jpg	Đạt Thị Đỗ	BW	0236598421	\N	1999/12/27	t	f	2021-06-10 22:01:21.202+07	2021-06-18 03:27:13.077+07	\N
846710e2-e0f4-4f11-b6aa-54efe4fbe455	ltstudent2@yopmail.com	\N	\N	$2a$12$WhQEGgUKLiME.fXTYTsGH.zmm/rNsjtavlgHNWUIc46R4i4yXRAZ6	https://api.livetutor.live/avatar/846710e2-e0f4-4f11-b6aa-54efe4fbe455avatar1623959653397.jpg	Trương Gia Hân	BJ	0123456789	\N	1999/12/22	t	f	2021-06-10 22:00:23.957+07	2021-06-18 02:54:32.939+07	\N
8aa24fdf-f527-46d8-8523-c21f477c9edf	lttutor2@yopmail.com	\N	\N	$2a$12$lCxmrlPUWymb8t2EqDU20.fQ9/mqRcz2cUoQrcFo5viMKDJ.1VMHS	https://api.livetutor.live/avatar/8aa24fdf-f527-46d8-8523-c21f477c9edfavatar1623867145119.jpg	Huỳnh Thái Anh	CH	\N	\N	1999/09/01	t	f	2021-06-10 22:05:44.533+07	2021-06-17 01:12:27.75+07	\N
a57371e1-07d7-403f-bd71-fa2f14c7c537	lttutor6@yopmail.com	\N	\N	$2a$12$KzI7wKGHH/3gtpXQqiI6d.dNardgqxe2YbbRLWtQ0r30C8T5KV25S	https://api.livetutor.live/avatar/a57371e1-07d7-403f-bd71-fa2f14c7c537avatar1623954887835.jpg	Nguyễn Trần Linh Chi	VN	\N	\N	1996/06/13	t	f	2021-06-10 22:08:34.662+07	2021-06-18 01:34:49.326+07	\N
c616bfac-c701-484c-8c3f-f914639be512	lttutor@yopmail.com	\N	\N	$2a$12$NIT0sJoopwAar0FaFfo5UOJNiNc.PJJl6XXhjEE8uZscDlDNktCGq	https://api.livetutor.live/avatar/c616bfac-c701-484c-8c3f-f914639be512avatar1623351190277.jpg	Trương Hàm Vận	CN	\N	\N	2000/03/08	t	f	2021-06-10 22:05:07.453+07	2021-06-11 01:53:10.409+07	\N
c6e0dd89-bc9d-45f2-87d4-975fd07ff8ba	lttutor9@yopmail.com	\N	\N	$2a$12$Nzt0k8iMyME4Ps6RPddrFeoMdzNhHVl3uAeE5BWTDVqyWRlb1t0A2	https://api.livetutor.live/avatar/c6e0dd89-bc9d-45f2-87d4-975fd07ff8baavatar1623956580728.jpg	Công Tằng Tôn Nữ	AS	\N	\N	1992/02/18	t	f	2021-06-10 22:08:56.007+07	2021-06-18 02:03:03.426+07	\N
ed6fd0c2-ed38-430a-ae55-a9e6a460b239	lttutor10@yopmail.com	\N	\N	$2a$12$rxz6iYTf1a/t8/uBYsU79uI2lBzXr.qZufOSUEhcbRSBtiEodpk7q	https://api.livetutor.live/avatar/ed6fd0c2-ed38-430a-ae55-a9e6a460b239avatar1623957239299.jpg	Võ Tòng	AU	\N	\N	1992/08/20	t	f	2021-06-10 22:09:10.896+07	2021-06-18 02:14:01.951+07	\N
fbf670b6-6a3d-45b1-9711-08de91ac7181	ltstudent5@yopmail.com	\N	\N	$2a$12$3o3rEUR/wElP3gX8m3uR8.mMpSSi5FOtro5amc3b8Jfw0p7FOcbGu	https://api.livetutor.live/avatar/fbf670b6-6a3d-45b1-9711-08de91ac7181avatar1623961666074.jpg	Phan Kim Dung	VN	0996655447	\N	1999/12/06	t	f	2021-06-10 22:01:54.764+07	2021-06-18 03:37:43.678+07	\N
\.


--
-- TOC entry 3205 (class 0 OID 41871)
-- Dependencies: 221
-- Data for Name: Wallets; Type: TABLE DATA; Schema: public; Owner: livetutor
--

COPY public."Wallets" (id, "userId", amount, "isBlocked", "createdAt", "updatedAt") FROM stdin;
9230a98b-7127-4397-bbac-90a9d63b226f	8e323ef4-c845-4d64-abd0-b19a23999beb	0	f	2021-06-10 21:57:03.992+07	2021-06-10 21:57:03.992+07
bfadd867-a3dd-4207-b8b0-3894753f3907	a018da69-8ea6-4ece-b9f0-2641774892be	0	f	2021-06-10 21:57:43.479+07	2021-06-10 21:57:43.479+07
d9c06f4e-926f-471b-9099-3b8016ba18f7	1888758a-4773-4bb9-a038-db93dd4c82e2	0	f	2021-06-10 21:58:48.027+07	2021-06-10 21:58:48.027+07
6aeb0cf2-c18e-47a7-85fa-d6ea6f05c230	a60ddc2b-16da-4c5b-abb0-19d452ff5203	0	f	2021-06-10 21:59:26.301+07	2021-06-10 21:59:26.301+07
2ee23417-b457-4075-8329-acc75827b80f	c82580b5-5dc7-4e18-b8fc-6b410c8ebe51	0	f	2021-06-10 22:00:07.53+07	2021-06-10 22:00:07.53+07
fb4fe179-2033-4e77-ac48-d76a4eb6d64b	334e6677-19e0-4f6f-855a-6c948b9ff5e7	0	f	2021-06-10 22:02:19.082+07	2021-06-10 22:02:19.082+07
3e2bad81-4f9a-45b6-99b3-de2bd5ccebe1	04ef870e-60cc-4822-9b6d-67c8143d2029	0	f	2021-06-10 22:02:56.754+07	2021-06-10 22:02:56.754+07
09cbfeba-020d-47a7-9bc2-5fe760da271b	28aa82c9-5b56-4a14-88a4-019dc2e67472	0	f	2021-06-10 22:03:36.085+07	2021-06-10 22:03:36.085+07
2e775135-3063-4652-bfbc-08629b1d557d	b7d11f54-cb5b-4c82-9939-ee766159f5e6	0	f	2021-06-10 22:03:58.952+07	2021-06-10 22:03:58.952+07
94a94113-4434-47d3-8bd4-d197da31a8e3	06ad33bf-9aeb-4b69-ba27-45b06f6177e2	0	f	2021-06-10 22:04:27.912+07	2021-06-10 22:04:27.912+07
802ed413-a80b-4deb-a4fa-57fbd2718044	62d78dd0-ecbf-40ef-89dc-feeff3f8c5b2	0	f	2021-06-18 02:23:14.732+07	2021-06-18 02:23:14.732+07
c04852a8-9969-44dc-ac0f-df8e09418046	846710e2-e0f4-4f11-b6aa-54efe4fbe455	1200000	f	2021-06-10 22:00:24.626+07	2021-06-18 05:03:44.939+07
450272f0-00bb-4d6a-88fb-369f9b176359	8aa24fdf-f527-46d8-8523-c21f477c9edf	200000	f	2021-06-10 22:05:45.172+07	2021-06-18 04:18:23.887+07
94e96d02-46ef-4374-82f6-526f0e729e72	c616bfac-c701-484c-8c3f-f914639be512	300000	f	2021-06-10 22:05:07.932+07	2021-06-18 04:21:21.587+07
8f468c49-e180-41b3-bbef-163a6ae234b8	0d7d4348-cf7e-4b6a-9a01-1d88f283e910	200000	f	2021-06-10 22:05:23.859+07	2021-06-18 04:22:10.654+07
0a66301d-f7d1-4e6d-87a6-3081b807b574	a57371e1-07d7-403f-bd71-fa2f14c7c537	11200000	f	2021-06-10 22:08:35.187+07	2021-06-18 05:07:35.763+07
706c5fac-993f-421d-9359-ad2eaa4a42d8	34e95981-3426-4103-9bfd-df43464723d0	3800000	f	2021-06-10 22:00:48.173+07	2021-06-18 05:07:56.309+07
a8bf1a03-ce19-435b-beaa-c0cac14a3a32	5df1c8dd-1939-4fdd-b01d-d03d28ad67eb	200000	f	2021-06-10 21:59:48.43+07	2021-06-18 04:48:53.732+07
e6c20011-8b8a-4b72-933a-2923fc6f0c34	ed6fd0c2-ed38-430a-ae55-a9e6a460b239	1000000	f	2021-06-10 22:09:11.419+07	2021-06-18 05:07:56.311+07
14e03d38-2da2-4206-b5f3-142063fd9a3a	c6e0dd89-bc9d-45f2-87d4-975fd07ff8ba	900000	f	2021-06-10 22:08:56.533+07	2021-06-18 05:09:58.909+07
a27e66a5-1433-4d1b-bfb0-d48c59677b4c	74655b72-3b14-463e-98b6-a2f64a459aa9	8400000	f	2021-06-10 22:01:21.924+07	2021-06-18 05:10:12.626+07
357d50ba-2377-4c1a-8690-9825f285a8ab	02ed45b7-b427-4f24-8705-d182b7199e1a	1000000	f	2021-06-10 22:08:40.392+07	2021-06-18 05:10:12.629+07
a2b70b3d-481e-4c73-b0a0-f05c1479323d	0712174d-c389-4286-af91-8a6b1beb9077	3200000	f	2021-06-10 22:08:25.748+07	2021-06-18 05:15:26.657+07
5dcbec92-551d-4ebf-96b1-73ca53262dfb	0728421c-15d0-4a81-8382-a23fb30d6500	900000	f	2021-06-10 22:08:46.684+07	2021-06-18 05:15:39.939+07
6c8384f3-52da-45df-8a34-b80d88dbf147	08d34ffc-e19c-40d3-8265-55044d5ed68e	300000	f	2021-06-10 22:08:18.593+07	2021-06-18 04:54:26.163+07
5b6ff287-30b6-495b-a194-1a034851b567	fbf670b6-6a3d-45b1-9711-08de91ac7181	2200000	f	2021-06-10 22:01:55.454+07	2021-06-18 05:16:06.455+07
80f2de40-8038-4396-b329-82e20fea9ab1	42c2a84a-163b-44d7-9a72-b136f85b594e	400000	f	2021-06-10 22:08:06.978+07	2021-06-18 05:16:06.457+07
\.


--
-- TOC entry 2990 (class 2606 OID 41879)
-- Name: Bookings Bookings_pkey; Type: CONSTRAINT; Schema: public; Owner: livetutor
--

ALTER TABLE ONLY public."Bookings"
    ADD CONSTRAINT "Bookings_pkey" PRIMARY KEY (id);


--
-- TOC entry 2992 (class 2606 OID 41881)
-- Name: CallSessions CallSessions_pkey; Type: CONSTRAINT; Schema: public; Owner: livetutor
--

ALTER TABLE ONLY public."CallSessions"
    ADD CONSTRAINT "CallSessions_pkey" PRIMARY KEY (id);


--
-- TOC entry 2994 (class 2606 OID 41883)
-- Name: Categories Categories_pkey; Type: CONSTRAINT; Schema: public; Owner: livetutor
--

ALTER TABLE ONLY public."Categories"
    ADD CONSTRAINT "Categories_pkey" PRIMARY KEY (id);


--
-- TOC entry 2996 (class 2606 OID 41885)
-- Name: Courses Courses_pkey; Type: CONSTRAINT; Schema: public; Owner: livetutor
--

ALTER TABLE ONLY public."Courses"
    ADD CONSTRAINT "Courses_pkey" PRIMARY KEY (id);


--
-- TOC entry 2998 (class 2606 OID 41887)
-- Name: FavoriteTutors FavoriteTutors_pkey; Type: CONSTRAINT; Schema: public; Owner: livetutor
--

ALTER TABLE ONLY public."FavoriteTutors"
    ADD CONSTRAINT "FavoriteTutors_pkey" PRIMARY KEY (id);


--
-- TOC entry 3000 (class 2606 OID 41889)
-- Name: Fees Fees_pkey; Type: CONSTRAINT; Schema: public; Owner: livetutor
--

ALTER TABLE ONLY public."Fees"
    ADD CONSTRAINT "Fees_pkey" PRIMARY KEY (id);


--
-- TOC entry 3002 (class 2606 OID 41891)
-- Name: Majors Majors_pkey; Type: CONSTRAINT; Schema: public; Owner: livetutor
--

ALTER TABLE ONLY public."Majors"
    ADD CONSTRAINT "Majors_pkey" PRIMARY KEY (id);


--
-- TOC entry 3004 (class 2606 OID 41893)
-- Name: Messages Messages_pkey; Type: CONSTRAINT; Schema: public; Owner: livetutor
--

ALTER TABLE ONLY public."Messages"
    ADD CONSTRAINT "Messages_pkey" PRIMARY KEY (id);


--
-- TOC entry 3006 (class 2606 OID 41895)
-- Name: RefreshTokens RefreshTokens_pkey; Type: CONSTRAINT; Schema: public; Owner: livetutor
--

ALTER TABLE ONLY public."RefreshTokens"
    ADD CONSTRAINT "RefreshTokens_pkey" PRIMARY KEY (id);


--
-- TOC entry 3008 (class 2606 OID 41897)
-- Name: Roles Roles_pkey; Type: CONSTRAINT; Schema: public; Owner: livetutor
--

ALTER TABLE ONLY public."Roles"
    ADD CONSTRAINT "Roles_pkey" PRIMARY KEY (id);


--
-- TOC entry 3010 (class 2606 OID 41899)
-- Name: ScheduleDetails ScheduleDetails_pkey; Type: CONSTRAINT; Schema: public; Owner: livetutor
--

ALTER TABLE ONLY public."ScheduleDetails"
    ADD CONSTRAINT "ScheduleDetails_pkey" PRIMARY KEY (id);


--
-- TOC entry 3012 (class 2606 OID 41901)
-- Name: Schedules Schedules_pkey; Type: CONSTRAINT; Schema: public; Owner: livetutor
--

ALTER TABLE ONLY public."Schedules"
    ADD CONSTRAINT "Schedules_pkey" PRIMARY KEY (id);


--
-- TOC entry 3014 (class 2606 OID 41903)
-- Name: SequelizeMeta SequelizeMeta_pkey; Type: CONSTRAINT; Schema: public; Owner: livetutor
--

ALTER TABLE ONLY public."SequelizeMeta"
    ADD CONSTRAINT "SequelizeMeta_pkey" PRIMARY KEY (name);


--
-- TOC entry 3016 (class 2606 OID 41905)
-- Name: SubMajors SubMajors_pkey; Type: CONSTRAINT; Schema: public; Owner: livetutor
--

ALTER TABLE ONLY public."SubMajors"
    ADD CONSTRAINT "SubMajors_pkey" PRIMARY KEY (id);


--
-- TOC entry 3018 (class 2606 OID 41907)
-- Name: Topics Topics_pkey; Type: CONSTRAINT; Schema: public; Owner: livetutor
--

ALTER TABLE ONLY public."Topics"
    ADD CONSTRAINT "Topics_pkey" PRIMARY KEY (id);


--
-- TOC entry 3020 (class 2606 OID 41909)
-- Name: Transactions Transactions_pkey; Type: CONSTRAINT; Schema: public; Owner: livetutor
--

ALTER TABLE ONLY public."Transactions"
    ADD CONSTRAINT "Transactions_pkey" PRIMARY KEY (id);


--
-- TOC entry 3022 (class 2606 OID 41911)
-- Name: TutorFeedbacks TutorFeedbacks_pkey; Type: CONSTRAINT; Schema: public; Owner: livetutor
--

ALTER TABLE ONLY public."TutorFeedbacks"
    ADD CONSTRAINT "TutorFeedbacks_pkey" PRIMARY KEY (id);


--
-- TOC entry 3024 (class 2606 OID 41913)
-- Name: Tutors Tutors_pkey; Type: CONSTRAINT; Schema: public; Owner: livetutor
--

ALTER TABLE ONLY public."Tutors"
    ADD CONSTRAINT "Tutors_pkey" PRIMARY KEY (id);


--
-- TOC entry 3026 (class 2606 OID 41915)
-- Name: Types Types_pkey; Type: CONSTRAINT; Schema: public; Owner: livetutor
--

ALTER TABLE ONLY public."Types"
    ADD CONSTRAINT "Types_pkey" PRIMARY KEY (id);


--
-- TOC entry 3028 (class 2606 OID 41917)
-- Name: UserRoles UserRoles_pkey; Type: CONSTRAINT; Schema: public; Owner: livetutor
--

ALTER TABLE ONLY public."UserRoles"
    ADD CONSTRAINT "UserRoles_pkey" PRIMARY KEY ("userId", "roleId");


--
-- TOC entry 3030 (class 2606 OID 41919)
-- Name: Users Users_pkey; Type: CONSTRAINT; Schema: public; Owner: livetutor
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_pkey" PRIMARY KEY (id);


--
-- TOC entry 3032 (class 2606 OID 41921)
-- Name: Wallets Wallets_pkey; Type: CONSTRAINT; Schema: public; Owner: livetutor
--

ALTER TABLE ONLY public."Wallets"
    ADD CONSTRAINT "Wallets_pkey" PRIMARY KEY (id);


--
-- TOC entry 3033 (class 2606 OID 41922)
-- Name: Bookings Bookings_scheduleDetailId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: livetutor
--

ALTER TABLE ONLY public."Bookings"
    ADD CONSTRAINT "Bookings_scheduleDetailId_fkey" FOREIGN KEY ("scheduleDetailId") REFERENCES public."ScheduleDetails"(id);


--
-- TOC entry 3034 (class 2606 OID 41927)
-- Name: Bookings Bookings_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: livetutor
--

ALTER TABLE ONLY public."Bookings"
    ADD CONSTRAINT "Bookings_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."Users"(id);


--
-- TOC entry 3035 (class 2606 OID 41932)
-- Name: CallSessions CallSessions_studentId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: livetutor
--

ALTER TABLE ONLY public."CallSessions"
    ADD CONSTRAINT "CallSessions_studentId_fkey" FOREIGN KEY ("studentId") REFERENCES public."Users"(id);


--
-- TOC entry 3036 (class 2606 OID 41937)
-- Name: CallSessions CallSessions_tutorId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: livetutor
--

ALTER TABLE ONLY public."CallSessions"
    ADD CONSTRAINT "CallSessions_tutorId_fkey" FOREIGN KEY ("tutorId") REFERENCES public."Users"(id);


--
-- TOC entry 3037 (class 2606 OID 41942)
-- Name: Courses Courses_tutorId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: livetutor
--

ALTER TABLE ONLY public."Courses"
    ADD CONSTRAINT "Courses_tutorId_fkey" FOREIGN KEY ("tutorId") REFERENCES public."Users"(id);


--
-- TOC entry 3038 (class 2606 OID 41947)
-- Name: Messages Messages_fromId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: livetutor
--

ALTER TABLE ONLY public."Messages"
    ADD CONSTRAINT "Messages_fromId_fkey" FOREIGN KEY ("fromId") REFERENCES public."Users"(id);


--
-- TOC entry 3039 (class 2606 OID 41952)
-- Name: Messages Messages_toId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: livetutor
--

ALTER TABLE ONLY public."Messages"
    ADD CONSTRAINT "Messages_toId_fkey" FOREIGN KEY ("toId") REFERENCES public."Users"(id);


--
-- TOC entry 3040 (class 2606 OID 41957)
-- Name: RefreshTokens RefreshTokens_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: livetutor
--

ALTER TABLE ONLY public."RefreshTokens"
    ADD CONSTRAINT "RefreshTokens_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."Users"(id);


--
-- TOC entry 3041 (class 2606 OID 41962)
-- Name: ScheduleDetails ScheduleDetails_scheduleId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: livetutor
--

ALTER TABLE ONLY public."ScheduleDetails"
    ADD CONSTRAINT "ScheduleDetails_scheduleId_fkey" FOREIGN KEY ("scheduleId") REFERENCES public."Schedules"(id);


--
-- TOC entry 3042 (class 2606 OID 41967)
-- Name: Schedules Schedules_tutorId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: livetutor
--

ALTER TABLE ONLY public."Schedules"
    ADD CONSTRAINT "Schedules_tutorId_fkey" FOREIGN KEY ("tutorId") REFERENCES public."Users"(id);


--
-- TOC entry 3043 (class 2606 OID 41972)
-- Name: SubMajors SubMajors_majorId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: livetutor
--

ALTER TABLE ONLY public."SubMajors"
    ADD CONSTRAINT "SubMajors_majorId_fkey" FOREIGN KEY ("majorId") REFERENCES public."Majors"(id);


--
-- TOC entry 3044 (class 2606 OID 41977)
-- Name: Topics Topics_courseId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: livetutor
--

ALTER TABLE ONLY public."Topics"
    ADD CONSTRAINT "Topics_courseId_fkey" FOREIGN KEY ("courseId") REFERENCES public."Courses"(id);


--
-- TOC entry 3045 (class 2606 OID 41982)
-- Name: Transactions Transactions_bookingId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: livetutor
--

ALTER TABLE ONLY public."Transactions"
    ADD CONSTRAINT "Transactions_bookingId_fkey" FOREIGN KEY ("bookingId") REFERENCES public."Bookings"(id);


--
-- TOC entry 3046 (class 2606 OID 41987)
-- Name: Transactions Transactions_walletId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: livetutor
--

ALTER TABLE ONLY public."Transactions"
    ADD CONSTRAINT "Transactions_walletId_fkey" FOREIGN KEY ("walletId") REFERENCES public."Wallets"(id);


--
-- TOC entry 3047 (class 2606 OID 41992)
-- Name: TutorFeedbacks TutorFeedbacks_firstId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: livetutor
--

ALTER TABLE ONLY public."TutorFeedbacks"
    ADD CONSTRAINT "TutorFeedbacks_firstId_fkey" FOREIGN KEY ("firstId") REFERENCES public."Users"(id);


--
-- TOC entry 3048 (class 2606 OID 41997)
-- Name: TutorFeedbacks TutorFeedbacks_secondId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: livetutor
--

ALTER TABLE ONLY public."TutorFeedbacks"
    ADD CONSTRAINT "TutorFeedbacks_secondId_fkey" FOREIGN KEY ("secondId") REFERENCES public."Users"(id);


--
-- TOC entry 3049 (class 2606 OID 42002)
-- Name: TutorFeedbacks TutorFeedbacks_sessionId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: livetutor
--

ALTER TABLE ONLY public."TutorFeedbacks"
    ADD CONSTRAINT "TutorFeedbacks_sessionId_fkey" FOREIGN KEY ("sessionId") REFERENCES public."CallSessions"(id);


--
-- TOC entry 3050 (class 2606 OID 42007)
-- Name: Tutors Tutors_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: livetutor
--

ALTER TABLE ONLY public."Tutors"
    ADD CONSTRAINT "Tutors_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."Users"(id);


--
-- TOC entry 3051 (class 2606 OID 42012)
-- Name: UserRoles UserRoles_roleId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: livetutor
--

ALTER TABLE ONLY public."UserRoles"
    ADD CONSTRAINT "UserRoles_roleId_fkey" FOREIGN KEY ("roleId") REFERENCES public."Roles"(id);


--
-- TOC entry 3052 (class 2606 OID 42017)
-- Name: UserRoles UserRoles_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: livetutor
--

ALTER TABLE ONLY public."UserRoles"
    ADD CONSTRAINT "UserRoles_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."Users"(id);


--
-- TOC entry 3053 (class 2606 OID 42022)
-- Name: Wallets Wallets_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: livetutor
--

ALTER TABLE ONLY public."Wallets"
    ADD CONSTRAINT "Wallets_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."Users"(id);


-- Completed on 2021-06-25 17:25:30

--
-- PostgreSQL database dump complete
--

