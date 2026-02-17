SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
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
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: enabling_legislations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.enabling_legislations (
    id bigint NOT NULL,
    identifier text,
    label text,
    date date,
    year integer,
    act_number integer,
    uri text,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    search_vector tsvector
);


--
-- Name: enabling_legislations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.enabling_legislations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: enabling_legislations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.enabling_legislations_id_seq OWNED BY public.enabling_legislations.id;


--
-- Name: organisations_accountable_to_parliament; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.organisations_accountable_to_parliament (
    id bigint NOT NULL,
    identifier text,
    label text,
    start_on date,
    end_on date,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    search_vector tsvector
);


--
-- Name: organisations_accountable_to_parliament_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.organisations_accountable_to_parliament_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: organisations_accountable_to_parliament_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.organisations_accountable_to_parliament_id_seq OWNED BY public.organisations_accountable_to_parliament.id;


--
-- Name: pg_search_documents; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.pg_search_documents (
    id bigint NOT NULL,
    content text,
    searchable_type character varying,
    searchable_id bigint,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: pg_search_documents_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.pg_search_documents_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: pg_search_documents_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.pg_search_documents_id_seq OWNED BY public.pg_search_documents.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


--
-- Name: steps; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.steps (
    id bigint NOT NULL,
    identifier text,
    label text,
    step_label text,
    description text,
    scope_note text,
    link_note text,
    date_note text,
    publication_name text,
    publication_url text,
    step_type_identifier text,
    step_type_label text,
    step_type_description text,
    commons_identifier text,
    lords_identifier text,
    legislature_identifier text,
    legislature_label text,
    business_item_identifier text,
    business_item_date text,
    business_item_link text,
    work_package_identifier text,
    work_package_made_available_on text,
    work_packageable_thing_identifier text,
    work_packageable_thing_label text,
    procedure_identifier text,
    procedure_label text,
    calculation_style_identifier text,
    calculation_style_label text,
    depth text,
    actualisation_count text,
    search_vector tsvector,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: steps_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.steps_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: steps_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.steps_id_seq OWNED BY public.steps.id;


--
-- Name: work_packages; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.work_packages (
    id bigint NOT NULL,
    identifier text,
    work_packageable_thing_identifer text,
    work_packageable_thing_label text,
    making_available_identifier text,
    made_available_on date,
    procedure_identifier text,
    procedure_label text,
    calculation_style_identifier text,
    calculation_style_label text,
    has_committee_concerns text,
    has_motion_tabled text,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    search_vector tsvector
);


--
-- Name: work_packages_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.work_packages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: work_packages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.work_packages_id_seq OWNED BY public.work_packages.id;


--
-- Name: enabling_legislations id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.enabling_legislations ALTER COLUMN id SET DEFAULT nextval('public.enabling_legislations_id_seq'::regclass);


--
-- Name: organisations_accountable_to_parliament id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.organisations_accountable_to_parliament ALTER COLUMN id SET DEFAULT nextval('public.organisations_accountable_to_parliament_id_seq'::regclass);


--
-- Name: pg_search_documents id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pg_search_documents ALTER COLUMN id SET DEFAULT nextval('public.pg_search_documents_id_seq'::regclass);


--
-- Name: steps id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.steps ALTER COLUMN id SET DEFAULT nextval('public.steps_id_seq'::regclass);


--
-- Name: work_packages id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.work_packages ALTER COLUMN id SET DEFAULT nextval('public.work_packages_id_seq'::regclass);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: enabling_legislations enabling_legislations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.enabling_legislations
    ADD CONSTRAINT enabling_legislations_pkey PRIMARY KEY (id);


--
-- Name: organisations_accountable_to_parliament organisations_accountable_to_parliament_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.organisations_accountable_to_parliament
    ADD CONSTRAINT organisations_accountable_to_parliament_pkey PRIMARY KEY (id);


--
-- Name: pg_search_documents pg_search_documents_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pg_search_documents
    ADD CONSTRAINT pg_search_documents_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: steps steps_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.steps
    ADD CONSTRAINT steps_pkey PRIMARY KEY (id);


--
-- Name: work_packages work_packages_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.work_packages
    ADD CONSTRAINT work_packages_pkey PRIMARY KEY (id);


--
-- Name: index_enabling_legislations_on_search_vector; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_enabling_legislations_on_search_vector ON public.enabling_legislations USING gin (search_vector);


--
-- Name: index_organisations_accountable_to_parliament_on_search_vector; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_organisations_accountable_to_parliament_on_search_vector ON public.organisations_accountable_to_parliament USING gin (search_vector);


--
-- Name: index_pg_search_documents_on_searchable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_pg_search_documents_on_searchable ON public.pg_search_documents USING btree (searchable_type, searchable_id);


--
-- Name: index_steps_on_search_vector; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_steps_on_search_vector ON public.steps USING gin (search_vector);


--
-- Name: index_work_packages_on_search_vector; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_work_packages_on_search_vector ON public.work_packages USING gin (search_vector);


--
-- Name: enabling_legislations tsvectorupdate_enabling_legislations; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER tsvectorupdate_enabling_legislations BEFORE INSERT OR UPDATE ON public.enabling_legislations FOR EACH ROW EXECUTE FUNCTION tsvector_update_trigger('search_vector', 'pg_catalog.english', 'label', 'identifier', 'uri');


--
-- Name: organisations_accountable_to_parliament tsvectorupdate_organisations; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER tsvectorupdate_organisations BEFORE INSERT OR UPDATE ON public.organisations_accountable_to_parliament FOR EACH ROW EXECUTE FUNCTION tsvector_update_trigger('search_vector', 'pg_catalog.english', 'label', 'identifier');


--
-- Name: steps tsvectorupdate_steps; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER tsvectorupdate_steps BEFORE INSERT OR UPDATE ON public.steps FOR EACH ROW EXECUTE FUNCTION tsvector_update_trigger('search_vector', 'pg_catalog.english', 'identifier', 'label', 'step_label', 'description', 'scope_note', 'link_note', 'date_note', 'publication_name', 'publication_url', 'step_type_identifier', 'step_type_label', 'step_type_description', 'commons_identifier', 'lords_identifier', 'legislature_identifier', 'legislature_label', 'business_item_identifier', 'business_item_date', 'business_item_link', 'work_package_identifier', 'work_package_made_available_on', 'work_packageable_thing_identifier', 'work_packageable_thing_label', 'procedure_identifier', 'procedure_label', 'calculation_style_identifier', 'calculation_style_label', 'depth', 'actualisation_count');


--
-- Name: work_packages tsvectorupdate_work_packages; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER tsvectorupdate_work_packages BEFORE INSERT OR UPDATE ON public.work_packages FOR EACH ROW EXECUTE FUNCTION tsvector_update_trigger('search_vector', 'pg_catalog.english', 'identifier', 'work_packageable_thing_identifer', 'work_packageable_thing_label', 'making_available_identifier', 'procedure_identifier', 'procedure_label', 'calculation_style_identifier', 'calculation_style_label');


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public;

INSERT INTO "schema_migrations" (version) VALUES
('20260130135554'),
('20260130120901'),
('20260130114439'),
('20260130102234'),
('20260121083520'),
('20260117170020');

