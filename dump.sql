--
-- PostgreSQL database dump
--

\restrict 7ZH7RugsFNc612eniszrrMdBvoeShlgtqdjGy9NTWKlNXc0eljiuR4jXapBWYAt

-- Dumped from database version 18.1
-- Dumped by pg_dump version 18.1

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

ALTER TABLE IF EXISTS ONLY public.structures DROP CONSTRAINT IF EXISTS structures_user_id_foreign;
ALTER TABLE IF EXISTS ONLY public.retours DROP CONSTRAINT IF EXISTS retours_mission_id_foreign;
ALTER TABLE IF EXISTS ONLY public.recettes DROP CONSTRAINT IF EXISTS recettes_created_by_foreign;
ALTER TABLE IF EXISTS ONLY public.professionnels DROP CONSTRAINT IF EXISTS professionnels_user_id_foreign;
ALTER TABLE IF EXISTS ONLY public.missions DROP CONSTRAINT IF EXISTS missions_structure_id_foreign;
ALTER TABLE IF EXISTS ONLY public.missions DROP CONSTRAINT IF EXISTS missions_professionnel_id_foreign;
ALTER TABLE IF EXISTS ONLY public.mission_responses DROP CONSTRAINT IF EXISTS mission_responses_professionnel_id_foreign;
ALTER TABLE IF EXISTS ONLY public.mission_responses DROP CONSTRAINT IF EXISTS mission_responses_mission_id_foreign;
ALTER TABLE IF EXISTS ONLY public.mission_repas DROP CONSTRAINT IF EXISTS mission_repas_simple_recette_id_foreign;
ALTER TABLE IF EXISTS ONLY public.mission_repas_recettes DROP CONSTRAINT IF EXISTS mission_repas_recettes_recette_id_foreign;
ALTER TABLE IF EXISTS ONLY public.mission_repas_recettes DROP CONSTRAINT IF EXISTS mission_repas_recettes_mission_repas_id_foreign;
ALTER TABLE IF EXISTS ONLY public.mission_repas DROP CONSTRAINT IF EXISTS mission_repas_plat_recette_id_foreign;
ALTER TABLE IF EXISTS ONLY public.mission_repas DROP CONSTRAINT IF EXISTS mission_repas_mission_id_foreign;
ALTER TABLE IF EXISTS ONLY public.mission_repas DROP CONSTRAINT IF EXISTS mission_repas_entree_recette_id_foreign;
ALTER TABLE IF EXISTS ONLY public.mission_repas DROP CONSTRAINT IF EXISTS mission_repas_dessert_recette_id_foreign;
ALTER TABLE IF EXISTS ONLY public.mission_repas DROP CONSTRAINT IF EXISTS mission_repas_accompagnement_recette_id_foreign;
ALTER TABLE IF EXISTS ONLY public.mission_recette DROP CONSTRAINT IF EXISTS mission_recette_recette_id_foreign;
ALTER TABLE IF EXISTS ONLY public.mission_recette DROP CONSTRAINT IF EXISTS mission_recette_mission_id_foreign;
ALTER TABLE IF EXISTS ONLY public.mission_messages DROP CONSTRAINT IF EXISTS mission_messages_user_id_foreign;
ALTER TABLE IF EXISTS ONLY public.mission_messages DROP CONSTRAINT IF EXISTS mission_messages_mission_id_foreign;
ALTER TABLE IF EXISTS ONLY public.menus DROP CONSTRAINT IF EXISTS menus_created_by_foreign;
ALTER TABLE IF EXISTS ONLY public.menu_recettes DROP CONSTRAINT IF EXISTS menu_recettes_recette_id_foreign;
ALTER TABLE IF EXISTS ONLY public.menu_recettes DROP CONSTRAINT IF EXISTS menu_recettes_menu_id_foreign;
ALTER TABLE IF EXISTS ONLY public.incidents DROP CONSTRAINT IF EXISTS incidents_mission_id_foreign;
ALTER TABLE IF EXISTS ONLY public.formations DROP CONSTRAINT IF EXISTS formations_professionnel_id_foreign;
DROP INDEX IF EXISTS public.users_role_index;
DROP INDEX IF EXISTS public.users_email_index;
DROP INDEX IF EXISTS public.sessions_user_id_index;
DROP INDEX IF EXISTS public.sessions_last_activity_index;
DROP INDEX IF EXISTS public.personal_access_tokens_tokenable_type_tokenable_id_index;
DROP INDEX IF EXISTS public.personal_access_tokens_expires_at_index;
DROP INDEX IF EXISTS public.notifications_notifiable_type_notifiable_id_index;
DROP INDEX IF EXISTS public.jobs_queue_index;
DROP INDEX IF EXISTS public.documents_documentable_type_documentable_id_index;
DROP INDEX IF EXISTS public.cache_locks_expiration_index;
DROP INDEX IF EXISTS public.cache_expiration_index;
ALTER TABLE IF EXISTS ONLY public.users DROP CONSTRAINT IF EXISTS users_pkey;
ALTER TABLE IF EXISTS ONLY public.users DROP CONSTRAINT IF EXISTS users_email_unique;
ALTER TABLE IF EXISTS ONLY public.structures DROP CONSTRAINT IF EXISTS structures_pkey;
ALTER TABLE IF EXISTS ONLY public.sessions DROP CONSTRAINT IF EXISTS sessions_pkey;
ALTER TABLE IF EXISTS ONLY public.retours DROP CONSTRAINT IF EXISTS retours_pkey;
ALTER TABLE IF EXISTS ONLY public.recettes DROP CONSTRAINT IF EXISTS recettes_pkey;
ALTER TABLE IF EXISTS ONLY public.professionnels DROP CONSTRAINT IF EXISTS professionnels_pkey;
ALTER TABLE IF EXISTS ONLY public.personal_access_tokens DROP CONSTRAINT IF EXISTS personal_access_tokens_token_unique;
ALTER TABLE IF EXISTS ONLY public.personal_access_tokens DROP CONSTRAINT IF EXISTS personal_access_tokens_pkey;
ALTER TABLE IF EXISTS ONLY public.password_reset_tokens DROP CONSTRAINT IF EXISTS password_reset_tokens_pkey;
ALTER TABLE IF EXISTS ONLY public.notifications DROP CONSTRAINT IF EXISTS notifications_pkey;
ALTER TABLE IF EXISTS ONLY public.missions DROP CONSTRAINT IF EXISTS missions_pkey;
ALTER TABLE IF EXISTS ONLY public.mission_responses DROP CONSTRAINT IF EXISTS mission_responses_pkey;
ALTER TABLE IF EXISTS ONLY public.mission_responses DROP CONSTRAINT IF EXISTS mission_responses_mission_id_professionnel_id_unique;
ALTER TABLE IF EXISTS ONLY public.mission_repas_recettes DROP CONSTRAINT IF EXISTS mission_repas_recettes_pkey;
ALTER TABLE IF EXISTS ONLY public.mission_repas DROP CONSTRAINT IF EXISTS mission_repas_pkey;
ALTER TABLE IF EXISTS ONLY public.mission_recette DROP CONSTRAINT IF EXISTS mission_recette_pkey;
ALTER TABLE IF EXISTS ONLY public.mission_messages DROP CONSTRAINT IF EXISTS mission_messages_pkey;
ALTER TABLE IF EXISTS ONLY public.migrations DROP CONSTRAINT IF EXISTS migrations_pkey;
ALTER TABLE IF EXISTS ONLY public.menus DROP CONSTRAINT IF EXISTS menus_pkey;
ALTER TABLE IF EXISTS ONLY public.menu_recettes DROP CONSTRAINT IF EXISTS menu_recettes_pkey;
ALTER TABLE IF EXISTS ONLY public.jobs DROP CONSTRAINT IF EXISTS jobs_pkey;
ALTER TABLE IF EXISTS ONLY public.job_batches DROP CONSTRAINT IF EXISTS job_batches_pkey;
ALTER TABLE IF EXISTS ONLY public.incidents DROP CONSTRAINT IF EXISTS incidents_pkey;
ALTER TABLE IF EXISTS ONLY public.formations DROP CONSTRAINT IF EXISTS formations_pkey;
ALTER TABLE IF EXISTS ONLY public.failed_jobs DROP CONSTRAINT IF EXISTS failed_jobs_uuid_unique;
ALTER TABLE IF EXISTS ONLY public.failed_jobs DROP CONSTRAINT IF EXISTS failed_jobs_pkey;
ALTER TABLE IF EXISTS ONLY public.documents DROP CONSTRAINT IF EXISTS documents_pkey;
ALTER TABLE IF EXISTS ONLY public.cache DROP CONSTRAINT IF EXISTS cache_pkey;
ALTER TABLE IF EXISTS ONLY public.cache_locks DROP CONSTRAINT IF EXISTS cache_locks_pkey;
ALTER TABLE IF EXISTS public.users ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.structures ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.retours ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.recettes ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.professionnels ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.personal_access_tokens ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.missions ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.mission_responses ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.mission_repas_recettes ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.mission_repas ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.mission_recette ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.mission_messages ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.migrations ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.menus ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.menu_recettes ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.jobs ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.incidents ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.formations ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.failed_jobs ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.documents ALTER COLUMN id DROP DEFAULT;
DROP SEQUENCE IF EXISTS public.users_id_seq;
DROP TABLE IF EXISTS public.users;
DROP SEQUENCE IF EXISTS public.structures_id_seq;
DROP TABLE IF EXISTS public.structures;
DROP TABLE IF EXISTS public.sessions;
DROP SEQUENCE IF EXISTS public.retours_id_seq;
DROP TABLE IF EXISTS public.retours;
DROP SEQUENCE IF EXISTS public.recettes_id_seq;
DROP TABLE IF EXISTS public.recettes;
DROP SEQUENCE IF EXISTS public.professionnels_id_seq;
DROP TABLE IF EXISTS public.professionnels;
DROP SEQUENCE IF EXISTS public.personal_access_tokens_id_seq;
DROP TABLE IF EXISTS public.personal_access_tokens;
DROP TABLE IF EXISTS public.password_reset_tokens;
DROP TABLE IF EXISTS public.notifications;
DROP SEQUENCE IF EXISTS public.missions_id_seq;
DROP TABLE IF EXISTS public.missions;
DROP SEQUENCE IF EXISTS public.mission_responses_id_seq;
DROP TABLE IF EXISTS public.mission_responses;
DROP SEQUENCE IF EXISTS public.mission_repas_recettes_id_seq;
DROP TABLE IF EXISTS public.mission_repas_recettes;
DROP SEQUENCE IF EXISTS public.mission_repas_id_seq;
DROP TABLE IF EXISTS public.mission_repas;
DROP SEQUENCE IF EXISTS public.mission_recette_id_seq;
DROP TABLE IF EXISTS public.mission_recette;
DROP SEQUENCE IF EXISTS public.mission_messages_id_seq;
DROP TABLE IF EXISTS public.mission_messages;
DROP SEQUENCE IF EXISTS public.migrations_id_seq;
DROP TABLE IF EXISTS public.migrations;
DROP SEQUENCE IF EXISTS public.menus_id_seq;
DROP TABLE IF EXISTS public.menus;
DROP SEQUENCE IF EXISTS public.menu_recettes_id_seq;
DROP TABLE IF EXISTS public.menu_recettes;
DROP SEQUENCE IF EXISTS public.jobs_id_seq;
DROP TABLE IF EXISTS public.jobs;
DROP TABLE IF EXISTS public.job_batches;
DROP SEQUENCE IF EXISTS public.incidents_id_seq;
DROP TABLE IF EXISTS public.incidents;
DROP SEQUENCE IF EXISTS public.formations_id_seq;
DROP TABLE IF EXISTS public.formations;
DROP SEQUENCE IF EXISTS public.failed_jobs_id_seq;
DROP TABLE IF EXISTS public.failed_jobs;
DROP SEQUENCE IF EXISTS public.documents_id_seq;
DROP TABLE IF EXISTS public.documents;
DROP TABLE IF EXISTS public.cache_locks;
DROP TABLE IF EXISTS public.cache;
DROP EXTENSION IF EXISTS unaccent;
--
-- Name: unaccent; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS unaccent WITH SCHEMA public;


--
-- Name: EXTENSION unaccent; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION unaccent IS 'text search dictionary that removes accents';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: cache; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cache (
    key character varying(255) NOT NULL,
    value text NOT NULL,
    expiration integer NOT NULL
);


ALTER TABLE public.cache OWNER TO postgres;

--
-- Name: cache_locks; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cache_locks (
    key character varying(255) NOT NULL,
    owner character varying(255) NOT NULL,
    expiration integer NOT NULL
);


ALTER TABLE public.cache_locks OWNER TO postgres;

