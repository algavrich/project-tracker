--
-- PostgreSQL database dump
--

-- Dumped from database version 13.7 (Ubuntu 13.7-1.pgdg20.04+1)
-- Dumped by pg_dump version 13.7 (Ubuntu 13.7-1.pgdg20.04+1)

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
-- Name: grades; Type: TABLE; Schema: public; Owner: algavrich
--

CREATE TABLE public.grades (
    id integer NOT NULL,
    student_github character varying(30),
    project_title character varying(30),
    grade integer
);


ALTER TABLE public.grades OWNER TO algavrich;

--
-- Name: grades_id_seq; Type: SEQUENCE; Schema: public; Owner: algavrich
--

CREATE SEQUENCE public.grades_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.grades_id_seq OWNER TO algavrich;

--
-- Name: grades_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: algavrich
--

ALTER SEQUENCE public.grades_id_seq OWNED BY public.grades.id;


--
-- Name: projects; Type: TABLE; Schema: public; Owner: algavrich
--

CREATE TABLE public.projects (
    id integer NOT NULL,
    title character varying(30),
    description text,
    max_grade integer
);


ALTER TABLE public.projects OWNER TO algavrich;

--
-- Name: projects_id_seq; Type: SEQUENCE; Schema: public; Owner: algavrich
--

CREATE SEQUENCE public.projects_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.projects_id_seq OWNER TO algavrich;

--
-- Name: projects_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: algavrich
--

ALTER SEQUENCE public.projects_id_seq OWNED BY public.projects.id;


--
-- Name: students; Type: TABLE; Schema: public; Owner: algavrich
--

CREATE TABLE public.students (
    first_name character varying(30),
    last_name character varying(30),
    github character varying(30) NOT NULL
);


ALTER TABLE public.students OWNER TO algavrich;

--
-- Name: report_card_view; Type: VIEW; Schema: public; Owner: algavrich
--

CREATE VIEW public.report_card_view AS
 SELECT students.first_name,
    students.last_name,
    grades.project_title,
    grades.grade,
    projects.max_grade
   FROM ((public.students
     JOIN public.grades ON (((students.github)::text = (grades.student_github)::text)))
     JOIN public.projects ON (((projects.title)::text = (grades.project_title)::text)));


ALTER TABLE public.report_card_view OWNER TO algavrich;

--
-- Name: grades id; Type: DEFAULT; Schema: public; Owner: algavrich
--

ALTER TABLE ONLY public.grades ALTER COLUMN id SET DEFAULT nextval('public.grades_id_seq'::regclass);


--
-- Name: projects id; Type: DEFAULT; Schema: public; Owner: algavrich
--

ALTER TABLE ONLY public.projects ALTER COLUMN id SET DEFAULT nextval('public.projects_id_seq'::regclass);


--
-- Data for Name: grades; Type: TABLE DATA; Schema: public; Owner: algavrich
--

COPY public.grades (id, student_github, project_title, grade) FROM stdin;
1	jhacks	Markov	10
2	jhacks	Blockly	2
3	sdevelops	Markov	50
4	sdevelops	Blockly	100
5	jhacks	Pokemon	500
\.


--
-- Data for Name: projects; Type: TABLE DATA; Schema: public; Owner: algavrich
--

COPY public.projects (id, title, description, max_grade) FROM stdin;
1	Markov	Tweets generated from Markov chains	50
2	Blockly	Programmatic Logic Puzzle Game	100
3	Facebook	Social media for old people	1000
4	Flip-a-Coin	Flips a coin	2
5	Pokemon	A game of pocket monsters	905
\.


--
-- Data for Name: students; Type: TABLE DATA; Schema: public; Owner: algavrich
--

COPY public.students (first_name, last_name, github) FROM stdin;
Jane	Hacker	jhacks
Sarah	Developer	sdevelops
\.


--
-- Name: grades_id_seq; Type: SEQUENCE SET; Schema: public; Owner: algavrich
--

SELECT pg_catalog.setval('public.grades_id_seq', 5, true);


--
-- Name: projects_id_seq; Type: SEQUENCE SET; Schema: public; Owner: algavrich
--

SELECT pg_catalog.setval('public.projects_id_seq', 5, true);


--
-- Name: grades grades_pkey; Type: CONSTRAINT; Schema: public; Owner: algavrich
--

ALTER TABLE ONLY public.grades
    ADD CONSTRAINT grades_pkey PRIMARY KEY (id);


--
-- Name: projects projects_pkey; Type: CONSTRAINT; Schema: public; Owner: algavrich
--

ALTER TABLE ONLY public.projects
    ADD CONSTRAINT projects_pkey PRIMARY KEY (id);


--
-- Name: students students_pkey; Type: CONSTRAINT; Schema: public; Owner: algavrich
--

ALTER TABLE ONLY public.students
    ADD CONSTRAINT students_pkey PRIMARY KEY (github);


--
-- PostgreSQL database dump complete
--