--
-- Name: documents; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.documents (
    id bigint NOT NULL,
    documentable_type character varying(255) NOT NULL,
    documentable_id bigint NOT NULL,
    nom character varying(255) NOT NULL,
    type character varying(255) NOT NULL,
    "cheminFichier" character varying(255) NOT NULL,
    statut character varying(255) DEFAULT 'en attente'::character varying NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.documents OWNER TO postgres;

--
-- Name: documents_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.documents_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.documents_id_seq OWNER TO postgres;

--
-- Name: documents_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.documents_id_seq OWNED BY public.documents.id;


--
-- Name: failed_jobs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.failed_jobs (
    id bigint NOT NULL,
    uuid character varying(255) NOT NULL,
    connection text NOT NULL,
    queue text NOT NULL,
    payload text NOT NULL,
    exception text NOT NULL,
    failed_at timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.failed_jobs OWNER TO postgres;

--
-- Name: failed_jobs_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.failed_jobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.failed_jobs_id_seq OWNER TO postgres;

--
-- Name: failed_jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.failed_jobs_id_seq OWNED BY public.failed_jobs.id;


--
-- Name: formations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.formations (
    id bigint NOT NULL,
    professionnel_id bigint NOT NULL,
    titre character varying(255) NOT NULL,
    duree character varying(255) NOT NULL,
    video_url character varying(255),
    type character varying(255) DEFAULT 'Recommandé'::character varying NOT NULL,
    image_url character varying(255),
    "statutValidation" character varying(255) DEFAULT 'A compléter'::character varying NOT NULL,
    "dateLimite" date,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    type_formation character varying(255),
    lien_formation character varying(255)
);


ALTER TABLE public.formations OWNER TO postgres;

--
-- Name: formations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.formations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.formations_id_seq OWNER TO postgres;

--
-- Name: formations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.formations_id_seq OWNED BY public.formations.id;


--
-- Name: incidents; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.incidents (
    id bigint NOT NULL,
    mission_id bigint NOT NULL,
    type character varying(255) NOT NULL,
    description text NOT NULL,
    gravite character varying(255) DEFAULT 'Moyenne'::character varying NOT NULL,
    statut character varying(255) DEFAULT 'Signalé'::character varying NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.incidents OWNER TO postgres;

--
-- Name: incidents_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.incidents_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.incidents_id_seq OWNER TO postgres;

--
-- Name: incidents_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.incidents_id_seq OWNED BY public.incidents.id;


--
-- Name: job_batches; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.job_batches (
    id character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    total_jobs integer NOT NULL,
    pending_jobs integer NOT NULL,
    failed_jobs integer NOT NULL,
    failed_job_ids text NOT NULL,
    options text,
    cancelled_at integer,
    created_at integer NOT NULL,
    finished_at integer
);


ALTER TABLE public.job_batches OWNER TO postgres;

--
-- Name: jobs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.jobs (
    id bigint NOT NULL,
    queue character varying(255) NOT NULL,
    payload text NOT NULL,
    attempts smallint NOT NULL,
    reserved_at integer,
    available_at integer NOT NULL,
    created_at integer NOT NULL
);


ALTER TABLE public.jobs OWNER TO postgres;

--
-- Name: jobs_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.jobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.jobs_id_seq OWNER TO postgres;

--
-- Name: jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.jobs_id_seq OWNED BY public.jobs.id;


--
-- Name: menu_recettes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.menu_recettes (
    id bigint NOT NULL,
    menu_id bigint NOT NULL,
    recette_id bigint NOT NULL,
    category character varying(255) NOT NULL,
    "order" integer DEFAULT 0 NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.menu_recettes OWNER TO postgres;

--
-- Name: menu_recettes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.menu_recettes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.menu_recettes_id_seq OWNER TO postgres;

--
-- Name: menu_recettes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.menu_recettes_id_seq OWNED BY public.menu_recettes.id;


--
-- Name: menus; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.menus (
    id bigint NOT NULL,
    nom character varying(255) NOT NULL,
    type character varying(255) NOT NULL,
    description text,
    status character varying(255) DEFAULT 'Brouillon'::character varying NOT NULL,
    diets json,
    created_by bigint,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.menus OWNER TO postgres;

--
-- Name: menus_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.menus_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.menus_id_seq OWNER TO postgres;

--
-- Name: menus_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.menus_id_seq OWNED BY public.menus.id;


--
-- Name: migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.migrations (
    id integer NOT NULL,
    migration character varying(255) NOT NULL,
    batch integer NOT NULL
);


ALTER TABLE public.migrations OWNER TO postgres;

--
-- Name: migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.migrations_id_seq OWNER TO postgres;

--
-- Name: migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.migrations_id_seq OWNED BY public.migrations.id;


--
-- Name: mission_messages; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.mission_messages (
    id bigint NOT NULL,
    mission_id bigint NOT NULL,
    user_id bigint NOT NULL,
    content text NOT NULL,
    is_read boolean DEFAULT false NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    type character varying(255),
    file_path text,
    latitude numeric(10,8),
    longitude numeric(11,8),
    is_handled boolean DEFAULT false NOT NULL,
    CONSTRAINT mission_messages_type_check CHECK (((type)::text = ANY (ARRAY[('text'::character varying)::text, ('image'::character varying)::text, ('file'::character varying)::text, ('location'::character varying)::text, ('contact'::character varying)::text, ('audio'::character varying)::text, ('incident'::character varying)::text, ('feedback'::character varying)::text])))
);


ALTER TABLE public.mission_messages OWNER TO postgres;

--
-- Name: mission_messages_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.mission_messages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.mission_messages_id_seq OWNER TO postgres;

--
-- Name: mission_messages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.mission_messages_id_seq OWNED BY public.mission_messages.id;


--
-- Name: mission_recette; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.mission_recette (
    id bigint NOT NULL,
    mission_id bigint NOT NULL,
    recette_id bigint NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.mission_recette OWNER TO postgres;

--
-- Name: mission_recette_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.mission_recette_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.mission_recette_id_seq OWNER TO postgres;

--
-- Name: mission_recette_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.mission_recette_id_seq OWNED BY public.mission_recette.id;


--
-- Name: mission_repas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.mission_repas (
    id bigint NOT NULL,
    mission_id bigint NOT NULL,
    type_repas character varying(255) NOT NULL,
    entree character varying(255),
    plat character varying(255),
    accompagnement character varying(255),
    dessert character varying(255),
    description_simple text,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    entree_recette_id bigint,
    plat_recette_id bigint,
    accompagnement_recette_id bigint,
    dessert_recette_id bigint,
    simple_recette_id bigint
);


ALTER TABLE public.mission_repas OWNER TO postgres;

--
-- Name: mission_repas_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.mission_repas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.mission_repas_id_seq OWNER TO postgres;

--
-- Name: mission_repas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.mission_repas_id_seq OWNED BY public.mission_repas.id;


--
-- Name: mission_repas_recettes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.mission_repas_recettes (
    id bigint NOT NULL,
    mission_repas_id bigint NOT NULL,
    recette_id bigint NOT NULL,
    category character varying(255) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.mission_repas_recettes OWNER TO postgres;

--
-- Name: mission_repas_recettes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.mission_repas_recettes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.mission_repas_recettes_id_seq OWNER TO postgres;

--
-- Name: mission_repas_recettes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.mission_repas_recettes_id_seq OWNED BY public.mission_repas_recettes.id;


--
-- Name: mission_responses; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.mission_responses (
    id bigint NOT NULL,
    mission_id bigint NOT NULL,
    professionnel_id bigint NOT NULL,
    status character varying(255) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.mission_responses OWNER TO postgres;

--
-- Name: mission_responses_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.mission_responses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.mission_responses_id_seq OWNER TO postgres;

--
-- Name: mission_responses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.mission_responses_id_seq OWNED BY public.mission_responses.id;


--
-- Name: missions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.missions (
    id bigint NOT NULL,
    structure_id bigint NOT NULL,
    professionnel_id bigint,
    date date,
    duree character varying(255),
    statut character varying(255) DEFAULT 'en cours'::character varying NOT NULL,
    commentaires text,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    nb_residents_jour integer,
    types_repas json,
    regimes_speciaux json,
    menu_entree_brut text,
    menu_plat_brut text,
    menu_accompagnement_brut text,
    menu_dessert_brut text,
    horaire_mission timestamp(0) without time zone,
    nb_regimes_haches integer DEFAULT 0 NOT NULL,
    nb_regimes_mixes integer DEFAULT 0 NOT NULL,
    nb_regimes_moulines integer DEFAULT 0 NOT NULL,
    est_cree_par_admin boolean DEFAULT false NOT NULL,
    horaire_fin timestamp(0) without time zone,
    commentaires_admin text,
    code_entree character varying(255),
    code_cuisine character varying(255),
    nb_chefs integer DEFAULT 1 NOT NULL,
    checklist_journee json,
    checklist_items json
);


ALTER TABLE public.missions OWNER TO postgres;

--
-- Name: missions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.missions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.missions_id_seq OWNER TO postgres;

--
-- Name: missions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.missions_id_seq OWNED BY public.missions.id;


--
-- Name: notifications; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.notifications (
    id uuid NOT NULL,
    type character varying(255) NOT NULL,
    notifiable_type character varying(255) NOT NULL,
    notifiable_id bigint NOT NULL,
    data text NOT NULL,
    read_at timestamp(0) without time zone,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.notifications OWNER TO postgres;

--
-- Name: password_reset_tokens; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.password_reset_tokens (
    email character varying(255) NOT NULL,
    token character varying(255) NOT NULL,
    created_at timestamp(0) without time zone
);


ALTER TABLE public.password_reset_tokens OWNER TO postgres;

--
-- Name: personal_access_tokens; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.personal_access_tokens (
    id bigint NOT NULL,
    tokenable_type character varying(255) NOT NULL,
    tokenable_id bigint NOT NULL,
    name text NOT NULL,
    token character varying(64) NOT NULL,
    abilities text,
    last_used_at timestamp(0) without time zone,
    expires_at timestamp(0) without time zone,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.personal_access_tokens OWNER TO postgres;

--
-- Name: personal_access_tokens_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.personal_access_tokens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.personal_access_tokens_id_seq OWNER TO postgres;

--
-- Name: personal_access_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.personal_access_tokens_id_seq OWNED BY public.personal_access_tokens.id;


--
-- Name: professionnels; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.professionnels (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    date_naissance date,
    lieu_naissance character varying(255),
    diplome character varying(255),
    annees_experience integer,
    specialites json,
    statut_validation character varying(255) DEFAULT 'en_attente'::character varying NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    fonction character varying(255)
);


ALTER TABLE public.professionnels OWNER TO postgres;

--
-- Name: professionnels_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.professionnels_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.professionnels_id_seq OWNER TO postgres;

--
-- Name: professionnels_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.professionnels_id_seq OWNED BY public.professionnels.id;


--
-- Name: recettes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.recettes (
    id bigint NOT NULL,
    nom character varying(255) NOT NULL,
    type character varying(255),
    description text,
    ingredients text,
    temps_preparation character varying(255),
    created_by bigint,
    regimes json,
    textures json,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    meal_types json,
    nb_regimes_haches integer DEFAULT 0 NOT NULL,
    nb_regimes_mixes integer DEFAULT 0 NOT NULL,
    nb_regimes_moulines integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.recettes OWNER TO postgres;

--
-- Name: recettes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.recettes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.recettes_id_seq OWNER TO postgres;

--
-- Name: recettes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.recettes_id_seq OWNED BY public.recettes.id;


--
-- Name: retours; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.retours (
    id bigint NOT NULL,
    mission_id bigint NOT NULL,
    note integer,
    commentaire text,
    "heureDebutEffectif" time(0) without time zone,
    "heureFinEffectif" time(0) without time zone,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.retours OWNER TO postgres;

--
-- Name: retours_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.retours_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.retours_id_seq OWNER TO postgres;

--
-- Name: retours_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.retours_id_seq OWNED BY public.retours.id;


--
-- Name: sessions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sessions (
    id character varying(255) NOT NULL,
    user_id bigint,
    ip_address character varying(45),
    user_agent text,
    payload text NOT NULL,
    last_activity integer NOT NULL
);


ALTER TABLE public.sessions OWNER TO postgres;

--
-- Name: structures; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.structures (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    nom_etablissement character varying(255),
    type_etablissement character varying(255),
    capacite integer,
    fonction character varying(255),
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    statut_validation character varying(255) DEFAULT 'en_attente'::character varying NOT NULL,
    telephone_etablissement character varying(20),
    adresse text,
    code_postal character varying(10),
    ville character varying(100)
);


ALTER TABLE public.structures OWNER TO postgres;

--
-- Name: structures_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.structures_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.structures_id_seq OWNER TO postgres;

--
-- Name: structures_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.structures_id_seq OWNED BY public.structures.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    prenom character varying(255) NOT NULL,
    nom character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    email_verified_at timestamp(0) without time zone,
    password character varying(255) NOT NULL,
    role character varying(255) DEFAULT 'client'::character varying NOT NULL,
    telephone character varying(20),
    adresse text,
    code_postal character varying(10),
    ville character varying(100),
    remember_token character varying(100),
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    CONSTRAINT users_role_check CHECK (((role)::text = ANY ((ARRAY['client'::character varying, 'professionnel'::character varying, 'admin'::character varying])::text[])))
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: documents id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.documents ALTER COLUMN id SET DEFAULT nextval('public.documents_id_seq'::regclass);


--
-- Name: failed_jobs id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.failed_jobs ALTER COLUMN id SET DEFAULT nextval('public.failed_jobs_id_seq'::regclass);


--
-- Name: formations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.formations ALTER COLUMN id SET DEFAULT nextval('public.formations_id_seq'::regclass);


--
-- Name: incidents id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.incidents ALTER COLUMN id SET DEFAULT nextval('public.incidents_id_seq'::regclass);


--
-- Name: jobs id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.jobs ALTER COLUMN id SET DEFAULT nextval('public.jobs_id_seq'::regclass);


--
-- Name: menu_recettes id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.menu_recettes ALTER COLUMN id SET DEFAULT nextval('public.menu_recettes_id_seq'::regclass);


--
-- Name: menus id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.menus ALTER COLUMN id SET DEFAULT nextval('public.menus_id_seq'::regclass);


--
-- Name: migrations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.migrations ALTER COLUMN id SET DEFAULT nextval('public.migrations_id_seq'::regclass);


--
-- Name: mission_messages id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mission_messages ALTER COLUMN id SET DEFAULT nextval('public.mission_messages_id_seq'::regclass);


--
-- Name: mission_recette id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mission_recette ALTER COLUMN id SET DEFAULT nextval('public.mission_recette_id_seq'::regclass);


--
-- Name: mission_repas id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mission_repas ALTER COLUMN id SET DEFAULT nextval('public.mission_repas_id_seq'::regclass);


--
-- Name: mission_repas_recettes id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mission_repas_recettes ALTER COLUMN id SET DEFAULT nextval('public.mission_repas_recettes_id_seq'::regclass);


--
-- Name: mission_responses id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mission_responses ALTER COLUMN id SET DEFAULT nextval('public.mission_responses_id_seq'::regclass);


--
-- Name: missions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.missions ALTER COLUMN id SET DEFAULT nextval('public.missions_id_seq'::regclass);


--
-- Name: personal_access_tokens id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personal_access_tokens ALTER COLUMN id SET DEFAULT nextval('public.personal_access_tokens_id_seq'::regclass);


--
-- Name: professionnels id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.professionnels ALTER COLUMN id SET DEFAULT nextval('public.professionnels_id_seq'::regclass);


--
-- Name: recettes id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recettes ALTER COLUMN id SET DEFAULT nextval('public.recettes_id_seq'::regclass);


--
-- Name: retours id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.retours ALTER COLUMN id SET DEFAULT nextval('public.retours_id_seq'::regclass);


--
-- Name: structures id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.structures ALTER COLUMN id SET DEFAULT nextval('public.structures_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: cache; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cache (key, value, expiration) FROM stdin;
ars-cache-5c785c036466adea360111aa28563bfd556b5fba:timer	i:1777949781;	1777949781
ars-cache-5c785c036466adea360111aa28563bfd556b5fba	i:2;	1777949781
\.


--
-- Data for Name: cache_locks; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cache_locks (key, owner, expiration) FROM stdin;
\.


--
-- Data for Name: documents; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.documents (id, documentable_type, documentable_id, nom, type, "cheminFichier", statut, created_at, updated_at) FROM stdin;
1	App\\Models\\Structure	2	contrat_prestation_path	document	documents/clients/1772031474_contrat_prestation_path.pdf	actif	2026-02-25 14:57:55	2026-02-25 14:57:55
2	App\\Models\\Structure	2	plan_locaux_path	document	documents/clients/1772031474_plan_locaux_path.pdf	actif	2026-02-25 14:57:55	2026-02-25 14:57:55
3	App\\Models\\Structure	2	reglement_interieur_path	document	documents/clients/1772031474_reglement_interieur_path.pdf	actif	2026-02-25 14:57:55	2026-02-25 14:57:55
6	App\\Models\\Professionnel	2	certificat_medical_path	document	documents/professionnels/1772187241_certificat_medical_path.pdf	actif	2026-02-27 10:14:02	2026-02-27 10:14:02
7	App\\Models\\Professionnel	2	permis_conduire_path	document	documents/professionnels/1772187241_permis_conduire_path.pdf	actif	2026-02-27 10:14:02	2026-02-27 10:14:02
9	App\\Models\\Professionnel	3	diplome_path	document	documents/professionnels/1772446165_diplome_path_0.pdf	actif	2026-03-02 10:09:26	2026-03-02 10:09:26
10	App\\Models\\Structure	3	contrat_prestation_path	document	documents/clients/1772464975_contrat_prestation_path.pdf	actif	2026-03-02 15:22:55	2026-03-02 15:22:55
11	App\\Models\\Structure	3	plan_locaux_path	document	documents/clients/1772464975_plan_locaux_path.pdf	actif	2026-03-02 15:22:55	2026-03-02 15:22:55
12	App\\Models\\Structure	3	reglement_interieur_path	document	documents/clients/1772464975_reglement_interieur_path.pdf	actif	2026-03-02 15:22:55	2026-03-02 15:22:55
13	App\\Models\\Structure	4	contrat_prestation_path	document	documents/clients/1774260411_contrat_prestation_path.pdf	actif	2026-03-23 10:06:53	2026-03-23 10:06:53
14	App\\Models\\Structure	4	plan_locaux_path	document	documents/clients/1774260413_plan_locaux_path.pdf	actif	2026-03-23 10:06:53	2026-03-23 10:06:53
15	App\\Models\\Structure	4	reglement_interieur_path	document	documents/clients/1774260413_reglement_interieur_path.pdf	actif	2026-03-23 10:06:53	2026-03-23 10:06:53
30	App\\Models\\User	1	photo_profil_path	document	images/profils/1777045594_photo_profil_path.jpg	actif	2026-04-24 15:46:34	2026-04-24 15:46:34
31	App\\Models\\Professionnel	2	photo_profil_path	document	images/profils/1777045966_photo_profil_path.avif	actif	2026-04-24 15:52:46	2026-04-24 15:52:46
32	App\\Models\\User	5	photo_profil_path	document	images/profils/1777045966_photo_profil_path.avif	actif	2026-04-24 15:52:46	2026-04-24 15:52:46
33	App\\Models\\Professionnel	3	photo_profil_path	document	images/profils/1777046500_photo_profil_path.jpg	actif	2026-04-24 16:01:40	2026-04-24 16:01:40
34	App\\Models\\User	6	photo_profil_path	document	images/profils/1777046500_photo_profil_path.jpg	actif	2026-04-24 16:01:40	2026-04-24 16:01:40
36	App\\Models\\User	9	photo_profil_path	document	images/profils/1777332184_photo_profil_path.jpg	actif	2026-04-27 23:23:04	2026-04-27 23:23:04
37	App\\Models\\Professionnel	2	Les resultants de BLAZOR.pdf	autre	documents/professionnels/1777335316_les-resultants-de-blazorpdf.pdf	actif	2026-04-28 00:15:16	2026-04-28 00:15:16
38	App\\Models\\Professionnel	2	TD_ADO_NET_Reponses.pdf	autre	documents/professionnels/1777640906_td-ado-net-reponsespdf.pdf	actif	2026-05-01 13:08:26	2026-05-01 13:08:26
39	App\\Models\\Professionnel	2	diplome_path	document	documents/professionnels/1777643487_diplome_path.pdf	actif	2026-05-01 13:51:27	2026-05-01 13:51:27
40	App\\Models\\Professionnel	3	TD_ADO_NET_Reponses.pdf	autre	documents/professionnels/f464676a-5aef-4d99-b24b-44f420d28df9.pdf	actif	2026-05-05 01:20:54	2026-05-05 01:20:54
41	App\\Models\\Professionnel	5	photo_profil_path	document	images/profils/c63a3e20-e73a-442f-942d-4794b15b9e00.jpg	actif	2026-05-05 01:49:51	2026-05-05 01:49:51
42	App\\Models\\Professionnel	5	diplome_path	document	documents/professionnels/c2d8bfcc-8371-4dfb-943d-9164d01ec36c.pdf	actif	2026-05-05 01:49:51	2026-05-05 01:49:51
43	App\\Models\\Professionnel	5	certificat_medical_path	document	documents/professionnels/8d150359-7779-4627-83c8-ac0e31714763.pdf	actif	2026-05-05 01:49:51	2026-05-05 01:49:51
44	App\\Models\\Professionnel	5	permis_conduire_path	document	documents/professionnels/0a562080-9d19-4754-b449-5614589a5101.pdf	actif	2026-05-05 01:49:51	2026-05-05 01:49:51
\.


--
-- Data for Name: failed_jobs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.failed_jobs (id, uuid, connection, queue, payload, exception, failed_at) FROM stdin;
\.


--
-- Data for Name: formations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.formations (id, professionnel_id, titre, duree, video_url, type, image_url, "statutValidation", "dateLimite", created_at, updated_at, type_formation, lien_formation) FROM stdin;
1	2	cuisine	30 min	E2sQntl1ygQ	Recommandé	\N	A compléter	\N	2026-03-31 23:23:33	2026-03-31 23:23:33	obligatoire	\N
2	3	Croquette de poulet	30 min	oiMxUibiauc	Recommandé	\N	A compléter	\N	2026-04-14 10:37:30	2026-04-14 10:37:30	recommandée	\N
\.


--
-- Data for Name: incidents; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.incidents (id, mission_id, type, description, gravite, statut, created_at, updated_at) FROM stdin;
1	31	Matériel	Le gaz a pris feu	Moyenne	Signalé	2026-04-20 15:41:13	2026-04-20 15:41:13
2	31	Matériel	Le gaz a pris feu	Moyenne	Signalé	2026-04-20 15:41:13	2026-04-20 15:41:13
3	34	Santé	Pas d'hygiene au niveau de la structure	Moyenne	Signalé	2026-04-23 10:53:03	2026-04-23 10:53:03
4	34	Santé	Pas d'hygiene au niveau de la structure	Moyenne	Signalé	2026-04-23 10:53:03	2026-04-23 10:53:03
5	29	Panne de matériel	pas de materiel	Moyenne	Signalé	2026-04-24 00:18:50	2026-04-24 00:18:50
6	29	Panne de matériel	pas de materiel	Moyenne	Signalé	2026-04-24 00:18:50	2026-04-24 00:18:50
7	34	Menu non conforme	Il a change la recette	Moyenne	Signalé	2026-04-24 12:45:16	2026-04-24 12:45:16
\.


--
-- Data for Name: job_batches; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.job_batches (id, name, total_jobs, pending_jobs, failed_jobs, failed_job_ids, options, cancelled_at, created_at, finished_at) FROM stdin;
\.


--
-- Data for Name: jobs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.jobs (id, queue, payload, attempts, reserved_at, available_at, created_at) FROM stdin;
\.


--
-- Data for Name: menu_recettes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.menu_recettes (id, menu_id, recette_id, category, "order", created_at, updated_at) FROM stdin;
1	1	15	entree	1	2026-04-20 12:26:29	2026-04-20 12:38:48
2	1	4	plat	2	2026-04-20 12:26:29	2026-04-20 12:38:48
3	1	28	accompagnement	3	2026-04-20 12:26:29	2026-04-20 12:38:48
5	1	12	dessert	4	2026-04-20 12:38:48	2026-04-20 12:38:48
\.


--
-- Data for Name: menus; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.menus (id, nom, type, description, status, diets, created_by, created_at, updated_at) FROM stdin;
1	iteafood	Déjeuner	\N	Validé	[]	1	2026-04-20 12:26:29	2026-04-20 12:38:22
\.


--
-- Data for Name: migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.migrations (id, migration, batch) FROM stdin;
1	0001_01_01_000000_create_users_table	1
2	0001_01_01_000001_create_cache_table	1
3	0001_01_01_000002_create_jobs_table	1
4	2026_02_04_140704_create_structures_table	1
5	2026_02_04_140753_create_professionnels_table	1
6	2026_02_04_160202_create_missions_table	1
7	2026_02_04_165616_create_incidents_table	1
8	2026_02_04_165701_create_retours_table	1
9	2026_02_06_095248_create_formations_table	1
10	2026_02_06_095308_create_documents_table	1
11	2026_02_06_103456_create_personal_access_tokens_table	1
12	2026_02_06_163010_make_name_nullable_in_users_table	1
13	2026_02_09_000000_drop_name_column_from_users_table	1
14	2026_02_13_105222_add_details_to_missions_table	1
15	2026_02_13_105222_create_menus_table	1
16	2026_02_13_105258_create_recettes_table	1
17	2026_02_23_105543_add_fields_to_formations_table	1
18	2026_02_23_130000_migrate_files_to_polymorphic_documents_table	1
19	2026_02_23_134543_drop_repas_and_regimes_from_structures_table	1
20	2026_02_23_150149_align_missions_table_schema	1
21	2026_02_23_152940_make_old_mission_fields_nullable	1
22	2026_02_23_160000_add_heure_fin_to_missions_table	1
23	2026_02_25_131600_add_type_to_recettes_table	1
24	2026_02_25_140000_enable_unaccent_extension	1
25	2026_02_27_110000_add_fonction_to_professionnels_table	2
26	2026_03_02_104637_add_statut_validation_to_structures_table	3
27	2026_03_03_151224_update_heure_fin_to_horaire_fin_in_missions_table	4
28	2026_03_04_003000_create_mission_recette_table	5
29	2026_03_04_100500_create_mission_repas_table	6
30	2026_03_04_101500_drop_menus_table	6
31	2026_03_04_103000_add_recette_ids_to_mission_repas_table	7
32	2026_03_04_151000_add_commentaires_admin_to_missions_table	8
33	2026_03_16_000000_create_mission_messages_table	9
35	2026_03_16_152753_update_mission_statuses_table	10
36	2024_03_17_112203_create_mission_responses_table	11
37	2026_03_17_132000_add_logistics_codes_to_missions_table	12
38	2026_03_23_120000_add_meal_types_to_recettes_table	12
39	2026_03_24_111500_create_mission_repas_recettes_table	13
40	2026_03_26_000000_add_nb_chefs_to_missions_table	14
41	2026_03_26_140000_update_ingredients_column_in_recettes_table	15
42	2026_03_26_150000_add_texture_counts_to_recettes_table	16
43	2026_03_26_160000_create_notifications_table	16
44	2026_03_27_112000_add_telephone_to_structures_table	16
45	2026_03_27_121000_add_checklist_to_missions_table	17
46	2026_03_27_153000_add_address_to_structures_table	18
47	2026_04_07_000000_add_incident_feedback_types_to_mission_messages	19
48	2026_04_13_000001_add_lat_lng_to_mission_messages_table	19
49	2026_04_17_154800_update_mission_messages_type_enum	20
51	2024_04_17_000000_create_feedbacks_table	21
52	2026_04_20_114500_create_menus_table	21
53	2026_04_20_114600_create_menu_recettes_table	21
54	2026_04_20_000000_rename_feedbacks_to_retours	22
55	2026_04_21_000000_add_is_handled_to_mission_messages_table	23
\.


--
-- Data for Name: mission_messages; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.mission_messages (id, mission_id, user_id, content, is_read, created_at, updated_at, type, file_path, latitude, longitude, is_handled) FROM stdin;
32	29	8	🚨 INCIDENT: [Panne de matériel] pas de materiel	t	2026-04-24 00:18:50	2026-04-24 00:19:47	incident	\N	\N	\N	t
31	34	8	⭐ FEEDBACK: [Note: 3/5] j'adore	t	2026-04-24 00:11:43	2026-04-24 00:19:58	feedback	\N	\N	\N	t
9	29	8	njjjjjjj	t	2026-04-14 10:23:21	2026-04-14 10:24:53	text	\N	\N	\N	f
30	34	8	⭐ FEEDBACK: [Note: 4/5] j suis satisfait	t	2026-04-23 23:44:27	2026-04-24 00:25:02	feedback	\N	\N	\N	t
15	30	6	⭐ FEEDBACK: [Note: 3/5] La mission était un peu désagreable	t	2026-04-17 10:51:13	2026-04-17 10:52:17	text	\N	\N	\N	f
16	30	1	d'accord j prends note	t	2026-04-17 10:52:43	2026-04-17 12:20:38	text	\N	\N	\N	f
33	34	8	CV_SMKND.pdf	t	2026-04-24 12:24:48	2026-04-24 12:29:03	file	mission_attachments/34/JkXCdn89VTynWbZi5jWwhXmq0LNxceT7lGIDXgAA.pdf	\N	\N	f
34	34	8	⭐ FEEDBACK: [Note: 3/5] j'ai aime	t	2026-04-24 12:41:53	2026-04-24 12:43:39	feedback	\N	\N	\N	t
10	29	1	est ce vous avez verifie les recettes	t	2026-04-14 15:36:08	2026-04-23 10:08:16	text	\N	\N	\N	f
11	29	1	oui tout est OK	t	2026-04-17 09:38:17	2026-04-23 10:08:16	text	\N	\N	\N	f
12	29	1	mission_29_20260413_115723.pdf	t	2026-04-17 09:38:47	2026-04-23 10:08:16	file	mission_attachments/29/AqCKCVIXezaofMcNo1H3H59m6zCgoPPLmVEFtwwm.pdf	\N	\N	f
17	28	1	boj=njour	t	2026-04-20 15:21:06	2026-04-23 10:47:38	text	\N	\N	\N	f
23	34	8	je valide la mission	t	2026-04-23 10:35:40	2026-04-23 10:48:18	text	\N	\N	\N	f
26	34	1	d'accord	t	2026-04-23 12:09:23	2026-04-23 12:37:40	text	\N	\N	\N	f
18	31	6	🚨 INCIDENT: [Matériel] Le gaz a pris feu	t	2026-04-20 15:41:13	2026-04-23 13:02:36	incident	\N	\N	\N	t
19	31	6	⭐ FEEDBACK: [Note: 5/5] Un peu desagreable	t	2026-04-20 15:42:07	2026-04-23 13:03:01	feedback	\N	\N	\N	t
27	34	1	Merci beaucoup	t	2026-04-23 13:26:12	2026-04-23 13:27:20	text	\N	\N	\N	f
28	34	1	pour	t	2026-04-23 13:51:59	2026-04-23 13:55:00	text	\N	\N	\N	f
29	34	1	la	t	2026-04-23 15:55:40	2026-04-23 15:56:21	text	\N	\N	\N	f
14	30	6	🚨 INCIDENT: [Matériel] Ils n'ont pas respecter les quantités	t	2026-04-17 10:17:42	2026-04-23 16:11:04	incident	\N	\N	\N	t
36	35	4	bonjour	t	2026-04-28 10:05:20	2026-04-28 10:06:09	text	\N	\N	\N	f
35	34	8	🚨 INCIDENT: [Menu non conforme] Il a change la recette	t	2026-04-24 12:45:16	2026-05-03 17:57:04	incident	\N	\N	\N	t
37	35	1	oui bonjour	t	2026-05-03 17:58:12	2026-05-03 18:03:59	text	\N	\N	\N	f
38	35	4	j'aimerais vous proposez quelque chose	t	2026-05-03 18:04:54	2026-05-03 18:13:44	text	\N	\N	\N	f
39	35	1	j vous ecoute	t	2026-05-03 18:13:59	2026-05-03 18:30:16	text	\N	\N	\N	f
40	35	1	que veux tu ARS est la	t	2026-05-03 18:29:27	2026-05-03 18:30:16	text	\N	\N	\N	f
42	35	4	bon	t	2026-05-03 19:06:10	2026-05-03 19:06:49	text	\N	\N	\N	f
43	35	1	ou j'ecoute madame	t	2026-05-03 19:07:18	2026-05-03 19:08:06	text	\N	\N	\N	f
\.


--
-- Data for Name: mission_recette; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.mission_recette (id, mission_id, recette_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: mission_repas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.mission_repas (id, mission_id, type_repas, entree, plat, accompagnement, dessert, description_simple, created_at, updated_at, entree_recette_id, plat_recette_id, accompagnement_recette_id, dessert_recette_id, simple_recette_id) FROM stdin;
46	28	lunch	\N	\N	\N	\N	\N	2026-03-26 16:58:57	2026-03-26 16:58:57	\N	\N	\N	\N	\N
47	27	breakfast	\N	\N	\N	\N	\N	2026-03-27 09:40:46	2026-03-27 09:40:46	\N	\N	\N	\N	\N
50	29	lunch	\N	Filet de viande rouge	\N	\N	\N	2026-04-13 13:14:56	2026-04-13 13:14:56	\N	\N	\N	\N	\N
52	30	dinner	\N	\N	\N	\N	\N	2026-04-17 09:55:08	2026-04-17 09:55:08	\N	\N	\N	\N	\N
54	31	lunch	\N	\N	\N	\N	\N	2026-04-20 15:34:44	2026-04-20 15:34:44	\N	\N	\N	\N	\N
57	34	lunch	Œufs Cocotte à la Crème	Blanquette de Veau à l'ancienne	Cota Chipenda	Île Flottante Onctueuse	\N	2026-04-23 10:34:35	2026-04-23 10:34:35	\N	\N	\N	\N	\N
42	26	breakfast	\N	\N	\N	\N	Île Flottante Onctueuse	2026-03-17 15:05:13	2026-03-17 15:05:13	\N	\N	\N	\N	\N
58	35	lunch	\N	\N	\N	\N	\N	2026-04-24 16:14:03	2026-04-24 16:14:03	\N	\N	\N	\N	\N
64	37	breakfast	\N	\N	\N	\N	Blanquette de Veau à l'ancienne	2026-05-04 00:30:09	2026-05-04 00:30:09	\N	\N	\N	\N	\N
65	37	lunch	Œufs Cocotte à la Crème	Blanquette de Veau à l'ancienne	Cota Chipenda	Île Flottante Onctueuse	\N	2026-05-04 00:30:09	2026-05-04 00:30:09	\N	\N	\N	\N	\N
\.


--
-- Data for Name: mission_repas_recettes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.mission_repas_recettes (id, mission_repas_id, recette_id, category, created_at, updated_at) FROM stdin;
8	46	3	entree	2026-03-26 16:58:57	2026-03-26 16:58:57
9	46	18	plat	2026-03-26 16:58:57	2026-03-26 16:58:57
10	46	21	accompagnement	2026-03-26 16:58:57	2026-03-26 16:58:57
11	47	14	simple	2026-03-27 09:40:46	2026-03-27 09:40:46
18	50	25	entree	2026-04-13 13:14:56	2026-04-13 13:14:56
19	50	23	dessert	2026-04-13 13:14:56	2026-04-13 13:14:56
26	52	25	entree	2026-04-17 09:55:08	2026-04-17 09:55:08
27	52	13	entree	2026-04-17 09:55:08	2026-04-17 09:55:08
28	52	17	plat	2026-04-17 09:55:08	2026-04-17 09:55:08
29	52	19	accompagnement	2026-04-17 09:55:08	2026-04-17 09:55:08
30	52	22	dessert	2026-04-17 09:55:08	2026-04-17 09:55:08
35	54	14	entree	2026-04-20 15:34:44	2026-04-20 15:34:44
36	54	29	plat	2026-04-20 15:34:45	2026-04-20 15:34:45
37	54	20	accompagnement	2026-04-20 15:34:45	2026-04-20 15:34:45
38	54	22	dessert	2026-04-20 15:34:45	2026-04-20 15:34:45
44	57	15	entree	2026-04-23 10:34:35	2026-04-23 10:34:35
45	57	4	plat	2026-04-23 10:34:35	2026-04-23 10:34:35
46	57	28	accompagnement	2026-04-23 10:34:35	2026-04-23 10:34:35
47	57	12	dessert	2026-04-23 10:34:35	2026-04-23 10:34:35
48	58	25	entree	2026-04-24 16:14:03	2026-04-24 16:14:03
49	58	29	plat	2026-04-24 16:14:03	2026-04-24 16:14:03
50	58	22	dessert	2026-04-24 16:14:03	2026-04-24 16:14:03
58	64	4	simple	2026-05-04 00:30:09	2026-05-04 00:30:09
59	65	15	entree	2026-05-04 00:30:09	2026-05-04 00:30:09
60	65	4	plat	2026-05-04 00:30:09	2026-05-04 00:30:09
61	65	28	accompagnement	2026-05-04 00:30:09	2026-05-04 00:30:09
62	65	12	dessert	2026-05-04 00:30:09	2026-05-04 00:30:09
\.


--
-- Data for Name: mission_responses; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.mission_responses (id, mission_id, professionnel_id, status, created_at, updated_at) FROM stdin;
2	28	2	confirmé	2026-03-27 09:59:56	2026-03-27 09:59:56
3	29	2	confirmé	2026-04-13 13:27:30	2026-04-13 13:27:30
4	30	3	confirmé	2026-04-17 10:09:52	2026-04-17 10:09:52
5	31	2	refusé	2026-04-20 15:38:20	2026-04-20 15:38:20
6	31	3	confirmé	2026-04-20 15:39:37	2026-04-20 15:39:37
9	35	2	confirmé	2026-04-25 17:12:43	2026-04-25 17:12:43
10	36	2	confirmé	2026-05-05 02:05:16	2026-05-05 02:05:16
\.


--
-- Data for Name: missions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.missions (id, structure_id, professionnel_id, date, duree, statut, commentaires, created_at, updated_at, nb_residents_jour, types_repas, regimes_speciaux, menu_entree_brut, menu_plat_brut, menu_accompagnement_brut, menu_dessert_brut, horaire_mission, nb_regimes_haches, nb_regimes_mixes, nb_regimes_moulines, est_cree_par_admin, horaire_fin, commentaires_admin, code_entree, code_cuisine, nb_chefs, checklist_journee, checklist_items) FROM stdin;
28	4	2	\N	\N	terminé	il faut mettre un peu de poivre	2026-03-26 11:29:45	2026-03-27 12:24:52	78	["lunch"]	["diabetic","vegetarian"]	\N	\N	\N	\N	2026-03-31 06:00:00	12	5	15	f	2026-03-27 12:24:52	il faut mettre un peu de poivre	VD45	GH85	45	\N	\N
36	3	2	2026-05-22	\N	en cours	\N	2026-05-03 20:24:33	2026-05-05 02:05:16	145	[]	[]	\N	\N	\N	\N	2026-05-22 20:24:00	0	0	0	f	2026-05-22 20:24:00	\N	SJJF	XBBX4	1	\N	\N
26	3	\N	\N	\N	en cours	\N	2026-03-17 15:05:13	2026-03-17 15:05:13	850	["breakfast"]	["textures","no_salt","diabetic"]	\N	\N	\N	\N	2026-03-18 06:00:00	10	0	0	f	2026-03-18 12:04:00	\N	\N	\N	1	\N	\N
27	4	\N	\N	\N	en cours	Il faut mettre un peu de sel	2026-03-26 10:46:48	2026-03-26 11:25:33	256	["breakfast"]	["diabetic","no_salt"]	\N	\N	\N	\N	2026-03-28 13:45:00	0	0	0	f	2026-03-31 00:45:00	Il faut mettre un peu de sel	\N	\N	4	\N	\N
29	4	2	\N	\N	terminé	\N	2026-04-13 11:20:47	2026-04-20 20:08:09	785	["lunch"]	["diabetic","no_salt","textures"]	\N	\N	\N	\N	2026-04-16 06:00:00	0	0	0	f	2026-04-13 15:16:44	\N	Ak	QK	14	{"Ouverture":true,"Frigos":true,"Pr\\u00e9paration":true,"Textures":true,"Dressage":true,"Nettoyage":true,"Signature":true}	\N
31	2	3	\N	\N	terminé	\N	2026-04-20 15:32:39	2026-04-20 15:41:40	74	["lunch"]	["textures","no_salt"]	\N	\N	\N	\N	2026-04-22 06:00:00	1	3	7	f	2026-04-20 15:41:40	\N	SGFGGF	QHHH85	1	{"Ouverture":true,"Frigos":true,"Pr\\u00e9paration":true,"Textures":true,"Dressage":true,"Nettoyage":true,"Signature":true}	\N
35	2	2	2026-04-30	\N	terminé	\N	2026-04-24 16:14:03	2026-04-25 17:14:12	185	["lunch"]	["diabetic","gluten_free"]	\N	\N	\N	\N	2026-04-30 02:00:00	0	0	0	f	2026-04-25 17:14:12	\N	AGDGGD	AGGDHDH	1	{"Ouverture":true,"Frigos":true,"Pr\\u00e9paration":true,"Textures":true,"Dressage":true,"Nettoyage":true,"Signature":true}	\N
34	4	\N	2026-04-23	\N	terminé	La mission doit etre .	2026-04-23 10:34:35	2026-04-23 10:53:13	300	["lunch"]	["vegetarian"]	\N	\N	\N	\N	2026-04-23 15:00:00	10	0	0	t	2026-04-23 10:53:13	\N	DFFDGGD4568	DGHHF56688	12	{"Ouverture":true,"Frigos":true,"Pr\\u00e9paration":true,"Textures":true,"Dressage":true,"Nettoyage":true,"Signature":true}	\N
30	3	3	\N	\N	terminé	A respecter svp	2026-04-17 09:51:32	2026-04-17 10:50:29	700	["dinner"]	["diabetic"]	\N	\N	\N	\N	2026-04-24 14:00:00	12	5	4	f	2026-04-17 10:50:29	A respecter svp	SHFHHF555	HHDHDH55	12	{"Ouverture":true,"Frigos":true,"Pr\\u00e9paration":true,"Textures":true,"Dressage":true,"Nettoyage":true,"Signature":true}	\N
37	4	\N	2026-05-28	\N	confirmé	faut respecter	2026-05-03 22:22:52	2026-05-04 00:29:49	180	["breakfast","lunch"]	["no_salt","diabetic","standard"]	\N	\N	\N	\N	2026-05-28 23:00:00	12	7	1	f	2026-05-28 00:00:00	faut respecter	QSSDDD45588	SDDFF4586	14	\N	\N
\.


--
-- Data for Name: notifications; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.notifications (id, type, notifiable_type, notifiable_id, data, read_at, created_at, updated_at) FROM stdin;
f4110459-7490-4b72-8a27-c6d998126b39	App\\Notifications\\MissionValidated	App\\Models\\User	3	{"mission_id":29,"title":"Nouvelle mission disponible","body":"Une mission \\u00e0 Hopital YA SALAM le 16\\/04\\/2026 est disponible.","type":"mission_available"}	\N	2026-04-13 13:15:19	2026-04-13 13:15:19
01085413-61c1-46ba-8b32-d96e51171b44	App\\Notifications\\MissionValidated	App\\Models\\User	6	{"mission_id":29,"title":"Nouvelle mission disponible","body":"Une mission \\u00e0 Hopital YA SALAM le 16\\/04\\/2026 est disponible.","type":"mission_available"}	\N	2026-04-13 13:15:19	2026-04-13 13:15:19
ad6d8f88-a2eb-479a-88cd-bb716d4afeb3	App\\Notifications\\MissionCreated	App\\Models\\User	1	{"mission_id":29,"title":"Nouvelle mission d\\u00e9pos\\u00e9e","body":"Une nouvelle mission a \\u00e9t\\u00e9 cr\\u00e9\\u00e9e par Hopital YA SALAM.","type":"new_mission"}	2026-04-14 11:20:49	2026-04-13 11:20:50	2026-04-14 11:20:49
7a662092-0a1c-4989-89e3-911c1d283f13	App\\Notifications\\MissionCreated	App\\Models\\User	1	{"mission_id":30,"title":"Nouvelle mission d\\u00e9pos\\u00e9e","body":"Une nouvelle mission a \\u00e9t\\u00e9 cr\\u00e9\\u00e9e par CLINIQUE YA SALAM.","type":"new_mission"}	2026-04-17 09:54:08	2026-04-17 09:51:39	2026-04-17 09:54:08
02753fc2-84ec-4550-b939-d6dfc1fdfe40	App\\Notifications\\MissionValidated	App\\Models\\User	6	{"mission_id":30,"title":"Nouvelle mission disponible","body":"Une mission \\u00e0 CLINIQUE YA SALAM le 24\\/04\\/2026 est disponible.","type":"mission_available"}	\N	2026-04-17 09:57:21	2026-04-17 09:57:21
47ed7ce9-cfe9-4a72-a06a-c24422a42674	App\\Notifications\\MissionValidated	App\\Models\\User	5	{"mission_id":30,"title":"Nouvelle mission disponible","body":"Une mission \\u00e0 CLINIQUE YA SALAM le 24\\/04\\/2026 est disponible.","type":"mission_available"}	2026-04-17 15:15:41	2026-04-17 09:57:21	2026-04-17 15:15:41
584041ac-2a2a-4411-9f95-ad955052e941	App\\Notifications\\MissionValidated	App\\Models\\User	5	{"mission_id":29,"title":"Nouvelle mission disponible","body":"Une mission \\u00e0 Hopital YA SALAM le 16\\/04\\/2026 est disponible.","type":"mission_available"}	2026-04-17 15:15:41	2026-04-13 13:15:19	2026-04-17 15:15:41
2c9d164a-8b80-4b3d-9e62-39dfd5bbdce9	App\\Notifications\\MissionValidated	App\\Models\\User	5	{"mission_id":31,"title":"Nouvelle mission disponible","body":"Une mission \\u00e0 Hopital Felip Senghor le 22\\/04\\/2026 est disponible.","type":"mission_available"}	\N	2026-04-20 15:35:00	2026-04-20 15:35:00
298774a3-f9f2-40fe-ab82-d1666d790282	App\\Notifications\\MissionValidated	App\\Models\\User	6	{"mission_id":31,"title":"Nouvelle mission disponible","body":"Une mission \\u00e0 Hopital Felip Senghor le 22\\/04\\/2026 est disponible.","type":"mission_available"}	\N	2026-04-20 15:35:00	2026-04-20 15:35:00
bf2d9169-b627-447e-a0c1-ef67d3a2a4c0	App\\Notifications\\MissionValidated	App\\Models\\User	5	{"mission_id":32,"title":"Nouvelle mission disponible","body":"Une mission \\u00e0 Hopital YA SALAM le 21\\/04\\/2026 est disponible.","type":"mission_available"}	\N	2026-04-20 15:59:22	2026-04-20 15:59:22
7b66940e-e697-48ad-a035-877c5bc02e84	App\\Notifications\\MissionValidated	App\\Models\\User	6	{"mission_id":32,"title":"Nouvelle mission disponible","body":"Une mission \\u00e0 Hopital YA SALAM le 21\\/04\\/2026 est disponible.","type":"mission_available"}	\N	2026-04-20 15:59:22	2026-04-20 15:59:22
bfd33b0d-3e14-44f0-93c7-3e81875d3ce7	App\\Notifications\\MissionValidated	App\\Models\\User	5	{"mission_id":32,"title":"Nouvelle mission disponible","body":"Une mission \\u00e0 Hopital YA SALAM le 21\\/04\\/2026 est disponible.","type":"mission_available"}	\N	2026-04-20 16:57:59	2026-04-20 16:57:59
1396d612-55f5-4a78-938b-4c91ad971e38	App\\Notifications\\MissionValidated	App\\Models\\User	6	{"mission_id":32,"title":"Nouvelle mission disponible","body":"Une mission \\u00e0 Hopital YA SALAM le 21\\/04\\/2026 est disponible.","type":"mission_available"}	\N	2026-04-20 16:57:59	2026-04-20 16:57:59
56304e0f-5b47-417a-b146-68aea759748c	App\\Notifications\\MissionCreated	App\\Models\\User	1	{"mission_id":31,"title":"Nouvelle mission d\\u00e9pos\\u00e9e","body":"Une nouvelle mission a \\u00e9t\\u00e9 cr\\u00e9\\u00e9e par Hopital Felip Senghor.","type":"new_mission"}	2026-04-21 01:26:24	2026-04-20 15:32:42	2026-04-21 01:26:24
4afd2570-2218-4938-9943-a1a620fe4c36	App\\Notifications\\MissionCreated	App\\Models\\User	1	{"mission_id":33,"title":"Nouvelle mission d\\u00e9pos\\u00e9e","body":"Une nouvelle mission a \\u00e9t\\u00e9 cr\\u00e9\\u00e9e par Hopital YA SALAM.","type":"new_mission"}	2026-04-23 09:38:09	2026-04-23 09:37:37	2026-04-23 09:38:09
65cc7025-6c33-4f95-ad9f-4d4ea269f972	App\\Notifications\\MissionValidated	App\\Models\\User	6	{"mission_id":33,"title":"Nouvelle mission disponible","body":"Une mission \\u00e0 Hopital YA SALAM le 25\\/04\\/2026 est disponible.","type":"mission_available"}	\N	2026-04-23 09:40:51	2026-04-23 09:40:51
b4905f76-7aa0-49e1-beee-713d33cb3aed	App\\Notifications\\MissionValidated	App\\Models\\User	9	{"mission_id":33,"title":"Nouvelle mission disponible","body":"Une mission \\u00e0 Hopital YA SALAM le 25\\/04\\/2026 est disponible.","type":"mission_available"}	\N	2026-04-23 09:40:51	2026-04-23 09:40:51
9cf4a5ea-5e39-470f-86c5-e3c645dd93f9	App\\Notifications\\MissionValidated	App\\Models\\User	5	{"mission_id":33,"title":"Nouvelle mission disponible","body":"Une mission \\u00e0 Hopital YA SALAM le 25\\/04\\/2026 est disponible.","type":"mission_available"}	2026-04-23 09:42:23	2026-04-23 09:40:51	2026-04-23 09:42:23
f360643d-a6ac-492d-a9ed-ba3dce62f3f5	App\\Notifications\\MissionCreated	App\\Models\\User	1	{"mission_id":32,"title":"Nouvelle mission d\\u00e9pos\\u00e9e","body":"Une nouvelle mission a \\u00e9t\\u00e9 cr\\u00e9\\u00e9e par Hopital YA SALAM.","type":"new_mission"}	2026-04-23 09:53:06	2026-04-20 15:48:06	2026-04-23 09:53:06
c427b1a2-a02c-4faa-9e54-4caeb1ef3104	App\\Notifications\\MissionCreated	App\\Models\\User	1	{"mission_id":34,"title":"Nouvelle mission d\\u00e9pos\\u00e9e","body":"Une nouvelle mission a \\u00e9t\\u00e9 cr\\u00e9\\u00e9e par Hopital YA SALAM.","type":"new_mission"}	2026-04-23 10:34:42	2026-04-23 10:34:35	2026-04-23 10:34:42
f313e0e1-d809-480f-818b-14a2d30ca375	App\\Notifications\\MissionValidated	App\\Models\\User	5	{"mission_id":34,"title":"Nouvelle mission disponible","body":"Une mission \\u00e0 Hopital YA SALAM le 23\\/04\\/2026 est disponible.","type":"mission_available"}	\N	2026-04-23 10:48:37	2026-04-23 10:48:37
9e8cbcfc-9145-4d79-bcf4-8b3ea1629af9	App\\Notifications\\MissionValidated	App\\Models\\User	6	{"mission_id":34,"title":"Nouvelle mission disponible","body":"Une mission \\u00e0 Hopital YA SALAM le 23\\/04\\/2026 est disponible.","type":"mission_available"}	\N	2026-04-23 10:48:37	2026-04-23 10:48:37
9639c2c5-8b19-454a-9e86-b2a0874d8b62	App\\Notifications\\MissionValidated	App\\Models\\User	9	{"mission_id":34,"title":"Nouvelle mission disponible","body":"Une mission \\u00e0 Hopital YA SALAM le 23\\/04\\/2026 est disponible.","type":"mission_available"}	2026-04-23 10:49:41	2026-04-23 10:48:37	2026-04-23 10:49:41
281b6fe9-c4fe-45aa-934a-c8b2314a5611	App\\Notifications\\MissionCreated	App\\Models\\User	1	{"mission_id":35,"title":"Nouvelle mission d\\u00e9pos\\u00e9e","body":"Une nouvelle mission a \\u00e9t\\u00e9 cr\\u00e9\\u00e9e par Hopital Felip Senghor.","type":"new_mission"}	2026-04-24 16:16:40	2026-04-24 16:14:05	2026-04-24 16:16:40
a31a6daa-0a00-43d7-a12f-471d47f9ec54	App\\Notifications\\MissionValidated	App\\Models\\User	6	{"mission_id":35,"title":"Nouvelle mission disponible","body":"Une mission \\u00e0 Hopital Felip Senghor le 30\\/04\\/2026 est disponible.","type":"mission_available"}	\N	2026-04-24 16:17:41	2026-04-24 16:17:41
c6fe1d19-2301-45fb-a5ab-7d8f312dced6	App\\Notifications\\MissionValidated	App\\Models\\User	9	{"mission_id":35,"title":"Nouvelle mission disponible","body":"Une mission \\u00e0 Hopital Felip Senghor le 30\\/04\\/2026 est disponible.","type":"mission_available"}	\N	2026-04-24 16:17:41	2026-04-24 16:17:41
4f4bee95-9419-45c8-b3d8-1c66585757c5	App\\Notifications\\MissionValidated	App\\Models\\User	5	{"mission_id":35,"title":"Nouvelle mission disponible","body":"Une mission \\u00e0 Hopital Felip Senghor le 30\\/04\\/2026 est disponible.","type":"mission_available"}	2026-04-25 17:12:19	2026-04-24 16:17:41	2026-04-25 17:12:19
2367fa30-b9a3-4084-bc49-8bb5f3bbec3f	App\\Notifications\\MissionCreated	App\\Models\\User	1	{"mission_id":36,"title":"Nouvelle mission d\\u00e9pos\\u00e9e","body":"Une nouvelle mission a \\u00e9t\\u00e9 cr\\u00e9\\u00e9e par CLINIQUE YA SALAM.","type":"new_mission"}	2026-05-03 22:46:06	2026-05-03 20:24:36	2026-05-03 22:46:06
81f7e332-c02c-4124-b6cb-2937b0040917	App\\Notifications\\MissionCreated	App\\Models\\User	1	{"mission_id":37,"title":"Nouvelle mission d\\u00e9pos\\u00e9e","body":"Une nouvelle mission a \\u00e9t\\u00e9 cr\\u00e9\\u00e9e par Hopital YA SALAM.","type":"new_mission"}	2026-05-03 22:46:13	2026-05-03 22:22:52	2026-05-03 22:46:13
2a70e479-08a9-47a1-b760-3687403c3a64	App\\Notifications\\MissionValidated	App\\Models\\User	6	{"mission_id":36,"title":"Nouvelle mission disponible","body":"Une mission \\u00e0 CLINIQUE YA SALAM le 22\\/05\\/2026 est disponible.","type":"mission_available"}	2026-05-03 22:48:34	2026-05-03 22:46:10	2026-05-03 22:48:34
eaac8fe8-c4e3-45ac-9ce4-4f76694f94c9	App\\Notifications\\MissionValidated	App\\Models\\User	6	{"mission_id":37,"title":"Nouvelle mission disponible","body":"Une mission \\u00e0 Hopital YA SALAM le 28\\/05\\/2026 est disponible.","type":"mission_available"}	2026-05-03 22:48:44	2026-05-03 22:46:18	2026-05-03 22:48:44
e83b0258-6f39-4819-b196-4f5e1c334d97	App\\Notifications\\MissionValidated	App\\Models\\User	5	{"mission_id":36,"title":"Nouvelle mission disponible","body":"Une mission \\u00e0 CLINIQUE YA SALAM le 22\\/05\\/2026 est disponible.","type":"mission_available"}	2026-05-04 00:19:06	2026-05-03 22:46:10	2026-05-04 00:19:06
1d0cccb6-691f-4329-8d1f-09a0c2dce735	App\\Notifications\\MissionValidated	App\\Models\\User	5	{"mission_id":37,"title":"Nouvelle mission disponible","body":"Une mission \\u00e0 Hopital YA SALAM le 28\\/05\\/2026 est disponible.","type":"mission_available"}	2026-05-04 00:19:20	2026-05-03 22:46:18	2026-05-04 00:19:20
\.


--
-- Data for Name: password_reset_tokens; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.password_reset_tokens (email, token, created_at) FROM stdin;
admin@ars.com	$2y$12$RN/YAluQ7tAS7Wnns5PdJOR/Bi4routUVz1ii7ano.QwPN4WLQW5.	2026-04-14 12:35:05
\.


--
-- Data for Name: personal_access_tokens; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.personal_access_tokens (id, tokenable_type, tokenable_id, name, token, abilities, last_used_at, expires_at, created_at, updated_at) FROM stdin;
39	App\\Models\\User	4	auth_token	a908eb665204a6a72dcae6a8dd6482759e6dfb853d80ceebef06b1927d347335	["*"]	2026-03-03 14:55:08	\N	2026-03-03 14:55:07	2026-03-03 14:55:08
10	App\\Models\\User	1	auth_token	62db22c956ac92711addc6bf8c098cf6fab6e8241f89452f487c39df4dce2159	["*"]	2026-02-27 10:31:59	\N	2026-02-27 10:31:52	2026-02-27 10:31:59
26	App\\Models\\User	1	auth_token	6c7ff6b77df04d56e68cbb4c092b42b675a4108f729093e64bf0e41328d628af	["*"]	2026-03-02 11:49:26	\N	2026-03-02 11:49:22	2026-03-02 11:49:26
19	App\\Models\\User	1	auth_token	cd6ff01f4fa649f3425091dffa5cf465b39ca3f327b9487c02f73491cff68d9a	["*"]	2026-03-02 10:13:03	\N	2026-03-02 10:12:53	2026-03-02 10:13:03
11	App\\Models\\User	1	auth_token	0eb3c89fdfd751892bfc50716eafd09f2ab5e8a85f5dd1933daf0aa95cd00900	["*"]	2026-02-27 11:20:03	\N	2026-02-27 10:42:48	2026-02-27 11:20:03
1	App\\Models\\User	1	auth_token	d7adcaf4a1b36e29da600f7fd3b58dc6ae97957030c93d6db5edb31eb79a8699	["*"]	2026-02-25 14:37:17	\N	2026-02-25 14:32:54	2026-02-25 14:37:17
36	App\\Models\\User	1	auth_token	ed9218302a1cdf15d06fadb48d1e3b14c9b8a62ec37923e748a43fdd6d3162da	["*"]	2026-03-03 14:24:14	\N	2026-03-03 14:23:25	2026-03-03 14:24:14
12	App\\Models\\User	1	auth_token	058cee28737ce4cc5d96d1501e7ca2a613c55ce90ac36d5239c7b758844dc3c4	["*"]	2026-02-27 11:28:32	\N	2026-02-27 11:28:29	2026-02-27 11:28:32
2	App\\Models\\User	1	auth_token	96b2621e454ec40dc3ef502e489b5c1af357125ba92c63a5b9cd9907395d7545	["*"]	2026-02-25 14:51:58	\N	2026-02-25 14:50:36	2026-02-25 14:51:58
20	App\\Models\\User	1	auth_token	8511dc6dfb799045aecca5520ed2171f38cb207e0cbd0c0ca84f87614fa585b7	["*"]	2026-03-02 10:31:32	\N	2026-03-02 10:29:26	2026-03-02 10:31:32
13	App\\Models\\User	1	auth_token	ea3b7f3d64a938a7eaba516a67a2ed846d72fea93a6246b17dce8a16e39ac471	["*"]	2026-02-27 12:39:56	\N	2026-02-27 12:39:35	2026-02-27 12:39:56
33	App\\Models\\User	1	auth_token	0260cbb83a9d374c5f1cc96a1f174a2a34f8be45e5d0ec6897a6ff07f2a9736c	["*"]	2026-03-02 15:16:44	\N	2026-03-02 13:57:32	2026-03-02 15:16:44
27	App\\Models\\User	1	auth_token	244945701dfd97208c7c54b409b8bee321c9c9df5d6c31fb9ae700731a0d356f	["*"]	2026-03-02 11:56:40	\N	2026-03-02 11:54:11	2026-03-02 11:56:40
15	App\\Models\\User	1	auth_token	9c42f2801dcf89d5387895b4c27e9de5fbcfb425aa78f676ba867c158e2ef69e	["*"]	2026-02-27 13:01:53	\N	2026-02-27 13:01:50	2026-02-27 13:01:53
5	App\\Models\\User	1	auth_token	b4753283e07acbac3f452102ea915eb12f3cf6ceb71033ad2a9b9bf2f8c06192	["*"]	2026-02-25 15:28:58	\N	2026-02-25 15:16:47	2026-02-25 15:28:58
6	App\\Models\\User	1	auth_token	ee0f474681ece344aa7579d456aa38952199bf58c9e50a511b542123494aa66a	["*"]	\N	\N	2026-02-27 09:42:04	2026-02-27 09:42:04
28	App\\Models\\User	1	auth_token	22a3c3a8c981328751f0d0992e12e059e1a21efe067f0d64709844d574f86cc8	["*"]	2026-03-02 12:01:07	\N	2026-03-02 12:01:01	2026-03-02 12:01:07
7	App\\Models\\User	1	auth_token	b08e2ba516cbbceafdca96881d86aa1bad06eedd89948c84206c0ca2e86d3704	["*"]	2026-02-27 09:43:19	\N	2026-02-27 09:42:14	2026-02-27 09:43:19
21	App\\Models\\User	1	auth_token	b8dc9e61648666be84903f872aab0a5f77c7e5c4d74455847e7266d0da7ee54c	["*"]	2026-03-02 11:05:24	\N	2026-03-02 11:01:02	2026-03-02 11:05:24
9	App\\Models\\User	5	auth_token	1860fc26853617d96895296934b053409e2f039512d532c01e404c6424d31bbe	["*"]	2026-02-27 10:14:34	\N	2026-02-27 10:14:33	2026-02-27 10:14:34
22	App\\Models\\User	1	auth_token	578c7b01f0212f0b9b86d762af79dd069130c3127347b900274533cec794cedf	["*"]	2026-03-02 11:14:11	\N	2026-03-02 11:13:52	2026-03-02 11:14:11
16	App\\Models\\User	1	auth_token	70bb746256098a80176fef4bde823fb281407d63687066d57edcb3623c9e5905	["*"]	2026-03-02 10:05:42	\N	2026-03-02 10:02:56	2026-03-02 10:05:42
29	App\\Models\\User	1	auth_token	611b424fe86663c6bca54597117f58d489ccd025b95c304ce13e9a29607e4d5c	["*"]	2026-03-02 12:14:00	\N	2026-03-02 12:13:55	2026-03-02 12:14:00
23	App\\Models\\User	1	auth_token	6512344a236d114650817bb6203d4e84829bb1d18eb778fdbd4be29e7c05b8c9	["*"]	2026-03-02 11:25:52	\N	2026-03-02 11:25:25	2026-03-02 11:25:52
24	App\\Models\\User	1	auth_token	3792b86c119518de6efffe5e076ccec9f8f78c24df3441c4793e3a054d40f170	["*"]	2026-03-02 11:33:49	\N	2026-03-02 11:33:42	2026-03-02 11:33:49
25	App\\Models\\User	1	auth_token	805b62d552e292e51fc19e7ad7caf9ba3f6441bcba11c5ea974b41d325b26b6e	["*"]	2026-03-02 11:39:10	\N	2026-03-02 11:39:02	2026-03-02 11:39:10
30	App\\Models\\User	1	auth_token	03e4921b86e48cbf61fefa09f9726448e44a89a0819dd5638d8784ac339ce59a	["*"]	2026-03-02 12:20:45	\N	2026-03-02 12:20:38	2026-03-02 12:20:45
40	App\\Models\\User	4	auth_token	a10378ebb965a58f637299f454135ece3abd4379029893dc289873de11986921	["*"]	2026-03-03 15:03:41	\N	2026-03-03 15:03:40	2026-03-03 15:03:41
31	App\\Models\\User	1	auth_token	e5384f56df68a22172cf64770f8dfed9de3b66318c05a3ba2a09a8d49957a18c	["*"]	2026-03-02 13:31:47	\N	2026-03-02 12:32:19	2026-03-02 13:31:47
43	App\\Models\\User	4	auth_token	9e6c78c3fc58361b8fad72bbc4d4f4be2633cbb4ad7229850cc54ffc6ab8f21e	["*"]	2026-03-03 22:55:23	\N	2026-03-03 22:55:22	2026-03-03 22:55:23
32	App\\Models\\User	1	auth_token	7456cd9464a4f848521ce2b580b92f146c27bfe15bff7e622ab14e562bc33131	["*"]	2026-03-02 13:44:47	\N	2026-03-02 13:44:44	2026-03-02 13:44:47
35	App\\Models\\User	1	auth_token	0e65427b6d062f14a4a4bcdea6d205bee0e4e4e6084adddb16a967514b6bdc26	["*"]	2026-03-02 15:26:58	\N	2026-03-02 15:26:38	2026-03-02 15:26:58
37	App\\Models\\User	1	auth_token	a5bd0dab5c10a624a23b5dec51cfa5c76ae83f400a9d3a8ae560d528c4eb8818	["*"]	2026-03-03 14:35:27	\N	2026-03-03 14:34:13	2026-03-03 14:35:27
38	App\\Models\\User	4	auth_token	414dac61cd68224d91b69cebd9dee3d03718a096b0e15371e481736df582c801	["*"]	2026-03-03 14:36:17	\N	2026-03-03 14:36:16	2026-03-03 14:36:17
42	App\\Models\\User	4	auth_token	2156d6bc868b9e41361f23091e5ed904b080af328a003e24031428d6cc49e2c7	["*"]	2026-03-03 22:51:33	\N	2026-03-03 22:51:33	2026-03-03 22:51:33
44	App\\Models\\User	4	auth_token	cedfbda3b8c7cd56f35040343ecb3b5e806e810a3187538b1591ea4f9bc21125	["*"]	2026-03-03 23:01:04	\N	2026-03-03 23:01:03	2026-03-03 23:01:04
45	App\\Models\\User	4	auth_token	53f878bd322f20f07f598ea1a77a243163f6cb0e60c3a02b6276689f412d42b7	["*"]	2026-03-03 23:35:21	\N	2026-03-03 23:35:19	2026-03-03 23:35:21
46	App\\Models\\User	4	auth_token	5b1943a6e2c97bb7d6330c4bc6c713caa74b7672c1e39809f9b10d0c1228107a	["*"]	2026-03-04 00:00:49	\N	2026-03-04 00:00:48	2026-03-04 00:00:49
47	App\\Models\\User	4	auth_token	fdc2e5a9768d015f3cfb054242ae1e062fd5c2a0440d7cf5999f9bdfd282f60d	["*"]	2026-03-04 00:05:51	\N	2026-03-04 00:05:50	2026-03-04 00:05:51
48	App\\Models\\User	4	auth_token	92c40cdd141ec9fcb3116df64f8a7e7626f933efea12b51c6a337bfdd0f231d8	["*"]	2026-03-04 00:11:21	\N	2026-03-04 00:11:20	2026-03-04 00:11:21
49	App\\Models\\User	4	auth_token	f169504ce84bb6261a848af4ce5628e0890410aed6f608b4e95bdd2c61de29ab	["*"]	2026-03-04 00:14:56	\N	2026-03-04 00:14:55	2026-03-04 00:14:56
50	App\\Models\\User	4	auth_token	bd9042f6952d8a7d52e44057a41ed88319e2f6996970436d7c9e367c7ee380b7	["*"]	2026-03-04 00:25:33	\N	2026-03-04 00:25:32	2026-03-04 00:25:33
51	App\\Models\\User	4	auth_token	cf8b3073b09173323cf69d9e22635be078a24c3efa20c9692d6d450e74e46add	["*"]	2026-03-04 00:32:52	\N	2026-03-04 00:32:51	2026-03-04 00:32:52
52	App\\Models\\User	4	auth_token	bd66fc73546382e525255dec7c16fd9a6263aac93ec09718e98d7658a1845c00	["*"]	2026-03-04 00:37:38	\N	2026-03-04 00:37:37	2026-03-04 00:37:38
53	App\\Models\\User	4	auth_token	55db627b8524b9c5132098af9133c8db6631aed16df874c56aad781afac55368	["*"]	2026-03-04 00:43:16	\N	2026-03-04 00:43:15	2026-03-04 00:43:16
54	App\\Models\\User	4	auth_token	82159754fa14548b201042f4d6c48f6a3a50a857b226e9e5148aa1c3f009bae5	["*"]	2026-03-04 00:48:04	\N	2026-03-04 00:48:03	2026-03-04 00:48:04
55	App\\Models\\User	4	auth_token	ff281f8dd3bbae5df9fd822199f67b5729ba90f0e49b3db33a5e0b5a65a5a07e	["*"]	2026-03-04 09:35:22	\N	2026-03-04 09:35:16	2026-03-04 09:35:22
56	App\\Models\\User	4	auth_token	adb1141c9d01191ec8d0a9e035117850528f6e2e43300b61e5045b8b523e3607	["*"]	\N	\N	2026-03-04 12:10:06	2026-03-04 12:10:06
57	App\\Models\\User	4	auth_token	f44ab3c380eb9e6f675b909eefb3c9c67215154147ee9bf887c4bf57503c8047	["*"]	\N	\N	2026-03-04 12:10:19	2026-03-04 12:10:19
84	App\\Models\\User	4	auth_token	8247b60a41060a0f82266e57d7c6fadf8922c427563483ef6e515b233a508085	["*"]	2026-03-06 11:38:49	\N	2026-03-06 11:38:48	2026-03-06 11:38:49
58	App\\Models\\User	4	auth_token	346eec2b91c4c22833cc0820142852389cfc0ea3386b6dfeb7bdd8a6fe60e8b8	["*"]	2026-03-04 12:12:38	\N	2026-03-04 12:12:36	2026-03-04 12:12:38
59	App\\Models\\User	4	auth_token	0eb50d0ba1b057a99e984196b299d20e76d97d6488675adbc7d3347c38d98740	["*"]	2026-03-04 12:20:28	\N	2026-03-04 12:20:27	2026-03-04 12:20:28
60	App\\Models\\User	4	auth_token	dd1ac3a8cdb3e9761ccc152d4915b563215305e6ef8d972fa46d558727541ec9	["*"]	2026-03-04 12:27:46	\N	2026-03-04 12:27:45	2026-03-04 12:27:46
61	App\\Models\\User	4	auth_token	728cdd6eab1b6f7233de58ba11fc6ed968581acaa21139c6869a5b9c7165c1ee	["*"]	2026-03-04 12:39:24	\N	2026-03-04 12:39:23	2026-03-04 12:39:24
62	App\\Models\\User	4	auth_token	2d04832a83c852ec99ad8712becd8844afb40d3f2837a3b70054a20fd7fad390	["*"]	2026-03-04 12:55:31	\N	2026-03-04 12:55:30	2026-03-04 12:55:31
63	App\\Models\\User	4	auth_token	993edad2a874a5e57213ed6bb5b383b25a2e6a179e5bc1032b51baaf10007328	["*"]	2026-03-04 13:05:49	\N	2026-03-04 13:05:48	2026-03-04 13:05:49
64	App\\Models\\User	4	auth_token	4a391fd52bf8a66c07749131d9967a9089d46e60febfdf9a139af79e5d020624	["*"]	2026-03-04 13:19:04	\N	2026-03-04 13:19:03	2026-03-04 13:19:04
65	App\\Models\\User	4	auth_token	1771b58195f691c906551be0816ade62a9a79eee7639dd307a6e895023cbd4ff	["*"]	2026-03-04 13:23:56	\N	2026-03-04 13:23:55	2026-03-04 13:23:56
70	App\\Models\\User	4	auth_token	2651f624897d3cb0e5bab4edec7821850b1af24ca6b8675268c03d7e1d745580	["*"]	2026-03-04 14:10:37	\N	2026-03-04 14:08:28	2026-03-04 14:10:37
66	App\\Models\\User	4	auth_token	efbbb770175812baf209066569bbb7f5452fa60c7230ee5385c24e958349868a	["*"]	2026-03-04 13:32:40	\N	2026-03-04 13:28:22	2026-03-04 13:32:40
67	App\\Models\\User	4	auth_token	8235fbb01024d0b555c8f853d5f4ceb8f1f71df37db0ad3479cea97fb10970af	["*"]	2026-03-04 13:39:47	\N	2026-03-04 13:37:54	2026-03-04 13:39:47
85	App\\Models\\User	4	auth_token	2e5ac996d9c429c749be485841e24cfac9c8713b710ae21e60adf411a7a59d99	["*"]	2026-03-06 11:45:04	\N	2026-03-06 11:45:02	2026-03-06 11:45:04
68	App\\Models\\User	4	auth_token	eddaedb0b563d7f963c488841e23c97dbd63a5bd733105d2a43ac373fd89da95	["*"]	2026-03-04 13:51:46	\N	2026-03-04 13:44:01	2026-03-04 13:51:46
74	App\\Models\\User	4	auth_token	f312387e27f728c238c5e400ced24fee5144b680b868f3e6dea2e03f39e6af5a	["*"]	2026-03-04 15:17:39	\N	2026-03-04 15:15:21	2026-03-04 15:17:39
69	App\\Models\\User	4	auth_token	1eef1dfae50de9332c8111c2d01ff1730d6c2d00869cc1f0da9073776e0c6ac7	["*"]	2026-03-04 14:00:39	\N	2026-03-04 13:58:30	2026-03-04 14:00:39
80	App\\Models\\User	4	auth_token	9b5e52a69e0341e4c420f2f7ddf16d93b3d7e03e8ef1321853bf8d7958226d3e	["*"]	2026-03-06 11:14:06	\N	2026-03-06 11:13:25	2026-03-06 11:14:06
75	App\\Models\\User	4	auth_token	0037720a73da817de4ad8c11825d05993fc083e71c2a60bbe7e0cd8273eca231	["*"]	2026-03-06 09:53:36	\N	2026-03-06 09:48:02	2026-03-06 09:53:36
72	App\\Models\\User	4	auth_token	0470632303bdfb4ff582c84a6bfd953c05c619e93c76d745cc12e8bfb3250007	["*"]	2026-03-04 14:54:27	\N	2026-03-04 14:52:10	2026-03-04 14:54:27
76	App\\Models\\User	4	auth_token	9e5cc0d14aec66320b9778070cadac60d22ccc930cf3742a44bdfd961fbdad59	["*"]	2026-03-06 09:54:48	\N	2026-03-06 09:54:47	2026-03-06 09:54:48
77	App\\Models\\User	4	auth_token	f9ca93da6632bfe059f5dd9a47ae112aab69186a4c56e810406b6d6d082496ad	["*"]	2026-03-06 10:26:36	\N	2026-03-06 10:26:34	2026-03-06 10:26:36
73	App\\Models\\User	4	auth_token	8f03b8e1147955656ff88ede88afbc4841de25e51c86b9d55a27328066c95282	["*"]	2026-03-04 15:12:43	\N	2026-03-04 15:01:05	2026-03-04 15:12:43
86	App\\Models\\User	4	auth_token	fd6df091abb61c3795346ed2c91348be081f8bc0f9540090d36d83ae395eed47	["*"]	2026-03-06 11:53:25	\N	2026-03-06 11:53:24	2026-03-06 11:53:25
81	App\\Models\\User	4	auth_token	d129fb3ab900f53ec1dc007be17287ac428a2531a09d04ea4b47ba70b332da23	["*"]	2026-03-06 11:22:16	\N	2026-03-06 11:22:06	2026-03-06 11:22:16
78	App\\Models\\User	4	auth_token	68c146e85c6d62bc7e4d3832092d98d80365cd42688b22134dfb4ccae4efdcfd	["*"]	2026-03-06 11:01:48	\N	2026-03-06 11:01:46	2026-03-06 11:01:48
79	App\\Models\\User	4	auth_token	43b6cf9c2ce7d034ad594739b07560d9eae54412092449885afae7a284b30519	["*"]	2026-03-06 11:05:01	\N	2026-03-06 11:05:00	2026-03-06 11:05:01
82	App\\Models\\User	4	auth_token	61da077afaa2bcc8c95aaffc3eb5d19fbd433a6909bb526d976b67c92f29e6fe	["*"]	2026-03-06 11:26:44	\N	2026-03-06 11:26:43	2026-03-06 11:26:44
83	App\\Models\\User	4	auth_token	f8114cb40abee4ad768f17ad8f06478fdd778a78ad388da595d42eadd293a2df	["*"]	2026-03-06 11:33:08	\N	2026-03-06 11:33:01	2026-03-06 11:33:08
87	App\\Models\\User	4	auth_token	58774ace7f89a888f23395aaf744976b85032c8c6097defcb552424b2c86db09	["*"]	2026-03-06 12:05:19	\N	2026-03-06 12:05:18	2026-03-06 12:05:19
88	App\\Models\\User	4	auth_token	5d9dc9f2bd3d8ba545f609bae2f209e04ce76c282794f70080bddfe341e93832	["*"]	2026-03-06 12:08:32	\N	2026-03-06 12:08:31	2026-03-06 12:08:32
89	App\\Models\\User	4	auth_token	c9ddf166a19e5f26dc75dfa14a57be7504b54e66d08146f17573696350d0ff93	["*"]	2026-03-06 12:10:22	\N	2026-03-06 12:10:21	2026-03-06 12:10:22
90	App\\Models\\User	4	auth_token	fbc38e49e8a9141d35b886200fa2f211a84b5ca326bc1ca1b91fb4fedb6b5f35	["*"]	2026-03-06 12:26:35	\N	2026-03-06 12:26:34	2026-03-06 12:26:35
91	App\\Models\\User	4	auth_token	9c69857a744ef138855f89a2193a0289dd88d5e861a10a085d462b98214627a4	["*"]	2026-03-06 12:32:10	\N	2026-03-06 12:32:09	2026-03-06 12:32:10
93	App\\Models\\User	4	auth_token	50213977fe6273fd4e3ce8fdd53ff70aa0644e4445962754285b28b8f4e382d3	["*"]	2026-03-06 12:45:16	\N	2026-03-06 12:45:15	2026-03-06 12:45:16
92	App\\Models\\User	4	auth_token	1c96d28cdfc291346fe64a1c0e3b8f8c4849fba8321d7bd1dcd2e68ddc62f90b	["*"]	2026-03-06 12:38:14	\N	2026-03-06 12:38:12	2026-03-06 12:38:14
94	App\\Models\\User	4	auth_token	d2a6d474fa1db91499ac75d7b363c5de6e2010d9d202b8e0e5054399a90b1ffe	["*"]	2026-03-06 12:48:35	\N	2026-03-06 12:48:34	2026-03-06 12:48:35
95	App\\Models\\User	4	auth_token	a089cd543a474029b8bd5f3257d7e30c858bfabcb220ebc040a4a18a36059619	["*"]	2026-03-06 13:01:29	\N	2026-03-06 13:01:28	2026-03-06 13:01:29
96	App\\Models\\User	4	auth_token	90ed07c04e597236b6bf8c09a2461c8bbe50d0b1c35dc0e5c3ffa351c08e698b	["*"]	2026-03-06 13:08:06	\N	2026-03-06 13:08:04	2026-03-06 13:08:06
97	App\\Models\\User	4	auth_token	818b6050a22914ac6f4c2f13f90e1b84322788cae3688e33aca0c7ad6812c0fe	["*"]	2026-03-06 13:12:44	\N	2026-03-06 13:12:43	2026-03-06 13:12:44
98	App\\Models\\User	4	auth_token	b4b6b75d944867cb1cde8bf4d90653c02fb72ff9f36bdd83dacba0035e6bb008	["*"]	2026-03-06 13:19:28	\N	2026-03-06 13:19:27	2026-03-06 13:19:28
99	App\\Models\\User	4	auth_token	77acad607a6095c456074155d0e46a671da67170ca8dbf1c4fa5eede0d18dd7d	["*"]	2026-03-06 13:21:45	\N	2026-03-06 13:21:44	2026-03-06 13:21:45
100	App\\Models\\User	4	auth_token	55045b4916b0163a56b90a276264b7a5bd38651f86da8c340ea466c2f3c5dfc3	["*"]	2026-03-06 13:31:55	\N	2026-03-06 13:31:53	2026-03-06 13:31:55
101	App\\Models\\User	4	auth_token	d27caaac346d2da7c66471fa131b4a0867c129bf76c04a2de6fc90c0499baf6a	["*"]	2026-03-06 13:38:50	\N	2026-03-06 13:38:49	2026-03-06 13:38:50
102	App\\Models\\User	4	auth_token	87b7159007175155e44c7dd3303964ccd56341cf34d93d536d7e78a9fd277b34	["*"]	2026-03-06 13:43:43	\N	2026-03-06 13:43:42	2026-03-06 13:43:43
103	App\\Models\\User	4	auth_token	5114c61187a9d03229d6f1b3b3c3955d830945178378d2c06a36eb6a3049bc1c	["*"]	2026-03-06 14:14:59	\N	2026-03-06 14:14:57	2026-03-06 14:14:59
104	App\\Models\\User	4	auth_token	803f17fa9a10e528f06c78a454e04a1f46a21aa43be4bc2068f8361f83cd1e7d	["*"]	2026-03-06 14:22:06	\N	2026-03-06 14:22:05	2026-03-06 14:22:06
105	App\\Models\\User	4	auth_token	ebfe4f8a43245688476b3d963456f78ffa1b1d9bad2bcaa8620c4521ff19588a	["*"]	2026-03-06 14:32:47	\N	2026-03-06 14:32:46	2026-03-06 14:32:47
106	App\\Models\\User	4	auth_token	ee5d9e0afef4b3bfc31a49eb881683f184a2d9d19c1844f1b4e7e6aec107bf1d	["*"]	2026-03-06 14:41:19	\N	2026-03-06 14:41:18	2026-03-06 14:41:19
112	App\\Models\\User	4	auth_token	83ba359bb11bfb779d608cfba7125361560fa3201880e30e5d83aa13bad4165a	["*"]	2026-03-06 15:32:18	\N	2026-03-06 15:32:17	2026-03-06 15:32:18
113	App\\Models\\User	4	auth_token	e839c4698d24302dbbd848743d15c6d449a549784aecb82ef42ee5cfd9b7fb38	["*"]	2026-03-06 15:36:56	\N	2026-03-06 15:36:54	2026-03-06 15:36:56
115	App\\Models\\User	1	auth_token	5daefcbb76a86fca636fe3523f2076240458517ec3f6f910011c73d017830456	["*"]	2026-03-16 10:13:49	\N	2026-03-16 09:59:52	2026-03-16 10:13:49
127	App\\Models\\User	1	auth_token	b652ab1d80db3509545d1ba18f0f59327063b3150b509f11b3f1a34be50a1cb5	["*"]	2026-03-16 12:06:32	\N	2026-03-16 12:06:27	2026-03-16 12:06:32
118	App\\Models\\User	1	auth_token	e4b7ac64bd53fa563fca728ac099c7254a79b05281fae7352e227fde17048d8d	["*"]	2026-03-16 10:39:44	\N	2026-03-16 10:39:40	2026-03-16 10:39:44
108	App\\Models\\User	1	auth_token	998883306169b4d83fd3b0e40613bf848938259c22a2b7a077f33c2b7e4785a8	["*"]	2026-03-06 14:55:18	\N	2026-03-06 14:51:35	2026-03-06 14:55:18
109	App\\Models\\User	4	auth_token	9368a49f7e3f082164d33742631eeb6052d2a7ad6c54a2ad3f350bdc4711b824	["*"]	2026-03-06 15:08:52	\N	2026-03-06 15:08:51	2026-03-06 15:08:52
110	App\\Models\\User	4	auth_token	d86fd2ee9ec2043aa59c6bb1c5f4f517e5a2071c4ad598ef8c02e1e66c2add97	["*"]	2026-03-06 15:21:56	\N	2026-03-06 15:21:51	2026-03-06 15:21:56
111	App\\Models\\User	4	auth_token	676d1bf51a72e16d2d2eb825152566924c1ba377e4a99c4633c6f27d0b1bcf4e	["*"]	2026-03-06 15:27:16	\N	2026-03-06 15:27:15	2026-03-06 15:27:16
124	App\\Models\\User	1	auth_token	af459cbffef208b275d78fd3f73e0e2968d1e830320a482946e1996c73835e21	["*"]	2026-03-16 11:46:09	\N	2026-03-16 11:44:20	2026-03-16 11:46:09
119	App\\Models\\User	1	auth_token	27a23327dfc76732a07ef99c5469f2dafb44bbe9a67a1cad3dd1a7229667d52e	["*"]	2026-03-16 10:47:14	\N	2026-03-16 10:47:12	2026-03-16 10:47:14
116	App\\Models\\User	1	auth_token	c13fdaaebf6539f4f35983edcb7179ca6dbae7f83be283adaacfde04a97651e0	["*"]	2026-03-16 10:25:27	\N	2026-03-16 10:18:14	2026-03-16 10:25:27
120	App\\Models\\User	1	auth_token	1da9db87f5cee19905ddff52528f616db8c2e004cf6d8de5aa7bf40c8dc87400	["*"]	2026-03-16 10:49:36	\N	2026-03-16 10:49:34	2026-03-16 10:49:36
132	App\\Models\\User	4	auth_token	ff2e465a1be172ea668c4d61eb482a000cfc8a14961f6b42e598392f6a9ee1ea	["*"]	2026-03-16 13:06:28	\N	2026-03-16 13:02:45	2026-03-16 13:06:28
128	App\\Models\\User	4	auth_token	3be26b37d7f186fd1206c0a60487790012f65df76898cd0467454b355b4ca6cb	["*"]	2026-03-16 12:27:30	\N	2026-03-16 12:27:11	2026-03-16 12:27:30
122	App\\Models\\User	1	auth_token	ff8b6657fbde0d94b6410b22104f593aa349decac8ddbcb795d1ab491e2cbe30	["*"]	2026-03-16 11:23:27	\N	2026-03-16 11:18:53	2026-03-16 11:23:27
125	App\\Models\\User	1	auth_token	c636e299ea4db865e0e556529126d7ac671d028a3f283fa04ec8980c6fac0ad5	["*"]	2026-03-16 11:59:27	\N	2026-03-16 11:54:03	2026-03-16 11:59:27
117	App\\Models\\User	1	auth_token	8c134385818cf581831adf18ab1d160f5ee7cced23fe460c4db0a59bb0d4c376	["*"]	2026-03-16 10:35:45	\N	2026-03-16 10:32:38	2026-03-16 10:35:45
121	App\\Models\\User	1	auth_token	ef73002ef6b66a17d6b3aade7ef1a94ce0f03c6331a5203caf61013585cb1cf1	["*"]	2026-03-16 11:09:42	\N	2026-03-16 11:06:29	2026-03-16 11:09:42
135	App\\Models\\User	1	auth_token	524fb650718c48ef4f631e8bcfaf7b2df911c3e38c2f972e98571060bd8d8046	["*"]	2026-03-16 13:10:38	\N	2026-03-16 13:10:30	2026-03-16 13:10:38
123	App\\Models\\User	1	auth_token	b124e9e050d680645f2bfb37038dbd6c903c75e4c8bb0f40c60f49a669f1e7f9	["*"]	2026-03-16 11:31:30	\N	2026-03-16 11:30:20	2026-03-16 11:31:30
130	App\\Models\\User	1	auth_token	20187a345f1ed2fc26221b14aa1c29f8856e01153713cfc3b422a691016952cd	["*"]	2026-03-16 12:34:08	\N	2026-03-16 12:32:49	2026-03-16 12:34:08
134	App\\Models\\User	4	auth_token	e7b4f6a7a98993aa64a000239a9b5d1fa610ab2300d2b9c05db7c6938e08b9d1	["*"]	2026-03-16 13:09:20	\N	2026-03-16 13:09:14	2026-03-16 13:09:20
131	App\\Models\\User	4	auth_token	d732bd46da50f1d3306fa2a208f619ef04cc6cfc4b0889a1c3af368da2c8b5de	["*"]	2026-03-16 12:45:44	\N	2026-03-16 12:43:42	2026-03-16 12:45:44
133	App\\Models\\User	1	auth_token	d372171def9fd6fb50706404d4c81d9eed8aa3bffdf5602fdd81912bf4cd0828	["*"]	2026-03-16 13:04:36	\N	2026-03-16 13:04:26	2026-03-16 13:04:36
136	App\\Models\\User	1	auth_token	807777194c586b9017828d4f1697beda4a775d6c8af5b209d1d1165a6c660cd6	["*"]	2026-03-16 13:16:19	\N	2026-03-16 13:16:12	2026-03-16 13:16:19
137	App\\Models\\User	4	auth_token	641968c7be603f9f3b0126a3163f00049cf3fe3b0282088fe66f056eefa0e8fd	["*"]	2026-03-16 13:19:31	\N	2026-03-16 13:17:40	2026-03-16 13:19:31
138	App\\Models\\User	4	auth_token	1ad5597aa1095ab8478b702e36f1c488ad31dcd7ffde6f59e0c997d9d73deaa3	["*"]	2026-03-16 13:29:42	\N	2026-03-16 13:29:36	2026-03-16 13:29:42
139	App\\Models\\User	1	auth_token	0d6e5c1b36f856fadd1db5a1709e9da9a58e3f0c389bc41734e671a2bffd14a3	["*"]	2026-03-16 13:32:27	\N	2026-03-16 13:31:09	2026-03-16 13:32:27
142	App\\Models\\User	1	auth_token	faa113dbfda61bb94d1717627fc8bd44b38c36134524b163c7e2eeef1b91a9f2	["*"]	2026-03-16 13:51:43	\N	2026-03-16 13:51:35	2026-03-16 13:51:43
140	App\\Models\\User	4	auth_token	4225e93f16329d765f62b29d02fb16fefc0dd740be8713e70f1dd69a8b84a483	["*"]	2026-03-16 13:40:05	\N	2026-03-16 13:35:56	2026-03-16 13:40:05
141	App\\Models\\User	1	auth_token	8d74623c2604a4625b267fbc7296c74042fa72f7bf4acdde84d155162563d4a0	["*"]	2026-03-16 13:42:06	\N	2026-03-16 13:36:27	2026-03-16 13:42:06
553	App\\Models\\User	1	auth_token	6364db1b3b5b5785e67d91dfa6520a06d2486bb07a59a8bfb752ed5f2c0c789d	["*"]	2026-04-23 10:55:09	\N	2026-04-23 10:54:42	2026-04-23 10:55:09
143	App\\Models\\User	1	auth_token	d3d986ae33d7af5db15b2e491e959d7944e42084b5516b8ee899e6c92fb59691	["*"]	2026-03-16 13:56:44	\N	2026-03-16 13:56:07	2026-03-16 13:56:44
144	App\\Models\\User	1	auth_token	224dae1aa2b661f5074cbfd389e466b496819bf6cc11c7d16475eeea74d7032e	["*"]	2026-03-16 14:02:42	\N	2026-03-16 14:02:38	2026-03-16 14:02:42
168	App\\Models\\User	6	auth_token	43c3101c09af13c9d0b7b75dd464486756f9a622a2519ad79f084ef23ab1d534	["*"]	2026-03-17 13:42:51	\N	2026-03-17 13:42:50	2026-03-17 13:42:51
163	App\\Models\\User	6	auth_token	4e5da632af31b5e508d44e30bf3cf1faafeab69dbbe93ae567bdba142bfd4f8d	["*"]	2026-03-17 12:09:06	\N	2026-03-17 12:09:05	2026-03-17 12:09:06
579	App\\Models\\User	1	auth_token	04f423b047b9d0cb82673e9d9dcb15041bc197a1b3d8f94db0a7c9c857623a93	["*"]	2026-04-23 16:16:26	\N	2026-04-23 16:16:25	2026-04-23 16:16:26
145	App\\Models\\User	1	auth_token	bf044fe3bc7769cfb2abde2548e81b2d3e8eeca7f34b05649fc23ff00eeb47b2	["*"]	2026-03-16 14:11:16	\N	2026-03-16 14:08:06	2026-03-16 14:11:16
146	App\\Models\\User	1	auth_token	2a4d745add36bb162dabad97534c7a8077155d1c830f77af4bf649280e2472b0	["*"]	2026-03-16 14:15:08	\N	2026-03-16 14:15:04	2026-03-16 14:15:08
178	App\\Models\\User	8	auth_token	72344bcc09a2fa11d39b280d168ea10a71df92493dad6b461e40470861fa2d82	["*"]	2026-03-23 11:09:37	\N	2026-03-23 11:09:34	2026-03-23 11:09:37
147	App\\Models\\User	1	auth_token	e724ce0583355d414e2451b54970c038df3a8e4b92e928fa1a9e551f6e3a4107	["*"]	2026-03-16 14:25:43	\N	2026-03-16 14:25:40	2026-03-16 14:25:43
154	App\\Models\\User	6	auth_token	02f47f09124e37ad09d7d52f8bf477ed3da6f586931d843509d4e70a87fd0a53	["*"]	2026-03-17 10:43:57	\N	2026-03-17 10:43:56	2026-03-17 10:43:57
156	App\\Models\\User	5	auth_token	ae461fa18bd1e1013c73a149afdb01afbb1f2d478751e98250cd538f839076f6	["*"]	2026-03-17 11:08:19	\N	2026-03-17 11:08:18	2026-03-17 11:08:19
157	App\\Models\\User	6	auth_token	b2fb6be9065a8944ed4b11cba33b3c30a0e4ba8d7510a77c1a78182a3693615b	["*"]	2026-03-17 11:31:00	\N	2026-03-17 11:30:56	2026-03-17 11:31:00
158	App\\Models\\User	6	auth_token	29874cb31d58f962168f4ae5159be6d683136d8426f1ed305d4a6cd4dbb00368	["*"]	2026-03-17 11:42:23	\N	2026-03-17 11:42:21	2026-03-17 11:42:23
148	App\\Models\\User	1	auth_token	1def75d77f7e1507b0fe7d5021e6f9841a371bcfbb87e05517eb394dd293ab41	["*"]	2026-03-16 14:44:22	\N	2026-03-16 14:32:45	2026-03-16 14:44:22
183	App\\Models\\User	8	auth_token	e9a054a072e2621ce46c878440628a1a9eada5a9ad5a13921c86b6ef436608f5	["*"]	2026-03-23 11:52:03	\N	2026-03-23 11:52:02	2026-03-23 11:52:03
149	App\\Models\\User	1	auth_token	ff6c8acaea4084911dd0303200ab53d739382af0d741ba827529a3b28b7dc88c	["*"]	2026-03-16 15:18:00	\N	2026-03-16 15:17:53	2026-03-16 15:18:00
150	App\\Models\\User	5	auth_token	125cd05c9d0ee36c40f1fab56791f9601ab0fb15a102ca37c119a20ecf60b2eb	["*"]	2026-03-17 10:11:04	\N	2026-03-17 10:11:03	2026-03-17 10:11:04
179	App\\Models\\User	1	auth_token	5e926d25e97ca38b7320c99faf1743c3a8b2777fc485d18bfd936d61c5f6abae	["*"]	2026-03-23 11:21:29	\N	2026-03-23 11:21:26	2026-03-23 11:21:29
165	App\\Models\\User	1	auth_token	3d88bea977a1bde6c809bbb296c60de017e3f2628b1cad0f8e5142576ccaa74a	["*"]	2026-03-17 13:05:48	\N	2026-03-17 12:44:39	2026-03-17 13:05:48
160	App\\Models\\User	5	auth_token	19cd92345b25cd973d43ab32f8c202b0adb3098c8464d5495b85855b7052fd13	["*"]	2026-03-17 11:57:26	\N	2026-03-17 11:57:21	2026-03-17 11:57:26
171	App\\Models\\User	1	auth_token	c9aa046b0c3f569a181de1566e13082ac59e98066c1f651d7ef22d55a97ab531	["*"]	2026-03-17 14:53:28	\N	2026-03-17 14:53:24	2026-03-17 14:53:28
164	App\\Models\\User	4	auth_token	32278032c9117218e3478f993e8d40e5eb8480ad3656e7dbdaaf56b85018abd0	["*"]	2026-03-17 12:47:20	\N	2026-03-17 12:41:44	2026-03-17 12:47:20
176	App\\Models\\User	1	auth_token	26ef04221baaaacfd2a4307c54018ea2463587beb20eea7861ef03c56ab0fa84	["*"]	2026-03-23 10:56:11	\N	2026-03-23 10:53:50	2026-03-23 10:56:11
172	App\\Models\\User	1	auth_token	b055c0360eecc57f353242e009643350c3d859d483754e8c5b11c1203afe6156	["*"]	2026-03-17 15:01:30	\N	2026-03-17 15:01:26	2026-03-17 15:01:30
166	App\\Models\\User	4	auth_token	598e9a04b5be3371c773f47d291ce75fc177e42df84dc5df7edd2fae5cf744d2	["*"]	2026-03-17 13:33:16	\N	2026-03-17 13:26:18	2026-03-17 13:33:16
180	App\\Models\\User	1	auth_token	19253eec38c12633ef3c6f1c6f757d71385d65a77ac2ce59cb8d703e623d188a	["*"]	2026-03-23 11:26:59	\N	2026-03-23 11:26:56	2026-03-23 11:26:59
173	App\\Models\\User	7	auth_token	b975e6d1f8ac56ccc4daa06144053c229e98355e9d87a92ad7b1df988a00dd2e	["*"]	2026-03-17 15:05:13	\N	2026-03-17 15:03:07	2026-03-17 15:05:13
167	App\\Models\\User	1	auth_token	fcba98f6400b679a06da679b36971ce2e0bae416646cf90e97e0d56ab6a049c8	["*"]	2026-03-17 13:41:08	\N	2026-03-17 13:38:21	2026-03-17 13:41:08
184	App\\Models\\User	8	auth_token	4a3f262b6b2e060ba1fa7e966d9576f21e37dc7acaf414ca067fa2de48e96ee9	["*"]	2026-03-23 12:08:48	\N	2026-03-23 12:08:45	2026-03-23 12:08:48
181	App\\Models\\User	1	auth_token	4ab00e034b05949453116d6d5e4b507ee468b40e37e6e6614e5250ae6486da44	["*"]	2026-03-23 11:36:53	\N	2026-03-23 11:35:01	2026-03-23 11:36:53
177	App\\Models\\User	1	auth_token	6bb95b2920114f4b949b320d440a2feaa65ca6641a41572ef8fb2cf10e3818f0	["*"]	2026-03-23 11:09:00	\N	2026-03-23 11:08:14	2026-03-23 11:09:00
187	App\\Models\\User	8	auth_token	43ea90cd8a1e57f09c175f12b2aed74c65df722557482e83de752651fe27cf3e	["*"]	2026-03-23 12:28:30	\N	2026-03-23 12:25:26	2026-03-23 12:28:30
185	App\\Models\\User	1	auth_token	8bc8289f44fdfb7f41be8dc738639b04372442fbafd7297a89eee1a0bbd14f8c	["*"]	2026-03-23 12:15:52	\N	2026-03-23 12:15:40	2026-03-23 12:15:52
186	App\\Models\\User	8	auth_token	1f31375b487f9cfdf1ead96d81221c52c22e9b04eec467996fe13e199ba79ee6	["*"]	2026-03-23 12:16:41	\N	2026-03-23 12:16:39	2026-03-23 12:16:41
182	App\\Models\\User	1	auth_token	4d7e5af177455c250874133780be4d430bd0886877a9c008adc5754ada8fc53a	["*"]	2026-03-23 11:50:59	\N	2026-03-23 11:50:19	2026-03-23 11:50:59
188	App\\Models\\User	8	auth_token	fdd2968042d3d34da63d6b8f5a206b93f84cc8725a539f74e394c485fb8665ba	["*"]	2026-03-23 12:50:50	\N	2026-03-23 12:36:44	2026-03-23 12:50:50
192	App\\Models\\User	1	auth_token	93c8a32d14196f82b7340c356427fca0562d2ba5ffb37a03bbbefb04ef8b5aa5	["*"]	2026-03-23 15:32:34	\N	2026-03-23 14:00:17	2026-03-23 15:32:34
191	App\\Models\\User	8	auth_token	51ca809a60086de4ed08170df09257cf5bdade56f34aa289dbce125f03c69a17	["*"]	2026-03-23 13:48:21	\N	2026-03-23 13:18:26	2026-03-23 13:48:21
189	App\\Models\\User	8	auth_token	5575b2eb80fd2503be065e5f9ea3b952138d5fa069b43ca1eb25729bd78947b4	["*"]	2026-03-23 13:03:21	\N	2026-03-23 13:01:59	2026-03-23 13:03:21
194	App\\Models\\User	4	auth_token	05205a17af0fb0c3dd2c701d41a46c17b75f298130b35e00277a72f0d9b928d6	["*"]	2026-03-23 15:41:48	\N	2026-03-23 15:41:10	2026-03-23 15:41:48
193	App\\Models\\User	4	auth_token	86d23f31192809e528f40ce36ae136c7d167347d52854ad76be1f9d47b99da4b	["*"]	2026-03-23 15:33:17	\N	2026-03-23 15:33:15	2026-03-23 15:33:17
196	App\\Models\\User	1	auth_token	0b3fdf7cbe3d7357466e49beea019fa736e75412a692a2924452f682faa701a2	["*"]	2026-03-23 16:53:24	\N	2026-03-23 16:45:41	2026-03-23 16:53:24
197	App\\Models\\User	8	auth_token	72548bf98e99173c6ec850a07e5bdf5f6d94756d7e29e3e47010798e893d005a	["*"]	2026-03-24 09:49:19	\N	2026-03-24 09:48:53	2026-03-24 09:49:19
198	App\\Models\\User	8	auth_token	84a51a6f4402dd8fc13813a4a8f0108e4eaf691a6305af7426969e9c9f709165	["*"]	2026-03-24 10:19:14	\N	2026-03-24 10:17:57	2026-03-24 10:19:14
220	App\\Models\\User	1	auth_token	02fedd3ddf6fd9b8ade14f6fa95216cc25e47ebf6e31266b4d9103e79c16fae2	["*"]	2026-03-26 11:54:41	\N	2026-03-26 11:51:46	2026-03-26 11:54:41
199	App\\Models\\User	8	auth_token	a72827df77d81d78a7bece427d006ea1511cd5aa49ef11ce375ae5a8453d7f00	["*"]	2026-03-24 10:29:51	\N	2026-03-24 10:29:25	2026-03-24 10:29:51
225	App\\Models\\User	1	auth_token	82d386319815b73ccf1e334bee152948f3541a616fe499ec9979d2dcc4a4bb33	["*"]	2026-03-26 13:31:06	\N	2026-03-26 13:26:56	2026-03-26 13:31:06
200	App\\Models\\User	8	auth_token	363e9697b2176274f3b9ca7f5bbebb117a7a0729cfac6b60a611d2dc14bb1d6e	["*"]	2026-03-24 10:48:53	\N	2026-03-24 10:48:15	2026-03-24 10:48:53
221	App\\Models\\User	1	auth_token	9613b2d7a35a4d7b2a5d044436c78470668f2fd8959727ca964c22fb30573475	["*"]	2026-03-26 12:02:27	\N	2026-03-26 12:02:23	2026-03-26 12:02:27
207	App\\Models\\User	1	auth_token	f6242e28c3e10dbf53301741d003e05a71aea3666ede84b21833feb255030cc5	["*"]	2026-03-26 10:43:35	\N	2026-03-26 10:42:59	2026-03-26 10:43:35
241	App\\Models\\User	1	auth_token	9d8953d82bdbe6cf01ee4b01aa11b156a9c74879c0055b1239b36f87a2598b47	["*"]	2026-03-26 16:54:12	\N	2026-03-26 16:54:09	2026-03-26 16:54:12
214	App\\Models\\User	1	auth_token	186cc1b1e6e746868709137cd4a98daaa34e3ff7626feac797f25d5675852f9a	["*"]	2026-03-26 11:33:13	\N	2026-03-26 11:30:14	2026-03-26 11:33:13
226	App\\Models\\User	1	auth_token	4cdc87f840161d6a060362a81eae12bb0e69143e9dc63b8b8db2c5878216e32b	["*"]	2026-03-26 13:54:27	\N	2026-03-26 13:54:21	2026-03-26 13:54:27
215	App\\Models\\User	1	auth_token	736a084b020c0ef0a4774dc1cf55e19810af4c8fb9d912190f239b638eba6800	["*"]	2026-03-26 11:38:23	\N	2026-03-26 11:38:19	2026-03-26 11:38:23
201	App\\Models\\User	8	auth_token	99ef74db4de944db83188096cfa58d28f4d1473a5cb0c22a86f7f63173923dbe	["*"]	2026-03-24 11:04:20	\N	2026-03-24 11:01:16	2026-03-24 11:04:20
209	App\\Models\\User	1	auth_token	8b7f92e1cac84f7ae6d00be326b453ae3803d5ad1fff142c2048c6a33dfbb544	["*"]	2026-03-26 10:51:29	\N	2026-03-26 10:49:02	2026-03-26 10:51:29
202	App\\Models\\User	8	auth_token	62fcf56f4c093f254523a641cf2b91397ebe13dbf2a7575120e592acb5b9d340	["*"]	2026-03-24 11:08:54	\N	2026-03-24 11:08:15	2026-03-24 11:08:54
222	App\\Models\\User	1	auth_token	3ec679c784185f717d6b1ae3a4e407cd480975ba67224d7b41c5d4b1048adb78	["*"]	2026-03-26 12:25:27	\N	2026-03-26 12:25:22	2026-03-26 12:25:27
210	App\\Models\\User	1	auth_token	8208b529b9c12696a10e8f0fa25f78c458007c9b1d401c9047cf58218394d6ed	["*"]	2026-03-26 10:57:21	\N	2026-03-26 10:57:16	2026-03-26 10:57:21
216	App\\Models\\User	1	auth_token	7df76957a2b9d8442c2c2a81a67d4e072aa8d39aeb22f473d821e4420ce99092	["*"]	2026-03-26 11:44:18	\N	2026-03-26 11:44:13	2026-03-26 11:44:18
211	App\\Models\\User	1	auth_token	d333489b66c855f7972b582fa03eda02a2ac2645edfcd2a792688d0eeef46244	["*"]	2026-03-26 11:11:05	\N	2026-03-26 11:11:01	2026-03-26 11:11:05
203	App\\Models\\User	8	auth_token	fd7de4e1c9ccd43f17fd3402394ea3bf770ce16d4d43b88b96bcd5f7fce053bc	["*"]	2026-03-24 11:23:47	\N	2026-03-24 11:22:09	2026-03-24 11:23:47
204	App\\Models\\User	8	auth_token	c23aa00c0c798fa0ca94ea4d0003dc87f40f5a2f4698bc7b5b52124501dbd862	["*"]	\N	\N	2026-03-26 10:26:43	2026-03-26 10:26:43
205	App\\Models\\User	8	auth_token	275597e5a4b7b5dea5cd39bf6615de5a8723c4241583fdba89d1cce8d3c4e1a5	["*"]	2026-03-26 10:27:01	\N	2026-03-26 10:26:58	2026-03-26 10:27:01
212	App\\Models\\User	1	auth_token	359d98ac9f6090d7b00a9fd8d88a37722d38f1741344bd180d65ca08809b276f	["*"]	2026-03-26 11:25:33	\N	2026-03-26 11:23:50	2026-03-26 11:25:33
229	App\\Models\\User	1	auth_token	bd324734729285087bfd9344008c9e13c26fd5700329b14d8e859ef3780d1fe9	["*"]	2026-03-26 15:22:51	\N	2026-03-26 15:11:09	2026-03-26 15:22:51
227	App\\Models\\User	1	auth_token	b51e7f9cfeaa65f152deb3335a5f31a6e6d8fb5de839739fd27693495ae7dcfe	["*"]	2026-03-26 14:09:05	\N	2026-03-26 14:06:04	2026-03-26 14:09:05
219	App\\Models\\User	1	auth_token	94105e1bb5104a4cfa17d909f4f04ab0ccdea11642eba0f054a8f608e2b7f15c	["*"]	2026-03-26 11:49:17	\N	2026-03-26 11:49:14	2026-03-26 11:49:17
223	App\\Models\\User	1	auth_token	2cc00407f3b671c522d7facd8b2570c6b8f8091f9e6469784ad5b739cebd3642	["*"]	2026-03-26 12:34:22	\N	2026-03-26 12:31:57	2026-03-26 12:34:22
233	App\\Models\\User	1	auth_token	44e1f8cff2891316725c3f3b1949336aae1bd6f2d13fdf61a96a7bf704ea2d55	["*"]	2026-03-26 16:11:59	\N	2026-03-26 16:11:41	2026-03-26 16:11:59
228	App\\Models\\User	1	auth_token	34f157dddff4ae1e3cb1c106ae04c079704160c490d7e3d1dc767970eead0eb5	["*"]	2026-03-26 15:01:16	\N	2026-03-26 15:01:12	2026-03-26 15:01:16
224	App\\Models\\User	1	auth_token	855f4734e1f8c3811f2c4584f96f53ebd755b81dcb4152ed7e7b0b43ede94495	["*"]	2026-03-26 12:47:27	\N	2026-03-26 12:45:06	2026-03-26 12:47:27
230	App\\Models\\User	1	auth_token	446c2370ca9f58d2ebe2b9f8029e8290cd429050ebd685d4606fe163def4adf2	["*"]	2026-03-26 15:52:29	\N	2026-03-26 15:52:13	2026-03-26 15:52:29
234	App\\Models\\User	1	auth_token	5c9300bc05e310f8ff62076afe0895eed5b137fd8f2c4d700429a8cb1596eb97	["*"]	2026-03-26 16:13:50	\N	2026-03-26 16:13:48	2026-03-26 16:13:50
231	App\\Models\\User	1	auth_token	2a12dc4bb833eadc509ce2385cc370f3b9ff0a9564def65348485cd07bd2f154	["*"]	2026-03-26 16:00:04	\N	2026-03-26 15:59:03	2026-03-26 16:00:04
242	App\\Models\\User	1	auth_token	8c35a92c18e9ec8f70d3f1eaabd4f9c206e1c2ff65517f530d5b22bc4bb0d5ad	["*"]	2026-03-26 16:59:28	\N	2026-03-26 16:58:43	2026-03-26 16:59:28
232	App\\Models\\User	1	auth_token	ded501c0d6cfcc0642daa9ba314eb00d94f0f3ad919f8d74a724c857fb96ce0c	["*"]	2026-03-26 16:07:37	\N	2026-03-26 16:07:34	2026-03-26 16:07:37
235	App\\Models\\User	1	auth_token	5bcd60a5ee62a501fc360b075e409dcca8fb75f728a673ee73ada8694e8082c8	["*"]	2026-03-26 16:19:51	\N	2026-03-26 16:19:48	2026-03-26 16:19:51
240	App\\Models\\User	1	auth_token	efaafe18e1d4f9104bc5d4ddc58b387167d23bf3ef07b823eaee3ab6a040a532	["*"]	2026-03-26 16:45:58	\N	2026-03-26 16:45:01	2026-03-26 16:45:58
238	App\\Models\\User	1	auth_token	05797a65bdf6cc891f741bf03cac9867a83b1f5fc0209a785e9c6338c61cfe41	["*"]	2026-03-26 16:22:30	\N	2026-03-26 16:22:17	2026-03-26 16:22:30
239	App\\Models\\User	1	auth_token	429b85b146176a4151fb8f1e148d3aaa26d95d5b2ef7066b0936ec6e41d38a7f	["*"]	2026-03-26 16:35:28	\N	2026-03-26 16:34:20	2026-03-26 16:35:28
245	App\\Models\\User	1	auth_token	29b2d4a77bf4d96fffd26357ecb6a595edb4af79f644a912601a8dfeb9076dfc	["*"]	2026-03-26 17:04:05	\N	2026-03-26 17:02:19	2026-03-26 17:04:05
247	App\\Models\\User	1	auth_token	88bec909d12df0d993c97360fe81ef6da6359db4bfa79a33bdffff9217e48ebd	["*"]	2026-03-27 09:48:14	\N	2026-03-27 09:40:16	2026-03-27 09:48:14
246	App\\Models\\User	1	auth_token	697ce213e958a8c0e752de1dda7f4ca34e57a773920ab79ef350046b07d4103c	["*"]	2026-03-27 09:30:32	\N	2026-03-27 09:30:22	2026-03-27 09:30:32
248	App\\Models\\User	1	auth_token	6ddbcd066da82bc4b06af089df4b8f1b345c822edf929f3c26174c7a54d97f9d	["*"]	2026-03-27 09:58:31	\N	2026-03-27 09:58:09	2026-03-27 09:58:31
252	App\\Models\\User	1	auth_token	432a10b3b9688faeb6f06bbae2ccca1fd914756ad973f9d9e7ad2deb0dfbdb5d	["*"]	2026-03-27 10:09:06	\N	2026-03-27 10:09:04	2026-03-27 10:09:06
251	App\\Models\\User	5	auth_token	22097f79509b0711edc2347b9f9ee1e2511aae16572da5f4d41664a46936498f	["*"]	2026-03-27 10:01:01	\N	2026-03-27 10:00:59	2026-03-27 10:01:01
253	App\\Models\\User	5	auth_token	1cf0ca3aafc70ff1345905a354b9c1fc19f86dd46b118cee120aafbeceec5951	["*"]	2026-03-27 10:09:46	\N	2026-03-27 10:09:44	2026-03-27 10:09:46
266	App\\Models\\User	1	auth_token	0d2dad1eae35430d831824a5cd74a53b61f64465c147d5aaa8b738e05307a7ae	["*"]	2026-03-27 14:33:41	\N	2026-03-27 14:33:31	2026-03-27 14:33:41
255	App\\Models\\User	5	auth_token	28608518e2e12510b62ab98e53cb734da2cb4c6f03b28d9629123cdcad76d71a	["*"]	2026-03-27 10:55:54	\N	2026-03-27 10:55:52	2026-03-27 10:55:54
256	App\\Models\\User	5	auth_token	a13f9e7dd5c6bfd999a39129741aa3b94f57472fe729199f8dc1e4de4e7e428e	["*"]	2026-03-27 11:08:04	\N	2026-03-27 11:08:02	2026-03-27 11:08:04
257	App\\Models\\User	5	auth_token	972e4b6ddbf4b70eea0113554f219760c603d01798bc2dad2caddabe38e32546	["*"]	2026-03-27 11:35:24	\N	2026-03-27 11:35:22	2026-03-27 11:35:24
258	App\\Models\\User	5	auth_token	fafd91bd4f5f2fd304244698b671798df60e58ebec141103a851a009ff558963	["*"]	2026-03-27 12:02:38	\N	2026-03-27 12:02:35	2026-03-27 12:02:38
259	App\\Models\\User	5	auth_token	2066f451d2f8348a4035581d32a9c9c5ce4e8630ca4e959184eb6eda73d2704e	["*"]	2026-03-27 12:16:53	\N	2026-03-27 12:16:50	2026-03-27 12:16:53
260	App\\Models\\User	5	auth_token	22f945db8eef59b5d1a2c25a891c4237f2bb712c2540ff656bacbf6edebd745d	["*"]	2026-03-27 12:24:52	\N	2026-03-27 12:24:35	2026-03-27 12:24:52
261	App\\Models\\User	5	auth_token	d1085392e4bc6b49569af8796deab962065a5c3fc8cbc2f140845d8b08d8c532	["*"]	2026-03-27 12:33:03	\N	2026-03-27 12:33:01	2026-03-27 12:33:03
280	App\\Models\\User	1	auth_token	ce720baa1409a592d92e327fcdca2d527f607d91141578cb2a1bce23b7c370cb	["*"]	2026-03-31 18:54:47	\N	2026-03-31 18:52:02	2026-03-31 18:54:47
262	App\\Models\\User	5	auth_token	7d6c3b81b902b8096c0c8d241b2feb00be1642104d440c4a53e7aecde970646d	["*"]	2026-03-27 12:39:58	\N	2026-03-27 12:39:56	2026-03-27 12:39:58
282	App\\Models\\User	1	auth_token	1c12e5b12ab6fabb1e69da4e2d6c9f6148b3e1e0dc45cf45598ee769f6c3128a	["*"]	2026-03-31 20:41:58	\N	2026-03-31 20:31:40	2026-03-31 20:41:58
267	App\\Models\\User	1	auth_token	8722224c478cf182efb61d17c9f340d39430dd31e5e69c9a9137bf92dc739e66	["*"]	2026-03-27 14:49:35	\N	2026-03-27 14:48:13	2026-03-27 14:49:35
273	App\\Models\\User	1	auth_token	84c7cca547ce1859651b1165c43d76ec9bc50e7e400ab5c40c16bce066a9bc7f	["*"]	2026-03-27 16:38:39	\N	2026-03-27 16:38:30	2026-03-27 16:38:39
269	App\\Models\\User	1	auth_token	f0f628b19aeaccca36935015078452b8e18590b54df9538ddd83baf26334a3ec	["*"]	2026-03-27 15:34:25	\N	2026-03-27 14:56:06	2026-03-27 15:34:25
278	App\\Models\\User	1	auth_token	8f88eb76aa433a83dbb5d9ae9bbba5dc9a0b4c1529e227054f96ab50c57e47d5	["*"]	2026-03-28 09:24:12	\N	2026-03-28 09:23:58	2026-03-28 09:24:12
264	App\\Models\\User	1	auth_token	7a6a548efea37cfcb9bf65b974873b2ed6d5d3a7f46b65df2c8b8ad2e6acf26b	["*"]	2026-03-27 12:53:36	\N	2026-03-27 12:48:12	2026-03-27 12:53:36
265	App\\Models\\User	1	auth_token	f6025aa3454218bd204c58c5bb8b1716ba4712e4faedba274d698a6450cf3887	["*"]	2026-03-27 13:00:56	\N	2026-03-27 13:00:54	2026-03-27 13:00:56
270	App\\Models\\User	1	auth_token	e49f49e643a6c3fe1e99e5a5a6fb12ef168a0aff43119021c41f52b5c80fa034	["*"]	2026-03-27 15:11:12	\N	2026-03-27 15:10:33	2026-03-27 15:11:12
272	App\\Models\\User	1	auth_token	d73b80c8bce41b38bff0c301578474ba4af7713e8306bbc2819405427e0bf3f2	["*"]	2026-03-27 16:41:10	\N	2026-03-27 16:26:58	2026-03-27 16:41:10
274	App\\Models\\User	1	auth_token	19421ededd2a41e145895df0da669e986d17cf8045a7af5bcd288d4a65c9f864	["*"]	2026-03-27 16:45:21	\N	2026-03-27 16:45:14	2026-03-27 16:45:21
271	App\\Models\\User	1	auth_token	0dc32d5f4c85be63d1c0af7187683a2fddaff9851e12a50bb22ede95433ad805	["*"]	2026-03-27 15:43:04	\N	2026-03-27 15:38:46	2026-03-27 15:43:04
287	App\\Models\\User	1	auth_token	a104cf98aa11acf851709a2143d454c7b9960b14a984655c1a6c3306ee7bea29	["*"]	2026-04-07 00:37:54	\N	2026-04-07 00:37:39	2026-04-07 00:37:54
275	App\\Models\\User	1	auth_token	f6ac95dbabc1f9299a0782a79012ae6e55b7f48be4c5270cc8d32896229b4b83	["*"]	2026-03-27 16:54:43	\N	2026-03-27 16:51:32	2026-03-27 16:54:43
279	App\\Models\\User	1	auth_token	16df7102b9b872c7338e6cc017eb5348062ab3ba70fcd119632822cba43fad9f	["*"]	2026-03-28 09:44:34	\N	2026-03-28 09:40:08	2026-03-28 09:44:34
276	App\\Models\\User	1	auth_token	d787fb603e34396d969379d5461bca5ee3359312e88d51350e4c828a51fa14dc	["*"]	2026-03-27 17:00:41	\N	2026-03-27 17:00:34	2026-03-27 17:00:41
294	App\\Models\\User	1	auth_token	7b7d0b1adcaebec48fbd369a9606885303ef63f910a848d22581a0bc3cd30d49	["*"]	2026-04-07 01:32:38	\N	2026-04-07 01:32:37	2026-04-07 01:32:38
285	App\\Models\\User	1	auth_token	b1409fc1ab0f777862cb0c43d830fa9c2352c2c96369c44c210de18a70a6ca9e	["*"]	2026-04-07 00:03:55	\N	2026-04-07 00:01:16	2026-04-07 00:03:55
277	App\\Models\\User	1	auth_token	49f7400e727dc3570eadcecba99b8721c3b91912a06c316cf5e21dec8842e439	["*"]	2026-03-28 09:08:22	\N	2026-03-28 09:08:18	2026-03-28 09:08:22
281	App\\Models\\User	1	auth_token	134c18bbaab74e3b87f317de33670b9bf5b459a18e31ed3db6ae4396c688293a	["*"]	2026-03-31 20:03:52	\N	2026-03-31 19:58:25	2026-03-31 20:03:52
283	App\\Models\\User	1	auth_token	3875446b78965644620529d17c861509ae0e92bc1e1316c5f503e30b99c34546	["*"]	2026-03-31 23:23:33	\N	2026-03-31 23:20:28	2026-03-31 23:23:33
284	App\\Models\\User	5	auth_token	a4db2ba6aa0fb483d3820d3257694b3e3a3bd5e1ab27584dd8c2516f9986b1d9	["*"]	2026-03-31 23:24:02	\N	2026-03-31 23:24:00	2026-03-31 23:24:02
288	App\\Models\\User	1	auth_token	7edfa50696c7c35fc6dd206b4405e90293a9c55637cdd102d09293471224d560	["*"]	2026-04-07 00:46:37	\N	2026-04-07 00:45:55	2026-04-07 00:46:37
291	App\\Models\\User	1	auth_token	c47f7441030a5f8e131ed1db4c717478acaea46eebe8d47788861e5154002993	["*"]	2026-04-07 01:26:40	\N	2026-04-07 01:25:44	2026-04-07 01:26:40
286	App\\Models\\User	1	auth_token	57e46473472be441ae94c16b0eb726612c37443673a54ad0fb2f05275f3c4e34	["*"]	2026-04-07 00:23:52	\N	2026-04-07 00:23:30	2026-04-07 00:23:52
289	App\\Models\\User	1	auth_token	53c434ea87eb4c4192bd32d859d13a8d6e1ac717aa4ffac49f174396c3b42214	["*"]	2026-04-07 01:07:57	\N	2026-04-07 01:06:58	2026-04-07 01:07:57
290	App\\Models\\User	1	auth_token	2f217a5d8965fae5308e5d0ca6a107d8564db405c9e53fc1cfd664d1ef9b7bdc	["*"]	2026-04-07 01:21:11	\N	2026-04-07 01:18:21	2026-04-07 01:21:11
295	App\\Models\\User	1	auth_token	1e79486c775885b9cd68addc95c6082b8a5c37c23e5c986a616b7b9dad1b19f3	["*"]	2026-04-07 02:02:21	\N	2026-04-07 02:01:39	2026-04-07 02:02:21
296	App\\Models\\User	1	auth_token	f369b02812b2378e4c41866e957349c22a55a934e73b3a2918f0d2941651f94b	["*"]	2026-04-09 10:45:38	\N	2026-04-09 10:44:57	2026-04-09 10:45:38
298	App\\Models\\User	1	auth_token	240943709136d1347f07b3b7e3be3fcc5949d4e2a34723b77f728883a519ac40	["*"]	2026-04-09 10:54:20	\N	2026-04-09 10:50:48	2026-04-09 10:54:20
300	App\\Models\\User	1	auth_token	0347b9f345a80ff60a70e93882bdb62dbe1e903d72364fe95aaa4503f8700235	["*"]	2026-04-09 11:15:06	\N	2026-04-09 10:59:37	2026-04-09 11:15:06
301	App\\Models\\User	1	auth_token	7c7e4026d2bed801152054bf32288b91c70523d9b378475e7a252657c0424266	["*"]	2026-04-13 09:38:06	\N	2026-04-13 09:38:00	2026-04-13 09:38:06
302	App\\Models\\User	1	auth_token	833993147f80771dddfe109eb8ea6427fbcf957e89cb8ac6aa2a3753b0377e8b	["*"]	2026-04-13 10:02:32	\N	2026-04-13 09:56:40	2026-04-13 10:02:32
308	App\\Models\\User	1	auth_token	f01f362b926f37af76cf3fdd4f553f05def8a8f46e95c25aba335de5d8b7e57c	["*"]	2026-04-13 10:37:27	\N	2026-04-13 10:36:48	2026-04-13 10:37:27
303	App\\Models\\User	1	auth_token	6aa28f61147a8f9fd690254786a5d56aaca28c1811a58ccc376f0936576eb7d7	["*"]	2026-04-13 10:06:34	\N	2026-04-13 10:06:28	2026-04-13 10:06:34
349	App\\Models\\User	8	auth_token	60fb8f3bd673181418325b226b3baf9da2e1ea00f7b5cae2541451c1a75e53f9	["*"]	2026-04-13 16:32:30	\N	2026-04-13 16:32:28	2026-04-13 16:32:30
318	App\\Models\\User	8	auth_token	d4da7a2e410979d609f9a8e9f9d4e0638accd76bd6e62dbb417f2c210268fb9b	["*"]	2026-04-13 11:29:45	\N	2026-04-13 11:29:18	2026-04-13 11:29:45
304	App\\Models\\User	1	auth_token	653fc089d3c42c0285ca9fc363037b6b86e673d43eb41eea2492de275d65ba13	["*"]	2026-04-13 10:12:34	\N	2026-04-13 10:10:58	2026-04-13 10:12:34
319	App\\Models\\User	8	auth_token	c9969e17f3b849a0334b3a1c41f124dda9c5100768c7c2fc82d8694000ba371a	["*"]	2026-04-13 11:45:46	\N	2026-04-13 11:45:45	2026-04-13 11:45:46
309	App\\Models\\User	1	auth_token	56150d1c032985b19fe1ec8c57c06f1bd9b3ed8c5392602deafe97ceb73483a0	["*"]	2026-04-13 11:01:36	\N	2026-04-13 11:00:59	2026-04-13 11:01:36
310	App\\Models\\User	5	auth_token	630fdbb0767f21902ffe10521aea0d9eb7ebef9f784e1999ee56ee52a2259f55	["*"]	2026-04-13 11:02:10	\N	2026-04-13 11:02:08	2026-04-13 11:02:10
305	App\\Models\\User	1	auth_token	6c90254ebb11f782606dec0e39bc8f6208995e7c5f559c2f0013a3298b2d286a	["*"]	2026-04-13 10:15:50	\N	2026-04-13 10:15:09	2026-04-13 10:15:50
311	App\\Models\\User	1	auth_token	3452976201f6f7736461a2291b2573411a364a7c0b5eb3d437790bd9e52573b3	["*"]	2026-04-13 11:09:48	\N	2026-04-13 11:09:46	2026-04-13 11:09:48
312	App\\Models\\User	5	auth_token	a19c33bb3758ee24d131a578cb79a1352b319a107d15797bdd608735b3a1b0ae	["*"]	2026-04-13 11:10:15	\N	2026-04-13 11:10:14	2026-04-13 11:10:15
324	App\\Models\\User	1	auth_token	b7bd31402f5676a6928e161c8095cb99a2dcd48dab3db9735597f28099d725e6	["*"]	2026-04-13 12:18:34	\N	2026-04-13 12:18:27	2026-04-13 12:18:34
320	App\\Models\\User	1	auth_token	cd9c9770d26a43d555a756d4ff411ca33301bbd20ba13962f5c3eed6ea5470a4	["*"]	2026-04-13 11:56:54	\N	2026-04-13 11:56:50	2026-04-13 11:56:54
306	App\\Models\\User	1	auth_token	bb21d828fdc4778c2009a36734be553a8e84ab7aa0534831a0fe99969f792de3	["*"]	2026-04-13 10:26:48	\N	2026-04-13 10:23:15	2026-04-13 10:26:48
313	App\\Models\\User	1	auth_token	19559959131578ceb24acab5e94fe028aaf833dda44f8a0172c7da6009f5c0f6	["*"]	2026-04-13 11:15:12	\N	2026-04-13 11:15:09	2026-04-13 11:15:12
307	App\\Models\\User	1	auth_token	c80e8b779d75daa0a8a6052c97b09eae1237eb462e1a9dff8ffed0828572dddd	["*"]	2026-04-13 10:30:05	\N	2026-04-13 10:29:38	2026-04-13 10:30:05
325	App\\Models\\User	8	auth_token	ed3f4e3e6c92a3dbbc597cea545d8e9528c8a2573bcb7a747ab73b08713a602b	["*"]	2026-04-13 12:19:02	\N	2026-04-13 12:19:00	2026-04-13 12:19:02
326	App\\Models\\User	8	auth_token	eb5d3d730b64f460468c1d9108860df71afbed5123bb634e2348260bbe1b63f5	["*"]	2026-04-13 12:27:58	\N	2026-04-13 12:27:56	2026-04-13 12:27:58
316	App\\Models\\User	8	auth_token	1c29b36aa9abb2adb72166c46fde985524fa0020de021cc458c33a2f2251eb51	["*"]	2026-04-13 11:20:47	\N	2026-04-13 11:17:24	2026-04-13 11:20:47
327	App\\Models\\User	8	auth_token	4746193cb76f2a47e8bb93fe5d20dd845369de37cfff61ccba38d65e5038a308	["*"]	2026-04-13 12:38:54	\N	2026-04-13 12:38:53	2026-04-13 12:38:54
317	App\\Models\\User	1	auth_token	2557984941b7a5aeece22fe0280655466e687ef24e2e3339e1175c6ca305aac7	["*"]	2026-04-13 11:28:20	\N	2026-04-13 11:28:17	2026-04-13 11:28:20
334	App\\Models\\User	1	auth_token	af5e60c288e0dcd17bb144763395e4ca2770f111be98bbc310ce023f10935251	["*"]	2026-04-13 13:25:23	\N	2026-04-13 13:25:06	2026-04-13 13:25:23
343	App\\Models\\User	1	auth_token	0336e39131aea1db1c03d0c7839be24fee3d46fdcc2b01c2b9c55a3bdeacd1a5	["*"]	2026-04-13 16:01:58	\N	2026-04-13 16:01:34	2026-04-13 16:01:58
331	App\\Models\\User	1	auth_token	fde3cfc958c6cd623538a187e66b6f367aa15fb3c115000602e58572eeb9287e	["*"]	2026-04-13 13:15:33	\N	2026-04-13 13:13:51	2026-04-13 13:15:33
323	App\\Models\\User	1	auth_token	89f643895650ddee0e67df89615524eedb9454b72908221749c3dc72ae33e4a5	["*"]	2026-04-13 12:03:44	\N	2026-04-13 12:03:04	2026-04-13 12:03:44
342	App\\Models\\User	1	auth_token	f8b9c3c970b2f267410861f0e082b17bd273dd2847c537b30dbaccdb9aca08e6	["*"]	2026-04-13 15:42:23	\N	2026-04-13 15:38:48	2026-04-13 15:42:23
329	App\\Models\\User	1	auth_token	f9ddbf40d45bf7e1fd03925addb0f495a0e86cf7030ec54314b1055f1babc5dc	["*"]	2026-04-13 12:51:33	\N	2026-04-13 12:49:43	2026-04-13 12:51:33
340	App\\Models\\User	5	auth_token	934fb35ff9bac78b70c700bfade79a65b06caea63ed0c1cdcf7b7273321147e0	["*"]	2026-04-13 15:18:20	\N	2026-04-13 15:15:19	2026-04-13 15:18:20
333	App\\Models\\User	5	auth_token	328aa5f35892e6e0e17b3f31488aa5f1de7b11ab8adc7269313cef8795838fdf	["*"]	2026-04-13 13:16:43	\N	2026-04-13 13:16:41	2026-04-13 13:16:43
330	App\\Models\\User	1	auth_token	afbfd40c8ee72a71e5f806efb0abb5b3c8beb8346295a75afe41768ed80bf1cb	["*"]	2026-04-13 13:06:10	\N	2026-04-13 13:06:05	2026-04-13 13:06:10
338	App\\Models\\User	1	auth_token	785f76021d9a9372b5d4cc89c55afd7633370cd46da9b20cb337f7953fa32079	["*"]	2026-04-13 13:47:48	\N	2026-04-13 13:45:44	2026-04-13 13:47:48
336	App\\Models\\User	6	auth_token	14d97f7f3e6bd6a267d249e1a4e717aa62af5d66cbbb652bd91d1089f9b8ac54	["*"]	2026-04-13 13:30:29	\N	2026-04-13 13:30:27	2026-04-13 13:30:29
337	App\\Models\\User	1	auth_token	9c558b3040bf6dd5e3e1a482762a86e2d0b44b26c5443c65ef8691d8d0126f66	["*"]	2026-04-13 13:42:06	\N	2026-04-13 13:35:40	2026-04-13 13:42:06
339	App\\Models\\User	1	auth_token	2c6fee70144d00fbcb59031d8cb8a6deca78c70cca8bec3a36d213d6c4f15a62	["*"]	2026-04-13 15:13:46	\N	2026-04-13 15:10:51	2026-04-13 15:13:46
347	App\\Models\\User	8	auth_token	3459a1eb4ccdc248130047e1fec628c9ed0844d314727ae6c89406df882fa9fd	["*"]	2026-04-13 16:12:12	\N	2026-04-13 16:11:37	2026-04-13 16:12:12
345	App\\Models\\User	8	auth_token	ae60a5c5fad4f7fee4a0ff0f1df05e7aab9cbb5526508b2e614c1c333573828f	["*"]	2026-04-13 16:04:10	\N	2026-04-13 16:03:51	2026-04-13 16:04:10
348	App\\Models\\User	8	auth_token	60b3995570f081588aed2fdd79b88f696abd10316012231494fbc784caae946d	["*"]	2026-04-13 16:18:22	\N	2026-04-13 16:17:45	2026-04-13 16:18:22
350	App\\Models\\User	8	auth_token	69bde42f54c2aedffccbb80c33846c72123fb19f4ad3d2ef2bfc8c3eb778a88f	["*"]	2026-04-13 16:38:21	\N	2026-04-13 16:36:46	2026-04-13 16:38:21
355	App\\Models\\User	1	auth_token	1fb69824530c1d2c4de231986ec0501c840fa94ed16e1ca5e86909700d60c30d	["*"]	2026-04-14 10:38:02	\N	2026-04-14 10:34:18	2026-04-14 10:38:02
351	App\\Models\\User	8	auth_token	a5725e73b782115ec89f4e9cc05e927827665edb390d0fa34bc1dff721da73b3	["*"]	2026-04-13 16:44:54	\N	2026-04-13 16:44:16	2026-04-13 16:44:54
352	App\\Models\\User	8	auth_token	0111584b4a5daf001a2c5f187385d2eded103f6cd852d77648b8003d5fa45079	["*"]	2026-04-13 16:49:34	\N	2026-04-13 16:49:15	2026-04-13 16:49:34
354	App\\Models\\User	1	auth_token	d84d2252aa904fd61d5d5a1d612bdafd7ee4df8a598bc68fb7e212612f27e34a	["*"]	2026-04-14 10:26:29	\N	2026-04-14 10:24:41	2026-04-14 10:26:29
356	App\\Models\\User	1	auth_token	74203710d1bad59d5b0a6446041c5b0a71e77222a1b78850c29bcd1f53a87f7b	["*"]	2026-04-14 10:38:33	\N	2026-04-14 10:38:31	2026-04-14 10:38:33
366	App\\Models\\User	5	auth_token	cd6bf4436c3e8c13ce272f413d68b2c0221f33b20aea4c4f224c9f4951271ce1	["*"]	2026-04-14 12:36:46	\N	2026-04-14 12:36:43	2026-04-14 12:36:46
357	App\\Models\\User	6	auth_token	5f2c7963cf67243dbce3b8bbe79ddd02f3a77eef2d11ce5a841f45ec2095cc6e	["*"]	2026-04-14 10:39:06	\N	2026-04-14 10:39:05	2026-04-14 10:39:06
390	App\\Models\\User	6	auth_token	0c18535fc8124334b2e14fa1b35e93a3136829ad879cad9a2b8088131087a012	["*"]	2026-04-17 10:11:31	\N	2026-04-17 10:09:44	2026-04-17 10:11:31
376	App\\Models\\User	1	auth_token	10ca0089b98c344fe36c140aa670ff5bb62df91dfdee48bff4a76a628ceb6903	["*"]	2026-04-14 16:03:33	\N	2026-04-14 16:01:10	2026-04-14 16:03:33
367	App\\Models\\User	5	auth_token	3b44433b6fdd83b58a0271b0251eebd04a30171efd6b634f67720ef1700ee444	["*"]	2026-04-14 13:33:52	\N	2026-04-14 13:33:48	2026-04-14 13:33:52
360	App\\Models\\User	1	auth_token	2b31d95126a7b8d9f607de53ea4afaff820f7607bd89c0864274ce3991cee609	["*"]	2026-04-14 11:21:47	\N	2026-04-14 11:20:41	2026-04-14 11:21:47
358	App\\Models\\User	1	auth_token	f155cecc3bae9c1299461f6c2453401fd5b8586b89f8c38f54c52ee5e2fe2df4	["*"]	2026-04-14 11:00:38	\N	2026-04-14 10:57:35	2026-04-14 11:00:38
402	App\\Models\\User	4	auth_token	2d2b673df00a3c431cf2a73a3a601df87a95fecb55c4628034f15d67efc1de75	["*"]	2026-04-17 11:16:19	\N	2026-04-17 11:16:17	2026-04-17 11:16:19
368	App\\Models\\User	5	auth_token	68bfa8edce42cac3f6ee2a8f1104e46b5808f831be6991e89b9226075dd20a32	["*"]	2026-04-14 13:52:42	\N	2026-04-14 13:51:55	2026-04-14 13:52:42
377	App\\Models\\User	7	auth_token	9ec478090730d17a83120b8a44005a92cb91605c99475daac5b6b47e661b000e	["*"]	2026-04-14 16:04:21	\N	2026-04-14 16:04:12	2026-04-14 16:04:21
361	App\\Models\\User	1	auth_token	bd6f5343f4b980b0bd3b44969b0ae5af27ae30dd90c15467e2820917850140fd	["*"]	2026-04-14 11:40:09	\N	2026-04-14 11:39:09	2026-04-14 11:40:09
374	App\\Models\\User	1	auth_token	5107e0a1c5823c2097b202f5ae3de845f92f48b3a96adc2c0a8f93b8aa238935	["*"]	2026-04-14 15:48:07	\N	2026-04-14 15:43:46	2026-04-14 15:48:07
369	App\\Models\\User	5	auth_token	0abee8f18e848de91482705bf3f337fe2242989c80893d7d64de8ec1b8e9be13	["*"]	2026-04-14 14:02:37	\N	2026-04-14 14:01:41	2026-04-14 14:02:37
375	App\\Models\\User	7	auth_token	075f9f7b989c5c2ff67458c9541b25815090198aba046fe9c4345482adf9d326	["*"]	2026-04-14 15:53:39	\N	2026-04-14 15:53:01	2026-04-14 15:53:39
370	App\\Models\\User	5	auth_token	5416a703bee801fbac04b57e06a5501ce75ca5175a1ad2c09032af8a7a8c77f7	["*"]	2026-04-14 14:10:19	\N	2026-04-14 14:10:01	2026-04-14 14:10:19
362	App\\Models\\User	1	auth_token	e2ed53837bec3682c99c2e23407b2ebd66c4e9b0ebd4faf220c09a3f187431db	["*"]	2026-04-14 11:58:37	\N	2026-04-14 11:55:56	2026-04-14 11:58:37
359	App\\Models\\User	1	auth_token	8e6852368fb030d07887c1c8da0cea501a40d4eae572366180b1f44e0663a719	["*"]	2026-04-14 11:10:48	\N	2026-04-14 11:06:58	2026-04-14 11:10:48
363	App\\Models\\User	1	auth_token	48826944d93bf144c2fcd132e31ef36580aae5535a9f4c917fee7896a8dd0482	["*"]	2026-04-14 12:04:06	\N	2026-04-14 12:04:04	2026-04-14 12:04:06
371	App\\Models\\User	5	auth_token	34e18c7e1095ef264647f3b8ed4a9e30b0986e548e69934d56e4e1bd376c3173	["*"]	2026-04-14 15:06:36	\N	2026-04-14 15:05:54	2026-04-14 15:06:36
364	App\\Models\\User	1	auth_token	12d7290ea4de7b74974db7389de9fec0e4edc4e7436e84a765d15df45a8abe9c	["*"]	2026-04-14 12:12:08	\N	2026-04-14 12:11:32	2026-04-14 12:12:08
365	App\\Models\\User	1	auth_token	80fb11f59081f257f71277d27da65ea7d02777d276408155b2f212f6a20d65fe	["*"]	2026-04-14 12:13:05	\N	2026-04-14 12:13:03	2026-04-14 12:13:05
385	App\\Models\\User	1	auth_token	74cad3371e0e7f843ca76d215d51e12aa6a4bf24a6e4395be54b50c68c1da5ce	["*"]	2026-04-17 09:57:22	\N	2026-04-17 09:56:58	2026-04-17 09:57:22
373	App\\Models\\User	1	auth_token	770342761392f4bf134277d27deb5eb884e8518f3acfa7cde59565108760d497	["*"]	2026-04-14 15:37:55	\N	2026-04-14 15:21:42	2026-04-14 15:37:55
391	App\\Models\\User	6	auth_token	797e194ffd066304a296be99d675b6b561184aebaa20e96276cc1d080232983f	["*"]	2026-04-17 10:17:42	\N	2026-04-17 10:15:50	2026-04-17 10:17:42
378	App\\Models\\User	1	auth_token	b96b1a1b91286646bb8fe8bfe60ef052eca4d57b601be56ad24cacea0e1a1431	["*"]	2026-04-14 17:10:35	\N	2026-04-14 17:08:36	2026-04-14 17:10:35
379	App\\Models\\User	1	auth_token	fef41900b23b18ca9ff3d4150b7c4b9926fcdb64c7cbb0c40bb18b6f947d867b	["*"]	2026-04-17 09:43:52	\N	2026-04-17 09:37:30	2026-04-17 09:43:52
400	App\\Models\\User	1	auth_token	51b299a7c20f5739a9f0dff8f6634142e8693558144631baeaff9a78a6f3cd1d	["*"]	2026-04-17 11:07:44	\N	2026-04-17 11:07:18	2026-04-17 11:07:44
383	App\\Models\\User	1	auth_token	b02e33f2d7daf9e6ae7df3b0d13e6cb2208fc35d82a60b6632679ea416d03252	["*"]	2026-04-17 09:55:54	\N	2026-04-17 09:54:02	2026-04-17 09:55:54
584	App\\Models\\User	8	auth_token	fe8467b0153a7b80ee96f8f0687b57b1e00b1abe968b751a0501482c58854f4e	["*"]	2026-04-23 20:11:17	\N	2026-04-23 20:10:35	2026-04-23 20:11:17
387	App\\Models\\User	5	auth_token	eb974a4cd039a8d3b6d0742293a37761afd9f1d167b6788155b14313b1219ac2	["*"]	2026-04-17 09:59:03	\N	2026-04-17 09:59:01	2026-04-17 09:59:03
392	App\\Models\\User	6	auth_token	d630736429cb9e4d8a66971ebea793fc282679a4d9e808b2f49d57c08ff07b0b	["*"]	2026-04-17 10:35:02	\N	2026-04-17 10:34:58	2026-04-17 10:35:02
396	App\\Models\\User	1	auth_token	93d9be94d4cfa9230115bbecb4e2d5717c096221f72a5b2d622f4426c798abf3	["*"]	2026-04-17 11:03:37	\N	2026-04-17 11:03:10	2026-04-17 11:03:37
395	App\\Models\\User	1	auth_token	1a03132e2bcc977279923deb9df6d075e577faa4098d3048887287cec4c59043	["*"]	2026-04-17 10:57:21	\N	2026-04-17 10:52:01	2026-04-17 10:57:21
393	App\\Models\\User	1	auth_token	6848453a48165658a42699f53161e8ef3d173a7ee5183bff5a0508d8ff5acb1d	["*"]	2026-04-17 10:44:41	\N	2026-04-17 10:39:56	2026-04-17 10:44:41
398	App\\Models\\User	1	auth_token	71754ce05d087d99352f6fb73727b056d2ce7f15bbd89b8f80d644bb25dbece2	["*"]	2026-04-17 11:06:08	\N	2026-04-17 11:05:16	2026-04-17 11:06:08
406	App\\Models\\User	7	auth_token	5bcf6e041c930a478489f2f6dfe924a3a38233d241ac09115107c5ec82fcd9b0	["*"]	2026-04-17 12:20:43	\N	2026-04-17 12:19:57	2026-04-17 12:20:43
401	App\\Models\\User	1	auth_token	5f29d61bb41ce29494bf8443c59bcfa4755c033c5df03edfb26ab150458d5380	["*"]	2026-04-17 11:15:33	\N	2026-04-17 11:15:30	2026-04-17 11:15:33
403	App\\Models\\User	4	auth_token	350027399faef201f9f1103ce269ae51f26e4884f04570486e6d90e1a41e56a5	["*"]	2026-04-17 11:23:58	\N	2026-04-17 11:23:56	2026-04-17 11:23:58
404	App\\Models\\User	4	auth_token	d451fdcde4a094ae51d9b2edfb670255a8714222c30047199f9d4b72f9458792	["*"]	2026-04-17 11:42:22	\N	2026-04-17 11:42:20	2026-04-17 11:42:22
407	App\\Models\\User	1	auth_token	67d886057e97e65ad8e1dfd090d6d964ae584889c00aa0e7073e98729bc18baa	["*"]	2026-04-17 12:40:07	\N	2026-04-17 12:39:35	2026-04-17 12:40:07
409	App\\Models\\User	1	auth_token	73616c8a096189fce0c155a18a94ec70da0bc6be152521a42bf74d15300cacea	["*"]	2026-04-17 13:05:24	\N	2026-04-17 13:01:31	2026-04-17 13:05:24
408	App\\Models\\User	1	auth_token	a86182bd2d48472c54e60fbb8d1b033ce8b814908f8613d69ad96974a771908f	["*"]	2026-04-17 12:46:42	\N	2026-04-17 12:43:15	2026-04-17 12:46:42
410	App\\Models\\User	1	auth_token	b19ed4648889982f1b4c530ba76d64523e859a50b6be2f60c3a25aebed6e9d9b	["*"]	2026-04-17 13:16:48	\N	2026-04-17 13:15:50	2026-04-17 13:16:48
411	App\\Models\\User	1	auth_token	0b12cc960362b1f50ec4c36521cbc10b481ead9a0bc47ac5e0ca66c809fd7bd9	["*"]	2026-04-17 13:27:39	\N	2026-04-17 13:22:00	2026-04-17 13:27:39
432	App\\Models\\User	1	auth_token	b1008abed1f8951a472cf48428f1c2530effd0228fbae86e3df6a8771d396262	["*"]	2026-04-20 10:25:46	\N	2026-04-20 09:46:09	2026-04-20 10:25:46
431	App\\Models\\User	1	auth_token	e6d71dea8f3c88793f627e0a0700434b5db4795fd50e9b576f6e08468910bd2f	["*"]	2026-04-17 16:54:29	\N	2026-04-17 16:54:19	2026-04-17 16:54:29
420	App\\Models\\User	1	auth_token	cd03d546fdbe5c5a2d283b0afb19510549d7e920ce2cfc0aa64aee16baefa6d3	["*"]	\N	\N	2026-04-17 15:32:19	2026-04-17 15:32:19
412	App\\Models\\User	1	auth_token	1df38888409fed8955794e6ac23639a0e2d0b3375f89e8dbdcb5fa803c35f0bc	["*"]	2026-04-17 14:54:41	\N	2026-04-17 14:53:48	2026-04-17 14:54:41
445	App\\Models\\User	1	auth_token	8f0acfdc218b3e7358caf73301dabadbcb53703c5549733784e37bd992a4df6f	["*"]	2026-04-20 12:45:32	\N	2026-04-20 12:44:51	2026-04-20 12:45:32
444	App\\Models\\User	1	auth_token	89f7f2ac2dc1e0b93541cbd748641f6ed19950fd58b3f0d4f004604f752a833b	["*"]	2026-04-20 12:39:05	\N	2026-04-20 12:37:59	2026-04-20 12:39:05
443	App\\Models\\User	1	auth_token	f298818118fecfaf2b09357e4a3faa349b254639aa079c12fcb97f84aa2d4708	["*"]	2026-04-20 12:26:29	\N	2026-04-20 12:25:13	2026-04-20 12:26:29
441	App\\Models\\User	1	auth_token	a9662fb0052320b89cdf27c5331491f08d5306b93db40a30fdb7aaee33ed4a68	["*"]	2026-04-20 12:15:19	\N	2026-04-20 12:11:06	2026-04-20 12:15:19
427	App\\Models\\User	1	auth_token	6c5b820384f24598934662cd435e1c9dde29777699f563a1797dc971b5f11e9f	["*"]	2026-04-17 16:09:08	\N	2026-04-17 16:08:49	2026-04-17 16:09:08
413	App\\Models\\User	1	auth_token	5543c1c841e105b34e53acfaaf16726b1f81059dbecc2aefb47d469efa575e87	["*"]	2026-04-17 15:06:14	\N	2026-04-17 15:01:38	2026-04-17 15:06:14
440	App\\Models\\User	1	auth_token	bd75ad6028eab9938ecd3dfa25ec695d37c3af84bbffeb54796d006f15713112	["*"]	2026-04-20 11:58:37	\N	2026-04-20 11:57:04	2026-04-20 11:58:37
436	App\\Models\\User	1	auth_token	a474389c8915b1bffaedae4037452c1bcecca5a544e1911de919c8eb8b289baf	["*"]	2026-04-20 10:47:10	\N	2026-04-20 10:43:47	2026-04-20 10:47:10
423	App\\Models\\User	1	auth_token	a76106b4126203c92e09031f767c602a72f84dcbe6998e5baee3a9058017178f	["*"]	2026-04-17 15:40:26	\N	2026-04-17 15:37:54	2026-04-17 15:40:26
438	App\\Models\\User	1	auth_token	1dcd27737e5aac2eeae63fd04662bf64136f895e27c89dd87e58d844162932d7	["*"]	2026-04-20 11:29:40	\N	2026-04-20 11:17:32	2026-04-20 11:29:40
417	App\\Models\\User	1	auth_token	8bc0cba9d5052173d6f64dc2e024a94910b66a675a11437920a8f3fceec76ac6	["*"]	2026-04-17 16:32:31	\N	2026-04-17 15:18:49	2026-04-17 16:32:31
421	App\\Models\\User	1	auth_token	9cd42319395bd072e52fd7424a2c3d37a7d30153828e4a34dbdce314c0ac5e54	["*"]	2026-04-17 15:35:07	\N	2026-04-17 15:32:37	2026-04-17 15:35:07
429	App\\Models\\User	4	auth_token	8cfb919bd8336b0f0dd99fc372dcc07923e3fbe459d3ba88c2af2435d8477d42	["*"]	2026-04-17 16:35:59	\N	2026-04-17 16:35:31	2026-04-17 16:35:59
415	App\\Models\\User	1	auth_token	3110b455a8377f7db2da2ad13ddd3c4b78d060331c17433c82c69fc403c172c2	["*"]	2026-04-17 15:12:53	\N	2026-04-17 15:09:17	2026-04-17 15:12:53
425	App\\Models\\User	1	auth_token	6774199084744ad2366e3f94cb90feed771a7fc2a1ea88d012bf59c42b59e223	["*"]	2026-04-17 16:02:50	\N	2026-04-17 15:56:32	2026-04-17 16:02:50
418	App\\Models\\User	1	auth_token	3878b60128cb7071bc353a9f5931749c025075f3869ff391889c9b322fe70f15	["*"]	\N	\N	2026-04-17 15:31:59	2026-04-17 15:31:59
419	App\\Models\\User	1	auth_token	0d8de53891e0e8d47539c47f63f6851f324819a33e485f7a7f4ef002b2653b92	["*"]	\N	\N	2026-04-17 15:32:02	2026-04-17 15:32:02
430	App\\Models\\User	4	auth_token	b16e5ab0b406a7d9db744a9aa4958eb17e5df89890d654633124ddad823495b9	["*"]	2026-04-17 16:52:45	\N	2026-04-17 16:52:29	2026-04-17 16:52:45
433	App\\Models\\User	1	auth_token	a69f74c4c9891409ef88d2eb5cea10268889d3eccab57d359d15b4205b32fddc	["*"]	2026-04-20 09:56:36	\N	2026-04-20 09:56:20	2026-04-20 09:56:36
435	App\\Models\\User	1	auth_token	39e9d93788ff0709e3eec581b40665b5c7571c30191e44533e5327fbf45832df	["*"]	2026-04-20 10:38:48	\N	2026-04-20 10:32:09	2026-04-20 10:38:48
449	App\\Models\\User	1	auth_token	ec5edc1fecc42ca626574fd2b2f3546e79fde19f0901aaad6474b2e83a5efdc8	["*"]	2026-04-20 13:28:11	\N	2026-04-20 13:24:54	2026-04-20 13:28:11
434	App\\Models\\User	1	auth_token	727f03ec169534a685ce0d063ea89e30de0605a8fa21f928d4ee62dd09b89f6b	["*"]	2026-04-20 10:03:16	\N	2026-04-20 10:01:52	2026-04-20 10:03:16
439	App\\Models\\User	1	auth_token	01fc8806009a22853f3b0713df202fd49d45b27ee561139e71168b8179332be9	["*"]	2026-04-20 11:37:01	\N	2026-04-20 11:36:54	2026-04-20 11:37:01
442	App\\Models\\User	1	auth_token	a7f7efcd4409064fbb8a5206d6ed48839b9dc95e054180a9fcb046b1978e3566	["*"]	2026-04-20 12:21:14	\N	2026-04-20 12:20:52	2026-04-20 12:21:14
437	App\\Models\\User	1	auth_token	52048412647fdc9bcb0bf22eb57b5244f40a576724404173622f0b264a9605df	["*"]	2026-04-20 11:09:57	\N	2026-04-20 11:07:11	2026-04-20 11:09:57
540	App\\Models\\User	8	auth_token	0f10c2ec7660e481bb1194745ebac2f8cb0e3abfb03805a8f2de232a6cf82cb9	["*"]	2026-04-23 09:54:52	\N	2026-04-23 09:54:15	2026-04-23 09:54:52
450	App\\Models\\User	1	auth_token	7b51bee0d53b86dec2272b010a83d337499688b6ad98eae309745ed39a03cd59	["*"]	2026-04-20 13:38:28	\N	2026-04-20 13:33:56	2026-04-20 13:38:28
447	App\\Models\\User	1	auth_token	0123575f32c1700aad28a4d58a5a819edc1b3c537072998c216f68adce56e154	["*"]	2026-04-20 13:13:11	\N	2026-04-20 13:08:09	2026-04-20 13:13:11
446	App\\Models\\User	1	auth_token	93f82e248736be2be1f28d452fed36a82d9fec9d1e8f25f0af6bbd4bd7fb6785	["*"]	2026-04-20 12:59:48	\N	2026-04-20 12:54:54	2026-04-20 12:59:48
453	App\\Models\\User	1	auth_token	bab8b7cc58c52eeb86664f54711ffaf195b5a66eed1c0d53d01e5b35d030eb59	["*"]	2026-04-20 13:56:15	\N	2026-04-20 13:50:22	2026-04-20 13:56:15
458	App\\Models\\User	1	auth_token	edac98663b1ecd1af48ac53cdd414b6f7b55315ea6d978d0ab84976661681f40	["*"]	2026-04-20 15:35:00	\N	2026-04-20 15:33:38	2026-04-20 15:35:00
448	App\\Models\\User	1	auth_token	32fa6d2d2560e48d02dddf1a285bc05e9176e01735afdb524ed27bb2e46ab38e	["*"]	2026-04-20 13:20:32	\N	2026-04-20 13:17:52	2026-04-20 13:20:32
452	App\\Models\\User	1	auth_token	406c3df75552f821d704e7c9336be6bd354ef4918f0be3730b2771ff61e53d9f	["*"]	2026-04-20 13:45:49	\N	2026-04-20 13:40:44	2026-04-20 13:45:49
454	App\\Models\\User	1	auth_token	b813fe2c56cfaaf5b66e6438e45185ecff02c9a4cec42ec97aa712e8401e70ae	["*"]	2026-04-20 14:57:55	\N	2026-04-20 14:57:45	2026-04-20 14:57:55
456	App\\Models\\User	1	auth_token	3abcf38375e4fc6beaaad15d758f856bbbcad942049038af8afa157dc7cbd4d2	["*"]	2026-04-20 15:29:34	\N	2026-04-20 15:17:56	2026-04-20 15:29:34
463	App\\Models\\User	1	auth_token	9df4d9efcb081f0d107ecf6ee599da01b64af18842b13fdec5fb4f8002bd9384	["*"]	2026-04-20 15:39:07	\N	2026-04-20 15:39:05	2026-04-20 15:39:07
466	App\\Models\\User	1	auth_token	33918260f436ea07659a78dd4fd0e61cfbde3b06314b083768e8f77fa3ac94a5	["*"]	2026-04-20 15:51:11	\N	2026-04-20 15:49:23	2026-04-20 15:51:11
465	App\\Models\\User	1	auth_token	5f4b4940bc06b385f3d2dd4141bc213f423eb904b4edb6fa853c6754b5d00a3a	["*"]	2026-04-20 15:48:56	\N	2026-04-20 15:42:39	2026-04-20 15:48:56
468	App\\Models\\User	1	auth_token	97bca9b1202f05f4e4b971a1ad796d15db056ec98c3526ce40a1136720c68441	["*"]	2026-04-20 15:53:53	\N	2026-04-20 15:53:46	2026-04-20 15:53:53
470	App\\Models\\User	1	auth_token	ba0c4e88ddd4ff9165bf34768d945fc2662966787b5d1d0ca77eb03ab6266c8a	["*"]	2026-04-20 15:59:22	\N	2026-04-20 15:55:08	2026-04-20 15:59:22
497	App\\Models\\User	1	auth_token	57a3b66b67363602cbfa8e475d0df65636db53a5682fa74f349f20afd132b45d	["*"]	2026-04-20 21:17:36	\N	2026-04-20 21:13:13	2026-04-20 21:17:36
722	App\\Models\\User	4	auth_token	fc13140a700dc124f4028a7d3b5e6960c588dc9ab8547f81f37abea5e138893d	["*"]	2026-05-02 11:49:16	\N	2026-05-02 11:36:38	2026-05-02 11:49:16
496	App\\Models\\User	1	auth_token	9094ce4243179360635bbe07baa6ebf10a0b88d31ad06f11cc03758a6aeaef0a	["*"]	2026-04-20 21:11:52	\N	2026-04-20 21:07:28	2026-04-20 21:11:52
482	App\\Models\\User	6	auth_token	f7bef729e5b75f7c9b0091e2ed2855c23c1692dd861021ea398acad9b934d569	["*"]	2026-04-20 16:37:46	\N	2026-04-20 16:35:55	2026-04-20 16:37:46
478	App\\Models\\User	1	auth_token	372629776f55817470a6514ffd2b3923e10531daaafea134926b3b35f6916890	["*"]	2026-04-20 16:10:04	\N	2026-04-20 16:10:02	2026-04-20 16:10:04
499	App\\Models\\User	1	auth_token	942951f5ae48185a39ede7e34e79b8ce4280a328b13fdca6474ea1098c8c435d	["*"]	2026-04-21 00:16:42	\N	2026-04-21 00:15:59	2026-04-21 00:16:42
490	App\\Models\\User	5	auth_token	cd496ee38b163f122333dcbf1b36d270383035d4074b18695dd14c33951341af	["*"]	2026-04-20 20:08:09	\N	2026-04-20 20:04:36	2026-04-20 20:08:09
486	App\\Models\\User	1	auth_token	5b67c8f0fb3308e436f6729c44fc51c9683dabc063b467be54c29e3aa1e927fa	["*"]	2026-04-20 16:50:50	\N	2026-04-20 16:48:32	2026-04-20 16:50:50
492	App\\Models\\User	1	auth_token	4db8ed69feaed84288d7faefd4bb09592b68ec1139a9d0e886219c8e8cccad27	["*"]	2026-04-20 20:17:32	\N	2026-04-20 20:16:48	2026-04-20 20:17:32
483	App\\Models\\User	1	auth_token	5f5cb03a3b5fbeada5cccb3f9dd95ed42cb177a8e6e1af546a02c4604ab60052	["*"]	2026-04-20 16:42:46	\N	2026-04-20 16:42:01	2026-04-20 16:42:46
479	App\\Models\\User	5	auth_token	691b5f1cab8eb6275271221d78202d0c3da59b2e54ce9aafa5a06d229e4ad8d5	["*"]	2026-04-20 16:12:26	\N	2026-04-20 16:10:34	2026-04-20 16:12:26
717	App\\Models\\User	5	auth_token	c4d44899b47d3afaa698921581696e9d57af06442e4cbad7c82ef09bca2ab0ed	["*"]	2026-05-02 00:58:17	\N	2026-05-02 00:55:15	2026-05-02 00:58:17
713	App\\Models\\User	5	auth_token	b67db33e18fac16c74657503dc9367c9b1b32ce3e03d8ecd083009ce65849a51	["*"]	2026-05-01 15:00:58	\N	2026-05-01 14:57:27	2026-05-01 15:00:58
495	App\\Models\\User	1	auth_token	96fb21d91de0a714ae17491a66b556262bb1b9698d585e2ab8959843e2ef2114	["*"]	2026-04-20 20:57:47	\N	2026-04-20 20:55:44	2026-04-20 20:57:47
472	App\\Models\\User	1	auth_token	42e713dcd21c277702e060a1b78e14416021d12e9fefc60800a287caa78cba23	["*"]	2026-04-20 16:03:47	\N	2026-04-20 16:01:20	2026-04-20 16:03:47
505	App\\Models\\User	1	auth_token	f3ab02b129144ea875dd90cbfc0244cd65930d0ba04062c5d53a5e4f67ac5a02	["*"]	2026-04-21 01:41:34	\N	2026-04-21 01:36:33	2026-04-21 01:41:34
501	App\\Models\\User	1	auth_token	4d8ab1fd360b9ab180870b6edf886283a0344e595821cb675c70069cf91ce362	["*"]	2026-04-21 01:49:23	\N	2026-04-21 00:59:18	2026-04-21 01:49:23
487	App\\Models\\User	1	auth_token	facc4d78c59a86f86d7c5b934993aee1112404c987d2204664fa340250dc1530	["*"]	2026-04-20 16:57:59	\N	2026-04-20 16:57:03	2026-04-20 16:57:59
474	App\\Models\\User	1	auth_token	e72ddfe1d7ca02af64f93c04b5e9eadf92e4b6543a906c338c27965253e6e301	["*"]	2026-04-20 16:05:38	\N	2026-04-20 16:05:36	2026-04-20 16:05:38
480	App\\Models\\User	1	auth_token	935421854152506328b9409070492d3a23e62e37b6d87955e16af728c2a661b7	["*"]	2026-04-20 16:33:07	\N	2026-04-20 16:30:34	2026-04-20 16:33:07
724	App\\Models\\User	5	auth_token	f8bb35994a595b3908b499cb5e3cdf31cb2108bc30637a365bc1c1225df07d5b	["*"]	2026-05-03 17:33:34	\N	2026-05-03 17:20:33	2026-05-03 17:33:34
484	App\\Models\\User	1	auth_token	227cca76f31f5ae4cd309ff53d2a503b4e01ca4c3c5f2fc66c4ff2fae4e1425c	["*"]	2026-04-20 16:45:15	\N	2026-04-20 16:43:59	2026-04-20 16:45:15
506	App\\Models\\User	1	auth_token	e583d6b6e1033f5a22035550346be57bb7b54315502f5a4b731538d632819f1a	["*"]	2026-04-21 01:47:03	\N	2026-04-21 01:44:32	2026-04-21 01:47:03
502	App\\Models\\User	1	auth_token	e550bdfcf5aa5c060146c64e11eeeb40dc5fa4bef24014826204c51ac470ea62	["*"]	2026-04-21 01:07:15	\N	2026-04-21 01:06:44	2026-04-21 01:07:15
494	App\\Models\\User	1	auth_token	8627d616aaf13d3a7c334e4012a91af2ae5d1d923bab3a7bbfb1e86addacd669	["*"]	2026-04-20 20:33:52	\N	2026-04-20 20:19:15	2026-04-20 20:33:52
498	App\\Models\\User	1	auth_token	873a270dcf6779a18fcfe69687473610913f78111799b1d90748c1a52379aad3	["*"]	2026-04-20 23:32:21	\N	2026-04-20 23:30:28	2026-04-20 23:32:21
489	App\\Models\\User	1	auth_token	8cf1bfe01511bd770ef5d7e8a976936dafca91445788d40ad6ef5f6376af1f33	["*"]	2026-04-20 20:04:08	\N	2026-04-20 20:03:52	2026-04-20 20:04:08
508	App\\Models\\User	1	auth_token	39dc4ca6e0eaff19adba34e550556bc7722e5ec58918d3aac8a86deec91b8200	["*"]	2026-04-21 02:01:09	\N	2026-04-21 01:58:07	2026-04-21 02:01:09
500	App\\Models\\User	1	auth_token	d90d7d7d23d2bc507154844fd7e12c851ecd01e3b5674a4033da0420bbbb2a8d	["*"]	2026-04-21 01:25:17	\N	2026-04-21 00:47:36	2026-04-21 01:25:17
503	App\\Models\\User	1	auth_token	acdac2b064f1419c4df377bb789827dd468009c89cc7ec4ce7d4f64b6896e14c	["*"]	2026-04-21 01:14:29	\N	2026-04-21 01:09:57	2026-04-21 01:14:29
504	App\\Models\\User	1	auth_token	9422940094aac954d22eeebc49f1ee49dadfe39a183a531fc40fda48257a04ef	["*"]	2026-04-21 01:33:19	\N	2026-04-21 01:21:48	2026-04-21 01:33:19
511	App\\Models\\User	1	auth_token	9adec5a23d0fbd6dd8e6e44c0e022fedcb1e5717914f60311e7ce8c61f483121	["*"]	2026-04-21 10:59:39	\N	2026-04-21 10:56:38	2026-04-21 10:59:39
731	App\\Models\\User	1	auth_token	acf5a36e580de8a3b74b0ee7e1b19114969b7561fb0c071fa94d536226a8abe2	["*"]	2026-05-03 18:14:20	\N	2026-05-03 18:13:34	2026-05-03 18:14:20
510	App\\Models\\User	1	auth_token	c6254c2e43bb53ab64eefb06caf77780e19fa774e278209181c4a1d0ade0a8fd	["*"]	2026-04-21 10:50:10	\N	2026-04-21 10:43:37	2026-04-21 10:50:10
509	App\\Models\\User	1	auth_token	2a7437e324bad66cbc348f923df5878cc14556be5acebef44c5d4ada7cc1a795	["*"]	2026-04-21 02:04:41	\N	2026-04-21 02:03:40	2026-04-21 02:04:41
515	App\\Models\\User	1	auth_token	ec542b6e519abe60b2bc862b621c4d5fc280eb974cefa6349189ad70e36e938f	["*"]	2026-04-21 14:04:23	\N	2026-04-21 14:03:22	2026-04-21 14:04:23
507	App\\Models\\User	1	auth_token	b68c0bebda3ab873f052b4e3c9804d9086b0f857a878853ef7566713ac40e90c	["*"]	2026-04-21 01:53:08	\N	2026-04-21 01:48:07	2026-04-21 01:53:08
733	App\\Models\\User	1	auth_token	9bd5584ab861242a1118bfbd97110955e3771e20fe246ca02cf98d4972504e6e	["*"]	2026-05-03 18:29:56	\N	2026-05-03 18:28:54	2026-05-03 18:29:56
735	App\\Models\\User	4	auth_token	3061b23ff773a320d4f221cf17b665cde8a3c660d24eeafb258e3ca2f9705714	["*"]	2026-05-03 18:42:42	\N	2026-05-03 18:40:11	2026-05-03 18:42:42
513	App\\Models\\User	1	auth_token	b2fcc54a23e68849512a0ed4ac68dabac3f2d28911f57e190c9c1907b4377105	["*"]	2026-04-21 11:06:51	\N	2026-04-21 11:01:57	2026-04-21 11:06:51
739	App\\Models\\User	4	auth_token	37009ae4e4bff37db991742bce705635e71f822eeee6c5e2586f8c41b410141d	["*"]	2026-05-03 19:14:36	\N	2026-05-03 19:07:49	2026-05-03 19:14:36
527	App\\Models\\User	1	auth_token	73c2fa9bc1deb13ef6af4300522acf5e7bab1ae98fdc94591e1b968e00807063	["*"]	2026-04-21 16:36:56	\N	2026-04-21 16:26:02	2026-04-21 16:36:56
572	App\\Models\\User	1	auth_token	9f8f22459e5581aa430002f477766c7b4a29cbbdf6f83525dafd11e61b5f3c4f	["*"]	2026-04-23 15:55:55	\N	2026-04-23 15:55:22	2026-04-23 15:55:55
531	App\\Models\\User	4	auth_token	a214d17fc163b0c9add8c7221ba2e3ef337c97ef863ad99fd217293967a30b23	["*"]	2026-04-21 17:05:38	\N	2026-04-21 16:58:24	2026-04-21 17:05:38
532	App\\Models\\User	1	auth_token	6bbe8fcb69ef2cdec01fd461c17f1b8e9f368fe7704e34db22c546253961eb68	["*"]	2026-04-23 09:24:37	\N	2026-04-23 09:23:06	2026-04-23 09:24:37
542	App\\Models\\User	1	auth_token	ae04c582737718b6456c5d366a511e7221d7ad68eb129db0d5bfb55092ca72b8	["*"]	2026-04-23 10:10:04	\N	2026-04-23 10:08:57	2026-04-23 10:10:04
569	App\\Models\\User	1	auth_token	8fe82d38666cd90536d4ee258c85053c5e34e143deded34e8024b6bed5fb717e	["*"]	2026-04-23 13:35:16	\N	2026-04-23 13:34:27	2026-04-23 13:35:16
555	App\\Models\\User	1	auth_token	ee62262f29be9456f60f580b9af42066dd3d6ba8adec04b329c2429f694b2e3b	["*"]	2026-04-23 11:03:08	\N	2026-04-23 10:57:58	2026-04-23 11:03:08
714	App\\Models\\User	5	auth_token	d0f9a8b2ab41068c377e9315d0902c372c47289790bdaaeb996656cc2129db95	["*"]	2026-05-02 00:20:43	\N	2026-05-02 00:16:10	2026-05-02 00:20:43
551	App\\Models\\User	1	auth_token	e2a6e83d4f3067d453a88cef4c163f956895059fe291db019a2a30640654dc03	["*"]	2026-04-23 10:51:38	\N	2026-04-23 10:51:08	2026-04-23 10:51:38
585	App\\Models\\User	1	auth_token	291dd00fcd35d1b11afe57b852684628ee61c5fd675745b24468552326531b95	["*"]	2026-04-23 20:33:43	\N	2026-04-23 20:33:12	2026-04-23 20:33:43
545	App\\Models\\User	1	auth_token	bb5123da24b8c46c247b9e5a5a2575f3d52ee1623abe68df0139b7e65326ce20	["*"]	2026-04-23 10:35:07	\N	2026-04-23 10:32:36	2026-04-23 10:35:07
593	App\\Models\\User	8	auth_token	14d20bb47d0285ff99c85c561f492c8729645da4b556ebc6673e29032829cd8e	["*"]	2026-04-23 23:52:03	\N	2026-04-23 23:43:32	2026-04-23 23:52:03
566	App\\Models\\User	1	auth_token	658776dd9622ef6f2e27cd177329946877dbaa7261325232ac32b8dd3aa70163	["*"]	2026-04-23 13:26:42	\N	2026-04-23 13:24:58	2026-04-23 13:26:42
588	App\\Models\\User	8	auth_token	39926959b99bfdd16a8ce4dc454c8b227b88fcf276c61b7a360b1d4fb9c193c9	["*"]	2026-04-23 20:39:13	\N	2026-04-23 20:35:41	2026-04-23 20:39:13
539	App\\Models\\User	1	auth_token	fead37f9ce2c80fbd2b5e588eb2f79611ce8fc796359c56ba7d34bef973630ca	["*"]	2026-04-23 09:53:52	\N	2026-04-23 09:51:54	2026-04-23 09:53:52
577	App\\Models\\User	1	auth_token	a5ead7aa05b68a52d1c5ced568b931da71ed81ec1f30bffaef34c240870fe1c8	["*"]	2026-04-23 16:14:25	\N	2026-04-23 16:10:00	2026-04-23 16:14:25
559	App\\Models\\User	1	auth_token	87f4fd05d1f2e051539ce9662dbfcbdd061b8d4e1cc4b73ce8ee01894967aff2	["*"]	2026-04-23 12:32:46	\N	2026-04-23 12:27:44	2026-04-23 12:32:46
562	App\\Models\\User	1	auth_token	6f9905575e4645839d9ec7cd073fa1bce33eed1ea3a8a0c3185393babac9f4cd	["*"]	2026-04-23 12:46:38	\N	2026-04-23 12:43:13	2026-04-23 12:46:38
718	App\\Models\\User	5	auth_token	db543b1084b028b7fb98c6a9b46370af2cf741a9a422684e1fbd355415137d7b	["*"]	2026-05-02 01:07:27	\N	2026-05-02 01:01:25	2026-05-02 01:07:27
534	App\\Models\\User	1	auth_token	6370e10482ed11990207fb17d7aa0635c7071e0640ba9727e7170b846644dfc6	["*"]	2026-04-23 09:41:22	\N	2026-04-23 09:34:50	2026-04-23 09:41:22
580	App\\Models\\User	1	auth_token	ac8c7ce85f7663004a8ad7a1891060b1e981101381bc9af7e03173a4a9c165d0	["*"]	2026-04-23 16:47:49	\N	2026-04-23 16:44:18	2026-04-23 16:47:49
533	App\\Models\\User	1	auth_token	68c94a4524ab80f394d8e887c3be3d4228d6f89849d154f6c5fc8695afa37746	["*"]	2026-04-23 09:29:37	\N	2026-04-23 09:24:44	2026-04-23 09:29:37
556	App\\Models\\User	1	auth_token	f0d8f8e863827c6ca5b2d7b3ca230b0d6ee5bce56e5f327c9827f4cd6a6577f5	["*"]	2026-04-23 11:21:09	\N	2026-04-23 11:11:08	2026-04-23 11:21:09
544	App\\Models\\User	1	auth_token	efb2ea314c65d7d38be07d601ef0be9cbe1d21dbbadb61d8edb970a4f0cf95ba	["*"]	2026-04-23 10:15:04	\N	2026-04-23 10:11:20	2026-04-23 10:15:04
546	App\\Models\\User	8	auth_token	2699d4003f60af86c0cbdce9d61cbe54314190bedacf679e9384bd517959512b	["*"]	2026-04-23 10:41:07	\N	2026-04-23 10:35:13	2026-04-23 10:41:07
558	App\\Models\\User	1	auth_token	39caed653e69914b604c056f886257b02652cc566e8757397e79d7237658f198	["*"]	2026-04-23 12:20:51	\N	2026-04-23 12:08:50	2026-04-23 12:20:51
560	App\\Models\\User	1	auth_token	286aef56849c2ada1090fbe017b5af834c41705ab5478afaec23e3771abe6491	["*"]	2026-04-23 12:36:50	\N	2026-04-23 12:35:48	2026-04-23 12:36:50
587	App\\Models\\User	1	auth_token	495b3c7fc5793806acb158c5de70600c72d24eb5d947eb0b2317ea9d3d66f1e9	["*"]	2026-04-23 20:35:14	\N	2026-04-23 20:34:32	2026-04-23 20:35:14
581	App\\Models\\User	8	auth_token	8ce82feaddf66953a66271db2ba854cdf33973eab9a05f82de4307ebeb4750b6	["*"]	2026-04-23 17:04:49	\N	2026-04-23 16:47:57	2026-04-23 17:04:49
548	App\\Models\\User	1	auth_token	46c375bc4ea7ca01ca6c601f049c906391146d20c1135a33cf4f38f3dd3bdf6e	["*"]	2026-04-23 10:49:08	\N	2026-04-23 10:48:13	2026-04-23 10:49:08
583	App\\Models\\User	1	auth_token	0d365cde4ec64989a54ec2abed323315b9a40a5463e4e97110b2a49aaa866543	["*"]	2026-04-23 20:10:18	\N	2026-04-23 20:08:46	2026-04-23 20:10:18
564	App\\Models\\User	1	auth_token	bd867d87c8dc159e89de0c08bce964ef9cac1c7245f5850214d32051aeb2bcc8	["*"]	2026-04-23 13:03:12	\N	2026-04-23 12:53:05	2026-04-23 13:03:12
571	App\\Models\\User	8	auth_token	57c33eeb91f3711ea65e3d8d3a61fea4d750f95b5184221d1890aa5789e070c3	["*"]	2026-04-23 14:27:08	\N	2026-04-23 13:52:25	2026-04-23 14:27:08
594	App\\Models\\User	8	auth_token	5b743f440674a14314d2c881142185419ae0b1853f99af54468ff2397709e0be	["*"]	2026-04-24 00:01:36	\N	2026-04-23 23:57:06	2026-04-24 00:01:36
582	App\\Models\\User	1	auth_token	b8cec45fe1a3144a51ebc2b3af82d7dba5dad460260e3f57b688563aeb52988b	["*"]	2026-04-23 20:03:23	\N	2026-04-23 20:01:21	2026-04-23 20:03:23
570	App\\Models\\User	1	auth_token	75b8613af7862fc71ca2d3d8c65a207d711cf7d53f975e6283d322953a30fd8b	["*"]	2026-04-23 13:52:08	\N	2026-04-23 13:47:37	2026-04-23 13:52:08
592	App\\Models\\User	8	auth_token	f11ec0ae71bff013051d5ea092c347e27d8b524c8eca353ae61f53c8dffec469	["*"]	2026-04-23 23:39:00	\N	2026-04-23 23:27:30	2026-04-23 23:39:00
591	App\\Models\\User	8	auth_token	5ee474dd187a5a0ac51a1b97bb486555f8b6d679305f2a6eadc6ed6432dbe821	["*"]	2026-04-23 21:09:15	\N	2026-04-23 21:07:15	2026-04-23 21:09:15
589	App\\Models\\User	8	auth_token	4aa49942fa9dd5d6f2dfd927192019ea0f43b98d6ccb75dfefbafad8ba1a3dc4	["*"]	2026-04-23 20:52:12	\N	2026-04-23 20:46:12	2026-04-23 20:52:12
590	App\\Models\\User	8	auth_token	6794ccaa6fc18d27f79e766a34c58a6c38e6bb478173019cde105c1d576a0d4d	["*"]	2026-04-23 21:03:02	\N	2026-04-23 20:59:02	2026-04-23 21:03:02
595	App\\Models\\User	8	auth_token	593428925c037c138e4bc8f26fd1ba8683eb86bf40d83edc4911203a705d12ec	["*"]	2026-04-24 00:08:07	\N	2026-04-24 00:05:06	2026-04-24 00:08:07
596	App\\Models\\User	8	auth_token	93bb7edd51b24e6cd8b735d9cb48d393f2ac6a5254340fd70eb5286ef98c7023	["*"]	2026-04-24 00:14:56	\N	2026-04-24 00:11:25	2026-04-24 00:14:56
599	App\\Models\\User	8	auth_token	65169408035a180a710916e03798a90c5c8efa384f36d3839d289a9a97604a6e	["*"]	2026-04-24 00:30:11	\N	2026-04-24 00:25:38	2026-04-24 00:30:11
598	App\\Models\\User	1	auth_token	458721f66749caf900ccdb1e897cef7682039a6930ec35867bf63f9d250459e9	["*"]	2026-04-24 00:25:11	\N	2026-04-24 00:19:28	2026-04-24 00:25:11
602	App\\Models\\User	8	auth_token	9735884172b4ce9c9f3d78894988c41c6247247e15ddfe946084be458e08aaf5	["*"]	2026-04-24 00:40:44	\N	2026-04-24 00:35:29	2026-04-24 00:40:44
618	App\\Models\\User	8	auth_token	21f852a2c75845c7689f68c579f033552215e441023e55be1e24eb36cc2e03e4	["*"]	2026-04-24 12:53:09	\N	2026-04-24 12:44:22	2026-04-24 12:53:09
603	App\\Models\\User	8	auth_token	5ff06805552b6140edd511103b32a8a2b7f44e15b753f466be551ab5f3a5c268	["*"]	2026-04-24 00:49:39	\N	2026-04-24 00:47:09	2026-04-24 00:49:39
631	App\\Models\\User	1	auth_token	bf3c77ab74c81e6e33a245adc52f436d8d7ec25bc5d97cd8c9aca4fe6c815e5b	["*"]	2026-04-24 14:06:18	\N	2026-04-24 14:05:47	2026-04-24 14:06:18
626	App\\Models\\User	8	auth_token	c8c7979762c460df1eceb614bc345d44dc2c7c0aa9fe525246be6a5247cd60a6	["*"]	2026-04-24 13:44:12	\N	2026-04-24 13:35:12	2026-04-24 13:44:12
619	App\\Models\\User	8	auth_token	7aec34f34e9caf714b3ab3e2b4c7e3bedbc1e8c490987331087d7cdedb4ba47c	["*"]	2026-04-24 12:56:18	\N	2026-04-24 12:56:05	2026-04-24 12:56:18
604	App\\Models\\User	8	auth_token	cf843e79ce92bfc3fe11256a6f1bbe263ce91c0ca8b80ec84157c1d8a426d5a4	["*"]	2026-04-24 00:55:03	\N	2026-04-24 00:53:03	2026-04-24 00:55:03
615	App\\Models\\User	8	auth_token	034ce5816d62679dcead91abe0a883ffedb53a0de3b7fc11cea438dcc9621dc4	["*"]	2026-04-24 12:38:28	\N	2026-04-24 12:33:28	2026-04-24 12:38:28
715	App\\Models\\User	5	auth_token	6df0ddaefbb201795e27babe6349d5d7a920e9ee1272e67a8976cf17a266459e	["*"]	2026-05-02 00:38:44	\N	2026-05-02 00:23:43	2026-05-02 00:38:44
620	App\\Models\\User	8	auth_token	bfc5c598c6f40d3c15386316f40aa103bb4aa99f1f97f181e46f337399e8836b	["*"]	2026-04-24 12:59:42	\N	2026-04-24 12:58:42	2026-04-24 12:59:42
606	App\\Models\\User	5	auth_token	460321d7325be98baa25b74d72d50710d6edab95f2cef58e402c379fe8526118	["*"]	2026-04-24 01:00:32	\N	2026-04-24 01:00:07	2026-04-24 01:00:32
622	App\\Models\\User	8	auth_token	920a111c7323f2b15cd018432125d9132a2e70360cb0ac1b9de2970b364d6b83	["*"]	2026-04-24 13:11:00	\N	2026-04-24 13:07:30	2026-04-24 13:11:00
642	App\\Models\\User	1	auth_token	3645c0a76370e9b0ae30416953510d908230a9dc85b4efe3d97ae4c0994b4683	["*"]	2026-04-24 15:34:58	\N	2026-04-24 15:33:09	2026-04-24 15:34:58
641	App\\Models\\User	1	auth_token	f8a06dbef782bd508ff09a9c62ac0f6c7c65e70da2460c5e4e515aa40da50a84	["*"]	2026-04-24 15:32:58	\N	2026-04-24 15:31:27	2026-04-24 15:32:58
624	App\\Models\\User	8	auth_token	6b8bf1bfd30ded124d83724914d444369a2858242a06a9346d96a9920771367a	["*"]	2026-04-24 13:23:46	\N	2026-04-24 13:19:45	2026-04-24 13:23:46
607	App\\Models\\User	8	auth_token	bdfd28ec47246cdbad4bf273cd3e0ad6f8662f08049fcb54d9dc375aff0bed0d	["*"]	2026-04-24 01:06:48	\N	2026-04-24 01:03:47	2026-04-24 01:06:48
612	App\\Models\\User	1	auth_token	b0577d508fc5a51373a8587f9afab7ac24a98340cfe14cb32b31014fb7868f60	["*"]	2026-04-24 12:23:41	\N	2026-04-24 12:21:40	2026-04-24 12:23:41
621	App\\Models\\User	8	auth_token	ac0a723434ca06ca6608149a3e104c24e3fa6487dcbe3fecfc8a8095f225824d	["*"]	2026-04-24 13:05:01	\N	2026-04-24 13:02:30	2026-04-24 13:05:01
614	App\\Models\\User	1	auth_token	12996006a98d39b8890d93f4d4903bc28b46984af48136bdc2f2a8ee57e55265	["*"]	2026-04-24 12:30:52	\N	2026-04-24 12:28:37	2026-04-24 12:30:52
634	App\\Models\\User	1	auth_token	124661f3befde49b0d85df1bd6c67af3766a8ebf9f58aad17ea11176f46d6010	["*"]	2026-04-24 14:15:48	\N	2026-04-24 14:14:48	2026-04-24 14:15:48
623	App\\Models\\User	8	auth_token	412e97c9156ed0d9827eeefe5c1b97189c36e685d8ccb81b362ee5628a908401	["*"]	2026-04-24 13:16:41	\N	2026-04-24 13:13:41	2026-04-24 13:16:41
608	App\\Models\\User	8	auth_token	52e78c583610b821372a1394cefd079f2cd0215800f2818be65f3c7d461a098d	["*"]	2026-04-24 01:32:10	\N	2026-04-24 01:10:38	2026-04-24 01:32:10
609	App\\Models\\User	1	auth_token	d7c0e8efb893ac80956d033920b9ec60ce6c08b0536b29af19597ceae1ee3131	["*"]	\N	\N	2026-04-24 09:49:53	2026-04-24 09:49:53
610	App\\Models\\User	1	auth_token	724dc283a2cdc2c1c1c998cd6fb175d348ab57219b235b13326b462890658b67	["*"]	\N	\N	2026-04-24 11:12:53	2026-04-24 11:12:53
611	App\\Models\\User	1	auth_token	d3cf2e24c57e8a0bb360ec75465a9e6d52b68d6f6c90438607f347543751914c	["*"]	\N	\N	2026-04-24 12:05:29	2026-04-24 12:05:29
617	App\\Models\\User	1	auth_token	648d9c18999ad30d4c50663ac4a7bb1e452d05a710c42ea4af7fde3e812f2d63	["*"]	2026-04-24 12:44:09	\N	2026-04-24 12:43:01	2026-04-24 12:44:09
630	App\\Models\\User	8	auth_token	3b5903c3dc0a3dbc342f78b64a114aace849501ec3bca070c0a007988d290efe	["*"]	2026-04-24 14:02:53	\N	2026-04-24 14:00:54	2026-04-24 14:02:53
625	App\\Models\\User	8	auth_token	75ef352d8edc0828db06a9a0f9238c77a15eae70b5d3b4a613d4aab4cb4b0b0e	["*"]	2026-04-24 13:32:35	\N	2026-04-24 13:29:04	2026-04-24 13:32:35
632	App\\Models\\User	8	auth_token	b404efd24b2b8b2e034b224e973dc7df3234cda0b2041f08036abee29d9e93a9	["*"]	2026-04-24 14:11:18	\N	2026-04-24 14:06:18	2026-04-24 14:11:18
627	App\\Models\\User	8	auth_token	b068346edace08308a118a12b6cae3fcd998a2127b672285e305610cce081ad1	["*"]	2026-04-24 13:54:46	\N	2026-04-24 13:48:46	2026-04-24 13:54:46
635	App\\Models\\User	8	auth_token	46297a245a88b93ed9efdb0e0334bc0edee61320dcc23cba26a26320b6f39b5c	["*"]	2026-04-24 14:18:53	\N	2026-04-24 14:18:22	2026-04-24 14:18:53
640	App\\Models\\User	5	auth_token	9ab2e12e144d03b2fb51cbd9f14120ede3a8db1e0d57f0318aa321b42cb684f6	["*"]	2026-04-24 15:23:01	\N	2026-04-24 15:21:42	2026-04-24 15:23:01
643	App\\Models\\User	1	auth_token	f44514975b37ff583a04b5c7f9cf796528310c05467e9e117b261d1237e945bd	["*"]	2026-04-24 15:41:02	\N	2026-04-24 15:38:01	2026-04-24 15:41:02
637	App\\Models\\User	1	auth_token	0379e0226925bb5dc470595becd21c6447510313c000931d1778725dc3c95ea0	["*"]	2026-04-24 15:10:25	\N	2026-04-24 15:04:29	2026-04-24 15:10:25
644	App\\Models\\User	1	auth_token	429565394e2077da5ef174efb34e62b33fd972fb79291635f3d383c38605c362	["*"]	2026-04-24 15:46:58	\N	2026-04-24 15:45:57	2026-04-24 15:46:58
638	App\\Models\\User	1	auth_token	a141af509fa82770c221719cced942263a3cccb46c5c52ce16596196c2a16d6f	["*"]	2026-04-24 15:16:01	\N	2026-04-24 15:13:00	2026-04-24 15:16:01
653	App\\Models\\User	1	auth_token	04142603c6a4cee407b25d851fcaf50075c76852525cf97407cfbfee7fee74bb	["*"]	2026-04-24 16:22:42	\N	2026-04-24 16:15:37	2026-04-24 16:22:42
646	App\\Models\\User	4	auth_token	b26e31f11b02dbdd85e7664fdb21a36daf377f09b984c2e11f145216aa58f905	["*"]	2026-04-24 15:54:58	\N	2026-04-24 15:53:23	2026-04-24 15:54:58
654	App\\Models\\User	5	auth_token	fd271e899fbda63e738b3662d2640d7a24f9d704a2b3727e2bf625ce71ebccae	["*"]	2026-04-24 16:17:24	\N	2026-04-24 16:16:24	2026-04-24 16:17:24
656	App\\Models\\User	5	auth_token	6256e7bada9051fc52d5d946f16eb542fabb8f1a0a0e8a21fed96004fcd7f33d	["*"]	2026-04-24 16:25:12	\N	2026-04-24 16:23:10	2026-04-24 16:25:12
657	App\\Models\\User	5	auth_token	f944e4e254472bd0cb3efc0d44d39a358c0de6b009212f2c8e2c8150acc53821	["*"]	2026-04-24 16:33:31	\N	2026-04-24 16:31:00	2026-04-24 16:33:31
655	App\\Models\\User	5	auth_token	86a42f12471ea59e332ef4c472e35412e51218e0c1370ad707621351e2b1b58c	["*"]	2026-04-24 16:25:26	\N	2026-04-24 16:18:55	2026-04-24 16:25:26
659	App\\Models\\User	1	auth_token	f15bf1d1805bc77ae58334d069933a16c0aa15d0bbb93e4277244dfc3c98033b	["*"]	2026-04-25 17:11:48	\N	2026-04-25 14:39:17	2026-04-25 17:11:48
658	App\\Models\\User	5	auth_token	2754992b23776bce017044a75a352c929b8dcc465c001331b783845191b2d99b	["*"]	2026-04-24 16:41:06	\N	2026-04-24 16:38:06	2026-04-24 16:41:06
687	App\\Models\\User	5	auth_token	2e78f6ec0e5b0e386576523e8a3d0efb337db622b23b25741b086b9d8d76cc39	["*"]	2026-05-01 00:13:17	\N	2026-05-01 00:10:46	2026-05-01 00:13:17
662	App\\Models\\User	1	auth_token	301d5a298141d79efaf7e81dce4e4f27d7e23b757a77ff2614fca772a39137cc	["*"]	2026-04-27 23:22:18	\N	2026-04-27 23:06:46	2026-04-27 23:22:18
673	App\\Models\\User	5	auth_token	5605f06161ccad004772f0e623f6b449ba699f482c2310a65ce890d4f385cf89	["*"]	2026-04-28 00:58:20	\N	2026-04-28 00:53:48	2026-04-28 00:58:20
685	App\\Models\\User	5	auth_token	3b17ab07da9f37edc9e3c580d4b8c84f2d55d821d6dbd531a5f9dd6e0d3cf1aa	["*"]	2026-04-30 23:58:49	\N	2026-04-30 23:54:48	2026-04-30 23:58:49
678	App\\Models\\User	1	auth_token	f81cdb43902b75d8e92ef0bae7744eac40bd23f8c8ff0106a909b1d4cfc72ce2	["*"]	2026-04-28 01:47:52	\N	2026-04-28 01:43:50	2026-04-28 01:47:52
669	App\\Models\\User	5	auth_token	0e294ed88026ad2590cb895cb9c2fc9588131f1e0ba8b593724ec3d73f08aaff	["*"]	2026-04-27 23:57:17	\N	2026-04-27 23:54:22	2026-04-27 23:57:17
699	App\\Models\\User	5	auth_token	9fe93eaa98cc960b74a56d3c045e693e1dd2bb4f397a6516f2c1db0f5d636fc3	["*"]	2026-05-01 12:40:14	\N	2026-05-01 12:40:10	2026-05-01 12:40:14
672	App\\Models\\User	5	test	016142ca1657c3e37cd12808865fba06eba1dc1560835caa6fe4a80484227b2b	["*"]	2026-04-28 00:22:04	\N	2026-04-28 00:22:03	2026-04-28 00:22:04
667	App\\Models\\User	5	auth_token	10980ce4cc469dbec4e3ca2fdb3b45b4649b3fa6bf93ac4dd7fc031f1ba8923e	["*"]	2026-04-27 23:48:35	\N	2026-04-27 23:45:04	2026-04-27 23:48:35
696	App\\Models\\User	5	auth_token	a8f0f89e3ab1a04872a90ce325293c04fdcb55724f21cd61b34843ce32b2cb50	["*"]	2026-05-01 01:51:12	\N	2026-05-01 01:42:39	2026-05-01 01:51:12
689	App\\Models\\User	5	auth_token	b50da83cceacdd0be19c0b7efa2eeaae537ead4928506b2768c8b475491901a6	["*"]	2026-05-01 00:40:29	\N	2026-05-01 00:35:57	2026-05-01 00:40:29
677	App\\Models\\User	1	auth_token	b801f96f72266bb9103cca496c7b1d89e46d2852963db7122bf2803b13be90a5	["*"]	2026-04-28 01:38:02	\N	2026-04-28 01:34:00	2026-04-28 01:38:02
695	App\\Models\\User	5	auth_token	ee17240da67a76e56294d2dd255439d3745c1bdaed1a74603b57daf863da1d95	["*"]	2026-05-01 01:39:00	\N	2026-05-01 01:30:29	2026-05-01 01:39:00
661	App\\Models\\User	5	auth_token	28bf43f2b5edf492009d44849d7feadc32c94f81e15896f6a9d8320ee6a75f6d	["*"]	2026-04-25 17:36:18	\N	2026-04-25 17:16:11	2026-04-25 17:36:18
704	App\\Models\\User	5	auth_token	2edf5a8f2e3f27e49f64cd04afe121c6815df393a3367b83056f3d5c94f630a7	["*"]	2026-05-01 13:32:11	\N	2026-05-01 13:22:40	2026-05-01 13:32:11
666	App\\Models\\User	5	auth_token	ab7b80a182ef9db54b76d6a4d519a1d84c25fc6b9ec9b42195708efdbb48bf6d	["*"]	2026-04-27 23:42:05	\N	2026-04-27 23:37:20	2026-04-27 23:42:05
697	App\\Models\\User	5	auth_token	3a9ff5f1962583c7a7f220fd39e74dc315fd6d484b12d973867d02fac92ffbd0	["*"]	2026-05-01 01:58:54	\N	2026-05-01 01:58:51	2026-05-01 01:58:54
693	App\\Models\\User	5	auth_token	870f25ffef59f3fa0f40843974439e7fbe90e69afdf2557ee0f5be06d5037cdf	["*"]	2026-05-01 01:19:00	\N	2026-05-01 01:14:59	2026-05-01 01:19:00
684	App\\Models\\User	5	auth_token	0d4aeaa9e86bd1d694f594ef4291d67667cc1cf74863681b9dafb942beb24413	["*"]	2026-04-30 23:44:32	\N	2026-04-30 23:38:29	2026-04-30 23:44:32
671	App\\Models\\User	5	auth_token	80c26864506ba832c4476b62f7e863c91990cf953525144f32092928fabc56bc	["*"]	2026-04-28 01:11:14	\N	2026-04-28 00:14:44	2026-04-28 01:11:14
668	App\\Models\\User	1	auth_token	549c015c9ee550530873c7c769a769c61a7d0b1a88e48bcd61474a7371e5d5a9	["*"]	2026-04-27 23:54:17	\N	2026-04-27 23:53:45	2026-04-27 23:54:17
688	App\\Models\\User	5	auth_token	7284a850e37a66f59af6f50d8afebcb4919f114f0f8afc59517acc12c425e7ab	["*"]	2026-05-01 00:30:20	\N	2026-05-01 00:16:19	2026-05-01 00:30:20
676	App\\Models\\User	1	auth_token	70f045889fb3eefa0059c812468d6c08a63ae80281eba71be78067e0eed71519	["*"]	2026-04-28 01:29:04	\N	2026-04-28 01:24:47	2026-04-28 01:29:04
686	App\\Models\\User	5	auth_token	954c4b70287083b49b91a5d963b84d1a2d6733a706b529a3f4b692fa5ed0eb7b	["*"]	2026-05-01 00:06:56	\N	2026-05-01 00:01:55	2026-05-01 00:06:56
681	App\\Models\\User	1	auth_token	6a4dfd344ecfa0c489d0690c7524deb6631fbfdccca34e8c9be6e1faa117ac4c	["*"]	2026-04-28 10:04:30	\N	2026-04-28 10:01:59	2026-04-28 10:04:30
679	App\\Models\\User	1	auth_token	6eafe03ff0cedcb76aa7aa31c5ead79bfc3b01ae2896b6773d6080ca2546407b	["*"]	2026-04-28 02:18:40	\N	2026-04-28 01:52:38	2026-04-28 02:18:40
674	App\\Models\\User	5	auth_token	64a1de4e272f4145008d534e17a0dab749ed59474df4a34a10f9d953dc8186ce	["*"]	2026-04-28 01:15:15	\N	2026-04-28 01:01:44	2026-04-28 01:15:15
680	App\\Models\\User	1	auth_token	3c58cb8e4ce546820e9808bf8f3131203f70ca099d2550d7e2c24f2aeb70cdae	["*"]	2026-04-28 02:41:50	\N	2026-04-28 02:32:18	2026-04-28 02:41:50
691	App\\Models\\User	5	auth_token	9d53bf3822b50d480aab74402243e8e88367937bf2e5034f19337f9b8d70d579	["*"]	2026-05-01 00:59:49	\N	2026-05-01 00:55:17	2026-05-01 00:59:49
694	App\\Models\\User	5	auth_token	54fb691e5686dd0ff617a9a7437fe0887c3b75fe3184d24b27fe76265b13959d	["*"]	2026-05-01 01:27:13	\N	2026-05-01 01:22:11	2026-05-01 01:27:13
683	App\\Models\\User	1	auth_token	32f8a19a2d5d4dbbdc8de9e3147f8a1dcda45e78677b53d7c6ce13a70f9617de	["*"]	2026-04-28 11:06:30	\N	2026-04-28 10:05:53	2026-04-28 11:06:30
692	App\\Models\\User	5	auth_token	bcec463eae0bf27bb93c235ba726dbb178defa1cb8c24423e4c4514f33d54bde	["*"]	2026-05-01 01:11:17	\N	2026-05-01 01:03:46	2026-05-01 01:11:17
690	App\\Models\\User	5	auth_token	b63f45f14180ad1bad5f8f7ceae26df49f9720699479a153f221133fd792b382	["*"]	2026-05-01 00:51:50	\N	2026-05-01 00:45:49	2026-05-01 00:51:50
701	App\\Models\\User	5	auth_token	7588c74230e2dd0e85489f575264d47de7262096894fbacd74824d032449a28a	["*"]	2026-05-01 12:56:47	\N	2026-05-01 12:48:46	2026-05-01 12:56:47
698	App\\Models\\User	5	auth_token	3da00c19a442cbd571b4b03482b10a3a327c2d5ac10628a729d642d7e9caf888	["*"]	2026-05-01 12:34:26	\N	2026-05-01 12:33:55	2026-05-01 12:34:26
703	App\\Models\\User	5	auth_token	f657dd63549b04be82728d371df681aacb6dc2246bb356e3e6ca3ade990f1c99	["*"]	2026-05-01 13:19:26	\N	2026-05-01 13:07:55	2026-05-01 13:19:26
700	App\\Models\\User	5	auth_token	88e65f3f637439db978b2f2154e01594e4deb7f4813456700d197c19ee779600	["*"]	2026-05-01 12:45:41	\N	2026-05-01 12:40:12	2026-05-01 12:45:41
702	App\\Models\\User	5	auth_token	35a23b2cefc17b0d1966ba390c3563be3107e9a12220fceb24e5c062d89af8f0	["*"]	2026-05-01 13:03:37	\N	2026-05-01 12:59:35	2026-05-01 13:03:37
706	App\\Models\\User	5	auth_token	c5c2da0ea0745e1410a421f76a6c98bbfcd2351da894a0ea9e53130e35cf64cf	["*"]	2026-05-01 13:54:31	\N	2026-05-01 13:50:59	2026-05-01 13:54:31
705	App\\Models\\User	5	auth_token	6839f03fe00e207ee84154f1a2adf5b3948b3d6522c5906bb241fcdea781971b	["*"]	2026-05-01 13:47:12	\N	2026-05-01 13:36:11	2026-05-01 13:47:12
707	App\\Models\\User	5	auth_token	bbcff3374405f4e1051fd648e21839aa535753c08418fb846dce277bbdf4ac1a	["*"]	2026-05-01 14:02:55	\N	2026-05-01 13:58:23	2026-05-01 14:02:55
709	App\\Models\\User	5	auth_token	0b3e3841bc6aa728e055949181fd0957e78ad4b6afe5b3d18275f786ecbf9134	["*"]	2026-05-01 14:29:46	\N	2026-05-01 14:19:15	2026-05-01 14:29:46
708	App\\Models\\User	5	auth_token	92dd4730498e11a0b7ec676ecba5e6421d2cd9c36c88f69f14587f456c57869c	["*"]	2026-05-01 14:14:20	\N	2026-05-01 14:05:48	2026-05-01 14:14:20
757	App\\Models\\User	1	auth_token	6634cb168ae26377482a9062fd4abc49ff862cafbcb853f964c668804bc7b44f	["*"]	2026-05-03 22:46:39	\N	2026-05-03 22:45:09	2026-05-03 22:46:39
750	App\\Models\\User	1	auth_token	fb46d554d25ac13b75dc2f095caffb9d44bd1b68350855a3118f6fdf6c747be4	["*"]	2026-05-03 22:19:31	\N	2026-05-03 22:15:14	2026-05-03 22:19:31
734	App\\Models\\User	4	auth_token	377fb5c0b081292aee4e08662da1b31b92dadc30a6c426b0e821589d47d403a1	["*"]	2026-05-03 18:37:07	\N	2026-05-03 18:30:06	2026-05-03 18:37:07
712	App\\Models\\User	5	auth_token	1ab741a5e01c6036da4aad4ca331ab6425e96d5a26cd60210a84effd63134149	["*"]	2026-05-01 14:54:32	\N	2026-05-01 14:48:30	2026-05-01 14:54:32
738	App\\Models\\User	1	auth_token	6ae17f60457133aa743eb23939eec89556714d31cc5998072ad2fa1805e5476b	["*"]	2026-05-03 19:07:43	\N	2026-05-03 19:06:43	2026-05-03 19:07:43
730	App\\Models\\User	1	auth_token	c676f1c7cb3e48d254f1ba2298914187282e589ce3a9146c7d97c8243f078f9c	["*"]	2026-05-03 18:10:44	\N	2026-05-03 18:05:57	2026-05-03 18:10:44
710	App\\Models\\User	5	auth_token	05174e3fd07e0070701198c7c018f8a58bc063bde5d55300e7690d0cc4c8cddd	["*"]	2026-05-01 14:37:14	\N	2026-05-01 14:32:42	2026-05-01 14:37:14
716	App\\Models\\User	5	auth_token	8664e28926738398434ea1964c962eb8ffff5aab3fe5fe9126d6f6717a1b89e3	["*"]	2026-05-02 00:47:06	\N	2026-05-02 00:44:04	2026-05-02 00:47:06
743	App\\Models\\User	7	auth_token	db3ba2f33380dfa24d66a925d4b5f52842b98431987c62f538a3882c6c638ec1	["*"]	2026-05-03 20:49:35	\N	2026-05-03 20:23:34	2026-05-03 20:49:35
754	App\\Models\\User	8	auth_token	fb78fced5e742508ce85c5eef05f46bcf0fe5f25fa7902ad5bcbdc68ed9ca668	["*"]	2026-05-03 22:38:12	\N	2026-05-03 22:24:56	2026-05-03 22:38:12
741	App\\Models\\User	7	auth_token	29027af432f418730240043cc961868d5479e15b2c2a67d8d0d68ca96f4c0ce4	["*"]	2026-05-03 20:04:28	\N	2026-05-03 19:46:27	2026-05-03 20:04:28
721	App\\Models\\User	1	auth_token	17e6186168fb6b63007dc44346c7dbe91e3d1194d4ca1b5e8b9fc10d496b1b9b	["*"]	2026-05-02 11:36:16	\N	2026-05-02 11:30:39	2026-05-02 11:36:16
719	App\\Models\\User	5	auth_token	c0fd8626256a570285dc74ef78e00984a740bbc037d3d1ac8b826714a2f44821	["*"]	2026-05-02 01:15:18	\N	2026-05-02 01:10:16	2026-05-02 01:15:18
711	App\\Models\\User	5	auth_token	6c76d30bf3d1176cec54ba0ad06f01ee1335bbafca20129c374fb2b97248adf7	["*"]	2026-05-01 14:45:24	\N	2026-05-01 14:40:22	2026-05-01 14:45:24
736	App\\Models\\User	4	auth_token	f0eab0603baeaf9860f3e6d88ea31f57c9aa4470e4702260f556a8363b6288f1	["*"]	2026-05-03 19:01:05	\N	2026-05-03 18:45:19	2026-05-03 19:01:05
732	App\\Models\\User	4	auth_token	21db067f122d57db65de0612dd5220e953f6bb9c2a49e14fe53f5d86b9ed2962	["*"]	2026-05-03 18:25:18	\N	2026-05-03 18:14:31	2026-05-03 18:25:18
740	App\\Models\\User	1	auth_token	da9e9ae2d27780a0aa628d16e0d303958a56f4029172edd954af469123daff46	["*"]	2026-05-03 19:44:10	\N	2026-05-03 19:26:38	2026-05-03 19:44:10
727	App\\Models\\User	1	auth_token	34f486634857f2254d3d24f576a4aa9a845d84f2864323c41802a1df1e8264c0	["*"]	2026-05-03 17:58:45	\N	2026-05-03 17:54:58	2026-05-03 17:58:45
748	App\\Models\\User	1	auth_token	9f6fd67dcfb1d30acb7e3ac0fcad04b9e35ac78887e6a95f8b8af2e94f88cc98	["*"]	2026-05-03 22:14:01	\N	2026-05-03 22:12:30	2026-05-03 22:14:01
744	App\\Models\\User	1	auth_token	1d1e29022ec28406526ee97a73ddd603434a0e9a5a93324885d8f27ca840f788	["*"]	2026-05-03 21:42:34	\N	2026-05-03 21:36:18	2026-05-03 21:42:34
725	App\\Models\\User	5	auth_token	fa0a78aa368a0391bb60d66fd97e0d77c50545514ce2cf66d51cf9836c339594	["*"]	2026-05-03 17:49:42	\N	2026-05-03 17:36:11	2026-05-03 17:49:42
742	App\\Models\\User	7	auth_token	bda10d7bd631fbecf7aec62ba06d28e1dbaf126f6ae33da27538a3fb6754d9bd	["*"]	2026-05-03 20:20:41	\N	2026-05-03 20:07:25	2026-05-03 20:20:41
723	App\\Models\\User	5	auth_token	4547fdec57ccbcc7692f598fd0b9a9ae97a4ece2a300941a1211489042d8ef06	["*"]	2026-05-03 17:18:17	\N	2026-05-03 17:10:44	2026-05-03 17:18:17
745	App\\Models\\User	1	auth_token	6980e3300af044218916583cd0ffde44c71f7ebc6da1c5ded7b08554610867a6	["*"]	2026-05-03 21:55:54	\N	2026-05-03 21:46:07	2026-05-03 21:55:54
753	App\\Models\\User	1	auth_token	8f8f21c22ad6769b0633f73ed43d6e093f985caa7df3ba592737739af120d4ce	["*"]	2026-05-03 22:24:49	\N	2026-05-03 22:24:19	2026-05-03 22:24:49
767	App\\Models\\User	1	auth_token	96c2483c8da4246c92a262c5e09bdd58f358f61a581c464a651bef6e4d651e89	["*"]	2026-05-04 00:28:02	\N	2026-05-04 00:26:46	2026-05-04 00:28:02
764	App\\Models\\User	1	auth_token	34c65c0c6b0470e87c10255d59f83cf58ebbb469a7fee2a55f88883f734fd540	["*"]	2026-05-04 00:10:50	\N	2026-05-04 00:00:18	2026-05-04 00:10:50
746	App\\Models\\User	1	auth_token	9de8b8d8ca3ba40cd3baa2a7a1c161bf808d354ad335a28d7d4929ac7f91468b	["*"]	2026-05-03 22:03:12	\N	2026-05-03 22:00:55	2026-05-03 22:03:12
755	App\\Models\\User	1	auth_token	9219d6e70a7d4d01fd377173d077f7f7995886fb6d53abf18a8c18c56340e058	["*"]	2026-05-03 22:43:48	\N	2026-05-03 22:43:01	2026-05-03 22:43:48
747	App\\Models\\User	1	auth_token	71ca86353fd57fa365bf008a97de6ed08d1158e470a86ed85d7c4332eff0168e	["*"]	2026-05-03 22:10:19	\N	2026-05-03 22:05:33	2026-05-03 22:10:19
761	App\\Models\\User	1	auth_token	56a5b8e09f8f312a1402be9118e96e227b15dc01e85d707e35110bfe17094fd5	["*"]	2026-05-03 23:36:50	\N	2026-05-03 23:27:04	2026-05-03 23:36:50
751	App\\Models\\User	1	auth_token	ce86cc57d105a859d8f717da96f9a52053cce8c46b5fb09e2e88e4a6ab70fe2f	["*"]	2026-05-03 22:23:19	\N	2026-05-03 22:19:34	2026-05-03 22:23:19
765	App\\Models\\User	1	auth_token	f06e2611bf2f48388231c8b4995ea0c207a5b3fb057f16e23456255cdb60c491	["*"]	2026-05-04 00:18:40	\N	2026-05-04 00:13:24	2026-05-04 00:18:40
763	App\\Models\\User	1	auth_token	6e0b545164dd0cd4e2fc29be20960be517c9ccbee187a609be6a87eb2983b7b6	["*"]	2026-05-03 23:58:00	\N	2026-05-03 23:49:11	2026-05-03 23:58:00
762	App\\Models\\User	1	auth_token	749befc9b0ce5fba16a64e5c21deb11ee8bea4f033b08a4f9628fc1ac6a100d7	["*"]	2026-05-03 23:45:45	\N	2026-05-03 23:39:43	2026-05-03 23:45:45
760	App\\Models\\User	1	auth_token	224d97093b41224ab9789b9871a06cacc13cc12922a35e8b7aafbd16fb0f8e0c	["*"]	2026-05-03 23:09:56	\N	2026-05-03 22:49:26	2026-05-03 23:09:56
766	App\\Models\\User	5	auth_token	9d0fabab831f3e322d934130326c875a0ea24b71b37a4db033b1e0be1838bac7	["*"]	2026-05-04 00:24:12	\N	2026-05-04 00:18:41	2026-05-04 00:24:12
769	App\\Models\\User	1	auth_token	25dbcd331deb08a655cd75f87bcc7b59c77d7d044a74d43464b3d33be018aea7	["*"]	2026-05-04 00:30:42	\N	2026-05-04 00:29:26	2026-05-04 00:30:42
771	App\\Models\\User	1	auth_token	7d71feac4cb08a9d2e6e3a9ecc4fae01d45437e48652bd0e6acb4c30cfa1d311	["*"]	2026-05-04 00:37:23	\N	2026-05-04 00:32:08	2026-05-04 00:37:23
772	App\\Models\\User	1	auth_token	7770cd22bc92c59a80bc19f440429c9ad171a06f506e2fe1c8e6f5555b5497b6	["*"]	2026-05-04 01:10:02	\N	2026-05-04 00:40:01	2026-05-04 01:10:02
773	App\\Models\\User	1	auth_token	2195b091c46358b6c91af7c8d9ceeb0b63abf03d7ba77f6c6cd54418e6dd1328	["*"]	2026-05-04 01:17:39	\N	2026-05-04 01:12:37	2026-05-04 01:17:39
774	App\\Models\\User	1	auth_token	099e12453b1a0e12fb26ed6373ea5db66b62f5a24d0ed5813cf2b9246a93ce97	["*"]	2026-05-04 01:20:56	\N	2026-05-04 01:19:54	2026-05-04 01:20:56
775	App\\Models\\User	1	auth_token	bca7236eb1b4dc7c5427b06ae677fa9d2ffc54f38c8d9385908aa987277983fb	["*"]	2026-05-04 01:27:53	\N	2026-05-04 01:23:06	2026-05-04 01:27:53
794	App\\Models\\User	1	auth_token	331a98c9a5da989a9b0a7f3408818c507325e29f26de4f6b7c91ebbf361b68bf	["*"]	2026-05-05 02:30:47	\N	2026-05-05 02:19:16	2026-05-05 02:30:47
779	App\\Models\\User	1	auth_token	e5903217abeb33ad1c0a257751fa0fe5bc694b2ca008301baf8f881e31338877	["*"]	2026-05-04 17:58:55	\N	2026-05-04 17:54:52	2026-05-04 17:58:55
778	App\\Models\\User	1	auth_token	fed8a3559be4b623deeb878996f8e52aa3390ba809dfc74709a95efcde5f7089	["*"]	2026-05-04 03:06:06	\N	2026-05-04 02:38:34	2026-05-04 03:06:06
793	App\\Models\\User	1	auth_token	cbca70b77f98fc92a68d02cdfd7ba6a84457c40f307cdbd37451e530eb941d8c	["*"]	2026-05-05 02:15:18	\N	2026-05-05 02:05:48	2026-05-05 02:15:18
781	App\\Models\\User	1	auth_token	0edfb664e2f9fca49d5f2147380a87bb3333a4a281df9bd1f01684628d1ce5e6	["*"]	2026-05-05 01:14:11	\N	2026-05-05 01:06:39	2026-05-05 01:14:11
776	App\\Models\\User	1	auth_token	192d8c63ef68938fef8eadbc6af028cd735d957e97d112bbd6279485618c9b10	["*"]	2026-05-04 03:07:07	\N	2026-05-04 01:31:38	2026-05-04 03:07:07
777	App\\Models\\User	1	auth_token	df63fc0c098fed4fd8f63c6b239ba3ae101fb2e319a2e575b8ee31fdcd98a834	["*"]	2026-05-04 02:35:13	\N	2026-05-04 02:20:57	2026-05-04 02:35:13
790	App\\Models\\User	1	auth_token	5d52b529cd9c1362dc36b5160b901d2c5886b96b9e96d7590bd31ef5ac438b59	["*"]	2026-05-05 01:55:17	\N	2026-05-05 01:52:14	2026-05-05 01:55:17
795	App\\Models\\User	1	auth_token	c54879c47260ee7e3ec366472ce8941c0429753f41b9b06ad73659ef195fe760	["*"]	2026-05-05 02:34:37	\N	2026-05-05 02:33:51	2026-05-05 02:34:37
789	App\\Models\\User	1	auth_token	f50cdf86705b62396abe7990612b2ff103fd7fdb8adc4f46e80bb4df4147d147	["*"]	2026-05-05 01:52:03	\N	2026-05-05 01:50:49	2026-05-05 01:52:03
780	App\\Models\\User	1	auth_token	b56ab2b666e45145b377d00237a61b61a4d76fa9b2da0adc5ea2318a69b53653	["*"]	2026-06-04 20:53:13	\N	2026-05-04 20:37:21	2026-06-04 20:53:13
791	App\\Models\\User	1	auth_token	2566ec2bb6f902776db70d7d2088e7e894c11e2949e552c020c39afd69ffe841	["*"]	2026-05-05 02:04:48	\N	2026-05-05 01:55:23	2026-05-05 02:04:48
798	App\\Models\\User	4	auth_token	16bf14de4d788c40cdbbdf5f61da4a0f44c0da67a4e13350b891765db004a626	["*"]	2026-05-05 05:44:22	\N	2026-05-05 02:55:36	2026-05-05 05:44:22
\.


--
-- Data for Name: professionnels; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.professionnels (id, user_id, date_naissance, lieu_naissance, diplome, annees_experience, specialites, statut_validation, created_at, updated_at, fonction) FROM stdin;
2	5	2000-01-20	\N	\N	3	["Cuisine traditionnelle","Cuisine di\\u00e9t\\u00e9tique","Textures modifi\\u00e9es","P\\u00e2tisserie","Boulangerie"]	valide	2026-02-27 10:14:02	2026-03-03 14:24:00	\N
3	6	2001-01-14	\N	\N	3	["Cuisine traditionnelle","Cuisine di\\u00e9t\\u00e9tique"]	valide	2026-03-02 10:09:26	2026-03-03 14:24:14	Aide cuisinier
5	10	2000-01-07	\N	\N	3	["traditional_cuisine","dietary_cuisine"]	valide	2026-05-05 01:49:51	2026-05-05 01:52:55	kitchen_commis
\.


--
-- Data for Name: recettes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.recettes (id, nom, type, description, ingredients, temps_preparation, created_by, regimes, textures, created_at, updated_at, meal_types, nb_regimes_haches, nb_regimes_mixes, nb_regimes_moulines) FROM stdin;
1	Velouté de Potiron et Châtaignes	entree	Un classique d'automne, onctueux et réconfortant.	[{"nom":"Potiron, Ch\\u00e2taignes, Cr\\u00e8me fra\\u00eeche, Oignon, Bouillon de l\\u00e9gumes.","quantite":1,"prix":0}]	45 min	\N	["V\\u00e9g\\u00e9tarien","Sans gluten","Diab\\u00e9tique"]	["Mix\\u00e9","Moulin\\u00e9"]	2026-02-25 14:04:39	2026-02-25 14:04:39	\N	0	0	0
2	Salade de Betteraves au Chèvre Frais	entree	Fraîcheur des betteraves et douceur du fromage.	[{"nom":"Betteraves, Fromage de ch\\u00e8vre, Noix, Vinaigrette.","quantite":1,"prix":0}]	15 min	\N	["V\\u00e9g\\u00e9tarien","Sans gluten"]	["Hach\\u00e9","Normal"]	2026-02-25 14:04:39	2026-02-25 14:04:39	\N	0	0	0
3	Œufs Cocotte à la Crème	entree	Œufs cuits au four avec de la crème et de la ciboulette.	[{"nom":"\\u0152ufs, Cr\\u00e8me liquide, Ciboulette, Sel, Poivre.","quantite":1,"prix":0}]	10 min	\N	["V\\u00e9g\\u00e9tarien","Sans gluten"]	["Normal"]	2026-02-25 14:04:39	2026-02-25 14:04:39	\N	0	0	0
4	Blanquette de Veau à l'ancienne	plat	Veau mijoté dans une sauce blanche crémeuse avec carottes et champignons.	[{"nom":"\\u00c9paule de veau, Carottes, Poireaux, Champignons, Cr\\u00e8me, \\u0152uf.","quantite":1,"prix":0}]	1h 30 min	\N	["Standard"]	["Normal","Hach\\u00e9"]	2026-02-25 14:04:39	2026-02-25 14:04:39	\N	0	0	0
25	boratin	entree	Il faut mettre des oeufs plus des oignons et du riz	[{"nom":"3 oeufs,5 kilos oignons,7kilo riz","quantite":"1","prix":0}]	60 min	\N	["Standard","Sans sel","Diab\\u00e9tique"]	["Normal","Mix\\u00e9"]	2026-03-26 12:47:27	2026-04-17 13:22:58	\N	0	0	0
5	Filet de Cabillaud Vapeur	plat	Poisson blanc léger cuit à la vapeur.	[{"nom":"Cabillaud, Citron, Huile d'olive.","quantite":1,"prix":0}]	20 min	\N	["Sans sel","L\\u00e9ger","Diab\\u00e9tique"]	["Normal","Hach\\u00e9","Mix\\u00e9"]	2026-02-25 14:04:39	2026-02-25 14:04:39	\N	0	0	0
6	Poulet Rôti aux Herbes de Provence	plat	Poulet juteux parfumé aux herbes.	[{"nom":"Poulet, Romarin, Thym, Ail, Huile d'olive.","quantite":1,"prix":0}]	1h 15 min	\N	["Standard","Sans gluten"]	["Normal","Hach\\u00e9"]	2026-02-25 14:04:39	2026-02-25 14:04:39	\N	0	0	0
7	Purée de Pommes de Terre Mousseline	accompagnement	Purée de pommes de terre onctueuse et sans grumeaux.	[{"nom":"Pommes de terre, Lait, Beurre, Sel.","quantite":1,"prix":0}]	30 min	\N	["V\\u00e9g\\u00e9tarien","Sans gluten"]	["Moulin\\u00e9","Mix\\u00e9"]	2026-02-25 14:04:39	2026-02-25 14:04:39	\N	0	0	0
8	Riz de Camargue à la Vapeur	accompagnement	Riz blanc parfaitement cuit.	[{"nom":"Riz, Eau, Sel.","quantite":1,"prix":0}]	15 min	\N	["V\\u00e9g\\u00e9talien","Sans gluten","Sans sel"]	["Normal","Mix\\u00e9"]	2026-02-25 14:04:39	2026-02-25 14:04:39	\N	0	0	0
9	Gratin Dauphinois traditionnel	accompagnement	Pommes de terre fondantes à la crème.	[{"nom":"Pommes de terre, Cr\\u00e8me, Lait, Ail, Muscade.","quantite":1,"prix":0}]	1h 00 min	\N	["V\\u00e9g\\u00e9tarien","Sans gluten"]	["Normal","Moulin\\u00e9"]	2026-02-25 14:04:39	2026-02-25 14:04:39	\N	0	0	0
10	Mousse au Chocolat Légère	dessert	Dessert aérien au chocolat noir 70%.	[{"nom":"Chocolat noir, \\u0152ufs, une pinc\\u00e9e de sel.","quantite":1,"prix":0}]	20 min (+ 4h repos)	\N	["Standard","V\\u00e9g\\u00e9tarien"]	["Mix\\u00e9"]	2026-02-25 14:04:39	2026-02-25 14:04:39	\N	0	0	0
11	Compote de Pommes et Vanille	dessert	Pommes fondantes parfumées à la vanille Bourbon.	[{"nom":"Pommes, Sucre vanill\\u00e9, B\\u00e2ton de vanille.","quantite":1,"prix":0}]	25 min	\N	["Sans sel","V\\u00e9g\\u00e9talien","Sans gluten"]	["Mix\\u00e9","Moulin\\u00e9"]	2026-02-25 14:04:39	2026-02-25 14:04:39	\N	0	0	0
12	Île Flottante Onctueuse	dessert	Blancs d'œufs en neige sur crème anglaise.	[{"nom":"\\u0152ufs, Lait, Sucre, Vanille.","quantite":1,"prix":0}]	30 min	\N	["V\\u00e9g\\u00e9tarien","Sans gluten"]	["Normal","Mix\\u00e9"]	2026-02-25 14:04:39	2026-02-25 14:04:39	\N	0	0	0
13	Velouté de Potiron et Châtaignes	entree	Un classique d'automne, onctueux et réconfortant.	[{"nom":"Potiron, Ch\\u00e2taignes, Cr\\u00e8me fra\\u00eeche, Oignon, Bouillon de l\\u00e9gumes.","quantite":1,"prix":0}]	45 min	\N	["V\\u00e9g\\u00e9tarien","Sans gluten","Diab\\u00e9tique"]	["Mix\\u00e9","Moulin\\u00e9"]	2026-02-25 14:26:59	2026-02-25 14:26:59	\N	0	0	0
14	Salade de Betteraves au Chèvre Frais	entree	Fraîcheur des betteraves et douceur du fromage.	[{"nom":"Betteraves, Fromage de ch\\u00e8vre, Noix, Vinaigrette.","quantite":1,"prix":0}]	15 min	\N	["V\\u00e9g\\u00e9tarien","Sans gluten"]	["Hach\\u00e9","Normal"]	2026-02-25 14:26:59	2026-02-25 14:26:59	\N	0	0	0
15	Œufs Cocotte à la Crème	entree	Œufs cuits au four avec de la crème et de la ciboulette.	[{"nom":"\\u0152ufs, Cr\\u00e8me liquide, Ciboulette, Sel, Poivre.","quantite":1,"prix":0}]	10 min	\N	["V\\u00e9g\\u00e9tarien","Sans gluten"]	["Normal"]	2026-02-25 14:26:59	2026-02-25 14:26:59	\N	0	0	0
16	Blanquette de Veau à l'ancienne	plat	Veau mijoté dans une sauce blanche crémeuse avec carottes et champignons.	[{"nom":"\\u00c9paule de veau, Carottes, Poireaux, Champignons, Cr\\u00e8me, \\u0152uf.","quantite":1,"prix":0}]	1h 30 min	\N	["Standard"]	["Normal","Hach\\u00e9"]	2026-02-25 14:26:59	2026-02-25 14:26:59	\N	0	0	0
17	Filet de Cabillaud Vapeur	plat	Poisson blanc léger cuit à la vapeur.	[{"nom":"Cabillaud, Citron, Huile d'olive.","quantite":1,"prix":0}]	20 min	\N	["Sans sel","L\\u00e9ger","Diab\\u00e9tique"]	["Normal","Hach\\u00e9","Mix\\u00e9"]	2026-02-25 14:26:59	2026-02-25 14:26:59	\N	0	0	0
18	Poulet Rôti aux Herbes de Provence	plat	Poulet juteux parfumé aux herbes.	[{"nom":"Poulet, Romarin, Thym, Ail, Huile d'olive.","quantite":1,"prix":0}]	1h 15 min	\N	["Standard","Sans gluten"]	["Normal","Hach\\u00e9"]	2026-02-25 14:26:59	2026-02-25 14:26:59	\N	0	0	0
19	Purée de Pommes de Terre Mousseline	accompagnement	Purée de pommes de terre onctueuse et sans grumeaux.	[{"nom":"Pommes de terre, Lait, Beurre, Sel.","quantite":1,"prix":0}]	30 min	\N	["V\\u00e9g\\u00e9tarien","Sans gluten"]	["Moulin\\u00e9","Mix\\u00e9"]	2026-02-25 14:26:59	2026-02-25 14:26:59	\N	0	0	0
20	Riz de Camargue à la Vapeur	accompagnement	Riz blanc parfaitement cuit.	[{"nom":"Riz, Eau, Sel.","quantite":1,"prix":0}]	15 min	\N	["V\\u00e9g\\u00e9talien","Sans gluten","Sans sel"]	["Normal","Mix\\u00e9"]	2026-02-25 14:26:59	2026-02-25 14:26:59	\N	0	0	0
21	Gratin Dauphinois traditionnel	accompagnement	Pommes de terre fondantes à la crème.	[{"nom":"Pommes de terre, Cr\\u00e8me, Lait, Ail, Muscade.","quantite":1,"prix":0}]	1h 00 min	\N	["V\\u00e9g\\u00e9tarien","Sans gluten"]	["Normal","Moulin\\u00e9"]	2026-02-25 14:26:59	2026-02-25 14:26:59	\N	0	0	0
22	Mousse au Chocolat Légère	dessert	Dessert aérien au chocolat noir 70%.	[{"nom":"Chocolat noir, \\u0152ufs, une pinc\\u00e9e de sel.","quantite":1,"prix":0}]	20 min (+ 4h repos)	\N	["Standard","V\\u00e9g\\u00e9tarien"]	["Mix\\u00e9"]	2026-02-25 14:26:59	2026-02-25 14:26:59	\N	0	0	0
23	Compote de Pommes et Vanille	dessert	Pommes fondantes parfumées à la vanille Bourbon.	[{"nom":"Pommes, Sucre vanill\\u00e9, B\\u00e2ton de vanille.","quantite":1,"prix":0}]	25 min	\N	["Sans sel","V\\u00e9g\\u00e9talien","Sans gluten"]	["Mix\\u00e9","Moulin\\u00e9"]	2026-02-25 14:26:59	2026-02-25 14:26:59	\N	0	0	0
26	Filet au ratin	plat	On melange des filets avec des mais doux plus de l'olive	[{"nom":"filets","quantite":50,"prix":2},{"nom":"mais","quantite":25,"prix":1},{"nom":"olive","quantite":9,"prix":1}]	150	\N	["Diab\\u00e9tique","Standard","Sans gluten"]	["Normal","Hach\\u00e9"]	2026-03-26 13:31:06	2026-03-26 13:31:06	\N	0	0	0
28	Cota Chipenda	accompagnement	Melange de salade,arricots blanc	[]	40 min	\N	["Standard","Sans sel"]	["Normal","Hach\\u00e9"]	2026-04-17 13:27:38	2026-04-20 12:59:48	[]	1	1	1
29	yassa	plat	Melage du poulet et oignons et a coté du riz	[{"nom":"poulet","quantite":"1","prix":250}]	30 min	\N	["Diab\\u00e9tique"]	["Normal"]	2026-04-20 13:10:17	2026-04-20 13:10:17	[]	10	10	1
\.


--
-- Data for Name: retours; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.retours (id, mission_id, note, commentaire, "heureDebutEffectif", "heureFinEffectif", created_at, updated_at) FROM stdin;
1	31	5	Un peu desagreable	\N	\N	2026-04-20 15:42:07	2026-04-20 15:42:07
2	31	5	Un peu desagreable	\N	\N	2026-04-20 15:42:07	2026-04-20 15:42:07
3	34	5	La mission s'es deroule correctement	\N	\N	2026-04-23 10:53:30	2026-04-23 10:53:30
4	34	5	La mission s'es deroule correctement	\N	\N	2026-04-23 10:53:30	2026-04-23 10:53:30
5	34	4	j suis satisfait	\N	\N	2026-04-23 23:44:27	2026-04-23 23:44:27
6	34	4	j suis satisfait	\N	\N	2026-04-23 23:44:27	2026-04-23 23:44:27
7	34	3	j'adore	\N	\N	2026-04-24 00:11:43	2026-04-24 00:11:43
8	34	3	j'adore	\N	\N	2026-04-24 00:11:43	2026-04-24 00:11:43
9	34	3	j'ai aime	\N	\N	2026-04-24 12:41:53	2026-04-24 12:41:53
\.


--
-- Data for Name: sessions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sessions (id, user_id, ip_address, user_agent, payload, last_activity) FROM stdin;
\.


--
-- Data for Name: structures; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.structures (id, user_id, nom_etablissement, type_etablissement, capacite, fonction, created_at, updated_at, statut_validation, telephone_etablissement, adresse, code_postal, ville) FROM stdin;
1	2	Clinique du Golf	Clinique	50	Directeur	2026-02-25 14:25:35	2026-03-03 14:34:33	valide	\N	\N	\N	\N
2	4	Hopital Felip Senghor	Hôpital	180	Directrice AG	2026-02-25 14:57:55	2026-03-03 14:35:09	valide	\N	\N	\N	\N
3	7	CLINIQUE YA SALAM	Clinique	150	Medecin	2026-03-02 15:22:55	2026-03-03 14:35:27	valide	\N	\N	\N	\N
4	8	Hopital YA SALAM	hospital	300	Secretaire	2026-03-23 10:06:53	2026-03-23 11:08:48	valide	\N	\N	\N	\N
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, prenom, nom, email, email_verified_at, password, role, telephone, adresse, code_postal, ville, remember_token, created_at, updated_at) FROM stdin;
1	Albert	Dubois	smknd2002@gmail.com	2026-02-25 14:23:03	$2y$12$zzx1abasI0d6f.9uLsWB/uVpIQoSdkAKAczqEhFMPEot4oquea/Am	admin	+ 331 785 96 89	\N	\N	\N	\N	2026-02-25 14:23:03	2026-05-05 00:57:48
2	Jean	Dupont	contact@clinique.fr	2026-05-05 01:12:00	$2y$12$YiY6BISRbFf0MZ4yGsKPieUbtjxkwfk2t07PNkab.TF401yUtYZie	client	771234567	Golf Sud	\N	Dakar	\N	2026-02-25 14:25:34	2026-05-05 01:12:00
4	Yacine	Gueye	yacine04@gmail.com	2026-05-05 01:12:00	$2y$12$CtMjtP0AXBSyj9tX2gWbmOPAnDnzTOVQakkEqkzk6OxpeE9zfjB/e	client	77 854 96 23	Yoff	17000	DAKAR	\N	2026-02-25 14:57:55	2026-05-05 01:12:00
6	Die	Sylla	die04@gmail.com	2026-05-05 01:12:00	$2y$12$6f0sYO3lVQjADYiKBbz.V.hcygpDDetKI9xcrllGC3m1y3sTBpfra	professionnel	77 895 63 12	Parcelles, 78000 DAKAR	78000	DAKAR	\N	2026-03-02 10:09:26	2026-05-05 01:12:00
7	NDIAYE	Alioune	alioune04@gmail.com	2026-05-05 01:12:00	$2y$12$VuHPqgNEtTtzqgitZLj2NuNrm6DrGEnCweEYggnEw0diE99dtcoV6	client	77 895 63 42	Corniche	85000	DAKAR	\N	2026-03-02 15:22:55	2026-05-05 01:12:00
8	Kabyr	Ndiaye	kabyr04@gmail.com	2026-05-05 01:12:00	$2y$12$a0IsGeOV.Tas8tHy0kdIMuwYZtKOblo5HOiEAomkbg..PUY5k7yxu	client	778956352	Corniche	78000	DAKAR	\N	2026-03-23 10:06:53	2026-05-05 01:12:00
5	Abdou karim	Fall	karim04@gmail.com	2026-05-05 01:12:00	$2y$12$yQ4XcTljLpFcUpy.XRpj6OambTAE6uNc2DsitBtKN9tP/A0/nOiCi	professionnel	77 895 263 74	Lac Rose, 75000 DAKAR	75000	DAKAR	\N	2026-02-27 10:14:02	2026-05-05 01:12:00
10	Maimouna	Ndiaye	kabyr3637@gmail.com	\N	$2y$12$wWzNhCJfAM6U0unDNa/GK.TOH4XIGtfzenCsLJhzbXI068QuyA1QO	professionnel	77 895 63 12	12 Rue de la République, 75001 Paris	75001	Paris	\N	2026-05-05 01:49:26	2026-05-05 01:49:26
\.


--
-- Name: documents_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.documents_id_seq', 44, true);


--
-- Name: failed_jobs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.failed_jobs_id_seq', 1, false);


--
-- Name: formations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.formations_id_seq', 2, true);


--
-- Name: incidents_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.incidents_id_seq', 7, true);


--
-- Name: jobs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.jobs_id_seq', 1, false);


--
-- Name: menu_recettes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.menu_recettes_id_seq', 5, true);


--
-- Name: menus_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.menus_id_seq', 1, true);


--
-- Name: migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.migrations_id_seq', 55, true);


--
-- Name: mission_messages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.mission_messages_id_seq', 43, true);


--
-- Name: mission_recette_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.mission_recette_id_seq', 1, false);


--
-- Name: mission_repas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.mission_repas_id_seq', 65, true);


--
-- Name: mission_repas_recettes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.mission_repas_recettes_id_seq', 62, true);


--
-- Name: mission_responses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.mission_responses_id_seq', 10, true);


--
-- Name: missions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.missions_id_seq', 37, true);


--
-- Name: personal_access_tokens_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.personal_access_tokens_id_seq', 798, true);


--
-- Name: professionnels_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.professionnels_id_seq', 5, true);


--
-- Name: recettes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.recettes_id_seq', 29, true);


--
-- Name: retours_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.retours_id_seq', 9, true);


--
-- Name: structures_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.structures_id_seq', 4, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 10, true);


--
-- Name: cache_locks cache_locks_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cache_locks
    ADD CONSTRAINT cache_locks_pkey PRIMARY KEY (key);


--
-- Name: cache cache_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cache
    ADD CONSTRAINT cache_pkey PRIMARY KEY (key);


--
-- Name: documents documents_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.documents
    ADD CONSTRAINT documents_pkey PRIMARY KEY (id);


--
-- Name: failed_jobs failed_jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.failed_jobs
    ADD CONSTRAINT failed_jobs_pkey PRIMARY KEY (id);


--
-- Name: failed_jobs failed_jobs_uuid_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.failed_jobs
    ADD CONSTRAINT failed_jobs_uuid_unique UNIQUE (uuid);


--
-- Name: formations formations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.formations
    ADD CONSTRAINT formations_pkey PRIMARY KEY (id);


--
-- Name: incidents incidents_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.incidents
    ADD CONSTRAINT incidents_pkey PRIMARY KEY (id);


--
-- Name: job_batches job_batches_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.job_batches
    ADD CONSTRAINT job_batches_pkey PRIMARY KEY (id);


--
-- Name: jobs jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.jobs
    ADD CONSTRAINT jobs_pkey PRIMARY KEY (id);


--
-- Name: menu_recettes menu_recettes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.menu_recettes
    ADD CONSTRAINT menu_recettes_pkey PRIMARY KEY (id);


--
-- Name: menus menus_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.menus
    ADD CONSTRAINT menus_pkey PRIMARY KEY (id);


--
-- Name: migrations migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.migrations
    ADD CONSTRAINT migrations_pkey PRIMARY KEY (id);


--
-- Name: mission_messages mission_messages_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mission_messages
    ADD CONSTRAINT mission_messages_pkey PRIMARY KEY (id);


--
-- Name: mission_recette mission_recette_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mission_recette
    ADD CONSTRAINT mission_recette_pkey PRIMARY KEY (id);


--
-- Name: mission_repas mission_repas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mission_repas
    ADD CONSTRAINT mission_repas_pkey PRIMARY KEY (id);


--
-- Name: mission_repas_recettes mission_repas_recettes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mission_repas_recettes
    ADD CONSTRAINT mission_repas_recettes_pkey PRIMARY KEY (id);


--
-- Name: mission_responses mission_responses_mission_id_professionnel_id_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mission_responses
    ADD CONSTRAINT mission_responses_mission_id_professionnel_id_unique UNIQUE (mission_id, professionnel_id);


--
-- Name: mission_responses mission_responses_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mission_responses
    ADD CONSTRAINT mission_responses_pkey PRIMARY KEY (id);


--
-- Name: missions missions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.missions
    ADD CONSTRAINT missions_pkey PRIMARY KEY (id);


--
-- Name: notifications notifications_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_pkey PRIMARY KEY (id);


--
-- Name: password_reset_tokens password_reset_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.password_reset_tokens
    ADD CONSTRAINT password_reset_tokens_pkey PRIMARY KEY (email);


--
-- Name: personal_access_tokens personal_access_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personal_access_tokens
    ADD CONSTRAINT personal_access_tokens_pkey PRIMARY KEY (id);


--
-- Name: personal_access_tokens personal_access_tokens_token_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personal_access_tokens
    ADD CONSTRAINT personal_access_tokens_token_unique UNIQUE (token);


--
-- Name: professionnels professionnels_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.professionnels
    ADD CONSTRAINT professionnels_pkey PRIMARY KEY (id);


--
-- Name: recettes recettes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recettes
    ADD CONSTRAINT recettes_pkey PRIMARY KEY (id);


--
-- Name: retours retours_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.retours
    ADD CONSTRAINT retours_pkey PRIMARY KEY (id);


--
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (id);


--
-- Name: structures structures_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.structures
    ADD CONSTRAINT structures_pkey PRIMARY KEY (id);


--
-- Name: users users_email_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_unique UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: cache_expiration_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX cache_expiration_index ON public.cache USING btree (expiration);


--
-- Name: cache_locks_expiration_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX cache_locks_expiration_index ON public.cache_locks USING btree (expiration);


--
-- Name: documents_documentable_type_documentable_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX documents_documentable_type_documentable_id_index ON public.documents USING btree (documentable_type, documentable_id);


--
-- Name: jobs_queue_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX jobs_queue_index ON public.jobs USING btree (queue);


--
-- Name: notifications_notifiable_type_notifiable_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX notifications_notifiable_type_notifiable_id_index ON public.notifications USING btree (notifiable_type, notifiable_id);


--
-- Name: personal_access_tokens_expires_at_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX personal_access_tokens_expires_at_index ON public.personal_access_tokens USING btree (expires_at);


--
-- Name: personal_access_tokens_tokenable_type_tokenable_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX personal_access_tokens_tokenable_type_tokenable_id_index ON public.personal_access_tokens USING btree (tokenable_type, tokenable_id);


--
-- Name: sessions_last_activity_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX sessions_last_activity_index ON public.sessions USING btree (last_activity);


--
-- Name: sessions_user_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX sessions_user_id_index ON public.sessions USING btree (user_id);


--
-- Name: users_email_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX users_email_index ON public.users USING btree (email);


--
-- Name: users_role_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX users_role_index ON public.users USING btree (role);


--
-- Name: formations formations_professionnel_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.formations
    ADD CONSTRAINT formations_professionnel_id_foreign FOREIGN KEY (professionnel_id) REFERENCES public.professionnels(id) ON DELETE CASCADE;


--
-- Name: incidents incidents_mission_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.incidents
    ADD CONSTRAINT incidents_mission_id_foreign FOREIGN KEY (mission_id) REFERENCES public.missions(id) ON DELETE CASCADE;


--
-- Name: menu_recettes menu_recettes_menu_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.menu_recettes
    ADD CONSTRAINT menu_recettes_menu_id_foreign FOREIGN KEY (menu_id) REFERENCES public.menus(id) ON DELETE CASCADE;


--
-- Name: menu_recettes menu_recettes_recette_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.menu_recettes
    ADD CONSTRAINT menu_recettes_recette_id_foreign FOREIGN KEY (recette_id) REFERENCES public.recettes(id) ON DELETE CASCADE;


--
-- Name: menus menus_created_by_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.menus
    ADD CONSTRAINT menus_created_by_foreign FOREIGN KEY (created_by) REFERENCES public.users(id) ON DELETE SET NULL;


--
-- Name: mission_messages mission_messages_mission_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mission_messages
    ADD CONSTRAINT mission_messages_mission_id_foreign FOREIGN KEY (mission_id) REFERENCES public.missions(id) ON DELETE CASCADE;


--
-- Name: mission_messages mission_messages_user_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mission_messages
    ADD CONSTRAINT mission_messages_user_id_foreign FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: mission_recette mission_recette_mission_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mission_recette
    ADD CONSTRAINT mission_recette_mission_id_foreign FOREIGN KEY (mission_id) REFERENCES public.missions(id) ON DELETE CASCADE;


--
-- Name: mission_recette mission_recette_recette_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mission_recette
    ADD CONSTRAINT mission_recette_recette_id_foreign FOREIGN KEY (recette_id) REFERENCES public.recettes(id) ON DELETE CASCADE;


--
-- Name: mission_repas mission_repas_accompagnement_recette_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mission_repas
    ADD CONSTRAINT mission_repas_accompagnement_recette_id_foreign FOREIGN KEY (accompagnement_recette_id) REFERENCES public.recettes(id) ON DELETE SET NULL;


--
-- Name: mission_repas mission_repas_dessert_recette_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mission_repas
    ADD CONSTRAINT mission_repas_dessert_recette_id_foreign FOREIGN KEY (dessert_recette_id) REFERENCES public.recettes(id) ON DELETE SET NULL;


--
-- Name: mission_repas mission_repas_entree_recette_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mission_repas
    ADD CONSTRAINT mission_repas_entree_recette_id_foreign FOREIGN KEY (entree_recette_id) REFERENCES public.recettes(id) ON DELETE SET NULL;


--
-- Name: mission_repas mission_repas_mission_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mission_repas
    ADD CONSTRAINT mission_repas_mission_id_foreign FOREIGN KEY (mission_id) REFERENCES public.missions(id) ON DELETE CASCADE;


--
-- Name: mission_repas mission_repas_plat_recette_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mission_repas
    ADD CONSTRAINT mission_repas_plat_recette_id_foreign FOREIGN KEY (plat_recette_id) REFERENCES public.recettes(id) ON DELETE SET NULL;


--
-- Name: mission_repas_recettes mission_repas_recettes_mission_repas_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mission_repas_recettes
    ADD CONSTRAINT mission_repas_recettes_mission_repas_id_foreign FOREIGN KEY (mission_repas_id) REFERENCES public.mission_repas(id) ON DELETE CASCADE;


--
-- Name: mission_repas_recettes mission_repas_recettes_recette_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mission_repas_recettes
    ADD CONSTRAINT mission_repas_recettes_recette_id_foreign FOREIGN KEY (recette_id) REFERENCES public.recettes(id) ON DELETE CASCADE;


--
-- Name: mission_repas mission_repas_simple_recette_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mission_repas
    ADD CONSTRAINT mission_repas_simple_recette_id_foreign FOREIGN KEY (simple_recette_id) REFERENCES public.recettes(id) ON DELETE SET NULL;


--
-- Name: mission_responses mission_responses_mission_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mission_responses
    ADD CONSTRAINT mission_responses_mission_id_foreign FOREIGN KEY (mission_id) REFERENCES public.missions(id) ON DELETE CASCADE;


--
-- Name: mission_responses mission_responses_professionnel_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mission_responses
    ADD CONSTRAINT mission_responses_professionnel_id_foreign FOREIGN KEY (professionnel_id) REFERENCES public.professionnels(id) ON DELETE CASCADE;


--
-- Name: missions missions_professionnel_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.missions
    ADD CONSTRAINT missions_professionnel_id_foreign FOREIGN KEY (professionnel_id) REFERENCES public.professionnels(id) ON DELETE SET NULL;


--
-- Name: missions missions_structure_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.missions
    ADD CONSTRAINT missions_structure_id_foreign FOREIGN KEY (structure_id) REFERENCES public.structures(id) ON DELETE CASCADE;


--
-- Name: professionnels professionnels_user_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.professionnels
    ADD CONSTRAINT professionnels_user_id_foreign FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: recettes recettes_created_by_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recettes
    ADD CONSTRAINT recettes_created_by_foreign FOREIGN KEY (created_by) REFERENCES public.users(id) ON DELETE SET NULL;


--
-- Name: retours retours_mission_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.retours
    ADD CONSTRAINT retours_mission_id_foreign FOREIGN KEY (mission_id) REFERENCES public.missions(id) ON DELETE CASCADE;


--
-- Name: structures structures_user_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.structures
    ADD CONSTRAINT structures_user_id_foreign FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

\unrestrict 7ZH7RugsFNc612eniszrrMdBvoeShlgtqdjGy9NTWKlNXc0eljiuR4jXapBWYAt

