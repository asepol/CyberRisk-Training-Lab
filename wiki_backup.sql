--
-- PostgreSQL database dump
--

\restrict RDdcpJf4ngJxHo6ZXdZaJ5RysLsyvGr6OXRRSCdfJrcifkTpBfEJDalVgKD1KZ0

-- Dumped from database version 14.22 (Debian 14.22-1.pgdg13+1)
-- Dumped by pg_dump version 14.22 (Debian 14.22-1.pgdg13+1)

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
-- Name: analytics; Type: TABLE; Schema: public; Owner: wikijs
--

CREATE TABLE public.analytics (
    key character varying(255) NOT NULL,
    "isEnabled" boolean DEFAULT false NOT NULL,
    config json NOT NULL
);


ALTER TABLE public.analytics OWNER TO wikijs;

--
-- Name: apiKeys; Type: TABLE; Schema: public; Owner: wikijs
--

CREATE TABLE public."apiKeys" (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    key text NOT NULL,
    expiration character varying(255) NOT NULL,
    "isRevoked" boolean DEFAULT false NOT NULL,
    "createdAt" character varying(255) NOT NULL,
    "updatedAt" character varying(255) NOT NULL
);


ALTER TABLE public."apiKeys" OWNER TO wikijs;

--
-- Name: apiKeys_id_seq; Type: SEQUENCE; Schema: public; Owner: wikijs
--

CREATE SEQUENCE public."apiKeys_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."apiKeys_id_seq" OWNER TO wikijs;

--
-- Name: apiKeys_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wikijs
--

ALTER SEQUENCE public."apiKeys_id_seq" OWNED BY public."apiKeys".id;


--
-- Name: assetData; Type: TABLE; Schema: public; Owner: wikijs
--

CREATE TABLE public."assetData" (
    id integer NOT NULL,
    data bytea NOT NULL
);


ALTER TABLE public."assetData" OWNER TO wikijs;

--
-- Name: assetFolders; Type: TABLE; Schema: public; Owner: wikijs
--

CREATE TABLE public."assetFolders" (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    slug character varying(255) NOT NULL,
    "parentId" integer
);


ALTER TABLE public."assetFolders" OWNER TO wikijs;

--
-- Name: assetFolders_id_seq; Type: SEQUENCE; Schema: public; Owner: wikijs
--

CREATE SEQUENCE public."assetFolders_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."assetFolders_id_seq" OWNER TO wikijs;

--
-- Name: assetFolders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wikijs
--

ALTER SEQUENCE public."assetFolders_id_seq" OWNED BY public."assetFolders".id;


--
-- Name: assets; Type: TABLE; Schema: public; Owner: wikijs
--

CREATE TABLE public.assets (
    id integer NOT NULL,
    filename character varying(255) NOT NULL,
    hash character varying(255) NOT NULL,
    ext character varying(255) NOT NULL,
    kind text DEFAULT 'binary'::text NOT NULL,
    mime character varying(255) DEFAULT 'application/octet-stream'::character varying NOT NULL,
    "fileSize" integer,
    metadata json,
    "createdAt" character varying(255) NOT NULL,
    "updatedAt" character varying(255) NOT NULL,
    "folderId" integer,
    "authorId" integer,
    CONSTRAINT assets_kind_check CHECK ((kind = ANY (ARRAY['binary'::text, 'image'::text])))
);


ALTER TABLE public.assets OWNER TO wikijs;

--
-- Name: COLUMN assets."fileSize"; Type: COMMENT; Schema: public; Owner: wikijs
--

COMMENT ON COLUMN public.assets."fileSize" IS 'In kilobytes';


--
-- Name: assets_id_seq; Type: SEQUENCE; Schema: public; Owner: wikijs
--

CREATE SEQUENCE public.assets_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.assets_id_seq OWNER TO wikijs;

--
-- Name: assets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wikijs
--

ALTER SEQUENCE public.assets_id_seq OWNED BY public.assets.id;


--
-- Name: authentication; Type: TABLE; Schema: public; Owner: wikijs
--

CREATE TABLE public.authentication (
    key character varying(255) NOT NULL,
    "isEnabled" boolean DEFAULT false NOT NULL,
    config json NOT NULL,
    "selfRegistration" boolean DEFAULT false NOT NULL,
    "domainWhitelist" json NOT NULL,
    "autoEnrollGroups" json NOT NULL,
    "order" integer DEFAULT 0 NOT NULL,
    "strategyKey" character varying(255) DEFAULT ''::character varying NOT NULL,
    "displayName" character varying(255) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE public.authentication OWNER TO wikijs;

--
-- Name: brute; Type: TABLE; Schema: public; Owner: wikijs
--

CREATE TABLE public.brute (
    key character varying(255),
    "firstRequest" bigint,
    "lastRequest" bigint,
    lifetime bigint,
    count integer
);


ALTER TABLE public.brute OWNER TO wikijs;

--
-- Name: commentProviders; Type: TABLE; Schema: public; Owner: wikijs
--

CREATE TABLE public."commentProviders" (
    key character varying(255) NOT NULL,
    "isEnabled" boolean DEFAULT false NOT NULL,
    config json NOT NULL
);


ALTER TABLE public."commentProviders" OWNER TO wikijs;

--
-- Name: comments; Type: TABLE; Schema: public; Owner: wikijs
--

CREATE TABLE public.comments (
    id integer NOT NULL,
    content text NOT NULL,
    "createdAt" character varying(255) NOT NULL,
    "updatedAt" character varying(255) NOT NULL,
    "pageId" integer,
    "authorId" integer,
    render text DEFAULT ''::text NOT NULL,
    name character varying(255) DEFAULT ''::character varying NOT NULL,
    email character varying(255) DEFAULT ''::character varying NOT NULL,
    ip character varying(255) DEFAULT ''::character varying NOT NULL,
    "replyTo" integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.comments OWNER TO wikijs;

--
-- Name: comments_id_seq; Type: SEQUENCE; Schema: public; Owner: wikijs
--

CREATE SEQUENCE public.comments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.comments_id_seq OWNER TO wikijs;

--
-- Name: comments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wikijs
--

ALTER SEQUENCE public.comments_id_seq OWNED BY public.comments.id;


--
-- Name: editors; Type: TABLE; Schema: public; Owner: wikijs
--

CREATE TABLE public.editors (
    key character varying(255) NOT NULL,
    "isEnabled" boolean DEFAULT false NOT NULL,
    config json NOT NULL
);


ALTER TABLE public.editors OWNER TO wikijs;

--
-- Name: groups; Type: TABLE; Schema: public; Owner: wikijs
--

CREATE TABLE public.groups (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    permissions json NOT NULL,
    "pageRules" json NOT NULL,
    "isSystem" boolean DEFAULT false NOT NULL,
    "createdAt" character varying(255) NOT NULL,
    "updatedAt" character varying(255) NOT NULL,
    "redirectOnLogin" character varying(255) DEFAULT '/'::character varying NOT NULL
);


ALTER TABLE public.groups OWNER TO wikijs;

--
-- Name: groups_id_seq; Type: SEQUENCE; Schema: public; Owner: wikijs
--

CREATE SEQUENCE public.groups_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.groups_id_seq OWNER TO wikijs;

--
-- Name: groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wikijs
--

ALTER SEQUENCE public.groups_id_seq OWNED BY public.groups.id;


--
-- Name: locales; Type: TABLE; Schema: public; Owner: wikijs
--

CREATE TABLE public.locales (
    code character varying(5) NOT NULL,
    strings json,
    "isRTL" boolean DEFAULT false NOT NULL,
    name character varying(255) NOT NULL,
    "nativeName" character varying(255) NOT NULL,
    availability integer DEFAULT 0 NOT NULL,
    "createdAt" character varying(255) NOT NULL,
    "updatedAt" character varying(255) NOT NULL
);


ALTER TABLE public.locales OWNER TO wikijs;

--
-- Name: loggers; Type: TABLE; Schema: public; Owner: wikijs
--

CREATE TABLE public.loggers (
    key character varying(255) NOT NULL,
    "isEnabled" boolean DEFAULT false NOT NULL,
    level character varying(255) DEFAULT 'warn'::character varying NOT NULL,
    config json
);


ALTER TABLE public.loggers OWNER TO wikijs;

--
-- Name: migrations; Type: TABLE; Schema: public; Owner: wikijs
--

CREATE TABLE public.migrations (
    id integer NOT NULL,
    name character varying(255),
    batch integer,
    migration_time timestamp with time zone
);


ALTER TABLE public.migrations OWNER TO wikijs;

--
-- Name: migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: wikijs
--

CREATE SEQUENCE public.migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.migrations_id_seq OWNER TO wikijs;

--
-- Name: migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wikijs
--

ALTER SEQUENCE public.migrations_id_seq OWNED BY public.migrations.id;


--
-- Name: migrations_lock; Type: TABLE; Schema: public; Owner: wikijs
--

CREATE TABLE public.migrations_lock (
    index integer NOT NULL,
    is_locked integer
);


ALTER TABLE public.migrations_lock OWNER TO wikijs;

--
-- Name: migrations_lock_index_seq; Type: SEQUENCE; Schema: public; Owner: wikijs
--

CREATE SEQUENCE public.migrations_lock_index_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.migrations_lock_index_seq OWNER TO wikijs;

--
-- Name: migrations_lock_index_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wikijs
--

ALTER SEQUENCE public.migrations_lock_index_seq OWNED BY public.migrations_lock.index;


--
-- Name: navigation; Type: TABLE; Schema: public; Owner: wikijs
--

CREATE TABLE public.navigation (
    key character varying(255) NOT NULL,
    config json
);


ALTER TABLE public.navigation OWNER TO wikijs;

--
-- Name: pageHistory; Type: TABLE; Schema: public; Owner: wikijs
--

CREATE TABLE public."pageHistory" (
    id integer NOT NULL,
    path character varying(255) NOT NULL,
    hash character varying(255) NOT NULL,
    title character varying(255) NOT NULL,
    description character varying(255),
    "isPrivate" boolean DEFAULT false NOT NULL,
    "isPublished" boolean DEFAULT false NOT NULL,
    "publishStartDate" character varying(255),
    "publishEndDate" character varying(255),
    action character varying(255) DEFAULT 'updated'::character varying,
    "pageId" integer,
    content text,
    "contentType" character varying(255) NOT NULL,
    "createdAt" character varying(255) NOT NULL,
    "editorKey" character varying(255),
    "localeCode" character varying(5),
    "authorId" integer,
    "versionDate" character varying(255) DEFAULT ''::character varying NOT NULL,
    extra json DEFAULT '{}'::json NOT NULL
);


ALTER TABLE public."pageHistory" OWNER TO wikijs;

--
-- Name: pageHistoryTags; Type: TABLE; Schema: public; Owner: wikijs
--

CREATE TABLE public."pageHistoryTags" (
    id integer NOT NULL,
    "pageId" integer,
    "tagId" integer
);


ALTER TABLE public."pageHistoryTags" OWNER TO wikijs;

--
-- Name: pageHistoryTags_id_seq; Type: SEQUENCE; Schema: public; Owner: wikijs
--

CREATE SEQUENCE public."pageHistoryTags_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."pageHistoryTags_id_seq" OWNER TO wikijs;

--
-- Name: pageHistoryTags_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wikijs
--

ALTER SEQUENCE public."pageHistoryTags_id_seq" OWNED BY public."pageHistoryTags".id;


--
-- Name: pageHistory_id_seq; Type: SEQUENCE; Schema: public; Owner: wikijs
--

CREATE SEQUENCE public."pageHistory_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."pageHistory_id_seq" OWNER TO wikijs;

--
-- Name: pageHistory_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wikijs
--

ALTER SEQUENCE public."pageHistory_id_seq" OWNED BY public."pageHistory".id;


--
-- Name: pageLinks; Type: TABLE; Schema: public; Owner: wikijs
--

CREATE TABLE public."pageLinks" (
    id integer NOT NULL,
    path character varying(255) NOT NULL,
    "localeCode" character varying(5) NOT NULL,
    "pageId" integer
);


ALTER TABLE public."pageLinks" OWNER TO wikijs;

--
-- Name: pageLinks_id_seq; Type: SEQUENCE; Schema: public; Owner: wikijs
--

CREATE SEQUENCE public."pageLinks_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."pageLinks_id_seq" OWNER TO wikijs;

--
-- Name: pageLinks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wikijs
--

ALTER SEQUENCE public."pageLinks_id_seq" OWNED BY public."pageLinks".id;


--
-- Name: pageTags; Type: TABLE; Schema: public; Owner: wikijs
--

CREATE TABLE public."pageTags" (
    id integer NOT NULL,
    "pageId" integer,
    "tagId" integer
);


ALTER TABLE public."pageTags" OWNER TO wikijs;

--
-- Name: pageTags_id_seq; Type: SEQUENCE; Schema: public; Owner: wikijs
--

CREATE SEQUENCE public."pageTags_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."pageTags_id_seq" OWNER TO wikijs;

--
-- Name: pageTags_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wikijs
--

ALTER SEQUENCE public."pageTags_id_seq" OWNED BY public."pageTags".id;


--
-- Name: pageTree; Type: TABLE; Schema: public; Owner: wikijs
--

CREATE TABLE public."pageTree" (
    id integer NOT NULL,
    path character varying(255) NOT NULL,
    depth integer NOT NULL,
    title character varying(255) NOT NULL,
    "isPrivate" boolean DEFAULT false NOT NULL,
    "isFolder" boolean DEFAULT false NOT NULL,
    "privateNS" character varying(255),
    parent integer,
    "pageId" integer,
    "localeCode" character varying(5),
    ancestors json
);


ALTER TABLE public."pageTree" OWNER TO wikijs;

--
-- Name: pages; Type: TABLE; Schema: public; Owner: wikijs
--

CREATE TABLE public.pages (
    id integer NOT NULL,
    path character varying(255) NOT NULL,
    hash character varying(255) NOT NULL,
    title character varying(255) NOT NULL,
    description character varying(255),
    "isPrivate" boolean DEFAULT false NOT NULL,
    "isPublished" boolean DEFAULT false NOT NULL,
    "privateNS" character varying(255),
    "publishStartDate" character varying(255),
    "publishEndDate" character varying(255),
    content text,
    render text,
    toc json,
    "contentType" character varying(255) NOT NULL,
    "createdAt" character varying(255) NOT NULL,
    "updatedAt" character varying(255) NOT NULL,
    "editorKey" character varying(255),
    "localeCode" character varying(5),
    "authorId" integer,
    "creatorId" integer,
    extra json DEFAULT '{}'::json NOT NULL
);


ALTER TABLE public.pages OWNER TO wikijs;

--
-- Name: pages_id_seq; Type: SEQUENCE; Schema: public; Owner: wikijs
--

CREATE SEQUENCE public.pages_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.pages_id_seq OWNER TO wikijs;

--
-- Name: pages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wikijs
--

ALTER SEQUENCE public.pages_id_seq OWNED BY public.pages.id;


--
-- Name: renderers; Type: TABLE; Schema: public; Owner: wikijs
--

CREATE TABLE public.renderers (
    key character varying(255) NOT NULL,
    "isEnabled" boolean DEFAULT false NOT NULL,
    config json
);


ALTER TABLE public.renderers OWNER TO wikijs;

--
-- Name: searchEngines; Type: TABLE; Schema: public; Owner: wikijs
--

CREATE TABLE public."searchEngines" (
    key character varying(255) NOT NULL,
    "isEnabled" boolean DEFAULT false NOT NULL,
    config json
);


ALTER TABLE public."searchEngines" OWNER TO wikijs;

--
-- Name: sessions; Type: TABLE; Schema: public; Owner: wikijs
--

CREATE TABLE public.sessions (
    sid character varying(255) NOT NULL,
    sess json NOT NULL,
    expired timestamp with time zone NOT NULL
);


ALTER TABLE public.sessions OWNER TO wikijs;

--
-- Name: settings; Type: TABLE; Schema: public; Owner: wikijs
--

CREATE TABLE public.settings (
    key character varying(255) NOT NULL,
    value json,
    "updatedAt" character varying(255) NOT NULL
);


ALTER TABLE public.settings OWNER TO wikijs;

--
-- Name: storage; Type: TABLE; Schema: public; Owner: wikijs
--

CREATE TABLE public.storage (
    key character varying(255) NOT NULL,
    "isEnabled" boolean DEFAULT false NOT NULL,
    mode character varying(255) DEFAULT 'push'::character varying NOT NULL,
    config json,
    "syncInterval" character varying(255),
    state json
);


ALTER TABLE public.storage OWNER TO wikijs;

--
-- Name: tags; Type: TABLE; Schema: public; Owner: wikijs
--

CREATE TABLE public.tags (
    id integer NOT NULL,
    tag character varying(255) NOT NULL,
    title character varying(255),
    "createdAt" character varying(255) NOT NULL,
    "updatedAt" character varying(255) NOT NULL
);


ALTER TABLE public.tags OWNER TO wikijs;

--
-- Name: tags_id_seq; Type: SEQUENCE; Schema: public; Owner: wikijs
--

CREATE SEQUENCE public.tags_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tags_id_seq OWNER TO wikijs;

--
-- Name: tags_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wikijs
--

ALTER SEQUENCE public.tags_id_seq OWNED BY public.tags.id;


--
-- Name: userAvatars; Type: TABLE; Schema: public; Owner: wikijs
--

CREATE TABLE public."userAvatars" (
    id integer NOT NULL,
    data bytea NOT NULL
);


ALTER TABLE public."userAvatars" OWNER TO wikijs;

--
-- Name: userGroups; Type: TABLE; Schema: public; Owner: wikijs
--

CREATE TABLE public."userGroups" (
    id integer NOT NULL,
    "userId" integer,
    "groupId" integer
);


ALTER TABLE public."userGroups" OWNER TO wikijs;

--
-- Name: userGroups_id_seq; Type: SEQUENCE; Schema: public; Owner: wikijs
--

CREATE SEQUENCE public."userGroups_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."userGroups_id_seq" OWNER TO wikijs;

--
-- Name: userGroups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wikijs
--

ALTER SEQUENCE public."userGroups_id_seq" OWNED BY public."userGroups".id;


--
-- Name: userKeys; Type: TABLE; Schema: public; Owner: wikijs
--

CREATE TABLE public."userKeys" (
    id integer NOT NULL,
    kind character varying(255) NOT NULL,
    token character varying(255) NOT NULL,
    "createdAt" character varying(255) NOT NULL,
    "validUntil" character varying(255) NOT NULL,
    "userId" integer
);


ALTER TABLE public."userKeys" OWNER TO wikijs;

--
-- Name: userKeys_id_seq; Type: SEQUENCE; Schema: public; Owner: wikijs
--

CREATE SEQUENCE public."userKeys_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."userKeys_id_seq" OWNER TO wikijs;

--
-- Name: userKeys_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wikijs
--

ALTER SEQUENCE public."userKeys_id_seq" OWNED BY public."userKeys".id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: wikijs
--

CREATE TABLE public.users (
    id integer NOT NULL,
    email character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    "providerId" character varying(255),
    password character varying(255),
    "tfaIsActive" boolean DEFAULT false NOT NULL,
    "tfaSecret" character varying(255),
    "jobTitle" character varying(255) DEFAULT ''::character varying,
    location character varying(255) DEFAULT ''::character varying,
    "pictureUrl" character varying(255),
    timezone character varying(255) DEFAULT 'America/New_York'::character varying NOT NULL,
    "isSystem" boolean DEFAULT false NOT NULL,
    "isActive" boolean DEFAULT false NOT NULL,
    "isVerified" boolean DEFAULT false NOT NULL,
    "mustChangePwd" boolean DEFAULT false NOT NULL,
    "createdAt" character varying(255) NOT NULL,
    "updatedAt" character varying(255) NOT NULL,
    "providerKey" character varying(255) DEFAULT 'local'::character varying NOT NULL,
    "localeCode" character varying(5) DEFAULT 'en'::character varying NOT NULL,
    "defaultEditor" character varying(255) DEFAULT 'markdown'::character varying NOT NULL,
    "lastLoginAt" character varying(255),
    "dateFormat" character varying(255) DEFAULT ''::character varying NOT NULL,
    appearance character varying(255) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE public.users OWNER TO wikijs;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: wikijs
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO wikijs;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wikijs
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: apiKeys id; Type: DEFAULT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."apiKeys" ALTER COLUMN id SET DEFAULT nextval('public."apiKeys_id_seq"'::regclass);


--
-- Name: assetFolders id; Type: DEFAULT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."assetFolders" ALTER COLUMN id SET DEFAULT nextval('public."assetFolders_id_seq"'::regclass);


--
-- Name: assets id; Type: DEFAULT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.assets ALTER COLUMN id SET DEFAULT nextval('public.assets_id_seq'::regclass);


--
-- Name: comments id; Type: DEFAULT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.comments ALTER COLUMN id SET DEFAULT nextval('public.comments_id_seq'::regclass);


--
-- Name: groups id; Type: DEFAULT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.groups ALTER COLUMN id SET DEFAULT nextval('public.groups_id_seq'::regclass);


--
-- Name: migrations id; Type: DEFAULT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.migrations ALTER COLUMN id SET DEFAULT nextval('public.migrations_id_seq'::regclass);


--
-- Name: migrations_lock index; Type: DEFAULT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.migrations_lock ALTER COLUMN index SET DEFAULT nextval('public.migrations_lock_index_seq'::regclass);


--
-- Name: pageHistory id; Type: DEFAULT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."pageHistory" ALTER COLUMN id SET DEFAULT nextval('public."pageHistory_id_seq"'::regclass);


--
-- Name: pageHistoryTags id; Type: DEFAULT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."pageHistoryTags" ALTER COLUMN id SET DEFAULT nextval('public."pageHistoryTags_id_seq"'::regclass);


--
-- Name: pageLinks id; Type: DEFAULT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."pageLinks" ALTER COLUMN id SET DEFAULT nextval('public."pageLinks_id_seq"'::regclass);


--
-- Name: pageTags id; Type: DEFAULT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."pageTags" ALTER COLUMN id SET DEFAULT nextval('public."pageTags_id_seq"'::regclass);


--
-- Name: pages id; Type: DEFAULT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.pages ALTER COLUMN id SET DEFAULT nextval('public.pages_id_seq'::regclass);


--
-- Name: tags id; Type: DEFAULT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.tags ALTER COLUMN id SET DEFAULT nextval('public.tags_id_seq'::regclass);


--
-- Name: userGroups id; Type: DEFAULT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."userGroups" ALTER COLUMN id SET DEFAULT nextval('public."userGroups_id_seq"'::regclass);


--
-- Name: userKeys id; Type: DEFAULT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."userKeys" ALTER COLUMN id SET DEFAULT nextval('public."userKeys_id_seq"'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: analytics; Type: TABLE DATA; Schema: public; Owner: wikijs
--

COPY public.analytics (key, "isEnabled", config) FROM stdin;
azureinsights	f	{"instrumentationKey":""}
baidutongji	f	{"propertyTrackingId":""}
countly	f	{"appKey":"","serverUrl":""}
elasticapm	f	{"serverUrl":"http://apm.example.com:8200","serviceName":"wiki-js","environment":""}
fathom	f	{"host":"","siteId":""}
fullstory	f	{"org":""}
google	f	{"propertyTrackingId":""}
gtm	f	{"containerTrackingId":""}
hotjar	f	{"siteId":""}
matomo	f	{"siteId":1,"serverHost":"https://example.matomo.cloud"}
newrelic	f	{"licenseKey":"","appId":"","beacon":"bam.nr-data.net","errorBeacon":"bam.nr-data.net"}
plausible	f	{"domain":"","plausibleJsSrc":"https://plausible.io/js/plausible.js"}
statcounter	f	{"projectId":"","securityToken":""}
umami	f	{"websiteID":"","url":""}
umami2	f	{"websiteID":"","url":""}
yandex	f	{"tagNumber":""}
\.


--
-- Data for Name: apiKeys; Type: TABLE DATA; Schema: public; Owner: wikijs
--

COPY public."apiKeys" (id, name, key, expiration, "isRevoked", "createdAt", "updatedAt") FROM stdin;
1	wiki	eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJhcGkiOjEsImdycCI6MSwiaWF0IjoxNzcyOTc3Njc1LCJleHAiOjE4Njc2NTA0NzUsImF1ZCI6InVybjp3aWtpLmpzIiwiaXNzIjoidXJuOndpa2kuanMifQ.OqxpJAwEMJN0OlQBypSQVOMVJKLHDBrQ2DjLG2sbKRXHjdoxdg2tdou_sW8whI1N1aI9xJJiI5EKXhgSnfN2yN6u23to_6KjKPwdyOlJDjrn8oL05ViSizDHMH7PIYkdTa5EvjIkVHd_AaIw3XLvxb0A7-wgmYuWhXXyFhLOD7tZr77s2O00Au2kN9AiVUZmnfx8u79L_-eRL5LWJbGOmEtNHfhoJL6bnbv_mUn9D8xq_PZTxoBClcsZbAUO0ypbvT3g6fl1nkpYAi8_O8mSCSUNSgopMRrf27oMFSty_YEcb45Po2cb3_063TIGuqirehQHqhODlZjYSWy86WK4Iw	2029-03-08T07:47:55.603Z	t	2026-03-08T13:47:55.609Z	2026-03-08T13:50:47.740Z
2	test	eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJhcGkiOjIsImdycCI6MSwiaWF0IjoxNzcyOTc3ODU3LCJleHAiOjE4Njc2NTA2NTcsImF1ZCI6InVybjp3aWtpLmpzIiwiaXNzIjoidXJuOndpa2kuanMifQ.e6qKvvs1vFLC3_kCIoO8q1JFGUgyv_L7XYPs6Hy7iWvR_OFh2lmhJapH25hqm5K_3mOheaART-dpR2Q3h8Dqim0lfNVTrv12TFVtKBezusK02_qInYRO1vpEUEqssjDeZv-WRRrUSKGvdk-20yguk9X-aU5ZrjtpKcYaWQOddZtid9V9pk7HmpaKAcSFAHwxjXl8PQT1I3G4Thq4q8p3Hq6HmiIONQpKerbkudX0b9MmB_OR6dutGNEMczvD64J53hMzmHKD84_2w-b6QfpqHGihLaU6iYZHW6JJ1DEweY10hlv6ICi0Xnb3akZt6nTYKPT0vv2BdoMPj1RQIZQPWw	2029-03-08T07:50:57.647Z	t	2026-03-08T13:50:57.648Z	2026-03-08T14:06:07.704Z
3	import	eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJhcGkiOjMsImdycCI6MSwiaWF0IjoxNzcyOTc4Nzc5LCJleHAiOjE4Njc2NTE1NzksImF1ZCI6InVybjp3aWtpLmpzIiwiaXNzIjoidXJuOndpa2kuanMifQ.eJ22Sev4mpndgQ8syvSsvKUIBfQdKAzMacuNB7WNu9Oq1kJl341y_D2m0_b74ZscEut0C7ieuTmce338e1h2IXjNxwn7xmbo5nysOsLmV3P4JG0mXce5udonlHEHAgFqrjfWBVBLusXUQ7Y-HmWqkA-uLJWeN6E_6mnMWRDFavTrBZi_nkQdwm87TzvnHDYtIoaxc-ercDDRGXd1tMu4HGgv2QV_6iCXEjxV2-cZMRZ1iJxV0tDlCky792iC3lohSJgaaTLAQ6dxXAUDHKN1UkIiedOxhcBcXe-_kLKx0xoGS48GFgBRrmS1Bh28e3JHfMrMv9RmRBMBgKlbCfwttQ	2029-03-08T08:06:19.603Z	t	2026-03-08T14:06:19.603Z	2026-03-08T14:23:41.147Z
4	final	eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJhcGkiOjQsImdycCI6MSwiaWF0IjoxNzcyOTc5ODMwLCJleHAiOjE4Njc2NTI2MzAsImF1ZCI6InVybjp3aWtpLmpzIiwiaXNzIjoidXJuOndpa2kuanMifQ.HMZwZBwPHaMjfvNR1bziftHIKEkb5xnfTk9ZsZa-qcMY0vCkDtG8TLYt9R5iwVwdKFfEEh0wmBpbdPEteQohEKFk2VYBlYlLYV5tHj8zrpM4sa1VEuHrjgKXzcBFz3BgPZddj85UQJibvl0jyxP7Vu9CaCUTdBHL5PraCQzs0e1OekETAMXS1HNwNEdnWioowKBlRCvr5aZL_Co2HieO4lcLBXlLRx61I1PH0CP4gUlmBNjp1Zf18bMgMZwd11RS6j5k5ui-l46LPKi2ut1HvIrOyI6TiNHkskc5SCIuR8i0n7GNkWkD2SRIqO8hU4bcOFVUadky3pjDc2Ta02Prkw	2029-03-08T08:23:50.656Z	f	2026-03-08T14:23:50.656Z	2026-03-08T14:23:50.661Z
\.


--
-- Data for Name: assetData; Type: TABLE DATA; Schema: public; Owner: wikijs
--

COPY public."assetData" (id, data) FROM stdin;
\.


--
-- Data for Name: assetFolders; Type: TABLE DATA; Schema: public; Owner: wikijs
--

COPY public."assetFolders" (id, name, slug, "parentId") FROM stdin;
\.


--
-- Data for Name: assets; Type: TABLE DATA; Schema: public; Owner: wikijs
--

COPY public.assets (id, filename, hash, ext, kind, mime, "fileSize", metadata, "createdAt", "updatedAt", "folderId", "authorId") FROM stdin;
\.


--
-- Data for Name: authentication; Type: TABLE DATA; Schema: public; Owner: wikijs
--

COPY public.authentication (key, "isEnabled", config, "selfRegistration", "domainWhitelist", "autoEnrollGroups", "order", "strategyKey", "displayName") FROM stdin;
local	t	{}	f	{"v":[]}	{"v":[]}	0	local	Local
\.


--
-- Data for Name: brute; Type: TABLE DATA; Schema: public; Owner: wikijs
--

COPY public.brute (key, "firstRequest", "lastRequest", lifetime, count) FROM stdin;
\.


--
-- Data for Name: commentProviders; Type: TABLE DATA; Schema: public; Owner: wikijs
--

COPY public."commentProviders" (key, "isEnabled", config) FROM stdin;
artalk	f	{"server":"","siteName":""}
commento	f	{"instanceUrl":"https://cdn.commento.io"}
default	t	{"akismet":"","minDelay":30}
disqus	f	{"accountName":""}
\.


--
-- Data for Name: comments; Type: TABLE DATA; Schema: public; Owner: wikijs
--

COPY public.comments (id, content, "createdAt", "updatedAt", "pageId", "authorId", render, name, email, ip, "replyTo") FROM stdin;
\.


--
-- Data for Name: editors; Type: TABLE DATA; Schema: public; Owner: wikijs
--

COPY public.editors (key, "isEnabled", config) FROM stdin;
api	f	{}
asciidoc	f	{}
ckeditor	f	{}
code	f	{}
markdown	t	{}
redirect	f	{}
wysiwyg	f	{}
\.


--
-- Data for Name: groups; Type: TABLE DATA; Schema: public; Owner: wikijs
--

COPY public.groups (id, name, permissions, "pageRules", "isSystem", "createdAt", "updatedAt", "redirectOnLogin") FROM stdin;
1	Administrators	["manage:system"]	[]	t	2026-03-08T13:42:16.098Z	2026-03-08T13:42:16.098Z	/
2	Guests	["read:pages","read:assets","read:comments"]	[{"id":"guest","roles":["read:pages","read:assets","read:comments"],"match":"START","deny":false,"path":"","locales":[]}]	t	2026-03-08T13:42:16.101Z	2026-03-08T13:42:16.101Z	/
\.


--
-- Data for Name: locales; Type: TABLE DATA; Schema: public; Owner: wikijs
--

COPY public.locales (code, strings, "isRTL", name, "nativeName", availability, "createdAt", "updatedAt") FROM stdin;
fr	\N	f	Français	Français	1	2026-03-08 14:45:56.542321+00	2026-03-08 14:45:56.542321+00
en	{"common":{"footer":{"poweredBy":"Powered by","copyright":"© {{year}} {{company}}. All rights reserved.","license":"Content is available under the {{license}}, by {{company}}."},"actions":{"save":"Save","cancel":"Cancel","download":"Download","upload":"Upload","discard":"Discard","clear":"Clear","create":"Create","edit":"Edit","delete":"Delete","refresh":"Refresh","saveChanges":"Save Changes","proceed":"Proceed","ok":"OK","add":"Add","apply":"Apply","browse":"Browse...","close":"Close","page":"Page","discardChanges":"Discard Changes","move":"Move","rename":"Rename","optimize":"Optimize","preview":"Preview","properties":"Properties","insert":"Insert","fetch":"Fetch","generate":"Generate","confirm":"Confirm","copy":"Copy","returnToTop":"Return to top","exit":"Exit","select":"Select","convert":"Convert"},"newpage":{"title":"This page does not exist yet.","subtitle":"Would you like to create it now?","create":"Create Page","goback":"Go back"},"unauthorized":{"title":"Unauthorized","action":{"view":"You cannot view this page.","source":"You cannot view the page source.","history":"You cannot view the page history.","edit":"You cannot edit the page.","create":"You cannot create the page.","download":"You cannot download the page content.","downloadVersion":"You cannot download the content for this page version.","sourceVersion":"You cannot view the source of this version of the page."},"goback":"Go Back","login":"Login As..."},"notfound":{"gohome":"Home","title":"Not Found","subtitle":"This page does not exist."},"welcome":{"title":"Welcome to your wiki!","subtitle":"Let's get started and create the home page.","createhome":"Create Home Page","goadmin":"Administration"},"header":{"home":"Home","newPage":"New Page","currentPage":"Current Page","view":"View","edit":"Edit","history":"History","viewSource":"View Source","move":"Move / Rename","delete":"Delete","assets":"Assets","imagesFiles":"Images & Files","search":"Search...","admin":"Administration","account":"Account","myWiki":"My Wiki","profile":"Profile","logout":"Logout","login":"Login","searchHint":"Type at least 2 characters to start searching...","searchLoading":"Searching...","searchNoResult":"No pages matching your query.","searchResultsCount":"Found {{total}} results","searchDidYouMean":"Did you mean...","searchClose":"Close","searchCopyLink":"Copy Search Link","language":"Language","browseTags":"Browse by Tags","siteMap":"Site Map","pageActions":"Page Actions","duplicate":"Duplicate","convert":"Convert"},"page":{"lastEditedBy":"Last edited by","unpublished":"Unpublished","editPage":"Edit Page","toc":"Page Contents","bookmark":"Bookmark","share":"Share","printFormat":"Print Format","delete":"Delete Page","deleteTitle":"Are you sure you want to delete page {{title}}?","deleteSubtitle":"The page can be restored from the administration area.","viewingSource":"Viewing source of page {{path}}","returnNormalView":"Return to Normal View","id":"ID {{id}}","published":"Published","private":"Private","global":"Global","loading":"Loading Page...","viewingSourceVersion":"Viewing source as of {{date}} of page {{path}}","versionId":"Version ID {{id}}","unpublishedWarning":"This page is not published.","tags":"Tags","tagsMatching":"Pages matching tags","convert":"Convert Page","convertTitle":"Select the editor you want to use going forward for the page {{title}}:","convertSubtitle":"The page content will be converted into the format of the newly selected editor. Note that some formatting or non-rendered content may be lost as a result of the conversion. A snapshot will be added to the page history and can be restored at any time.","editExternal":"Edit on {{name}}"},"error":{"unexpected":"An unexpected error occurred."},"password":{"veryWeak":"Very Weak","weak":"Weak","average":"Average","strong":"Strong","veryStrong":"Very Strong"},"user":{"search":"Search User","searchPlaceholder":"Search Users..."},"duration":{"every":"Every","minutes":"Minute(s)","hours":"Hour(s)","days":"Day(s)","months":"Month(s)","years":"Year(s)"},"outdatedBrowserWarning":"Your browser is outdated. Upgrade to a {{modernBrowser}}.","modernBrowser":"modern browser","license":{"none":"None","ccby":" Creative Commons Attribution License","ccbysa":"Creative Commons Attribution-ShareAlike License","ccbynd":"Creative Commons Attribution-NoDerivs License","ccbync":"Creative Commons Attribution-NonCommercial License","ccbyncsa":"Creative Commons Attribution-NonCommercial-ShareAlike License","ccbyncnd":"Creative Commons Attribution-NonCommercial-NoDerivs License","cc0":"Public Domain","alr":"All Rights Reserved"},"sidebar":{"browse":"Browse","mainMenu":"Main Menu","currentDirectory":"Current Directory","root":"(root)"},"comments":{"title":"Comments","newPlaceholder":"Write a new comment...","fieldName":"Your Name","fieldEmail":"Your Email Address","markdownFormat":"Markdown Format","postComment":"Post Comment","loading":"Loading comments...","postingAs":"Posting as {{name}}","beFirst":"Be the first to comment.","none":"No comments yet.","updateComment":"Update Comment","deleteConfirmTitle":"Confirm Delete","deleteWarn":"Are you sure you want to permanently delete this comment?","deletePermanentWarn":"This action cannot be undone!","modified":"modified {{reldate}}","postSuccess":"New comment posted successfully.","contentMissingError":"Comment is empty or too short!","updateSuccess":"Comment was updated successfully.","deleteSuccess":"Comment was deleted successfully.","viewDiscussion":"View Discussion","newComment":"New Comment","fieldContent":"Comment Content","sdTitle":"Talk"},"pageSelector":{"createTitle":"Select New Page Location","moveTitle":"Move / Rename Page Location","selectTitle":"Select a Page","virtualFolders":"Virtual Folders","pages":"Pages","folderEmptyWarning":"This folder is empty."}},"auth":{"loginRequired":"Login required","fields":{"emailUser":"Email / Username","password":"Password","email":"Email Address","verifyPassword":"Verify Password","name":"Name","username":"Username"},"actions":{"login":"Log In","register":"Register"},"errors":{"invalidLogin":"Invalid Login","invalidLoginMsg":"The email or password is invalid.","invalidUserEmail":"Invalid User Email","loginError":"Login error","notYetAuthorized":"You have not been authorized to login to this site yet.","tooManyAttempts":"Too many attempts!","tooManyAttemptsMsg":"You've made too many failed attempts in a short period of time, please try again {{time}}.","userNotFound":"User not found"},"providers":{"local":"Local","windowslive":"Microsoft Account","azure":"Azure Active Directory","google":"Google ID","facebook":"Facebook","github":"GitHub","slack":"Slack","ldap":"LDAP / Active Directory"},"tfa":{"title":"Two Factor Authentication","subtitle":"Security code required:","placeholder":"XXXXXX","verifyToken":"Verify"},"registerTitle":"Create an account","switchToLogin":{"text":"Already have an account? {{link}}","link":"Login instead"},"loginUsingStrategy":"Login using {{strategy}}","forgotPasswordLink":"Forgot your password?","orLoginUsingStrategy":"or login using...","switchToRegister":{"text":"Don't have an account yet? {{link}}","link":"Create an account"},"invalidEmailUsername":"Enter a valid email / username.","invalidPassword":"Enter a valid password.","loginSuccess":"Login Successful! Redirecting...","signingIn":"Signing In...","genericError":"Authentication is unavailable.","registerSubTitle":"Fill-in the form below to create your account.","pleaseWait":"Please wait","registerSuccess":"Account created successfully!","registering":"Creating account...","missingEmail":"Missing email address.","invalidEmail":"Email address is invalid.","missingPassword":"Missing password.","passwordTooShort":"Password is too short.","passwordNotMatch":"Both passwords do not match.","missingName":"Name is missing.","nameTooShort":"Name is too short.","nameTooLong":"Name is too long.","forgotPasswordCancel":"Cancel","sendResetPassword":"Reset Password","forgotPasswordSubtitle":"Enter your email address to receive the instructions to reset your password:","registerCheckEmail":"Check your emails to activate your account.","changePwd":{"subtitle":"Choose a new password","instructions":"You must choose a new password:","newPasswordPlaceholder":"New Password","newPasswordVerifyPlaceholder":"Verify New Password","proceed":"Change Password","loading":"Changing password..."},"forgotPasswordLoading":"Requesting password reset...","forgotPasswordSuccess":"Check your emails for password reset instructions!","selectAuthProvider":"Select Authentication Provider","enterCredentials":"Enter your credentials","forgotPasswordTitle":"Forgot your password","tfaFormTitle":"Enter the security code generated from your trusted device:","tfaSetupTitle":"Your administrator has required Two-Factor Authentication (2FA) to be enabled on your account.","tfaSetupInstrFirst":"1) Scan the QR code below from your mobile 2FA application:","tfaSetupInstrSecond":"2) Enter the security code generated from your trusted device:"},"admin":{"dashboard":{"title":"Dashboard","subtitle":"Wiki.js","pages":"Pages","users":"Users","groups":"Groups","versionLatest":"You are running the latest version.","versionNew":"A new version is available: {{version}}","contributeSubtitle":"Wiki.js is a free and open source project. There are several ways you can contribute to the project.","contributeHelp":"We need your help!","contributeLearnMore":"Learn More","recentPages":"Recent Pages","mostPopularPages":"Most Popular Pages","lastLogins":"Last Logins"},"general":{"title":"General","subtitle":"Main settings of your wiki","siteInfo":"Site Info","siteBranding":"Site Branding","general":"General","siteUrl":"Site URL","siteUrlHint":"Full URL to your wiki, without the trailing slash. (e.g. https://wiki.example.com)","siteTitle":"Site Title","siteTitleHint":"Displayed in the top bar and appended to all pages meta title.","logo":"Logo","uploadLogo":"Upload Logo","uploadClear":"Clear","uploadSizeHint":"An image of {{size}} pixels is recommended for best results.","uploadTypesHint":"{{typeList}} or {{lastType}} files only","footerCopyright":"Footer Copyright","companyName":"Company / Organization Name","companyNameHint":"Name to use when displaying copyright notice in the footer. Leave empty to hide.","siteDescription":"Site Description","siteDescriptionHint":"Default description when none is provided for a page.","metaRobots":"Meta Robots","metaRobotsHint":"Default: Index, Follow. Can also be set on a per-page basis.","logoUrl":"Logo URL","logoUrlHint":"Specify an image to use as the logo. SVG, PNG, JPG are supported, in a square ratio, 34x34 pixels or larger. Click the button on the right to upload a new image.","contentLicense":"Content License","contentLicenseHint":"License shown in the footer of all content pages.","siteTitleInvalidChars":"Site Title contains invalid characters.","saveSuccess":"Site configuration saved successfully.","pageExtensions":"Page Extensions","pageExtensionsHint":"A comma-separated list of URL extensions that will be treated as pages. For example, adding md will treat /foobar.md the same as /foobar.","editMenuExternalName":"Button Site Name","editMenuExternalNameHint":"The name of the external site to display on the edit button. Do not include the \\"Edit on\\" prefix.","editMenuExternalIcon":"Button Icon","editMenuExternalIconHint":"The icon to display on the edit button. For example, mdi-github to display the GitHub icon.","editMenuExternalUrl":"Button URL","editMenuExternalUrlHint":"Url to the page on the external repository. Use the {filename} placeholder where the filename should be included. (e.g. https://github.com/foo/bar/blob/main/{filename} )","editShortcuts":"Edit Shortcuts","editFab":"FAB Quick Edit Menu","editFabHint":"Display the edit floating action button (FAB) with a speed-dial menu in the bottom right corner of the screen.","editMenuBar":"Edit Menu Bar","displayEditMenuBar":"Display Edit Menu Bar","displayEditMenuBarHint":"Display the edit menu bar in the page header.","displayEditMenuBtn":"Display Edit Button","displayEditMenuBtnHint":"Display a button to edit the current page.","displayEditMenuExternalBtn":"Display External Edit Button","displayEditMenuExternalBtnHint":"Display a button linking to an external repository (e.g. GitHub) where users can edit or submit a PR for the current page.","footerOverride":"Footer Text Override","footerOverrideHint":"Optionally override the footer text with a custom message. Useful if none of the above licenses are appropriate."},"locale":{"title":"Locale","subtitle":"Set localization options for your wiki","settings":"Locale Settings","namespacing":"Multilingual Namespacing","downloadTitle":"Download Locale","base":{"labelWithNS":"Base Locale","hint":"All UI text elements will be displayed in selected language.","label":"Site Locale"},"autoUpdate":{"label":"Update Automatically","hintWithNS":"Automatically download updates to all namespaced locales enabled below.","hint":"Automatically download updates to this locale as they become available."},"namespaces":{"label":"Multilingual Namespaces","hint":"Enables multiple language versions of the same page."},"activeNamespaces":{"label":"Active Namespaces","hint":"List of locales enabled for multilingual namespacing. The base locale defined above will always be included regardless of this selection."},"namespacingPrefixWarning":{"title":"The locale code will be prefixed to all paths. (e.g. /{{langCode}}/page-name)","subtitle":"Paths without a locale code will be automatically redirected to the base locale defined above."},"sideload":"Sideload Locale Package","sideloadHelp":"If you are not connected to the internet or cannot download locale files using the method above, you can instead sideload packages manually by uploading them below.","code":"Code","name":"Name","nativeName":"Native Name","rtl":"RTL","availability":"Availability","download":"Download"},"stats":{"title":"Statistics"},"theme":{"title":"Theme","subtitle":"Modify the look & feel of your wiki","siteTheme":"Site Theme","siteThemeHint":"Themes affect how content pages are displayed. Other site sections (such as the editor or admin area) are not affected.","darkMode":"Dark Mode","darkModeHint":"Not recommended for accessibility. May not be supported by all themes.","codeInjection":"Code Injection","cssOverride":"CSS Override","cssOverrideHint":"CSS code to inject after system default CSS. Consider using custom themes if you have a large amount of css code. Injecting too much CSS code will result in poor page load performance! CSS will automatically be minified.","headHtmlInjection":"Head HTML Injection","headHtmlInjectionHint":"HTML code to be injected just before the closing head tag. Usually for script tags.","bodyHtmlInjection":"Body HTML Injection","bodyHtmlInjectionHint":"HTML code to be injected just before the closing body tag.","downloadThemes":"Download Themes","iconset":"Icon Set","iconsetHint":"Set of icons to use for the sidebar navigation.","downloadName":"Name","downloadAuthor":"Author","downloadDownload":"Download","cssOverrideWarning":"{{caution}} When adding styles for page content, you must scope them to the {{cssClass}} class. Omitting this could break the layout of the editor!","cssOverrideWarningCaution":"CAUTION:","options":"Theme Options","tocHeadingLevels":"Default TOC Heading Levels","tocHeadingLevelsHint":"The table of contents will show headings from and up to the selected levels by default."},"groups":{"title":"Groups"},"users":{"title":"Users","active":"Active","inactive":"Inactive","verified":"Verified","unverified":"Unverified","edit":"Edit User","id":"ID {{id}}","basicInfo":"Basic Info","email":"Email","displayName":"Display Name","authentication":"Authentication","authProvider":"Provider","password":"Password","changePassword":"Change Password","newPassword":"New Password","tfa":"Two Factor Authentication (2FA)","toggle2FA":"Toggle 2FA","authProviderId":"Provider Id","groups":"User Groups","noGroupAssigned":"This user is not assigned to any group yet. You must assign at least 1 group to a user.","selectGroup":"Select Group...","groupAssign":"Assign","extendedMetadata":"Extended Metadata","location":"Location","jobTitle":"Job Title","timezone":"Timezone","userUpdateSuccess":"User updated successfully.","userAlreadyAssignedToGroup":"User is already assigned to this group!","deleteConfirmTitle":"Delete User?","deleteConfirmText":"Are you sure you want to delete user {{username}}?","updateUser":"Update User","groupAssignNotice":"Note that you cannot assign users to the Administrators or Guests groups from this panel.","deleteConfirmForeignNotice":"Note that you cannot delete a user that already created content. You must instead either deactivate the user or delete all content that was created by that user.","userVerifySuccess":"User has been verified successfully.","userActivateSuccess":"User has been activated successfully.","userDeactivateSuccess":"User deactivated successfully.","deleteConfirmReplaceWarn":"Any content (pages, uploads, comments, etc.) that was created by this user will be reassigned to the user selected below. It is recommended to create a dummy target user (e.g. Deleted User) if you don't want the content to be reassigned to any current active user.","userTFADisableSuccess":"2FA was disabled successfully.","userTFAEnableSuccess":"2FA was enabled successfully."},"auth":{"title":"Authentication","subtitle":"Configure the authentication settings of your wiki","strategies":"Strategies","globalAdvSettings":"Global Advanced Settings","jwtAudience":"JWT Audience","jwtAudienceHint":"Audience URN used in JWT issued upon login. Usually your domain name. (e.g. urn:your.domain.com)","tokenExpiration":"Token Expiration","tokenExpirationHint":"The expiration period of a token until it must be renewed. (default: 30m)","tokenRenewalPeriod":"Token Renewal Period","tokenRenewalPeriodHint":"The maximum period a token can be renewed when expired. (default: 14d)","strategyState":"This strategy is {{state}} {{locked}}","strategyStateActive":"active","strategyStateInactive":"not active","strategyStateLocked":"and cannot be disabled.","strategyConfiguration":"Strategy Configuration","strategyNoConfiguration":"This strategy has no configuration options you can modify.","registration":"Registration","selfRegistration":"Allow self-registration","selfRegistrationHint":"Allow any user successfully authorized by the strategy to access the wiki.","domainsWhitelist":"Limit to specific email domains","domainsWhitelistHint":"A list of domains authorized to register. The user email address domain must match one of these to gain access.","autoEnrollGroups":"Assign to group","autoEnrollGroupsHint":"Automatically assign new users to these groups.","security":"Security","force2fa":"Force all users to use Two-Factor Authentication (2FA)","force2faHint":"Users will be required to setup 2FA the first time they login and cannot be disabled by the user.","configReference":"Configuration Reference","configReferenceSubtitle":"Some strategies may require some configuration values to be set on your provider. These are provided for reference only and may not be needed by the current strategy.","siteUrlNotSetup":"You must set a valid {{siteUrl}} first! Click on {{general}} in the left sidebar.","allowedWebOrigins":"Allowed Web Origins","callbackUrl":"Callback URL / Redirect URI","loginUrl":"Login URL","logoutUrl":"Logout URL","tokenEndpointAuthMethod":"Token Endpoint Authentication Method","refreshSuccess":"List of strategies has been refreshed.","saveSuccess":"Authentication configuration saved successfully.","activeStrategies":"Active Strategies","addStrategy":"Add Strategy","strategyIsEnabled":"Active","strategyIsEnabledHint":"Are users able to login using this strategy?","displayName":"Display Name","displayNameHint":"The title shown to the end user for this authentication strategy."},"editor":{"title":"Editor"},"logging":{"title":"Logging"},"rendering":{"title":"Rendering","subtitle":"Configure the page rendering pipeline"},"search":{"title":"Search Engine","subtitle":"Configure the search capabilities of your wiki","rebuildIndex":"Rebuild Index","searchEngine":"Search Engine","engineConfig":"Engine Configuration","engineNoConfig":"This engine has no configuration options you can modify.","listRefreshSuccess":"List of search engines has been refreshed.","configSaveSuccess":"Search engine configuration saved successfully.","indexRebuildSuccess":"Index rebuilt successfully."},"storage":{"title":"Storage","subtitle":"Set backup and sync targets for your content","targets":"Targets","status":"Status","lastSync":"Last synchronization {{time}}","lastSyncAttempt":"Last attempt was {{time}}","errorMsg":"Error Message","noTarget":"You don't have any active storage target.","targetConfig":"Target Configuration","noConfigOption":"This storage target has no configuration options you can modify.","syncDirection":"Sync Direction","syncDirectionSubtitle":"Choose how content synchronization is handled for this storage target.","syncDirBi":"Bi-directional","syncDirPush":"Push to target","syncDirPull":"Pull from target","unsupported":"Unsupported","syncDirBiHint":"In bi-directional mode, content is first pulled from the storage target. Any newer content overwrites local content. New content since last sync is then pushed to the storage target, overwriting any content on target if present.","syncDirPushHint":"Content is always pushed to the storage target, overwriting any existing content. This is safest choice for backup scenarios.","syncDirPullHint":"Content is always pulled from the storage target, overwriting any local content which already exists. This choice is usually reserved for single-use content import. Caution with this option as any local content will always be overwritten!","syncSchedule":"Sync Schedule","syncScheduleHint":"For performance reasons, this storage target synchronize changes on an interval-based schedule, instead of on every change. Define at which interval should the synchronization occur.","syncScheduleCurrent":"Currently set to every {{schedule}}.","syncScheduleDefault":"The default is every {{schedule}}.","actions":"Actions","actionRun":"Run","targetState":"This storage target is {{state}}","targetStateActive":"active","targetStateInactive":"inactive","actionsInactiveWarn":"You must enable this storage target and apply changes before you can run actions."},"api":{"title":"API Access","subtitle":"Manage keys to access the API","enabled":"API Enabled","disabled":"API Disabled","enableButton":"Enable API","disableButton":"Disable API","newKeyButton":"New API Key","headerName":"Name","headerKeyEnding":"Key Ending","headerExpiration":"Expiration","headerCreated":"Created","headerLastUpdated":"Last Updated","headerRevoke":"Revoke","noKeyInfo":"No API keys have been generated yet.","revokeConfirm":"Revoke API Key?","revokeConfirmText":"Are you sure you want to revoke key {{name}}? This action cannot be undone!","revoke":"Revoke","refreshSuccess":"List of API keys has been refreshed.","revokeSuccess":"The key has been revoked successfully.","newKeyTitle":"New API Key","newKeySuccess":"API key created successfully.","newKeyNameError":"Name is missing or invalid.","newKeyGroupError":"You must select a group.","newKeyGuestGroupError":"The guests group cannot be used for API keys.","newKeyNameHint":"Purpose of this key","newKeyName":"Name","newKeyExpiration":"Expiration","newKeyExpirationHint":"You can still revoke a key anytime regardless of the expiration.","newKeyPermissionScopes":"Permission Scopes","newKeyFullAccess":"Full Access","newKeyGroupPermissions":"or use group permissions...","newKeyGroup":"Group","newKeyGroupHint":"The API key will have the same permissions as the selected group.","expiration30d":"30 days","expiration90d":"90 days","expiration180d":"180 days","expiration1y":"1 year","expiration3y":"3 years","newKeyCopyWarn":"Copy the key shown below as {{bold}}","newKeyCopyWarnBold":"it will NOT be shown again","toggleStateEnabledSuccess":"API has been enabled successfully.","toggleStateDisabledSuccess":"API has been disabled successfully."},"system":{"title":"System Info","subtitle":"Information about your system","hostInfo":"Host Information","currentVersion":"Current Version","latestVersion":"Latest Version","published":"Published","os":"Operating System","hostname":"Hostname","cpuCores":"CPU Cores","totalRAM":"Total RAM","workingDirectory":"Working Directory","configFile":"Configuration File","ramUsage":"RAM Usage: {{used}} / {{total}}","dbPartialSupport":"Your database version is not fully supported. Some functionality may be limited or not work as expected.","refreshSuccess":"System Info has been refreshed."},"utilities":{"title":"Utilities","subtitle":"Maintenance and miscellaneous tools","tools":"Tools","authTitle":"Authentication","authSubtitle":"Various tools for authentication / users","cacheTitle":"Flush Cache","cacheSubtitle":"Flush cache of various components","graphEndpointTitle":"GraphQL Endpoint","graphEndpointSubtitle":"Change the GraphQL endpoint for Wiki.js","importv1Title":"Import from Wiki.js 1.x","importv1Subtitle":"Migrate data from a previous 1.x installation","telemetryTitle":"Telemetry","telemetrySubtitle":"Enable/Disable telemetry or reset the client ID","contentTitle":"Content","contentSubtitle":"Various tools for pages","exportTitle":"Export to Disk","exportSubtitle":"Save content to tarball for backup / migration"},"dev":{"title":"Developer Tools","flags":{"title":"Flags"},"graphiql":{"title":"GraphiQL"},"voyager":{"title":"Voyager"}},"contribute":{"title":"Contribute to Wiki.js","subtitle":"Help support Wiki.js development and operations","fundOurWork":"Fund our work","spreadTheWord":"Spread the word","talkToFriends":"Talk to your friends and colleagues about how awesome Wiki.js is!","followUsOnTwitter":"Follow us on {{0}}.","submitAnIdea":"Submit an idea or vote on a proposed one on the {{0}}.","submitAnIdeaLink":"feature requests board","foundABug":"Found a bug? Submit an issue on {{0}}.","helpTranslate":"Help translate Wiki.js in your language. Let us know on {{0}}.","makeADonation":"Make a donation","contribute":"Contribute","openCollective":"Wiki.js is also part of the Open Collective initiative, a transparent fund that goes toward community resources. You can contribute financially by making a monthly or one-time donation:","needYourHelp":"We need your help to keep improving the software and run the various associated services (e.g. hosting and networking).","openSource":"Wiki.js is a free and open-source software brought to you with {{0}} by {{1}} and {{2}}.","openSourceContributors":"contributors","tshirts":"You can also buy Wiki.js t-shirts to support the project financially:","shop":"Wiki.js Shop","becomeAPatron":"Become a Patron","patreon":"Become a backer or sponsor via Patreon (goes directly into supporting lead developer Nicolas Giard's goal of working full-time on Wiki.js)","paypal":"Make a one-time or recurring donation via Paypal:","ethereum":"We accept donations using Ethereum:","github":"Become a sponsor via GitHub Sponsors (goes directly into supporting lead developer Nicolas Giard's goal of working full-time on Wiki.js)","becomeASponsor":"Become a Sponsor"},"nav":{"site":"Site","users":"Users","modules":"Modules","system":"System"},"pages":{"title":"Pages"},"navigation":{"title":"Navigation","subtitle":"Manage the site navigation","link":"Link","divider":"Divider","header":"Header","label":"Label","icon":"Icon","targetType":"Target Type","target":"Target","noSelectionText":"Select a navigation item on the left.","untitled":"Untitled {{kind}}","navType":{"external":"External Link","home":"Home","page":"Page","searchQuery":"Search Query","externalblank":"External Link (New Window)"},"edit":"Edit {{kind}}","delete":"Delete {{kind}}","saveSuccess":"Navigation saved successfully.","noItemsText":"Click the Add button to add your first navigation item.","emptyList":"Navigation is empty","visibilityMode":{"all":"Visible to everyone","restricted":"Visible to select groups..."},"selectPageButton":"Select Page...","mode":"Navigation Mode","modeSiteTree":{"title":"Site Tree","description":"Classic Tree-based Navigation"},"modeCustom":{"title":"Custom Navigation","description":"Static Navigation Menu + Site Tree Button"},"modeNone":{"title":"None","description":"Disable Site Navigation"},"copyFromLocale":"Copy from locale...","sourceLocale":"Source Locale","sourceLocaleHint":"The locale from which navigation items will be copied from.","copyFromLocaleInfoText":"Select the locale from which items will be copied from. Items will be appended to the current list of items in the active locale.","modeStatic":{"title":"Static Navigation","description":"Static Navigation Menu Only"}},"mail":{"title":"Mail","subtitle":"Configure mail settings","configuration":"Configuration","dkim":"DKIM (optional)","test":"Send a test email","testRecipient":"Recipient Email Address","testSend":"Send Email","sender":"Sender","senderName":"Sender Name","senderEmail":"Sender Email","smtp":"SMTP Settings","smtpHost":"Host","smtpPort":"Port","smtpPortHint":"Usually 465 (recommended), 587 or 25.","smtpTLS":"Secure (TLS)","smtpTLSHint":"Should be enabled when using port 465, otherwise turned off (587 or 25).","smtpUser":"Username","smtpPwd":"Password","dkimHint":"DKIM (DomainKeys Identified Mail) provides a layer of security on all emails sent from Wiki.js by providing the means for recipients to validate the domain name and ensure the message authenticity.","dkimUse":"Use DKIM","dkimDomainName":"Domain Name","dkimKeySelector":"Key Selector","dkimPrivateKey":"Private Key","dkimPrivateKeyHint":"Private key for the selector in PEM format","testHint":"Send a test email to ensure your SMTP configuration is working.","saveSuccess":"Configuration saved successfully.","sendTestSuccess":"A test email was sent successfully.","smtpVerifySSL":"Verify SSL Certificate","smtpVerifySSLHint":"Some hosts requires SSL certificate checking to be disabled. Leave enabled for proper security.","smtpName":"Client Identifying Hostname","smtpNameHint":"An optional name to send to the SMTP server to identify your mailer. Leave empty to use server hostname. For Google Workspace customers, this should be your main domain name."},"webhooks":{"title":"Webhooks","subtitle":"Manage webhooks to external services"},"adminArea":"Administration Area","analytics":{"title":"Analytics","subtitle":"Add analytics and tracking tools to your wiki","providers":"Providers","providerConfiguration":"Provider Configuration","providerNoConfiguration":"This provider has no configuration options you can modify.","refreshSuccess":"List of providers refreshed successfully.","saveSuccess":"Analytics configuration saved successfully"},"comments":{"title":"Comments","provider":"Provider","subtitle":"Add discussions to your wiki pages","providerConfig":"Provider Configuration","providerNoConfig":"This provider has no configuration options you can modify.","configSaveSuccess":"Comments configuration saved successfully."},"tags":{"title":"Tags","subtitle":"Manage page tags","emptyList":"No tags to display.","edit":"Edit Tag","tag":"Tag","label":"Label","date":"Created {{created}} and last updated {{updated}}.","delete":"Delete this tag","noSelectionText":"Select a tag from the list on the left.","noItemsText":"Add a tag to a page to get started.","refreshSuccess":"Tags have been refreshed.","deleteSuccess":"Tag deleted successfully.","saveSuccess":"Tag has been saved successfully.","filter":"Filter...","viewLinkedPages":"View Linked Pages","deleteConfirm":"Delete Tag?","deleteConfirmText":"Are you sure you want to delete tag {{tag}}? The tag will also be unlinked from all pages."},"ssl":{"title":"SSL","subtitle":"Manage SSL configuration","provider":"Provider","providerHint":"Select Custom Certificate if you have your own certificate already.","domain":"Domain","domainHint":"Enter the fully qualified domain pointing to your wiki. (e.g. wiki.example.com)","providerOptions":"Provider Options","providerDisabled":"Disabled","providerLetsEncrypt":"Let's Encrypt","providerCustomCertificate":"Custom Certificate","ports":"Ports","httpPort":"HTTP Port","httpPortHint":"Non-SSL port the server will listen to for HTTP requests. Usually 80 or 3000.","httpsPort":"HTTPS Port","httpsPortHint":"SSL port the server will listen to for HTTPS requests. Usually 443.","httpPortRedirect":"Redirect HTTP requests to HTTPS","httpPortRedirectHint":"Will automatically redirect any requests on the HTTP port to HTTPS.","writableConfigFileWarning":"Note that your config file must be writable in order to persist ports configuration.","renewCertificate":"Renew Certificate","status":"Certificate Status","expiration":"Certificate Expiration","subscriberEmail":"Subscriber Email","currentState":"Current State","httpPortRedirectTurnOn":"Turn On","httpPortRedirectTurnOff":"Turn Off","renewCertificateLoadingTitle":"Renewing Certificate...","renewCertificateLoadingSubtitle":"Do not leave this page.","renewCertificateSuccess":"Certificate renewed successfully.","httpPortRedirectSaveSuccess":"HTTP Redirection changed successfully."},"security":{"title":"Security","maxUploadSize":"Max Upload Size","maxUploadBatch":"Max Files per Upload","maxUploadBatchHint":"How many files can be uploaded in a single batch?","maxUploadSizeHint":"The maximum size for a single file.","maxUploadSizeSuffix":"bytes","maxUploadBatchSuffix":"files","uploads":"Uploads","uploadsInfo":"These settings only affect Wiki.js. If you're using a reverse-proxy (e.g. nginx, apache, Cloudflare), you must also change its settings to match.","subtitle":"Configure security settings","login":"Login","loginScreen":"Login Screen","jwt":"JWT Configuration","bypassLogin":"Bypass Login Screen","bypassLoginHint":"Should the user be redirected automatically to the first authentication provider.","loginBgUrl":"Login Background Image URL","loginBgUrlHint":"Specify an image to use as the login background. PNG and JPG are supported, 1920x1080 recommended. Leave empty for default. Click the button on the right to upload a new image. Note that the Guests group must have read-access to the selected image!","hideLocalLogin":"Hide Local Authentication Provider","hideLocalLoginHint":"Don't show the local authentication provider on the login screen. Add ?all to the URL to temporarily use it.","loginSecurity":"Security","enforce2fa":"Enforce 2FA","enforce2faHint":"Force all users to use Two-Factor Authentication when using an authentication provider with a user / password form."},"extensions":{"title":"Extensions","subtitle":"Install extensions for extra functionality"}},"editor":{"page":"Page","save":{"processing":"Rendering","pleaseWait":"Please wait...","createSuccess":"Page created successfully.","error":"An error occurred while creating the page","updateSuccess":"Page updated successfully.","saved":"Saved"},"props":{"pageProperties":"Page Properties","pageInfo":"Page Info","title":"Title","shortDescription":"Short Description","shortDescriptionHint":"Shown below the title","pathCategorization":"Path & Categorization","locale":"Locale","path":"Path","pathHint":"Do not include any leading or trailing slashes.","tags":"Tags","tagsHint":"Use tags to categorize your pages and make them easier to find.","publishState":"Publishing State","publishToggle":"Published","publishToggleHint":"Unpublished pages are still visible to users with write permissions on this page.","publishStart":"Publish starting on...","publishStartHint":"Leave empty for no start date","publishEnd":"Publish ending on...","publishEndHint":"Leave empty for no end date","info":"Info","scheduling":"Scheduling","social":"Social","categorization":"Categorization","socialFeatures":"Social Features","allowComments":"Allow Comments","allowCommentsHint":"Enable commenting abilities on this page.","allowRatings":"Allow Ratings","displayAuthor":"Display Author Info","displaySharingBar":"Display Sharing Toolbar","displaySharingBarHint":"Show a toolbar with buttons to share and print this page","displayAuthorHint":"Show the page author along with the last edition time.","allowRatingsHint":"Enable rating capabilities on this page.","scripts":"Scripts","css":"CSS","cssHint":"CSS will automatically be minified upon saving. Do not include surrounding style tags, only the actual CSS code.","styles":"Styles","html":"HTML","htmlHint":"You must surround your javascript code with HTML script tags.","toc":"TOC","tocTitle":"Table of Contents","tocUseDefault":"Use Site Defaults","tocHeadingLevels":"TOC Heading Levels","tocHeadingLevelsHint":"The table of contents will show headings from and up to the selected levels."},"unsaved":{"title":"Discard Unsaved Changes?","body":"You have unsaved changes. Are you sure you want to leave the editor and discard any modifications you made since the last save?"},"select":{"title":"Which editor do you want to use for this page?","cannotChange":"This cannot be changed once the page is created.","customView":"or create a custom view?"},"assets":{"title":"Assets","newFolder":"New Folder","folderName":"Folder Name","folderNameNamingRules":"Must follow the asset folder {{namingRules}}.","folderNameNamingRulesLink":"naming rules","folderEmpty":"This asset folder is empty.","fileCount":"{{count}} files","headerId":"ID","headerFilename":"Filename","headerType":"Type","headerFileSize":"File Size","headerAdded":"Added","headerActions":"Actions","uploadAssets":"Upload Assets","uploadAssetsDropZone":"Browse or Drop files here...","fetchImage":"Fetch Remote Image","imageAlign":"Image Alignment","renameAsset":"Rename Asset","renameAssetSubtitle":"Enter the new name for this asset:","deleteAsset":"Delete Asset","deleteAssetConfirm":"Are you sure you want to delete asset","deleteAssetWarn":"This action cannot be undone!","refreshSuccess":"List of assets refreshed successfully.","uploadFailed":"File upload failed.","folderCreateSuccess":"Asset folder created successfully.","renameSuccess":"Asset renamed successfully.","deleteSuccess":"Asset deleted successfully.","noUploadError":"You must choose a file to upload first!"},"backToEditor":"Back to Editor","markup":{"bold":"Bold","italic":"Italic","strikethrough":"Strikethrough","heading":"Heading {{level}}","subscript":"Subscript","superscript":"Superscript","blockquote":"Blockquote","blockquoteInfo":"Info Blockquote","blockquoteSuccess":"Success Blockquote","blockquoteWarning":"Warning Blockquote","blockquoteError":"Error Blockquote","unorderedList":"Unordered List","orderedList":"Ordered List","inlineCode":"Inline Code","keyboardKey":"Keyboard Key","horizontalBar":"Horizontal Bar","togglePreviewPane":"Hide / Show Preview Pane","insertLink":"Insert Link","insertAssets":"Insert Assets","insertBlock":"Insert Block","insertCodeBlock":"Insert Code Block","insertVideoAudio":"Insert Video / Audio","insertDiagram":"Insert Diagram","insertMathExpression":"Insert Math Expression","tableHelper":"Table Helper","distractionFreeMode":"Distraction Free Mode","markdownFormattingHelp":"Markdown Formatting Help","noSelectionError":"Text must be selected first!","toggleSpellcheck":"Toggle Spellcheck"},"ckeditor":{"stats":"{{chars}} chars, {{words}} words"},"conflict":{"title":"Resolve Save Conflict","useLocal":"Use Local","useRemote":"Use Remote","useRemoteHint":"Discard local changes and use latest version","useLocalHint":"Use content in the left panel","viewLatestVersion":"View Latest Version","infoGeneric":"A more recent version of this page was saved by {{authorName}}, {{date}}","whatToDo":"What do you want to do?","whatToDoLocal":"Use your current local version and ignore the latest changes.","whatToDoRemote":"Use the remote version (latest) and discard your changes.","overwrite":{"title":"Overwrite with Remote Version?","description":"Are you sure you want to replace your current version with the latest remote content? {{refEditsLost}}","editsLost":"Your current edits will be lost."},"localVersion":"Local Version {{refEditable}}","editable":"(editable)","readonly":"(read-only)","remoteVersion":"Remote Version {{refReadOnly}}","leftPanelInfo":"Your current edit, based on page version from {{date}}","rightPanelInfo":"Last edited by {{authorName}}, {{date}}","pageTitle":"Title:","pageDescription":"Description:","warning":"Save conflict! Another user has already modified this page."},"unsavedWarning":"You have unsaved edits. Are you sure you want to leave the editor?"},"tags":{"currentSelection":"Current Selection","clearSelection":"Clear Selection","selectOneMoreTags":"Select one or more tags","searchWithinResultsPlaceholder":"Search within results...","locale":"Locale","orderBy":"Order By","selectOneMoreTagsHint":"Select one or more tags on the left.","retrievingResultsLoading":"Retrieving page results...","noResults":"Couldn't find any page with the selected tags.","noResultsWithFilter":"Couldn't find any page matching the current filtering options.","pageLastUpdated":"Last Updated {{date}}","orderByField":{"creationDate":"Creation Date","ID":"ID","lastModified":"Last Modified","path":"Path","title":"Title"},"localeAny":"Any"},"history":{"restore":{"confirmTitle":"Restore page version?","confirmText":"Are you sure you want to restore this page content as it was on {{date}}? This version will be copied on top of the current history. As such, newer versions will still be preserved.","confirmButton":"Restore","success":"Page version restored succesfully!"}},"profile":{"displayName":"Display Name","location":"Location","jobTitle":"Job Title","timezone":"Timezone","title":"Profile","subtitle":"My personal info","myInfo":"My Info","viewPublicProfile":"View Public Profile","auth":{"title":"Authentication","provider":"Provider","changePassword":"Change Password","currentPassword":"Current Password","newPassword":"New Password","verifyPassword":"Confirm New Password","changePassSuccess":"Password changed successfully."},"groups":{"title":"Groups"},"activity":{"title":"Activity","joinedOn":"Joined on","lastUpdatedOn":"Profile last updated on","lastLoginOn":"Last login on","pagesCreated":"Pages created","commentsPosted":"Comments posted"},"save":{"success":"Profile saved successfully."},"pages":{"title":"Pages","subtitle":"List of pages I created or last modified","emptyList":"No pages to display.","refreshSuccess":"Page list has been refreshed.","headerTitle":"Title","headerPath":"Path","headerCreatedAt":"Created","headerUpdatedAt":"Last Updated"},"comments":{"title":"Comments"},"preferences":"Preferences","dateFormat":"Date Format","localeDefault":"Locale Default","appearance":"Appearance","appearanceDefault":"Site Default","appearanceLight":"Light","appearanceDark":"Dark"}}	f	English	English	100	2026-03-08T13:42:16.089Z	2026-03-09T13:04:48.249Z
\.


--
-- Data for Name: loggers; Type: TABLE DATA; Schema: public; Owner: wikijs
--

COPY public.loggers (key, "isEnabled", level, config) FROM stdin;
airbrake	f	warn	{}
bugsnag	f	warn	{"key":""}
disk	f	info	{}
eventlog	f	warn	{}
loggly	f	warn	{"token":"","subdomain":""}
logstash	f	warn	{}
newrelic	f	warn	{}
papertrail	f	warn	{"host":"","port":0}
raygun	f	warn	{}
rollbar	f	warn	{"key":""}
sentry	f	warn	{"key":""}
syslog	f	warn	{}
\.


--
-- Data for Name: migrations; Type: TABLE DATA; Schema: public; Owner: wikijs
--

COPY public.migrations (id, name, batch, migration_time) FROM stdin;
1	2.0.0.js	1	2026-03-08 11:06:55.955+00
2	2.1.85.js	1	2026-03-08 11:06:55.957+00
3	2.2.3.js	1	2026-03-08 11:06:55.974+00
4	2.2.17.js	1	2026-03-08 11:06:55.978+00
5	2.3.10.js	1	2026-03-08 11:06:55.987+00
6	2.3.23.js	1	2026-03-08 11:06:55.991+00
7	2.4.13.js	1	2026-03-08 11:06:55.994+00
8	2.4.14.js	1	2026-03-08 11:06:56.001+00
9	2.4.36.js	1	2026-03-08 11:06:56.006+00
10	2.4.61.js	1	2026-03-08 11:06:56.017+00
11	2.5.1.js	1	2026-03-08 11:06:56.027+00
12	2.5.12.js	1	2026-03-08 11:06:56.034+00
13	2.5.108.js	1	2026-03-08 11:06:56.042+00
14	2.5.118.js	1	2026-03-08 11:06:56.043+00
15	2.5.122.js	1	2026-03-08 11:06:56.054+00
16	2.5.128.js	1	2026-03-08 11:06:56.061+00
\.


--
-- Data for Name: migrations_lock; Type: TABLE DATA; Schema: public; Owner: wikijs
--

COPY public.migrations_lock (index, is_locked) FROM stdin;
1	0
\.


--
-- Data for Name: navigation; Type: TABLE DATA; Schema: public; Owner: wikijs
--

COPY public.navigation (key, config) FROM stdin;
site	[{"locale":"en","items":[{"id":"cd5b7c05-9758-499e-bac5-b0cc97ea4aef","kind":"link","label":"Home","icon":"mdi-home","targetType":"home","target":"/","visibilityMode":"all","visibilityGroups":null}]},{"locale":"fr","items":[]}]
\.


--
-- Data for Name: pageHistory; Type: TABLE DATA; Schema: public; Owner: wikijs
--

COPY public."pageHistory" (id, path, hash, title, description, "isPrivate", "isPublished", "publishStartDate", "publishEndDate", action, "pageId", content, "contentType", "createdAt", "editorKey", "localeCode", "authorId", "versionDate", extra) FROM stdin;
1	home	b29b5d2ce62e55412776ab98f05631e0aa96597b	Bienvenue dans le cours sur la Sécurité des Systèmes d'information		f	t			deleted	1	# Header\nYour content here	markdown	2026-03-08T14:17:37.976Z	markdown	en	1	2026-03-08T13:55:27.642Z	{}
2	ebios-intro	462c81fb17efa5f23f5869263ae1dd136aedbedf	ebios-intro		f	t			updated	10	# EBIOS - Introduction\n\n## Concepts\n- Actifs essentiels\n- Menaces\n- Vulnérabilités\n- Scénarios	markdown	2026-03-08T15:09:11.614Z	markdown	fr	1	2026-03-08T14:47:20.791Z	{}
3	ebios-intro	462c81fb17efa5f23f5869263ae1dd136aedbedf	ebios-intro		f	t			updated	10	# EBIOS - Introduction\n\n## Concepts\n- Actifs essentiels\n- Menaces\n- Vulnérabilités\n- Scénarios	markdown	2026-03-08T15:23:21.046Z	markdown	fr	1	2026-03-08T15:09:13.668Z	{}
4	ebios-intro	462c81fb17efa5f23f5869263ae1dd136aedbedf	ebios-intro		f	t			updated	10	[home](/home)# EBIOS - Introduction\n\n## Concepts\n- Actifs essentiels\n- Menaces\n- Vulnérabilités\n- Scénarios	markdown	2026-03-08T15:23:28.723Z	markdown	fr	1	2026-03-08T15:23:22.248Z	{}
5	home	b29b5d2ce62e55412776ab98f05631e0aa96597b	Welcome Page	Good Luck	f	t			updated	19	# Have fun\n:)	markdown	2026-03-08T15:28:43.509Z	markdown	en	1	2026-03-08T15:12:21.409Z	{}
6	rgpd	a1253a913676dd890221765c67d996054b205203	RÈGLEMENT GÉNÉRAL DE LA PROTECTION DES DONNÉES		f	t			deleted	20	# RGPD - Règlement Général sur la Protection des Données\n\n## Objectifs\n- Protéger les données personnelles.\n- Harmoniser les règles dans l’UE.\n- Renforcer les droits des personnes.\n\n## Principes clés\n- Licéité, loyauté, transparence\n- Minimisation des données\n- Limitation de conservation\n- Intégrité et confidentialité\n- Accountability\n\n## Droits des personnes\n- Accès, rectification, effacement\n- Portabilité\n- Opposition\n- Limitation du traitement\n\n## Obligations\n- Registre des traitements\n- AIPD\n- Notification des violations\n	markdown	2026-03-08T15:30:59.135Z	markdown	en	1	2026-03-08T15:27:14.159Z	{}
7	home/EbiosRM	3123cae6782d1f00cdaac94c2c3adc263218df68	Ebios RM		f	t			updated	22	# EBIOS - Introduction\n\n## Concepts\n- Actifs essentiels\n- Menaces\n- Vulnérabilités\n- Scénarios\nroot@debianssi:/opt/ssi-lab/wiki-content# cat ebios-rm.md\n# EBIOS Risk Manager\n\n## Étapes\n1. Cadrage\n2. Événements redoutés\n3. Scénarios stratégiques\n4. Scénarios opérationnels\n5. Traitement des risques\n	markdown	2026-03-08T15:52:07.631Z	markdown	en	1	2026-03-08T15:32:59.948Z	{}
8	home/EbiosRM	3123cae6782d1f00cdaac94c2c3adc263218df68	Ebios RM		f	t			updated	22	# EBIOS Risk Manager — Cours complet\n\n## 🎯 Objectifs pédagogiques\n- Comprendre la méthode EBIOS RM en profondeur.\n- Savoir appliquer chaque atelier avec précision.\n- Construire des scénarios stratégiques et opérationnels réalistes.\n- Utiliser EBIOS RM pour analyser les risques d’une application GitLab.\n- Produire un JSON structuré représentant les scénarios de menace.\n- Préparer les étudiants à un TP complet d’analyse de risques.\n\n---\n\n# 🧩 Introduction générale\n\nEBIOS Risk Manager (EBIOS RM) est la méthode officielle de l’ANSSI pour analyser les risques de cybersécurité.  \nElle repose sur **5 ateliers**, chacun produisant des livrables concrets.\n\nLes ateliers sont :\n\n1. **Cadrage et socle de sécurité**  \n2. **Sources de risques**  \n3. **Scénarios stratégiques**  \n4. **Scénarios opérationnels**  \n5. **Traitement du risque**\n\nEBIOS RM est particulièrement adaptée aux environnements modernes : DevOps, GitLab, CI/CD, cloud, API, microservices, etc.\n\n---\n\n# 🏗️ Atelier 1 — Cadrage et socle de sécurité\n\n## 🎯 Objectifs\n- Définir le périmètre analysé.\n- Identifier les actifs essentiels.\n- Déterminer les besoins de sécurité (C, I, D).\n- Décrire le socle de sécurité existant.\n\n## 📌 Contenu détaillé\n### 1. Définition du périmètre\n- Application GitLab interne\n- Serveur GitLab CE/EE\n- Runners CI/CD\n- Pipeline de déploiement\n- Dépôts de code source\n- Utilisateurs internes et externes\n\n### 2. Parties prenantes\n- Développeurs\n- DevOps\n- Administrateurs système\n- RSSI\n- Clients internes\n- Prestataires (hébergement, maintenance)\n\n### 3. Actifs essentiels\n| Actif | Description | Criticité |\n|-------|-------------|-----------|\n| Code source | Propriété intellectuelle | Très élevé |\n| Secrets CI/CD | Tokens, clés SSH | Très élevé |\n| Pipelines | Automatisation des déploiements | Élevé |\n| Serveur GitLab | Plateforme centrale | Élevé |\n| Identités utilisateurs | Comptes GitLab | Élevé |\n\n### 4. Besoins de sécurité\n- **Confidentialité** : secrets CI/CD, code source\n- **Intégrité** : pipelines, commits, tags\n- **Disponibilité** : GitLab, runners, API\n\n### 5. Socle de sécurité existant\n- Authentification LDAP\n- Sauvegardes quotidiennes\n- HTTPS obligatoire\n- Runners isolés\n- Journalisation partielle\n\n---\n\n# 🧪 TP Atelier 1\n1. Définir le périmètre d’un GitLab fictif.  \n2. Identifier 5 actifs essentiels.  \n3. Définir les besoins C/I/D pour chaque actif.  \n4. Décrire le socle de sécurité existant.\n\n---\n\n# 🏗️ Atelier 2 — Sources de risques\n\n## 🎯 Objectifs\n- Identifier les acteurs menaçants.\n- Décrire leurs motivations.\n- Évaluer leurs capacités.\n\n## 📌 Typologie des acteurs\n### 1. Cybercriminels\n- Motivation : argent\n- Capacité : élevée\n- Exemple : ransomware via runner compromis\n\n### 2. Employé malveillant\n- Motivation : sabotage, vengeance\n- Capacité : très élevée (accès interne)\n\n### 3. Prestataire\n- Motivation : opportunisme\n- Capacité : moyenne à élevée\n\n### 4. Hacktiviste\n- Motivation : idéologie\n- Capacité : variable\n\n### 5. État / APT\n- Motivation : espionnage\n- Capacité : très élevée\n\n---\n\n# 🧪 TP Atelier 2\nAssocier chaque acteur à :\n- une motivation\n- une capacité\n- une cible GitLab\n\n---\n\n# 🏗️ Atelier 3 — Scénarios stratégiques\n\n## 🎯 Objectifs\n- Construire des scénarios de menace de haut niveau.\n- Identifier les événements redoutés.\n- Décrire les objectifs des attaquants.\n\n## 📌 Exemple concret (GitLab)\n\n### 🎯 Événement redouté 1\n**ER1 : Compromission du code source**\n\n### 🎯 Événement redouté 2\n**ER2 : Injection de code malveillant dans un pipeline**\n\n### 🎯 Scénario stratégique (exemple)\n- Acteur : cybercriminel\n- Objectif : insérer un malware dans le code source\n- Cible : pipeline CI/CD\n- Impact : déploiement d’un logiciel compromis chez les clients\n\n---\n\n# 🧪 TP Atelier 3\nCréer 2 scénarios stratégiques pour GitLab :\n- un scénario interne\n- un scénario externe\n\n---\n\n# 🏗️ Atelier 4 — Scénarios opérationnels\n\n## 🎯 Objectifs\n- Décrire les attaques techniques possibles.\n- Identifier les vulnérabilités exploitées.\n- Décrire les chemins d’attaque.\n\n## 📌 Exemple concret (GitLab)\n\n### Scénario opérationnel 1 : Vol de token CI/CD\n1. Phishing d’un développeur  \n2. Accès au compte GitLab  \n3. Récupération des variables CI/CD  \n4. Injection de code malveillant dans un pipeline  \n5. Déploiement d’un malware\n\n### Scénario opérationnel 2 : Runner compromis\n1. Attaque sur un runner mal configuré  \n2. Exécution de commandes arbitraires  \n3. Accès aux secrets  \n4. Compromission du dépôt\n\n---\n\n# 🧪 TP Atelier 4\nDécrire un scénario opérationnel complet pour :\n- une attaque par clé SSH volée  \n- une attaque via runner compromis  \n\n---\n\n# 🏗️ Atelier 5 — Traitement du risque\n\n## 🎯 Objectifs\n- Définir les mesures de sécurité.\n- Réduire les risques majeurs.\n- Construire un plan d’action.\n\n## 📌 Mesures recommandées pour GitLab\n- MFA obligatoire  \n- Rotation automatique des tokens  \n- Runners isolés en VM  \n- Analyse SAST/DAST automatique  \n- Signature des commits  \n- Revue de code obligatoire  \n- Journalisation complète  \n- Sauvegardes chiffrées  \n\n---\n\n# 🧪 TP Atelier 5\nProposer 10 mesures pour réduire le risque de compromission du pipeline CI/CD.\n\n---\n\n# 🧩 Exemple complet de scénario JSON (GitLab)\n\nVoici un JSON structuré représentant un scénario EBIOS RM complet :\n\n```json\n{\n  "perimetre": "Plateforme GitLab interne",\n  "actifsEssentiels": [\n    {"nom": "Code source", "criticite": "Très élevé"},\n    {"nom": "Secrets CI/CD", "criticite": "Très élevé"},\n    {"nom": "Pipeline CI/CD", "criticite": "Élevé"}\n  ],\n  "acteurMenacant": {\n    "type": "Cybercriminel",\n    "motivation": "Gain financier",\n    "capacite": "Élevée"\n  },\n  "scenarioStrategique": {\n    "evenementRedoute": "Injection de code malveillant dans le pipeline",\n    "objectifAttaquant": "Déployer un malware chez les clients"\n  },\n  "scenarioOperationnel": {\n    "etapes": [\n      "Phishing d'un développeur",\n      "Accès au compte GitLab",\n      "Vol des variables CI/CD",\n      "Modification du pipeline",\n      "Déploiement du code malveillant"\n    ]\n  },\n  "mesures": [\n    "MFA obligatoire",\n    "Rotation des tokens",\n    "Isolation des runners",\n    "Analyse SAST/DAST",\n    "Signature des commits"\n  ]\n}\n	markdown	2026-03-08T15:55:54.331Z	markdown	en	1	2026-03-08T15:52:08.867Z	{}
9	home/ISO27002	693a3348faaadfcf0ebd0e6049bef202876a325b	ISO27002 - Bonne pratique pour les mesures de sécurité		f	t			updated	24	# ISO/IEC 27002 - Bonnes pratiques\n\n## Domaines\n- Politique de sécurité\n- Gestion des actifs\n- Contrôle d’accès\n- Cryptographie\n- Sécurité physique\n- Sécurité des opérations\n- Gestion des incidents\n	markdown	2026-03-08T15:59:52.331Z	markdown	en	1	2026-03-08T15:38:29.824Z	{}
10	home/ISO27005	d991eecc90b8d970c740f10d30f9930ee31e2973	ISO27005 - Gestion des risques liés à la sécurité de l’information		f	t			updated	25	# ISO/IEC 27005 - Gestion des risques\n\n## Étapes\n- Contexte\n- Identification des risques\n- Analyse\n- Évaluation\n- Traitement\n- Surveillance\n	markdown	2026-03-08T16:01:45.778Z	markdown	en	1	2026-03-08T15:39:55.938Z	{}
11	home/NIS2	5a451341a9927e5780ecb5370299b3fd36b7102a	NIS2 - Directive		f	t			updated	26	# Directive NIS2\n\n## Objectif\nRenforcer la cybersécurité des entités essentielles et importantes.\n\n## Exigences\n- Gouvernance SSI\n- Gestion des risques\n- Mesures techniques et organisationnelles\n- Gestion des incidents\n- Continuité d’activité\n	markdown	2026-03-08T16:03:01.866Z	markdown	en	1	2026-03-08T15:41:23.236Z	{}
12	home/rgpd	19efc204f624cfefa2e1b15f99ad966c78d02d7c	RGPD		f	t			updated	21	# RGPD - Règlement Général sur la Protection des Données\n\n## Objectifs\n- Protéger les données personnelles.\n- Harmoniser les règles dans l’UE.\n- Renforcer les droits des personnes.\n\n## Principes clés\n- Licéité, loyauté, transparence\n- Minimisation des données\n- Limitation de conservation\n- Intégrité et confidentialité\n- Accountability\n\n## Droits des personnes\n- Accès, rectification, effacement\n- Portabilité\n- Opposition\n- Limitation du traitement\n\n## Obligations\n- Registre des traitements\n- AIPD\n- Notification des violations\n	markdown	2026-03-08T16:04:02.268Z	markdown	en	1	2026-03-08T15:29:50.615Z	{}
13	home/MEHARI	87121be462bf1559e0552cfb4163d92ccde2810a	MEHARI - Analyse de risques		f	t			updated	27	# MEHARI - Analyse de risques\n\n## Principes\n- Scénarios de menaces\n- Gravité des impacts\n- Vraisemblance\n- Niveau de risque\n- Plans de traitement\n	markdown	2026-03-08T16:05:12.869Z	markdown	en	1	2026-03-08T15:42:46.729Z	{}
14	home/ISO27001	7a6220617768079052ad5660687c65706c2edd5c	ISO27001 - SMSI		f	t			updated	23	# ISO/IEC 27001 - SMSI\n\n## Objectif\nMettre en place un système de management de la sécurité de l’information.\n\n## Principes\n- Approche risques\n- PDCA\n- Leadership\n- Amélioration continue\n\n## Annexes\n- Annexe A : catalogue de contrôles\n	markdown	2026-03-08T16:07:07.505Z	markdown	en	1	2026-03-08T15:34:58.219Z	{}
15	home/MEHARI	87121be462bf1559e0552cfb4163d92ccde2810a	MEHARI - Analyse de risques		f	t			updated	27	# MEHARI — Méthode Harmonisée d'Analyse des Risques (Version enrichie)\n\n## 🎯 Objectifs pédagogiques\n- Comprendre la logique complète de la méthode MEHARI.\n- Savoir analyser les risques avec les grilles de sécurité.\n- Comprendre les notions de scénarios, vulnérabilités et impacts.\n- Apprendre à justifier chaque étape de l’analyse.\n- Préparer les étudiants à un TP complet d’analyse de risques.\n- Développer une vision opérationnelle de la sécurité.\n\n---\n\n# 🧩 Introduction générale\n\nMEHARI est une méthode française d’analyse des risques développée par le **CLUSIF**.  \nElle est utilisée pour :\n- évaluer les risques,\n- définir les mesures de sécurité,\n- structurer une démarche SSI,\n- préparer un SMSI (ISO 27001).\n\nMEHARI repose sur :\n- des **grilles de vulnérabilités**,\n- des **grilles de menaces**,\n- des **grilles d’impacts**,\n- des **scénarios de risques**.\n\nElle est très pédagogique et adaptée aux étudiants.\n\n---\n\n# 🧱 Pourquoi MEHARI est utile ?\n\n## ✔ Justification 1 : méthode simple et structurée\nLes grilles permettent une analyse claire et reproductible.\n\n## ✔ Justification 2 : adaptée aux organisations de toutes tailles\nPME, collectivités, grandes entreprises.\n\n## ✔ Justification 3 : compatible avec ISO 27005\nMEHARI = outil pratique  \nISO 27005 = cadre méthodologique\n\n## ✔ Justification 4 : très pédagogique\nLes étudiants comprennent rapidement les liens entre :\n- actifs,\n- menaces,\n- vulnérabilités,\n- impacts.\n\n---\n\n# 🧱 Les grandes étapes de MEHARI\n\n1. **Identification des enjeux**\n2. **Analyse des risques**\n3. **Évaluation des vulnérabilités**\n4. **Construction des scénarios**\n5. **Évaluation des impacts**\n6. **Choix des mesures**\n7. **Plan d’action**\n\nChaque étape est détaillée ci‑dessous.\n\n---\n\n# 🏗️ 1. Identification des enjeux\n\n## 🎯 Objectif\nComprendre ce qui est important pour l’organisation.\n\n## 📌 On identifie :\n- les actifs essentiels,\n- les processus critiques,\n- les dépendances,\n- les contraintes légales.\n\n## ✔ Justification\nImpossible d’analyser un risque sans connaître les enjeux.\n\n## 🧪 Exemple concret\nActif : base de données clients  \nEnjeu : continuité du service + RGPD  \n\n---\n\n# 🏗️ 2. Analyse des risques\n\n## 🎯 Objectif\nLister les risques potentiels.\n\n## 📌 On identifie :\n- les menaces,\n- les vulnérabilités,\n- les scénarios possibles.\n\n## ✔ Justification\nUn risque = menace + vulnérabilité + impact.\n\n## 🧪 Exemple concret\nMenace : ransomware  \nVulnérabilité : absence de sauvegarde hors ligne  \n\n---\n\n# 🏗️ 3. Évaluation des vulnérabilités\n\nMEHARI utilise des **grilles de vulnérabilités** pour évaluer :\n- la robustesse des mesures existantes,\n- les faiblesses techniques,\n- les faiblesses organisationnelles.\n\n## ✔ Justification\nLes vulnérabilités déterminent la probabilité d’un risque.\n\n## 🧪 Exemple concret\nVulnérabilité :  \n- pas de MFA → vulnérabilité élevée  \n- pas de segmentation réseau → vulnérabilité critique  \n\n---\n\n# 🏗️ 4. Construction des scénarios\n\n## 🎯 Objectif\nDécrire comment une menace peut exploiter une vulnérabilité.\n\n## 📌 Exemple de scénario\n1. Phishing d’un employé  \n2. Vol d’identifiants  \n3. Accès au serveur  \n4. Déploiement d’un ransomware  \n\n## ✔ Justification\nLes scénarios permettent de comprendre **comment** une attaque se produit.\n\n---\n\n# 🏗️ 5. Évaluation des impacts\n\nMEHARI utilise des **grilles d’impacts** pour évaluer :\n- l’impact financier,\n- l’impact opérationnel,\n- l’impact juridique,\n- l’impact image.\n\n## ✔ Justification\nUn risque n’est pas grave si l’impact est faible.\n\n## 🧪 Exemple concret\nImpact :  \n- perte de données clients → impact très élevé  \n- indisponibilité 2h → impact faible  \n\n---\n\n# 🏗️ 6. Choix des mesures\n\n## 🎯 Objectif\nRéduire les risques à un niveau acceptable.\n\n## 📌 Types de mesures\n- organisationnelles,\n- techniques,\n- physiques,\n- humaines.\n\n## ✔ Justification\nLes mesures doivent être adaptées au risque.\n\n## 🧪 Exemple concret\nRisque : ransomware  \nMesures :  \n- sauvegardes hors ligne,  \n- MFA,  \n- segmentation réseau,  \n- formation anti‑phishing.  \n\n---\n\n# 🏗️ 7. Plan d’action\n\n## 🎯 Objectif\nPlanifier les mesures dans le temps.\n\n## 📌 On définit :\n- priorité,\n- budget,\n- responsable,\n- échéance.\n\n## ✔ Justification\nSans plan d’action → analyse inutile.\n\n---\n\n# 🧱 Cas pratiques (mini‑études)\n\n## 🧪 Cas 1 : PME victime d’un ransomware\n- vulnérabilité : absence de sauvegarde  \n- impact : perte de données  \n- mesure : sauvegarde hors ligne  \n\n## 🧪 Cas 2 : Collectivité locale sans MFA\n- vulnérabilité : comptes non protégés  \n- impact : vol de données  \n- mesure : MFA obligatoire  \n\n## 🧪 Cas 3 : Hôpital avec serveurs obsolètes\n- vulnérabilité : absence de patch  \n- impact : risque vital  \n- mesure : plan de mise à jour  \n\n---\n\n# 🧠 Synthèse générale\n\nMEHARI permet :\n- d’analyser les risques de manière structurée,\n- de comprendre les vulnérabilités,\n- de construire des scénarios réalistes,\n- de définir des mesures adaptées,\n- de préparer un SMSI.\n\n---\n\n# 🧪 TP final complet\n\n1. Choisir un périmètre (ex : service RH).  \n2. Identifier les actifs essentiels.  \n3. Lister les menaces et vulnérabilités.  \n4. Construire 2 scénarios de risques.  \n5. Évaluer les impacts.  \n6. Proposer un plan de traitement.  \n7. Rédiger un plan d’action.  \n	markdown	2026-03-08T18:15:17.308Z	markdown	en	1	2026-03-08T16:05:13.986Z	{}
16	home/NIS2	5a451341a9927e5780ecb5370299b3fd36b7102a	NIS2 - Directive		f	t			updated	26	# Directive NIS2 — Sécurité des réseaux et systèmes d'information (Version enrichie)\n\n## 🎯 Objectifs pédagogiques\n- Comprendre le rôle et les objectifs de la directive NIS2.\n- Identifier les organisations concernées et leurs obligations.\n- Comprendre les exigences de cybersécurité imposées par l’UE.\n- Savoir justifier chaque exigence auprès d’étudiants ou d’auditeurs.\n- Apprendre les impacts concrets sur les entreprises.\n- Préparer les étudiants à un audit ou un TP de conformité NIS2.\n\n---\n\n# 🧩 Introduction générale\n\nLa directive **NIS2** (Network and Information Security 2) est une loi européenne visant à renforcer la cybersécurité des organisations essentielles au fonctionnement de la société.\n\nElle remplace la directive NIS1 (2016) et impose :\n- plus de secteurs concernés,\n- plus d’obligations,\n- plus de contrôles,\n- plus de sanctions.\n\nNIS2 est **obligatoire** pour les États membres, qui doivent la transposer dans leur droit national.\n\n---\n\n# 🧱 Pourquoi NIS2 existe ?\n\n## ✔ Justification 1 : explosion des cyberattaques\n- Ransomwares massifs\n- Attaques supply chain\n- Attaques sur les hôpitaux\n- Espionnage industriel\n\n## ✔ Justification 2 : dépendance numérique\nLes services essentiels (énergie, santé, transport…) reposent sur l’informatique.\n\n## ✔ Justification 3 : harmonisation européenne\nAvant NIS2, chaque pays avait son propre niveau d’exigence → incohérences.\n\n## ✔ Justification 4 : protéger la société\nUne attaque sur un hôpital ou un réseau électrique peut mettre des vies en danger.\n\n---\n\n# 🧱 Organisations concernées\n\nNIS2 distingue deux catégories :\n\n## 🔹 1. Entités essentielles\nExemples :\n- Énergie\n- Transport\n- Santé\n- Eau potable\n- Finance\n- Administration publique\n- Infrastructures numériques\n\n## 🔹 2. Entités importantes\nExemples :\n- Services numériques (cloud, data centers)\n- Fabrication (chimie, électronique)\n- Recherche\n- Gestion des déchets\n- Agroalimentaire\n\n## ✔ Justification\nCes secteurs sont critiques pour la société ou l’économie.\n\n---\n\n# 🧱 Obligations principales de NIS2\n\nNIS2 impose **10 obligations majeures**.  \nPour chaque obligation, je t’ajoute une justification + un exemple concret.\n\n---\n\n## 🔹 1. Gestion des risques de cybersécurité\n\n**Justification :**  \nImpossible de sécuriser sans connaître les risques.\n\n**Exemples :**\n- analyse de risques annuelle,\n- cartographie des actifs,\n- identification des dépendances critiques.\n\n---\n\n## 🔹 2. Politiques de sécurité documentées\n\n**Justification :**  \nLes équipes doivent savoir quoi faire.\n\n**Exemples :**\n- PSSI,\n- politique d’accès,\n- politique de sauvegarde.\n\n---\n\n## 🔹 3. Gestion des incidents\n\n**Justification :**  \nLes attaques sont inévitables → il faut savoir réagir.\n\n**Exemples :**\n- procédure d’alerte,\n- cellule de crise,\n- journalisation.\n\n---\n\n## 🔹 4. Continuité d’activité (PCA/PRA)\n\n**Justification :**  \nUn service essentiel ne peut pas s’arrêter.\n\n**Exemples :**\n- redondance,\n- PRA,\n- sauvegardes hors ligne.\n\n---\n\n## 🔹 5. Sécurité de la supply chain\n\n**Justification :**  \nLes fournisseurs sont souvent la porte d’entrée.\n\n**Exemples :**\n- audits fournisseurs,\n- clauses contractuelles,\n- contrôle des accès prestataires.\n\n---\n\n## 🔹 6. Sécurité des réseaux et systèmes\n\n**Justification :**  \nRéduire les surfaces d’attaque.\n\n**Exemples :**\n- segmentation réseau,\n- MFA,\n- patch management.\n\n---\n\n## 🔹 7. Authentification forte\n\n**Justification :**  \nLes mots de passe seuls ne suffisent plus.\n\n**Exemples :**\n- MFA obligatoire,\n- gestion des comptes à privilèges.\n\n---\n\n## 🔹 8. Journalisation et supervision\n\n**Justification :**  \nImpossible de détecter une attaque sans logs.\n\n**Exemples :**\n- SIEM,\n- alertes,\n- corrélation d’événements.\n\n---\n\n## 🔹 9. Formation et sensibilisation\n\n**Justification :**  \nLe facteur humain est la première cause d’incidents.\n\n**Exemples :**\n- formation anti‑phishing,\n- exercices de crise.\n\n---\n\n## 🔹 10. Notification des incidents\n\n**Justification :**  \nLes autorités doivent être informées rapidement.\n\n**Délais :**\n- 24h : alerte préliminaire\n- 72h : rapport détaillé\n- 1 mois : rapport final\n\n---\n\n# 🧱 Sanctions NIS2\n\nNIS2 introduit des sanctions **très élevées** :\n\n- jusqu’à **10 millions d’euros**  \n- ou **2 % du chiffre d’affaires mondial**\n\n## ✔ Justification\nCréer un effet dissuasif comparable au RGPD.\n\n---\n\n# 🧱 Impacts concrets pour les entreprises\n\n- obligation de mettre en place un SMSI,\n- audits réguliers,\n- documentation obligatoire,\n- renforcement des équipes SSI,\n- investissements dans la sécurité,\n- responsabilité personnelle des dirigeants.\n\n---\n\n# 🧱 Cas pratiques (mini‑études)\n\n## 🧪 Cas 1 : Hôpital attaqué par ransomware\n- service essentiel → obligations maximales  \n- impact direct sur la vie humaine  \n- obligation de notifier sous 24h  \n\n## 🧪 Cas 2 : Entreprise cloud victime d’une fuite de données\n- entité importante  \n- impact sur des milliers de clients  \n- obligation de renforcer la supply chain  \n\n## 🧪 Cas 3 : Collectivité locale sans MFA\n- non‑conformité  \n- risque de sanction  \n- obligation de mise en conformité immédiate  \n\n---\n\n# 🧠 Synthèse générale\n\nNIS2 impose :\n- une sécurité plus forte,\n- une gouvernance plus stricte,\n- une gestion des risques obligatoire,\n- une supervision continue,\n- une responsabilité accrue des dirigeants.\n\n---\n\n# 🧪 TP final complet\n\n1. Choisir une organisation (ex : hôpital, mairie, entreprise cloud).  \n2. Identifier si elle est “essentielle” ou “importante”.  \n3. Lister ses obligations NIS2.  \n4. Identifier 5 risques majeurs.  \n5. Proposer un plan de mise en conformité.  \n6. Rédiger une synthèse pour la direction.  \n	markdown	2026-03-08T18:15:48.898Z	markdown	en	1	2026-03-08T16:03:03.880Z	{}
17	home/PSSI	b7f51409dfd753a4af9c0afc78e2c4da6475933d	PSSI — Politique de Sécurité des Systèmes d’Information		f	t			updated	28	# PSSI — Politique de Sécurité des Systèmes d’Information (Version enrichie)\n\n## 🎯 Objectifs pédagogiques\n- Comprendre le rôle stratégique d’une PSSI dans une organisation.\n- Savoir rédiger une PSSI claire, efficace et adaptée.\n- Comprendre les responsabilités, les règles et les exigences de sécurité.\n- Apprendre à justifier chaque section auprès d’étudiants ou d’auditeurs.\n- Préparer les étudiants à un TP de rédaction ou d’audit de PSSI.\n\n---\n\n# 🧩 Introduction générale\n\nLa **PSSI** (Politique de Sécurité des Systèmes d’Information) est un document stratégique qui définit :\n- les objectifs de sécurité,\n- les règles à respecter,\n- les responsabilités,\n- les exigences techniques et organisationnelles.\n\nElle constitue la **colonne vertébrale** de la sécurité dans une organisation.\n\n---\n\n# 🧱 Pourquoi une PSSI est indispensable ?\n\n## ✔ Justification 1 : aligner toute l’organisation\nSans règles claires → chacun fait “à sa manière”.\n\n## ✔ Justification 2 : répondre aux obligations légales\n- ISO 27001 (clause 5)\n- NIS2\n- RGPD\n- Contrats clients\n\n## ✔ Justification 3 : réduire les risques humains\n80 % des incidents viennent d’erreurs humaines.\n\n## ✔ Justification 4 : protéger l’image et la réputation\nUne fuite de données peut ruiner la confiance.\n\n## ✔ Justification 5 : base de tous les audits\nUne PSSI est systématiquement demandée.\n\n---\n\n# 🧱 Structure d’une PSSI complète\n\nUne PSSI efficace contient généralement :\n\n1. **Objectifs et portée**\n2. **Rôles et responsabilités**\n3. **Gestion des accès**\n4. **Sécurité des postes de travail**\n5. **Sécurité réseau**\n6. **Gestion des incidents**\n7. **Sauvegardes**\n8. **Continuité d’activité**\n9. **Sensibilisation**\n10. **Conformité et sanctions**\n\nChaque section est détaillée ci‑dessous.\n\n---\n\n# 🏗️ 1. Objectifs et portée\n\n## 🎯 Objectif\nDéfinir ce que couvre la PSSI.\n\n## 📌 Contenu\n- objectifs de sécurité,\n- périmètre (SI, utilisateurs, équipements),\n- principes généraux.\n\n## ✔ Justification\nUne PSSI sans périmètre → document inutile.\n\n## 🧪 Exemple\n« La PSSI s’applique à tous les employés, prestataires et équipements connectés au réseau interne. »\n\n---\n\n# 🏗️ 2. Rôles et responsabilités\n\n## 🎯 Objectif\nClarifier qui fait quoi.\n\n## 📌 Acteurs typiques\n- Direction\n- RSSI\n- DSI\n- Administrateurs\n- Utilisateurs\n- Prestataires\n\n## ✔ Justification\nSans responsabilités → aucune règle n’est appliquée.\n\n## 🧪 Exemple\nLe RSSI valide les règles de sécurité.  \nLa DSI les met en œuvre.  \nLes utilisateurs doivent les respecter.\n\n---\n\n# 🏗️ 3. Gestion des accès\n\n## 🎯 Objectif\nContrôler qui accède à quoi.\n\n## 📌 Exigences\n- comptes individuels,\n- MFA obligatoire,\n- gestion des droits selon le besoin d’en connaître,\n- révocation immédiate lors des départs.\n\n## ✔ Justification\nUn accès mal géré = compromission totale.\n\n## ❌ Erreurs fréquentes\n- comptes partagés,\n- droits trop élevés,\n- comptes non supprimés.\n\n---\n\n# 🏗️ 4. Sécurité des postes de travail\n\n## 🎯 Objectif\nProtéger les équipements utilisateurs.\n\n## 📌 Exigences\n- antivirus,\n- chiffrement disque,\n- mises à jour automatiques,\n- verrouillage automatique.\n\n## ✔ Justification\nLe poste utilisateur est la première cible des attaquants.\n\n---\n\n# 🏗️ 5. Sécurité réseau\n\n## 🎯 Objectif\nProtéger les communications et l’infrastructure.\n\n## 📌 Exigences\n- segmentation réseau,\n- pare-feu,\n- VPN sécurisé,\n- interdiction des Wi-Fi non sécurisés.\n\n## ✔ Justification\nUn réseau plat = propagation rapide d’un ransomware.\n\n---\n\n# 🏗️ 6. Gestion des incidents\n\n## 🎯 Objectif\nSavoir réagir rapidement.\n\n## 📌 Exigences\n- procédure d’alerte,\n- cellule de crise,\n- journalisation,\n- rapport post‑incident.\n\n## ✔ Justification\nUne mauvaise réaction peut aggraver l’incident.\n\n---\n\n# 🏗️ 7. Sauvegardes\n\n## 🎯 Objectif\nAssurer la récupération des données.\n\n## 📌 Exigences\n- sauvegardes régulières,\n- tests de restauration,\n- sauvegardes hors ligne.\n\n## ✔ Justification\nDernière ligne de défense contre les ransomwares.\n\n---\n\n# 🏗️ 8. Continuité d’activité\n\n## 🎯 Objectif\nAssurer la disponibilité des services essentiels.\n\n## 📌 Exigences\n- PCA,\n- PRA,\n- redondance,\n- tests réguliers.\n\n## ✔ Justification\nUne panne peut coûter des millions.\n\n---\n\n# 🏗️ 9. Sensibilisation\n\n## 🎯 Objectif\nFormer les utilisateurs.\n\n## 📌 Exigences\n- formation annuelle,\n- campagnes anti‑phishing,\n- rappels réguliers.\n\n## ✔ Justification\nL’humain est le maillon le plus faible.\n\n---\n\n# 🏗️ 10. Conformité et sanctions\n\n## 🎯 Objectif\nGarantir le respect de la PSSI.\n\n## 📌 Exigences\n- audits internes,\n- sanctions disciplinaires,\n- suivi des non‑conformités.\n\n## ✔ Justification\nUne règle sans sanction = règle inutile.\n\n---\n\n# 🧱 Cas pratiques (mini‑études)\n\n## 🧪 Cas 1 : Employé qui partage son mot de passe\n→ violation de la PSSI  \n→ risque de compromission  \n→ sanction + formation\n\n## 🧪 Cas 2 : Prestataire avec accès non contrôlé\n→ violation de la PSSI  \n→ risque supply chain  \n→ mise à jour des contrats\n\n## 🧪 Cas 3 : Absence de sauvegardes testées\n→ violation de la PSSI  \n→ risque ransomware  \n→ plan d’action immédiat\n\n---\n\n# 🧠 Synthèse générale\n\nUne PSSI permet :\n- d’unifier les règles de sécurité,\n- de responsabiliser les acteurs,\n- de réduire les risques,\n- de structurer la sécurité,\n- de préparer les audits.\n\n---\n\n# 🧪 TP final complet\n\n1. Définir le périmètre d’une PSSI.  \n2. Rédiger les rôles et responsabilités.  \n3. Décrire les règles de gestion des accès.  \n4. Proposer un plan de sensibilisation.  \n5. Définir les règles de sauvegarde.  \n6. Rédiger une section “sanctions”.  \n7. Présenter la PSSI à la direction.  \n	markdown	2026-03-08T18:16:15.436Z	markdown	en	1	2026-03-08T18:12:29.858Z	{}
18	home/rgpd	19efc204f624cfefa2e1b15f99ad966c78d02d7c	RGPD		f	t			updated	21	# RGPD — Règlement Général sur la Protection des Données (Version enrichie)\n\n## 🎯 Objectifs pédagogiques\n- Comprendre les principes fondamentaux du RGPD.\n- Identifier les obligations légales des organisations.\n- Comprendre les droits des personnes concernées.\n- Savoir justifier chaque exigence auprès d’étudiants ou d’auditeurs.\n- Apprendre les impacts concrets sur les entreprises.\n- Préparer les étudiants à un audit ou un TP RGPD.\n\n---\n\n# 🧩 Introduction générale\n\nLe **RGPD** (Règlement Général sur la Protection des Données) est la loi européenne qui encadre la protection des données personnelles.\n\nIl s’applique :\n- à toutes les organisations qui traitent des données personnelles,\n- aux entreprises européennes,\n- aux entreprises non européennes qui ciblent des résidents européens.\n\nLe RGPD vise à :\n- protéger les citoyens,\n- responsabiliser les entreprises,\n- harmoniser les règles en Europe.\n\n---\n\n# 🧱 Pourquoi le RGPD existe ?\n\n## ✔ Justification 1 : explosion des données personnelles\nLes entreprises collectent énormément de données (clients, employés, navigation…).\n\n## ✔ Justification 2 : multiplication des abus\nProfilage, revente de données, surveillance excessive.\n\n## ✔ Justification 3 : harmonisation européenne\nAvant le RGPD, chaque pays avait ses propres lois → incohérences.\n\n## ✔ Justification 4 : protéger les droits fondamentaux\nLa vie privée est un droit fondamental en Europe.\n\n---\n\n# 🧱 Définitions essentielles\n\n## 🔹 Donnée personnelle\nToute information permettant d’identifier une personne :\n- nom,\n- email,\n- IP,\n- localisation,\n- données de santé,\n- données biométriques.\n\n## 🔹 Traitement\nToute opération sur une donnée :\n- collecte,\n- stockage,\n- modification,\n- suppression.\n\n## 🔹 Responsable de traitement\nL’organisation qui décide du “pourquoi” et du “comment”.\n\n## 🔹 Sous‑traitant\nL’organisation qui traite les données pour le compte d’un autre.\n\n---\n\n# 🧱 Les 7 principes fondamentaux du RGPD\n\nPour chaque principe, je t’ajoute une justification + un exemple + une erreur fréquente.\n\n---\n\n## 🔹 1. Licéité, loyauté, transparence\n\n**Justification :**  \nLes personnes doivent savoir ce qu’on fait de leurs données.\n\n**Exemples :**\n- bannière cookies,\n- politique de confidentialité claire.\n\n**Erreur fréquente :**  \nTexte juridique incompréhensible.\n\n---\n\n## 🔹 2. Limitation des finalités\n\n**Justification :**  \nOn ne peut pas utiliser les données pour autre chose que prévu.\n\n**Exemple :**  \nCollecter un email pour une commande ≠ l’utiliser pour du marketing sans consentement.\n\n---\n\n## 🔹 3. Minimisation des données\n\n**Justification :**  \nMoins on collecte, moins on risque.\n\n**Exemple :**  \nNe pas demander la date de naissance si l’âge suffit.\n\n---\n\n## 🔹 4. Exactitude\n\n**Justification :**  \nDes données incorrectes peuvent causer des erreurs graves.\n\n**Exemple :**  \nAdresse erronée → livraison ratée.\n\n---\n\n## 🔹 5. Limitation de conservation\n\n**Justification :**  \nGarder des données trop longtemps augmente les risques.\n\n**Exemple :**  \nSupprimer les comptes inactifs après 3 ans.\n\n---\n\n## 🔹 6. Intégrité et confidentialité\n\n**Justification :**  \nProtéger les données contre les accès non autorisés.\n\n**Exemples :**\n- chiffrement,\n- MFA,\n- sauvegardes.\n\n---\n\n## 🔹 7. Responsabilité (Accountability)\n\n**Justification :**  \nL’entreprise doit prouver sa conformité.\n\n**Exemples :**\n- registre des traitements,\n- politiques internes,\n- preuves de formation.\n\n---\n\n# 🧱 Droits des personnes\n\n## 🔹 Droit d’accès\nVoir quelles données sont collectées.\n\n## 🔹 Droit de rectification\nCorriger les erreurs.\n\n## 🔹 Droit à l’effacement (“droit à l’oubli”)\nSupprimer les données si plus nécessaires.\n\n## 🔹 Droit à la portabilité\nRécupérer ses données dans un format lisible.\n\n## 🔹 Droit d’opposition\nRefuser certains traitements (ex : marketing).\n\n## 🔹 Droit à la limitation\nGeler temporairement un traitement.\n\n## 🔹 Droit d’être informé\nTransparence obligatoire.\n\n---\n\n# 🧱 Obligations des entreprises\n\n## 🔹 1. Registre des traitements\nDocument obligatoire listant :\n- finalités,\n- données collectées,\n- durées de conservation,\n- destinataires.\n\n## 🔹 2. DPO (Délégué à la Protection des Données)\nObligatoire pour :\n- organismes publics,\n- traitements sensibles,\n- surveillance à grande échelle.\n\n## 🔹 3. Analyse d’impact (AIPD)\nObligatoire si :\n- données sensibles,\n- surveillance,\n- risque élevé.\n\n## 🔹 4. Notification des violations\nDélais :\n- 72h à la CNIL,\n- sans délai aux personnes si risque élevé.\n\n## 🔹 5. Contrats sous‑traitants\nClauses obligatoires :\n- sécurité,\n- confidentialité,\n- assistance.\n\n---\n\n# 🧱 Sanctions RGPD\n\n- jusqu’à **20 millions d’euros**,  \n- ou **4 % du chiffre d’affaires mondial**.\n\n## ✔ Justification\nCréer un effet dissuasif réel.\n\n---\n\n# 🧱 Cas pratiques (mini‑études)\n\n## 🧪 Cas 1 : fuite de données clients\n- notification obligatoire,\n- analyse d’impact,\n- mesures correctives.\n\n## 🧪 Cas 2 : collecte excessive\nUne application demande l’accès aux contacts → non conforme.\n\n## 🧪 Cas 3 : absence de consentement\nNewsletter envoyée sans opt‑in → violation RGPD.\n\n---\n\n# 🧠 Synthèse générale\n\nLe RGPD impose :\n- transparence,\n- sécurité,\n- minimisation,\n- responsabilité.\n\nIl protège les citoyens et responsabilise les entreprises.\n\n---\n\n# 🧪 TP final complet\n\n1. Choisir un service (ex : site e‑commerce).  \n2. Identifier les données collectées.  \n3. Déterminer les finalités.  \n4. Construire un registre RGPD.  \n5. Identifier les risques.  \n6. Proposer des mesures de conformité.  \n7. Rédiger une politique de confidentialité.  \n	markdown	2026-03-08T18:16:38.233Z	markdown	en	1	2026-03-08T16:04:03.500Z	{}
\.


--
-- Data for Name: pageHistoryTags; Type: TABLE DATA; Schema: public; Owner: wikijs
--

COPY public."pageHistoryTags" (id, "pageId", "tagId") FROM stdin;
\.


--
-- Data for Name: pageLinks; Type: TABLE DATA; Schema: public; Owner: wikijs
--

COPY public."pageLinks" (id, path, "localeCode", "pageId") FROM stdin;
1	home	en	10
\.


--
-- Data for Name: pageTags; Type: TABLE DATA; Schema: public; Owner: wikijs
--

COPY public."pageTags" (id, "pageId", "tagId") FROM stdin;
\.


--
-- Data for Name: pageTree; Type: TABLE DATA; Schema: public; Owner: wikijs
--

COPY public."pageTree" (id, path, depth, title, "isPrivate", "isFolder", "privateNS", parent, "pageId", "localeCode", ancestors) FROM stdin;
1	home	1	Welcome Page	f	t	\N	\N	19	en	[]
2	home/EbiosRM	2	Ebios RM	f	f	\N	1	22	en	[1]
3	home/GDR	2	Gestion des risques	f	f	\N	1	30	en	[1]
4	home/GIS	2	Gestion des incidents de sécurité	f	f	\N	1	29	en	[1]
5	home/ISO27001	2	ISO27001 - SMSI	f	f	\N	1	23	en	[1]
6	home/ISO27002	2	ISO27002 - Bonne pratique pour les mesures de sécurité	f	f	\N	1	24	en	[1]
7	home/ISO27005	2	ISO27005 - Gestion des risques liés à la sécurité de l’information	f	f	\N	1	25	en	[1]
8	home/MEHARI	2	MEHARI - Analyse de risques	f	f	\N	1	27	en	[1]
9	home/NIS2	2	NIS2 - Directive	f	f	\N	1	26	en	[1]
10	home/PCA-PRA	2	PCA/PRA	f	f	\N	1	31	en	[1]
11	home/PSSI	2	PSSI — Politique de Sécurité des Systèmes d’Information	f	f	\N	1	28	en	[1]
12	home/rgpd	2	RGPD	f	f	\N	1	21	en	[1]
13	ebios-intro	1	ebios-intro	f	f	\N	\N	10	fr	[]
14	ebios-rm	1	ebios-rm	f	f	\N	\N	11	fr	[]
15	home	1	Untitled Page	f	f	\N	\N	18	fr	[]
16	iso27001	1	iso27001	f	f	\N	\N	12	fr	[]
17	iso27002	1	iso27002	f	f	\N	\N	13	fr	[]
18	iso27005	1	iso27005	f	f	\N	\N	14	fr	[]
19	mehari	1	mehari	f	f	\N	\N	15	fr	[]
20	nis2	1	nis2	f	f	\N	\N	16	fr	[]
21	rgpd	1	rgpd	f	f	\N	\N	17	fr	[]
\.


--
-- Data for Name: pages; Type: TABLE DATA; Schema: public; Owner: wikijs
--

COPY public.pages (id, path, hash, title, description, "isPrivate", "isPublished", "privateNS", "publishStartDate", "publishEndDate", content, render, toc, "contentType", "createdAt", "updatedAt", "editorKey", "localeCode", "authorId", "creatorId", extra) FROM stdin;
10	ebios-intro	462c81fb17efa5f23f5869263ae1dd136aedbedf	ebios-intro		f	t	\N			[home](/home)# EBIOS - Introduction\n\n## Concepts\n- Actifs essentiels\n- Menaces\n- Vulnérabilités\n- Scénarios	<p><a href="/home" class="is-internal-link is-valid-page">home</a># EBIOS - Introduction</p>\n<h2 id="concepts" class="toc-header"><a class="toc-anchor" href="#concepts">¶</a> Concepts</h2>\n<ul>\n<li>Actifs essentiels</li>\n<li>Menaces</li>\n<li>Vulnérabilités</li>\n<li>Scénarios</li>\n</ul>\n	[{"title":"Concepts","anchor":"#concepts","children":[]}]	markdown	2026-03-08T14:47:19.216Z	2026-03-08T15:23:29.749Z	markdown	fr	1	1	{"js":"","css":""}
11	ebios-rm	855d340f5f4346fcfd0b786d7f904206dc7a4f89	ebios-rm		f	t	\N			# EBIOS Risk Manager\n\n## Étapes\n1. Cadrage\n2. Événements redoutés\n3. Scénarios stratégiques\n4. Scénarios opérationnels\n5. Traitement des risques	<h1 id="ebios-risk-manager" class="toc-header"><a class="toc-anchor" href="#ebios-risk-manager">¶</a> EBIOS Risk Manager</h1>\n<h2 id="étapes" class="toc-header"><a class="toc-anchor" href="#étapes">¶</a> Étapes</h2>\n<ol>\n<li>Cadrage</li>\n<li>Événements redoutés</li>\n<li>Scénarios stratégiques</li>\n<li>Scénarios opérationnels</li>\n<li>Traitement des risques</li>\n</ol>\n	[{"title":"EBIOS Risk Manager","anchor":"#ebios-risk-manager","children":[{"title":"Étapes","anchor":"#étapes","children":[]}]}]	markdown	2026-03-08T14:47:21.274Z	2026-03-08T14:47:22.117Z	markdown	fr	1	1	{"js":"","css":""}
13	iso27002	a1e300c684841901be455d2430b3d4b03bb89a88	iso27002		f	t	\N			# ISO/IEC 27002 - Bonnes pratiques\n\n## Domaines\n- Politique de sécurité\n- Gestion des actifs\n- Contrôle d’accès\n- Cryptographie\n- Sécurité physique\n- Sécurité des opérations\n- Gestion des incidents	<h1 id="isoiec-27002-bonnes-pratiques" class="toc-header"><a class="toc-anchor" href="#isoiec-27002-bonnes-pratiques">¶</a> ISO/IEC 27002 - Bonnes pratiques</h1>\n<h2 id="domaines" class="toc-header"><a class="toc-anchor" href="#domaines">¶</a> Domaines</h2>\n<ul>\n<li>Politique de sécurité</li>\n<li>Gestion des actifs</li>\n<li>Contrôle d’accès</li>\n<li>Cryptographie</li>\n<li>Sécurité physique</li>\n<li>Sécurité des opérations</li>\n<li>Gestion des incidents</li>\n</ul>\n	[{"title":"ISO/IEC 27002 - Bonnes pratiques","anchor":"#isoiec-27002-bonnes-pratiques","children":[{"title":"Domaines","anchor":"#domaines","children":[]}]}]	markdown	2026-03-08T14:47:23.850Z	2026-03-08T14:47:24.753Z	markdown	fr	1	1	{"js":"","css":""}
14	iso27005	a1e60d259f9ba68e7f292d55f63b893b7815ed0f	iso27005		f	t	\N			# ISO/IEC 27005 - Gestion des risques\n\n## Étapes\n- Contexte\n- Identification des risques\n- Analyse\n- Évaluation\n- Traitement\n- Surveillance	<h1 id="isoiec-27005-gestion-des-risques" class="toc-header"><a class="toc-anchor" href="#isoiec-27005-gestion-des-risques">¶</a> ISO/IEC 27005 - Gestion des risques</h1>\n<h2 id="étapes" class="toc-header"><a class="toc-anchor" href="#étapes">¶</a> Étapes</h2>\n<ul>\n<li>Contexte</li>\n<li>Identification des risques</li>\n<li>Analyse</li>\n<li>Évaluation</li>\n<li>Traitement</li>\n<li>Surveillance</li>\n</ul>\n	[{"title":"ISO/IEC 27005 - Gestion des risques","anchor":"#isoiec-27005-gestion-des-risques","children":[{"title":"Étapes","anchor":"#étapes","children":[]}]}]	markdown	2026-03-08T14:47:25.181Z	2026-03-08T14:47:26.051Z	markdown	fr	1	1	{"js":"","css":""}
15	mehari	899bb21ed392b676ffa84748034ff87ab443cf0b	mehari		f	t	\N			# MEHARI - Analyse de risques\n\n## Principes\n- Scénarios de menaces\n- Gravité des impacts\n- Vraisemblance\n- Niveau de risque\n- Plans de traitement	<h1 id="mehari-analyse-de-risques" class="toc-header"><a class="toc-anchor" href="#mehari-analyse-de-risques">¶</a> MEHARI - Analyse de risques</h1>\n<h2 id="principes" class="toc-header"><a class="toc-anchor" href="#principes">¶</a> Principes</h2>\n<ul>\n<li>Scénarios de menaces</li>\n<li>Gravité des impacts</li>\n<li>Vraisemblance</li>\n<li>Niveau de risque</li>\n<li>Plans de traitement</li>\n</ul>\n	[{"title":"MEHARI - Analyse de risques","anchor":"#mehari-analyse-de-risques","children":[{"title":"Principes","anchor":"#principes","children":[]}]}]	markdown	2026-03-08T14:47:26.512Z	2026-03-08T14:47:27.380Z	markdown	fr	1	1	{"js":"","css":""}
16	nis2	6d0a428f1df8f67d30dc0f97cfefb0d7f5947131	nis2		f	t	\N			# Directive NIS2\n\n## Objectif\nRenforcer la cybersécurité des entités essentielles et importantes.\n\n## Exigences\n- Gouvernance SSI\n- Gestion des risques\n- Mesures techniques et organisationnelles\n- Gestion des incidents\n- Continuité d’activité	<h1 id="directive-nis2" class="toc-header"><a class="toc-anchor" href="#directive-nis2">¶</a> Directive NIS2</h1>\n<h2 id="objectif" class="toc-header"><a class="toc-anchor" href="#objectif">¶</a> Objectif</h2>\n<p>Renforcer la cybersécurité des entités essentielles et importantes.</p>\n<h2 id="exigences" class="toc-header"><a class="toc-anchor" href="#exigences">¶</a> Exigences</h2>\n<ul>\n<li>Gouvernance SSI</li>\n<li>Gestion des risques</li>\n<li>Mesures techniques et organisationnelles</li>\n<li>Gestion des incidents</li>\n<li>Continuité d’activité</li>\n</ul>\n	[{"title":"Directive NIS2","anchor":"#directive-nis2","children":[{"title":"Objectif","anchor":"#objectif","children":[]},{"title":"Exigences","anchor":"#exigences","children":[]}]}]	markdown	2026-03-08T14:47:27.814Z	2026-03-08T14:47:28.639Z	markdown	fr	1	1	{"js":"","css":""}
12	iso27001	2a8b635a6be32c53f7e1fdba3a71b9f813b17ba3	iso27001		f	t	\N			# ISO/IEC 27001 - SMSI\n\n## Objectif\nMettre en place un système de management de la sécurité de l’information.\n\n## Principes\n- Approche risques\n- PDCA\n- Leadership\n- Amélioration continue\n\n## Annexes\n- Annexe A : catalogue de contrôles	<h1 id="isoiec-27001-smsi" class="toc-header"><a class="toc-anchor" href="#isoiec-27001-smsi">¶</a> ISO/IEC 27001 - SMSI</h1>\n<h2 id="objectif" class="toc-header"><a class="toc-anchor" href="#objectif">¶</a> Objectif</h2>\n<p>Mettre en place un système de management de la sécurité de l’information.</p>\n<h2 id="principes" class="toc-header"><a class="toc-anchor" href="#principes">¶</a> Principes</h2>\n<ul>\n<li>Approche risques</li>\n<li>PDCA</li>\n<li>Leadership</li>\n<li>Amélioration continue</li>\n</ul>\n<h2 id="annexes" class="toc-header"><a class="toc-anchor" href="#annexes">¶</a> Annexes</h2>\n<ul>\n<li>Annexe A : catalogue de contrôles</li>\n</ul>\n	[{"title":"ISO/IEC 27001 - SMSI","anchor":"#isoiec-27001-smsi","children":[{"title":"Objectif","anchor":"#objectif","children":[]},{"title":"Principes","anchor":"#principes","children":[]},{"title":"Annexes","anchor":"#annexes","children":[]}]}]	markdown	2026-03-08T14:47:22.536Z	2026-03-08T14:47:23.380Z	markdown	fr	1	1	{"js":"","css":""}
17	rgpd	807a8ea9dbaa6c37bdc20aeed253b99382a4f755	rgpd		f	t	\N			# RGPD - Règlement Général sur la Protection des Données\n\n## Objectifs\n- Protéger les données personnelles.\n- Harmoniser les règles dans l’UE.\n- Renforcer les droits des personnes.\n\n## Principes clés\n- Licéité, loyauté, transparence\n- Minimisation des données\n- Limitation de conservation\n- Intégrité et confidentialité\n- Accountability\n\n## Droits des personnes\n- Accès, rectification, effacement\n- Portabilité\n- Opposition\n- Limitation du traitement\n\n## Obligations\n- Registre des traitements\n- AIPD\n- Notification des violations	<h1 id="rgpd-règlement-général-sur-la-protection-des-données" class="toc-header"><a class="toc-anchor" href="#rgpd-règlement-général-sur-la-protection-des-données">¶</a> RGPD - Règlement Général sur la Protection des Données</h1>\n<h2 id="objectifs" class="toc-header"><a class="toc-anchor" href="#objectifs">¶</a> Objectifs</h2>\n<ul>\n<li>Protéger les données personnelles.</li>\n<li>Harmoniser les règles dans l’UE.</li>\n<li>Renforcer les droits des personnes.</li>\n</ul>\n<h2 id="principes-clés" class="toc-header"><a class="toc-anchor" href="#principes-clés">¶</a> Principes clés</h2>\n<ul>\n<li>Licéité, loyauté, transparence</li>\n<li>Minimisation des données</li>\n<li>Limitation de conservation</li>\n<li>Intégrité et confidentialité</li>\n<li>Accountability</li>\n</ul>\n<h2 id="droits-des-personnes" class="toc-header"><a class="toc-anchor" href="#droits-des-personnes">¶</a> Droits des personnes</h2>\n<ul>\n<li>Accès, rectification, effacement</li>\n<li>Portabilité</li>\n<li>Opposition</li>\n<li>Limitation du traitement</li>\n</ul>\n<h2 id="obligations" class="toc-header"><a class="toc-anchor" href="#obligations">¶</a> Obligations</h2>\n<ul>\n<li>Registre des traitements</li>\n<li>AIPD</li>\n<li>Notification des violations</li>\n</ul>\n	[{"title":"RGPD - Règlement Général sur la Protection des Données","anchor":"#rgpd-règlement-général-sur-la-protection-des-données","children":[{"title":"Objectifs","anchor":"#objectifs","children":[]},{"title":"Principes clés","anchor":"#principes-clés","children":[]},{"title":"Droits des personnes","anchor":"#droits-des-personnes","children":[]},{"title":"Obligations","anchor":"#obligations","children":[]}]}]	markdown	2026-03-08T14:47:29.077Z	2026-03-08T14:47:29.902Z	markdown	fr	1	1	{"js":"","css":""}
18	home	f030e2d764b754176d0dfc3bcdfb92a3cd67ceb3	Untitled Page		f	t	\N			# Header\nYour content here	<h1 id="header" class="toc-header"><a class="toc-anchor" href="#header">¶</a> Header</h1>\n<p>Your content here</p>\n	[{"title":"Header","anchor":"#header","children":[]}]	markdown	2026-03-08T15:10:35.889Z	2026-03-08T15:10:36.921Z	markdown	fr	1	1	{"js":"","css":""}
19	home	b29b5d2ce62e55412776ab98f05631e0aa96597b	Welcome Page	Good Luck	f	t	\N			# Have fun\n:)	<h1 id="have-fun" class="toc-header"><a class="toc-anchor" href="#have-fun">¶</a> Have fun</h1>\n<p><img class="emoji" draggable="false" alt="😃" src="/_assets/svg/twemoji/1f603.svg"></p>\n	[{"title":"Have fun","anchor":"#have-fun","children":[]}]	markdown	2026-03-08T15:12:20.173Z	2026-03-08T15:28:44.562Z	markdown	en	1	1	{"js":"","css":""}
25	home/ISO27005	d991eecc90b8d970c740f10d30f9930ee31e2973	ISO27005 - Gestion des risques liés à la sécurité de l’information		f	t	\N			# ISO/IEC 27005:2022 — Gestion des risques de sécurité de l'information\n\n## 🎯 Objectifs pédagogiques\n- Comprendre la logique complète de la gestion des risques.\n- Savoir identifier, analyser, évaluer et traiter les risques.\n- Comprendre les liens entre ISO 27001, ISO 27002 et ISO 27005.\n- Apprendre à justifier chaque étape de l’analyse.\n- Développer une capacité d’analyse critique pour les TP et audits.\n\n---\n\n# 🧩 Introduction générale\n\nISO 27005 est la norme internationale dédiée à la **gestion des risques de sécurité de l’information**.  \nElle fournit un cadre méthodologique complet pour :\n\n- identifier les risques,\n- analyser les risques,\n- évaluer les risques,\n- traiter les risques,\n- surveiller les risques.\n\nElle ne donne pas une méthode unique, mais un **cadre adaptable**.  \nElle est compatible avec :\n- EBIOS RM,\n- MEHARI,\n- OCTAVE,\n- NIST RMF.\n\n---\n\n# 🧱 Pourquoi la gestion des risques est essentielle ?\n\n### ✔ Justification 1 : impossible de tout protéger\nLes ressources sont limitées → il faut prioriser.\n\n### ✔ Justification 2 : les menaces évoluent\nNouveaux ransomwares, nouvelles vulnérabilités, nouveaux usages.\n\n### ✔ Justification 3 : obligation réglementaire\n- ISO 27001\n- NIS2\n- RGPD (AIPD)\n- Assurance cyber\n\n### ✔ Justification 4 : base de toute stratégie SSI\nSans analyse de risques → sécurité “au hasard”.\n\n---\n\n# 🧱 Structure générale de la norme\n\nISO 27005 suit 8 grandes étapes :\n\n1. **Contexte**\n2. **Identification des risques**\n3. **Analyse**\n4. **Évaluation**\n5. **Traitement**\n6. **Acceptation**\n7. **Communication**\n8. **Surveillance**\n\nChaque étape est justifiée et illustrée ci‑dessous.\n\n---\n\n# 🏗️ 1. Contexte\n\n## 🎯 Objectif\nComprendre l’environnement dans lequel évolue le système.\n\n## 📌 Contenu\n- périmètre,\n- actifs,\n- parties prenantes,\n- contraintes légales,\n- dépendances externes.\n\n## ✔ Justification\nImpossible d’analyser un risque si on ne sait pas **sur quoi** il porte.\n\n## 🧪 Exemple concret\nPérimètre : plateforme de messagerie interne  \nParties prenantes : employés, DSI, prestataire cloud  \nContraintes : RGPD, politique interne  \nDépendances : Microsoft 365, réseau interne  \n\n## ❌ Erreurs fréquentes\n- périmètre trop large → analyse impossible  \n- périmètre trop flou → résultats inutilisables  \n\n---\n\n# 🏗️ 2. Identification des risques\n\n## 🎯 Objectif\nLister tous les éléments nécessaires à la construction d’un risque.\n\n## 📌 On identifie :\n- les **actifs** (ce qu’on protège),\n- les **menaces** (ce qui peut arriver),\n- les **vulnérabilités** (faiblesses),\n- les **impacts** (conséquences).\n\n## ✔ Justification\nUn risque = menace × vulnérabilité × impact.\n\n## 🧪 Exemple concret\nActif : base de données clients  \nMenace : ransomware  \nVulnérabilité : absence de sauvegarde hors ligne  \nImpact : perte de données critiques  \n\n## ❌ Erreurs fréquentes\n- confondre menace et vulnérabilité  \n- oublier les actifs immatériels (réputation, image)  \n\n---\n\n# 🏗️ 3. Analyse des risques\n\n## 🎯 Objectif\nÉvaluer :\n- la probabilité,\n- l’impact,\n- le niveau de risque.\n\n## ✔ Justification\nPermet de **prioriser** les risques.\n\n## 📌 Méthodes possibles\n- qualitative (faible / moyen / élevé),\n- semi‑quantitative (1 à 5),\n- quantitative (pertes financières).\n\n## 🧪 Exemple concret\nProbabilité : élevée (attaques fréquentes)  \nImpact : très élevé (perte financière + RGPD)  \nRisque : critique  \n\n## ❌ Erreurs fréquentes\n- sous‑estimer les impacts non financiers  \n- ignorer les risques internes  \n\n---\n\n# 🏗️ 4. Évaluation des risques\n\n## 🎯 Objectif\nDécider si un risque est :\n- acceptable,\n- tolérable,\n- inacceptable.\n\n## ✔ Justification\nPermet de savoir **où agir en premier**.\n\n## 📌 Exemple\nRisque critique → action immédiate  \nRisque moyen → planifié  \nRisque faible → surveillé  \n\n---\n\n# 🏗️ 5. Traitement des risques\n\n## 🎯 Objectif\nChoisir une stratégie :\n\n1. **Réduire** (mesures de sécurité)\n2. **Éviter** (changer le processus)\n3. **Transférer** (assurance, sous‑traitant)\n4. **Accepter** (risque faible)\n\n## ✔ Justification\nToutes les organisations n’ont pas les mêmes priorités.\n\n## 🧪 Exemple concret\nRisque : ransomware  \nTraitement :  \n- sauvegardes hors ligne,  \n- MFA,  \n- segmentation réseau,  \n- formation anti‑phishing.  \n\n---\n\n# 🏗️ 6. Acceptation des risques\n\n## 🎯 Objectif\nValider officiellement les risques résiduels.\n\n## ✔ Justification\nResponsabilité de la direction, pas du RSSI.\n\n## 📌 Exemple\n“Nous acceptons le risque de perte de service de 2h par mois.”\n\n---\n\n# 🏗️ 7. Communication\n\n## 🎯 Objectif\nPartager les résultats avec :\n- direction,\n- équipes techniques,\n- métiers,\n- partenaires.\n\n## ✔ Justification\nLa sécurité est **collective**.\n\n---\n\n# 🏗️ 8. Surveillance\n\n## 🎯 Objectif\nMettre en place un cycle d’amélioration continue.\n\n## 📌 On surveille :\n- nouveaux risques,\n- incidents,\n- changements techniques,\n- nouvelles vulnérabilités.\n\n## ✔ Justification\nUn risque évolue dans le temps.\n\n---\n\n# 🧠 Synthèse générale\n\nISO 27005 permet :\n- d’avoir une vision claire des risques,\n- de prioriser les actions,\n- de justifier les mesures de sécurité,\n- de structurer un SMSI,\n- de répondre aux exigences ISO 27001.\n\n---\n\n# 🧪 TP final complet\n\n1. Choisir un périmètre (ex : serveur web).  \n2. Identifier 5 actifs essentiels.  \n3. Lister les menaces et vulnérabilités associées.  \n4. Évaluer probabilité + impact.  \n5. Classer les risques (faible / moyen / élevé / critique).  \n6. Proposer un plan de traitement.  \n7. Rédiger une synthèse pour la direction.  \n	<h1 id="isoiec-270052022-gestion-des-risques-de-sécurité-de-linformation" class="toc-header"><a class="toc-anchor" href="#isoiec-270052022-gestion-des-risques-de-sécurité-de-linformation">¶</a> ISO/IEC 27005:2022 — Gestion des risques de sécurité de l'information</h1>\n<h2 id="objectifs-pédagogiques" class="toc-header"><a class="toc-anchor" href="#objectifs-pédagogiques">¶</a> 🎯 Objectifs pédagogiques</h2>\n<ul>\n<li>Comprendre la logique complète de la gestion des risques.</li>\n<li>Savoir identifier, analyser, évaluer et traiter les risques.</li>\n<li>Comprendre les liens entre ISO 27001, ISO 27002 et ISO 27005.</li>\n<li>Apprendre à justifier chaque étape de l’analyse.</li>\n<li>Développer une capacité d’analyse critique pour les TP et audits.</li>\n</ul>\n<hr>\n<h1 id="introduction-générale" class="toc-header"><a class="toc-anchor" href="#introduction-générale">¶</a> 🧩 Introduction générale</h1>\n<p>ISO 27005 est la norme internationale dédiée à la <strong>gestion des risques de sécurité de l’information</strong>.<br>\nElle fournit un cadre méthodologique complet pour :</p>\n<ul>\n<li>identifier les risques,</li>\n<li>analyser les risques,</li>\n<li>évaluer les risques,</li>\n<li>traiter les risques,</li>\n<li>surveiller les risques.</li>\n</ul>\n<p>Elle ne donne pas une méthode unique, mais un <strong>cadre adaptable</strong>.<br>\nElle est compatible avec :</p>\n<ul>\n<li>EBIOS RM,</li>\n<li>MEHARI,</li>\n<li>OCTAVE,</li>\n<li>NIST RMF.</li>\n</ul>\n<hr>\n<h1 id="pourquoi-la-gestion-des-risques-est-essentielle" class="toc-header"><a class="toc-anchor" href="#pourquoi-la-gestion-des-risques-est-essentielle">¶</a> 🧱 Pourquoi la gestion des risques est essentielle ?</h1>\n<h3 id="justification-1-impossible-de-tout-protéger" class="toc-header"><a class="toc-anchor" href="#justification-1-impossible-de-tout-protéger">¶</a> ✔ Justification 1 : impossible de tout protéger</h3>\n<p>Les ressources sont limitées → il faut prioriser.</p>\n<h3 id="justification-2-les-menaces-évoluent" class="toc-header"><a class="toc-anchor" href="#justification-2-les-menaces-évoluent">¶</a> ✔ Justification 2 : les menaces évoluent</h3>\n<p>Nouveaux ransomwares, nouvelles vulnérabilités, nouveaux usages.</p>\n<h3 id="justification-3-obligation-réglementaire" class="toc-header"><a class="toc-anchor" href="#justification-3-obligation-réglementaire">¶</a> ✔ Justification 3 : obligation réglementaire</h3>\n<ul>\n<li>ISO 27001</li>\n<li>NIS2</li>\n<li>RGPD (AIPD)</li>\n<li>Assurance cyber</li>\n</ul>\n<h3 id="justification-4-base-de-toute-stratégie-ssi" class="toc-header"><a class="toc-anchor" href="#justification-4-base-de-toute-stratégie-ssi">¶</a> ✔ Justification 4 : base de toute stratégie SSI</h3>\n<p>Sans analyse de risques → sécurité “au hasard”.</p>\n<hr>\n<h1 id="structure-générale-de-la-norme" class="toc-header"><a class="toc-anchor" href="#structure-générale-de-la-norme">¶</a> 🧱 Structure générale de la norme</h1>\n<p>ISO 27005 suit 8 grandes étapes :</p>\n<ol>\n<li><strong>Contexte</strong></li>\n<li><strong>Identification des risques</strong></li>\n<li><strong>Analyse</strong></li>\n<li><strong>Évaluation</strong></li>\n<li><strong>Traitement</strong></li>\n<li><strong>Acceptation</strong></li>\n<li><strong>Communication</strong></li>\n<li><strong>Surveillance</strong></li>\n</ol>\n<p>Chaque étape est justifiée et illustrée ci‑dessous.</p>\n<hr>\n<h1 id="️-1-contexte" class="toc-header"><a class="toc-anchor" href="#️-1-contexte">¶</a> 🏗️ 1. Contexte</h1>\n<h2 id="objectif" class="toc-header"><a class="toc-anchor" href="#objectif">¶</a> 🎯 Objectif</h2>\n<p>Comprendre l’environnement dans lequel évolue le système.</p>\n<h2 id="contenu" class="toc-header"><a class="toc-anchor" href="#contenu">¶</a> 📌 Contenu</h2>\n<ul>\n<li>périmètre,</li>\n<li>actifs,</li>\n<li>parties prenantes,</li>\n<li>contraintes légales,</li>\n<li>dépendances externes.</li>\n</ul>\n<h2 id="justification" class="toc-header"><a class="toc-anchor" href="#justification">¶</a> ✔ Justification</h2>\n<p>Impossible d’analyser un risque si on ne sait pas <strong>sur quoi</strong> il porte.</p>\n<h2 id="exemple-concret" class="toc-header"><a class="toc-anchor" href="#exemple-concret">¶</a> 🧪 Exemple concret</h2>\n<p>Périmètre : plateforme de messagerie interne<br>\nParties prenantes : employés, DSI, prestataire cloud<br>\nContraintes : RGPD, politique interne<br>\nDépendances : Microsoft 365, réseau interne</p>\n<h2 id="erreurs-fréquentes" class="toc-header"><a class="toc-anchor" href="#erreurs-fréquentes">¶</a> ❌ Erreurs fréquentes</h2>\n<ul>\n<li>périmètre trop large → analyse impossible</li>\n<li>périmètre trop flou → résultats inutilisables</li>\n</ul>\n<hr>\n<h1 id="️-2-identification-des-risques" class="toc-header"><a class="toc-anchor" href="#️-2-identification-des-risques">¶</a> 🏗️ 2. Identification des risques</h1>\n<h2 id="objectif-1" class="toc-header"><a class="toc-anchor" href="#objectif-1">¶</a> 🎯 Objectif</h2>\n<p>Lister tous les éléments nécessaires à la construction d’un risque.</p>\n<h2 id="on-identifie" class="toc-header"><a class="toc-anchor" href="#on-identifie">¶</a> 📌 On identifie :</h2>\n<ul>\n<li>les <strong>actifs</strong> (ce qu’on protège),</li>\n<li>les <strong>menaces</strong> (ce qui peut arriver),</li>\n<li>les <strong>vulnérabilités</strong> (faiblesses),</li>\n<li>les <strong>impacts</strong> (conséquences).</li>\n</ul>\n<h2 id="justification-1" class="toc-header"><a class="toc-anchor" href="#justification-1">¶</a> ✔ Justification</h2>\n<p>Un risque = menace × vulnérabilité × impact.</p>\n<h2 id="exemple-concret-1" class="toc-header"><a class="toc-anchor" href="#exemple-concret-1">¶</a> 🧪 Exemple concret</h2>\n<p>Actif : base de données clients<br>\nMenace : ransomware<br>\nVulnérabilité : absence de sauvegarde hors ligne<br>\nImpact : perte de données critiques</p>\n<h2 id="erreurs-fréquentes-1" class="toc-header"><a class="toc-anchor" href="#erreurs-fréquentes-1">¶</a> ❌ Erreurs fréquentes</h2>\n<ul>\n<li>confondre menace et vulnérabilité</li>\n<li>oublier les actifs immatériels (réputation, image)</li>\n</ul>\n<hr>\n<h1 id="️-3-analyse-des-risques" class="toc-header"><a class="toc-anchor" href="#️-3-analyse-des-risques">¶</a> 🏗️ 3. Analyse des risques</h1>\n<h2 id="objectif-2" class="toc-header"><a class="toc-anchor" href="#objectif-2">¶</a> 🎯 Objectif</h2>\n<p>Évaluer :</p>\n<ul>\n<li>la probabilité,</li>\n<li>l’impact,</li>\n<li>le niveau de risque.</li>\n</ul>\n<h2 id="justification-2" class="toc-header"><a class="toc-anchor" href="#justification-2">¶</a> ✔ Justification</h2>\n<p>Permet de <strong>prioriser</strong> les risques.</p>\n<h2 id="méthodes-possibles" class="toc-header"><a class="toc-anchor" href="#méthodes-possibles">¶</a> 📌 Méthodes possibles</h2>\n<ul>\n<li>qualitative (faible / moyen / élevé),</li>\n<li>semi‑quantitative (1 à 5),</li>\n<li>quantitative (pertes financières).</li>\n</ul>\n<h2 id="exemple-concret-2" class="toc-header"><a class="toc-anchor" href="#exemple-concret-2">¶</a> 🧪 Exemple concret</h2>\n<p>Probabilité : élevée (attaques fréquentes)<br>\nImpact : très élevé (perte financière + RGPD)<br>\nRisque : critique</p>\n<h2 id="erreurs-fréquentes-2" class="toc-header"><a class="toc-anchor" href="#erreurs-fréquentes-2">¶</a> ❌ Erreurs fréquentes</h2>\n<ul>\n<li>sous‑estimer les impacts non financiers</li>\n<li>ignorer les risques internes</li>\n</ul>\n<hr>\n<h1 id="️-4-évaluation-des-risques" class="toc-header"><a class="toc-anchor" href="#️-4-évaluation-des-risques">¶</a> 🏗️ 4. Évaluation des risques</h1>\n<h2 id="objectif-3" class="toc-header"><a class="toc-anchor" href="#objectif-3">¶</a> 🎯 Objectif</h2>\n<p>Décider si un risque est :</p>\n<ul>\n<li>acceptable,</li>\n<li>tolérable,</li>\n<li>inacceptable.</li>\n</ul>\n<h2 id="justification-3" class="toc-header"><a class="toc-anchor" href="#justification-3">¶</a> ✔ Justification</h2>\n<p>Permet de savoir <strong>où agir en premier</strong>.</p>\n<h2 id="exemple" class="toc-header"><a class="toc-anchor" href="#exemple">¶</a> 📌 Exemple</h2>\n<p>Risque critique → action immédiate<br>\nRisque moyen → planifié<br>\nRisque faible → surveillé</p>\n<hr>\n<h1 id="️-5-traitement-des-risques" class="toc-header"><a class="toc-anchor" href="#️-5-traitement-des-risques">¶</a> 🏗️ 5. Traitement des risques</h1>\n<h2 id="objectif-4" class="toc-header"><a class="toc-anchor" href="#objectif-4">¶</a> 🎯 Objectif</h2>\n<p>Choisir une stratégie :</p>\n<ol>\n<li><strong>Réduire</strong> (mesures de sécurité)</li>\n<li><strong>Éviter</strong> (changer le processus)</li>\n<li><strong>Transférer</strong> (assurance, sous‑traitant)</li>\n<li><strong>Accepter</strong> (risque faible)</li>\n</ol>\n<h2 id="justification-4" class="toc-header"><a class="toc-anchor" href="#justification-4">¶</a> ✔ Justification</h2>\n<p>Toutes les organisations n’ont pas les mêmes priorités.</p>\n<h2 id="exemple-concret-3" class="toc-header"><a class="toc-anchor" href="#exemple-concret-3">¶</a> 🧪 Exemple concret</h2>\n<p>Risque : ransomware<br>\nTraitement :</p>\n<ul>\n<li>sauvegardes hors ligne,</li>\n<li>MFA,</li>\n<li>segmentation réseau,</li>\n<li>formation anti‑phishing.</li>\n</ul>\n<hr>\n<h1 id="️-6-acceptation-des-risques" class="toc-header"><a class="toc-anchor" href="#️-6-acceptation-des-risques">¶</a> 🏗️ 6. Acceptation des risques</h1>\n<h2 id="objectif-5" class="toc-header"><a class="toc-anchor" href="#objectif-5">¶</a> 🎯 Objectif</h2>\n<p>Valider officiellement les risques résiduels.</p>\n<h2 id="justification-5" class="toc-header"><a class="toc-anchor" href="#justification-5">¶</a> ✔ Justification</h2>\n<p>Responsabilité de la direction, pas du RSSI.</p>\n<h2 id="exemple-1" class="toc-header"><a class="toc-anchor" href="#exemple-1">¶</a> 📌 Exemple</h2>\n<p>“Nous acceptons le risque de perte de service de 2h par mois.”</p>\n<hr>\n<h1 id="️-7-communication" class="toc-header"><a class="toc-anchor" href="#️-7-communication">¶</a> 🏗️ 7. Communication</h1>\n<h2 id="objectif-6" class="toc-header"><a class="toc-anchor" href="#objectif-6">¶</a> 🎯 Objectif</h2>\n<p>Partager les résultats avec :</p>\n<ul>\n<li>direction,</li>\n<li>équipes techniques,</li>\n<li>métiers,</li>\n<li>partenaires.</li>\n</ul>\n<h2 id="justification-6" class="toc-header"><a class="toc-anchor" href="#justification-6">¶</a> ✔ Justification</h2>\n<p>La sécurité est <strong>collective</strong>.</p>\n<hr>\n<h1 id="️-8-surveillance" class="toc-header"><a class="toc-anchor" href="#️-8-surveillance">¶</a> 🏗️ 8. Surveillance</h1>\n<h2 id="objectif-7" class="toc-header"><a class="toc-anchor" href="#objectif-7">¶</a> 🎯 Objectif</h2>\n<p>Mettre en place un cycle d’amélioration continue.</p>\n<h2 id="on-surveille" class="toc-header"><a class="toc-anchor" href="#on-surveille">¶</a> 📌 On surveille :</h2>\n<ul>\n<li>nouveaux risques,</li>\n<li>incidents,</li>\n<li>changements techniques,</li>\n<li>nouvelles vulnérabilités.</li>\n</ul>\n<h2 id="justification-7" class="toc-header"><a class="toc-anchor" href="#justification-7">¶</a> ✔ Justification</h2>\n<p>Un risque évolue dans le temps.</p>\n<hr>\n<h1 id="synthèse-générale" class="toc-header"><a class="toc-anchor" href="#synthèse-générale">¶</a> 🧠 Synthèse générale</h1>\n<p>ISO 27005 permet :</p>\n<ul>\n<li>d’avoir une vision claire des risques,</li>\n<li>de prioriser les actions,</li>\n<li>de justifier les mesures de sécurité,</li>\n<li>de structurer un SMSI,</li>\n<li>de répondre aux exigences ISO 27001.</li>\n</ul>\n<hr>\n<h1 id="tp-final-complet" class="toc-header"><a class="toc-anchor" href="#tp-final-complet">¶</a> 🧪 TP final complet</h1>\n<ol>\n<li>Choisir un périmètre (ex : serveur web).</li>\n<li>Identifier 5 actifs essentiels.</li>\n<li>Lister les menaces et vulnérabilités associées.</li>\n<li>Évaluer probabilité + impact.</li>\n<li>Classer les risques (faible / moyen / élevé / critique).</li>\n<li>Proposer un plan de traitement.</li>\n<li>Rédiger une synthèse pour la direction.</li>\n</ol>\n	[{"title":"ISO/IEC 27005:2022 — Gestion des risques de sécurité de l'information","anchor":"#isoiec-270052022-gestion-des-risques-de-sécurité-de-linformation","children":[{"title":"🎯 Objectifs pédagogiques","anchor":"#objectifs-pédagogiques","children":[]}]},{"title":"🧩 Introduction générale","anchor":"#introduction-générale","children":[]},{"title":"🧱 Pourquoi la gestion des risques est essentielle ?","anchor":"#pourquoi-la-gestion-des-risques-est-essentielle","children":[]},{"title":"🧱 Structure générale de la norme","anchor":"#structure-générale-de-la-norme","children":[]},{"title":"🏗️ 1. Contexte","anchor":"#️-1-contexte","children":[{"title":"🎯 Objectif","anchor":"#objectif","children":[]},{"title":"📌 Contenu","anchor":"#contenu","children":[]},{"title":"✔ Justification","anchor":"#justification","children":[]},{"title":"🧪 Exemple concret","anchor":"#exemple-concret","children":[]},{"title":"❌ Erreurs fréquentes","anchor":"#erreurs-fréquentes","children":[]}]},{"title":"🏗️ 2. Identification des risques","anchor":"#️-2-identification-des-risques","children":[{"title":"🎯 Objectif","anchor":"#objectif-1","children":[]},{"title":"📌 On identifie :","anchor":"#on-identifie","children":[]},{"title":"✔ Justification","anchor":"#justification-1","children":[]},{"title":"🧪 Exemple concret","anchor":"#exemple-concret-1","children":[]},{"title":"❌ Erreurs fréquentes","anchor":"#erreurs-fréquentes-1","children":[]}]},{"title":"🏗️ 3. Analyse des risques","anchor":"#️-3-analyse-des-risques","children":[{"title":"🎯 Objectif","anchor":"#objectif-2","children":[]},{"title":"✔ Justification","anchor":"#justification-2","children":[]},{"title":"📌 Méthodes possibles","anchor":"#méthodes-possibles","children":[]},{"title":"🧪 Exemple concret","anchor":"#exemple-concret-2","children":[]},{"title":"❌ Erreurs fréquentes","anchor":"#erreurs-fréquentes-2","children":[]}]},{"title":"🏗️ 4. Évaluation des risques","anchor":"#️-4-évaluation-des-risques","children":[{"title":"🎯 Objectif","anchor":"#objectif-3","children":[]},{"title":"✔ Justification","anchor":"#justification-3","children":[]},{"title":"📌 Exemple","anchor":"#exemple","children":[]}]},{"title":"🏗️ 5. Traitement des risques","anchor":"#️-5-traitement-des-risques","children":[{"title":"🎯 Objectif","anchor":"#objectif-4","children":[]},{"title":"✔ Justification","anchor":"#justification-4","children":[]},{"title":"🧪 Exemple concret","anchor":"#exemple-concret-3","children":[]}]},{"title":"🏗️ 6. Acceptation des risques","anchor":"#️-6-acceptation-des-risques","children":[{"title":"🎯 Objectif","anchor":"#objectif-5","children":[]},{"title":"✔ Justification","anchor":"#justification-5","children":[]},{"title":"📌 Exemple","anchor":"#exemple-1","children":[]}]},{"title":"🏗️ 7. Communication","anchor":"#️-7-communication","children":[{"title":"🎯 Objectif","anchor":"#objectif-6","children":[]},{"title":"✔ Justification","anchor":"#justification-6","children":[]}]},{"title":"🏗️ 8. Surveillance","anchor":"#️-8-surveillance","children":[{"title":"🎯 Objectif","anchor":"#objectif-7","children":[]},{"title":"📌 On surveille :","anchor":"#on-surveille","children":[]},{"title":"✔ Justification","anchor":"#justification-7","children":[]}]},{"title":"🧠 Synthèse générale","anchor":"#synthèse-générale","children":[]},{"title":"🧪 TP final complet","anchor":"#tp-final-complet","children":[]}]	markdown	2026-03-08T15:39:54.705Z	2026-03-08T16:01:47.422Z	markdown	en	1	1	{"js":"","css":""}
23	home/ISO27001	7a6220617768079052ad5660687c65706c2edd5c	ISO27001 - SMSI		f	t	\N			# ISO/IEC 27001:2022 — Système de Management de la Sécurité de l’Information (SMSI)\n\n## 🎯 Objectifs pédagogiques\n- Comprendre le rôle et les objectifs d’ISO 27001.\n- Savoir ce qu’est un SMSI et pourquoi il est essentiel.\n- Comprendre les exigences de la norme (clauses 4 à 10).\n- Apprendre à justifier chaque exigence auprès d’étudiants ou d’auditeurs.\n- Comprendre les liens entre ISO 27001, ISO 27002 et ISO 27005.\n- Préparer les étudiants à un audit ou un TP de mise en conformité.\n\n---\n\n# 🧩 Introduction générale\n\nISO 27001 est la norme internationale qui définit les **exigences** pour mettre en place un **Système de Management de la Sécurité de l’Information (SMSI)**.\n\nElle permet :\n- de protéger les données,\n- de réduire les risques,\n- d’améliorer la gouvernance,\n- d’assurer la conformité,\n- d’obtenir une certification reconnue mondialement.\n\nISO 27001 est **certifiable**, contrairement à ISO 27002.\n\n---\n\n# 🧱 Pourquoi un SMSI est indispensable ?\n\n## ✔ Justification 1 : les cyberattaques augmentent\nRansomwares, phishing, supply chain, espionnage…\n\n## ✔ Justification 2 : les entreprises dépendent du numérique\nUne panne ou une attaque peut arrêter toute l’activité.\n\n## ✔ Justification 3 : obligations légales\n- RGPD  \n- NIS2  \n- Contrats clients  \n- Assurance cyber  \n\n## ✔ Justification 4 : structurer la sécurité\nSans SMSI → sécurité improvisée, non priorisée.\n\n## ✔ Justification 5 : certification reconnue\nGage de confiance pour les clients et partenaires.\n\n---\n\n# 🧱 Structure de la norme ISO 27001\n\nISO 27001 suit la structure **Annex SL**, commune aux normes ISO :\n\n1. Contexte de l’organisation  \n2. Leadership  \n3. Planification  \n4. Support  \n5. Fonctionnement  \n6. Évaluation des performances  \n7. Amélioration  \n\nEt l’**Annexe A** contient les **93 mesures de sécurité** (détaillées dans ISO 27002).\n\n---\n\n# 🏗️ Clause 4 — Contexte de l’organisation\n\n## 🎯 Objectif\nComprendre l’environnement dans lequel le SMSI doit fonctionner.\n\n## 📌 Contenu\n- contexte interne (processus, culture, organisation),\n- contexte externe (réglementation, marché, menaces),\n- parties intéressées (clients, employés, prestataires),\n- périmètre du SMSI.\n\n## ✔ Justification\nImpossible de sécuriser ce qu’on ne comprend pas.\n\n## 🧪 Exemple concret\nPérimètre :  \n« Le SMSI couvre les services cloud internes, le réseau d’entreprise et les données clients. »\n\n## ❌ Erreurs fréquentes\n- périmètre trop large → ingérable  \n- périmètre trop flou → audit impossible  \n\n---\n\n# 🏗️ Clause 5 — Leadership\n\n## 🎯 Objectif\nImpliquer la direction dans la sécurité.\n\n## 📌 Exigences\n- engagement de la direction,\n- politique de sécurité,\n- rôles et responsabilités.\n\n## ✔ Justification\nSans soutien de la direction → aucun budget, aucune priorité.\n\n## 🧪 Exemple concret\nNomination d’un RSSI + politique de sécurité signée.\n\n---\n\n# 🏗️ Clause 6 — Planification\n\n## 🎯 Objectif\nPlanifier la sécurité sur la base des risques.\n\n## 📌 Exigences\n- analyse de risques (ISO 27005),\n- objectifs de sécurité,\n- plan de traitement des risques.\n\n## ✔ Justification\nLa sécurité doit être **pilotée par les risques**, pas par l’intuition.\n\n## 🧪 Exemple concret\nObjectif :  \n« Réduire le risque ransomware à un niveau acceptable d’ici 12 mois. »\n\n---\n\n# 🏗️ Clause 7 — Support\n\n## 🎯 Objectif\nFournir les ressources nécessaires au SMSI.\n\n## 📌 Exigences\n- compétences,\n- formation,\n- communication,\n- gestion documentaire.\n\n## ✔ Justification\nUn SMSI sans ressources = SMSI inutile.\n\n## 🧪 Exemple concret\nPlan de formation annuel pour les employés.\n\n---\n\n# 🏗️ Clause 8 — Fonctionnement\n\n## 🎯 Objectif\nMettre en œuvre les mesures de sécurité.\n\n## 📌 Exemples\n- gestion des accès,\n- sauvegardes,\n- supervision,\n- gestion des incidents.\n\n## ✔ Justification\nC’est ici que la sécurité devient **opérationnelle**.\n\n---\n\n# 🏗️ Clause 9 — Évaluation des performances\n\n## 🎯 Objectif\nMesurer l’efficacité du SMSI.\n\n## 📌 Exigences\n- audits internes,\n- revue de direction,\n- indicateurs.\n\n## ✔ Justification\nOn ne peut pas améliorer ce qu’on ne mesure pas.\n\n## 🧪 Exemple concret\nIndicateur :  \n« Taux de conformité des sauvegardes : 98 %. »\n\n---\n\n# 🏗️ Clause 10 — Amélioration\n\n## 🎯 Objectif\nAméliorer continuellement le SMSI.\n\n## 📌 Exigences\n- actions correctives,\n- amélioration continue (PDCA).\n\n## ✔ Justification\nLa sécurité évolue → le SMSI aussi.\n\n---\n\n# 🧱 Annexe A — Les 93 mesures de sécurité\n\nLes mesures sont regroupées en 4 catégories :\n\n1. Organisationnelles  \n2. Humaines  \n3. Physiques  \n4. Technologiques  \n\n## ✔ Justification\nCes mesures permettent de réduire les risques identifiés.\n\n## 🧪 Exemples\n- A.5 : gouvernance SSI  \n- A.7 : sécurité RH  \n- A.8 : gestion des actifs  \n- A.9 : contrôle d’accès  \n- A.12 : journalisation  \n- A.17 : continuité d’activité  \n\n---\n\n# 🧱 Liens entre ISO 27001, 27002 et 27005\n\n| Norme | Rôle |\n|-------|------|\n| **ISO 27001** | Exigences du SMSI (certifiable) |\n| **ISO 27002** | Bonnes pratiques pour appliquer les mesures |\n| **ISO 27005** | Méthode d’analyse des risques |\n\n## ✔ Justification\nLes trois normes sont complémentaires.\n\n---\n\n# 🧱 Cas pratiques (mini‑études)\n\n## 🧪 Cas 1 : PME victime d’un ransomware\n- risque critique → plan de traitement  \n- mesures : sauvegardes, MFA, segmentation  \n\n## 🧪 Cas 2 : Collectivité locale sans politique de sécurité\n- non‑conformité clause 5  \n- action : rédaction d’une PSSI  \n\n## 🧪 Cas 3 : Entreprise cloud sans journalisation\n- non‑conformité annexe A  \n- risque : attaque non détectée  \n\n---\n\n# 🧠 Synthèse générale\n\nISO 27001 permet :\n- d’organiser la sécurité,\n- de réduire les risques,\n- d’améliorer la conformité,\n- de structurer les processus,\n- d’obtenir une certification reconnue.\n\n---\n\n# 🧪 TP final complet\n\n1. Définir le périmètre d’un SMSI.  \n2. Identifier les parties intéressées.  \n3. Rédiger une politique de sécurité.  \n4. Réaliser une analyse de risques simple.  \n5. Choisir 10 mesures de l’annexe A.  \n6. Préparer une revue de direction.  \n7. Proposer un plan d’amélioration continue.  \n	<h1 id="isoiec-270012022-système-de-management-de-la-sécurité-de-linformation-smsi" class="toc-header"><a class="toc-anchor" href="#isoiec-270012022-système-de-management-de-la-sécurité-de-linformation-smsi">¶</a> ISO/IEC 27001:2022 — Système de Management de la Sécurité de l’Information (SMSI)</h1>\n<h2 id="objectifs-pédagogiques" class="toc-header"><a class="toc-anchor" href="#objectifs-pédagogiques">¶</a> 🎯 Objectifs pédagogiques</h2>\n<ul>\n<li>Comprendre le rôle et les objectifs d’ISO 27001.</li>\n<li>Savoir ce qu’est un SMSI et pourquoi il est essentiel.</li>\n<li>Comprendre les exigences de la norme (clauses 4 à 10).</li>\n<li>Apprendre à justifier chaque exigence auprès d’étudiants ou d’auditeurs.</li>\n<li>Comprendre les liens entre ISO 27001, ISO 27002 et ISO 27005.</li>\n<li>Préparer les étudiants à un audit ou un TP de mise en conformité.</li>\n</ul>\n<hr>\n<h1 id="introduction-générale" class="toc-header"><a class="toc-anchor" href="#introduction-générale">¶</a> 🧩 Introduction générale</h1>\n<p>ISO 27001 est la norme internationale qui définit les <strong>exigences</strong> pour mettre en place un <strong>Système de Management de la Sécurité de l’Information (SMSI)</strong>.</p>\n<p>Elle permet :</p>\n<ul>\n<li>de protéger les données,</li>\n<li>de réduire les risques,</li>\n<li>d’améliorer la gouvernance,</li>\n<li>d’assurer la conformité,</li>\n<li>d’obtenir une certification reconnue mondialement.</li>\n</ul>\n<p>ISO 27001 est <strong>certifiable</strong>, contrairement à ISO 27002.</p>\n<hr>\n<h1 id="pourquoi-un-smsi-est-indispensable" class="toc-header"><a class="toc-anchor" href="#pourquoi-un-smsi-est-indispensable">¶</a> 🧱 Pourquoi un SMSI est indispensable ?</h1>\n<h2 id="justification-1-les-cyberattaques-augmentent" class="toc-header"><a class="toc-anchor" href="#justification-1-les-cyberattaques-augmentent">¶</a> ✔ Justification 1 : les cyberattaques augmentent</h2>\n<p>Ransomwares, phishing, supply chain, espionnage…</p>\n<h2 id="justification-2-les-entreprises-dépendent-du-numérique" class="toc-header"><a class="toc-anchor" href="#justification-2-les-entreprises-dépendent-du-numérique">¶</a> ✔ Justification 2 : les entreprises dépendent du numérique</h2>\n<p>Une panne ou une attaque peut arrêter toute l’activité.</p>\n<h2 id="justification-3-obligations-légales" class="toc-header"><a class="toc-anchor" href="#justification-3-obligations-légales">¶</a> ✔ Justification 3 : obligations légales</h2>\n<ul>\n<li>RGPD</li>\n<li>NIS2</li>\n<li>Contrats clients</li>\n<li>Assurance cyber</li>\n</ul>\n<h2 id="justification-4-structurer-la-sécurité" class="toc-header"><a class="toc-anchor" href="#justification-4-structurer-la-sécurité">¶</a> ✔ Justification 4 : structurer la sécurité</h2>\n<p>Sans SMSI → sécurité improvisée, non priorisée.</p>\n<h2 id="justification-5-certification-reconnue" class="toc-header"><a class="toc-anchor" href="#justification-5-certification-reconnue">¶</a> ✔ Justification 5 : certification reconnue</h2>\n<p>Gage de confiance pour les clients et partenaires.</p>\n<hr>\n<h1 id="structure-de-la-norme-iso-27001" class="toc-header"><a class="toc-anchor" href="#structure-de-la-norme-iso-27001">¶</a> 🧱 Structure de la norme ISO 27001</h1>\n<p>ISO 27001 suit la structure <strong>Annex SL</strong>, commune aux normes ISO :</p>\n<ol>\n<li>Contexte de l’organisation</li>\n<li>Leadership</li>\n<li>Planification</li>\n<li>Support</li>\n<li>Fonctionnement</li>\n<li>Évaluation des performances</li>\n<li>Amélioration</li>\n</ol>\n<p>Et l’<strong>Annexe A</strong> contient les <strong>93 mesures de sécurité</strong> (détaillées dans ISO 27002).</p>\n<hr>\n<h1 id="️-clause-4-contexte-de-lorganisation" class="toc-header"><a class="toc-anchor" href="#️-clause-4-contexte-de-lorganisation">¶</a> 🏗️ Clause 4 — Contexte de l’organisation</h1>\n<h2 id="objectif" class="toc-header"><a class="toc-anchor" href="#objectif">¶</a> 🎯 Objectif</h2>\n<p>Comprendre l’environnement dans lequel le SMSI doit fonctionner.</p>\n<h2 id="contenu" class="toc-header"><a class="toc-anchor" href="#contenu">¶</a> 📌 Contenu</h2>\n<ul>\n<li>contexte interne (processus, culture, organisation),</li>\n<li>contexte externe (réglementation, marché, menaces),</li>\n<li>parties intéressées (clients, employés, prestataires),</li>\n<li>périmètre du SMSI.</li>\n</ul>\n<h2 id="justification" class="toc-header"><a class="toc-anchor" href="#justification">¶</a> ✔ Justification</h2>\n<p>Impossible de sécuriser ce qu’on ne comprend pas.</p>\n<h2 id="exemple-concret" class="toc-header"><a class="toc-anchor" href="#exemple-concret">¶</a> 🧪 Exemple concret</h2>\n<p>Périmètre :<br>\n« Le SMSI couvre les services cloud internes, le réseau d’entreprise et les données clients. »</p>\n<h2 id="erreurs-fréquentes" class="toc-header"><a class="toc-anchor" href="#erreurs-fréquentes">¶</a> ❌ Erreurs fréquentes</h2>\n<ul>\n<li>périmètre trop large → ingérable</li>\n<li>périmètre trop flou → audit impossible</li>\n</ul>\n<hr>\n<h1 id="️-clause-5-leadership" class="toc-header"><a class="toc-anchor" href="#️-clause-5-leadership">¶</a> 🏗️ Clause 5 — Leadership</h1>\n<h2 id="objectif-1" class="toc-header"><a class="toc-anchor" href="#objectif-1">¶</a> 🎯 Objectif</h2>\n<p>Impliquer la direction dans la sécurité.</p>\n<h2 id="exigences" class="toc-header"><a class="toc-anchor" href="#exigences">¶</a> 📌 Exigences</h2>\n<ul>\n<li>engagement de la direction,</li>\n<li>politique de sécurité,</li>\n<li>rôles et responsabilités.</li>\n</ul>\n<h2 id="justification-1" class="toc-header"><a class="toc-anchor" href="#justification-1">¶</a> ✔ Justification</h2>\n<p>Sans soutien de la direction → aucun budget, aucune priorité.</p>\n<h2 id="exemple-concret-1" class="toc-header"><a class="toc-anchor" href="#exemple-concret-1">¶</a> 🧪 Exemple concret</h2>\n<p>Nomination d’un RSSI + politique de sécurité signée.</p>\n<hr>\n<h1 id="️-clause-6-planification" class="toc-header"><a class="toc-anchor" href="#️-clause-6-planification">¶</a> 🏗️ Clause 6 — Planification</h1>\n<h2 id="objectif-2" class="toc-header"><a class="toc-anchor" href="#objectif-2">¶</a> 🎯 Objectif</h2>\n<p>Planifier la sécurité sur la base des risques.</p>\n<h2 id="exigences-1" class="toc-header"><a class="toc-anchor" href="#exigences-1">¶</a> 📌 Exigences</h2>\n<ul>\n<li>analyse de risques (ISO 27005),</li>\n<li>objectifs de sécurité,</li>\n<li>plan de traitement des risques.</li>\n</ul>\n<h2 id="justification-2" class="toc-header"><a class="toc-anchor" href="#justification-2">¶</a> ✔ Justification</h2>\n<p>La sécurité doit être <strong>pilotée par les risques</strong>, pas par l’intuition.</p>\n<h2 id="exemple-concret-2" class="toc-header"><a class="toc-anchor" href="#exemple-concret-2">¶</a> 🧪 Exemple concret</h2>\n<p>Objectif :<br>\n« Réduire le risque ransomware à un niveau acceptable d’ici 12 mois. »</p>\n<hr>\n<h1 id="️-clause-7-support" class="toc-header"><a class="toc-anchor" href="#️-clause-7-support">¶</a> 🏗️ Clause 7 — Support</h1>\n<h2 id="objectif-3" class="toc-header"><a class="toc-anchor" href="#objectif-3">¶</a> 🎯 Objectif</h2>\n<p>Fournir les ressources nécessaires au SMSI.</p>\n<h2 id="exigences-2" class="toc-header"><a class="toc-anchor" href="#exigences-2">¶</a> 📌 Exigences</h2>\n<ul>\n<li>compétences,</li>\n<li>formation,</li>\n<li>communication,</li>\n<li>gestion documentaire.</li>\n</ul>\n<h2 id="justification-3" class="toc-header"><a class="toc-anchor" href="#justification-3">¶</a> ✔ Justification</h2>\n<p>Un SMSI sans ressources = SMSI inutile.</p>\n<h2 id="exemple-concret-3" class="toc-header"><a class="toc-anchor" href="#exemple-concret-3">¶</a> 🧪 Exemple concret</h2>\n<p>Plan de formation annuel pour les employés.</p>\n<hr>\n<h1 id="️-clause-8-fonctionnement" class="toc-header"><a class="toc-anchor" href="#️-clause-8-fonctionnement">¶</a> 🏗️ Clause 8 — Fonctionnement</h1>\n<h2 id="objectif-4" class="toc-header"><a class="toc-anchor" href="#objectif-4">¶</a> 🎯 Objectif</h2>\n<p>Mettre en œuvre les mesures de sécurité.</p>\n<h2 id="exemples" class="toc-header"><a class="toc-anchor" href="#exemples">¶</a> 📌 Exemples</h2>\n<ul>\n<li>gestion des accès,</li>\n<li>sauvegardes,</li>\n<li>supervision,</li>\n<li>gestion des incidents.</li>\n</ul>\n<h2 id="justification-4" class="toc-header"><a class="toc-anchor" href="#justification-4">¶</a> ✔ Justification</h2>\n<p>C’est ici que la sécurité devient <strong>opérationnelle</strong>.</p>\n<hr>\n<h1 id="️-clause-9-évaluation-des-performances" class="toc-header"><a class="toc-anchor" href="#️-clause-9-évaluation-des-performances">¶</a> 🏗️ Clause 9 — Évaluation des performances</h1>\n<h2 id="objectif-5" class="toc-header"><a class="toc-anchor" href="#objectif-5">¶</a> 🎯 Objectif</h2>\n<p>Mesurer l’efficacité du SMSI.</p>\n<h2 id="exigences-3" class="toc-header"><a class="toc-anchor" href="#exigences-3">¶</a> 📌 Exigences</h2>\n<ul>\n<li>audits internes,</li>\n<li>revue de direction,</li>\n<li>indicateurs.</li>\n</ul>\n<h2 id="justification-5" class="toc-header"><a class="toc-anchor" href="#justification-5">¶</a> ✔ Justification</h2>\n<p>On ne peut pas améliorer ce qu’on ne mesure pas.</p>\n<h2 id="exemple-concret-4" class="toc-header"><a class="toc-anchor" href="#exemple-concret-4">¶</a> 🧪 Exemple concret</h2>\n<p>Indicateur :<br>\n« Taux de conformité des sauvegardes : 98 %. »</p>\n<hr>\n<h1 id="️-clause-10-amélioration" class="toc-header"><a class="toc-anchor" href="#️-clause-10-amélioration">¶</a> 🏗️ Clause 10 — Amélioration</h1>\n<h2 id="objectif-6" class="toc-header"><a class="toc-anchor" href="#objectif-6">¶</a> 🎯 Objectif</h2>\n<p>Améliorer continuellement le SMSI.</p>\n<h2 id="exigences-4" class="toc-header"><a class="toc-anchor" href="#exigences-4">¶</a> 📌 Exigences</h2>\n<ul>\n<li>actions correctives,</li>\n<li>amélioration continue (PDCA).</li>\n</ul>\n<h2 id="justification-6" class="toc-header"><a class="toc-anchor" href="#justification-6">¶</a> ✔ Justification</h2>\n<p>La sécurité évolue → le SMSI aussi.</p>\n<hr>\n<h1 id="annexe-a-les-93-mesures-de-sécurité" class="toc-header"><a class="toc-anchor" href="#annexe-a-les-93-mesures-de-sécurité">¶</a> 🧱 Annexe A — Les 93 mesures de sécurité</h1>\n<p>Les mesures sont regroupées en 4 catégories :</p>\n<ol>\n<li>Organisationnelles</li>\n<li>Humaines</li>\n<li>Physiques</li>\n<li>Technologiques</li>\n</ol>\n<h2 id="justification-7" class="toc-header"><a class="toc-anchor" href="#justification-7">¶</a> ✔ Justification</h2>\n<p>Ces mesures permettent de réduire les risques identifiés.</p>\n<h2 id="exemples-1" class="toc-header"><a class="toc-anchor" href="#exemples-1">¶</a> 🧪 Exemples</h2>\n<ul>\n<li>A.5 : gouvernance SSI</li>\n<li>A.7 : sécurité RH</li>\n<li>A.8 : gestion des actifs</li>\n<li>A.9 : contrôle d’accès</li>\n<li>A.12 : journalisation</li>\n<li>A.17 : continuité d’activité</li>\n</ul>\n<hr>\n<h1 id="liens-entre-iso-27001-27002-et-27005" class="toc-header"><a class="toc-anchor" href="#liens-entre-iso-27001-27002-et-27005">¶</a> 🧱 Liens entre ISO 27001, 27002 et 27005</h1>\n<div class="table-container"><table>\n<thead>\n<tr>\n<th>Norme</th>\n<th>Rôle</th>\n</tr>\n</thead>\n<tbody>\n<tr>\n<td><strong>ISO 27001</strong></td>\n<td>Exigences du SMSI (certifiable)</td>\n</tr>\n<tr>\n<td><strong>ISO 27002</strong></td>\n<td>Bonnes pratiques pour appliquer les mesures</td>\n</tr>\n<tr>\n<td><strong>ISO 27005</strong></td>\n<td>Méthode d’analyse des risques</td>\n</tr>\n</tbody>\n</table></div>\n<h2 id="justification-8" class="toc-header"><a class="toc-anchor" href="#justification-8">¶</a> ✔ Justification</h2>\n<p>Les trois normes sont complémentaires.</p>\n<hr>\n<h1 id="cas-pratiques-miniétudes" class="toc-header"><a class="toc-anchor" href="#cas-pratiques-miniétudes">¶</a> 🧱 Cas pratiques (mini‑études)</h1>\n<h2 id="cas-1-pme-victime-dun-ransomware" class="toc-header"><a class="toc-anchor" href="#cas-1-pme-victime-dun-ransomware">¶</a> 🧪 Cas 1 : PME victime d’un ransomware</h2>\n<ul>\n<li>risque critique → plan de traitement</li>\n<li>mesures : sauvegardes, MFA, segmentation</li>\n</ul>\n<h2 id="cas-2-collectivité-locale-sans-politique-de-sécurité" class="toc-header"><a class="toc-anchor" href="#cas-2-collectivité-locale-sans-politique-de-sécurité">¶</a> 🧪 Cas 2 : Collectivité locale sans politique de sécurité</h2>\n<ul>\n<li>non‑conformité clause 5</li>\n<li>action : rédaction d’une PSSI</li>\n</ul>\n<h2 id="cas-3-entreprise-cloud-sans-journalisation" class="toc-header"><a class="toc-anchor" href="#cas-3-entreprise-cloud-sans-journalisation">¶</a> 🧪 Cas 3 : Entreprise cloud sans journalisation</h2>\n<ul>\n<li>non‑conformité annexe A</li>\n<li>risque : attaque non détectée</li>\n</ul>\n<hr>\n<h1 id="synthèse-générale" class="toc-header"><a class="toc-anchor" href="#synthèse-générale">¶</a> 🧠 Synthèse générale</h1>\n<p>ISO 27001 permet :</p>\n<ul>\n<li>d’organiser la sécurité,</li>\n<li>de réduire les risques,</li>\n<li>d’améliorer la conformité,</li>\n<li>de structurer les processus,</li>\n<li>d’obtenir une certification reconnue.</li>\n</ul>\n<hr>\n<h1 id="tp-final-complet" class="toc-header"><a class="toc-anchor" href="#tp-final-complet">¶</a> 🧪 TP final complet</h1>\n<ol>\n<li>Définir le périmètre d’un SMSI.</li>\n<li>Identifier les parties intéressées.</li>\n<li>Rédiger une politique de sécurité.</li>\n<li>Réaliser une analyse de risques simple.</li>\n<li>Choisir 10 mesures de l’annexe A.</li>\n<li>Préparer une revue de direction.</li>\n<li>Proposer un plan d’amélioration continue.</li>\n</ol>\n	[{"title":"ISO/IEC 27001:2022 — Système de Management de la Sécurité de l’Information (SMSI)","anchor":"#isoiec-270012022-système-de-management-de-la-sécurité-de-linformation-smsi","children":[{"title":"🎯 Objectifs pédagogiques","anchor":"#objectifs-pédagogiques","children":[]}]},{"title":"🧩 Introduction générale","anchor":"#introduction-générale","children":[]},{"title":"🧱 Pourquoi un SMSI est indispensable ?","anchor":"#pourquoi-un-smsi-est-indispensable","children":[{"title":"✔ Justification 1 : les cyberattaques augmentent","anchor":"#justification-1-les-cyberattaques-augmentent","children":[]},{"title":"✔ Justification 2 : les entreprises dépendent du numérique","anchor":"#justification-2-les-entreprises-dépendent-du-numérique","children":[]},{"title":"✔ Justification 3 : obligations légales","anchor":"#justification-3-obligations-légales","children":[]},{"title":"✔ Justification 4 : structurer la sécurité","anchor":"#justification-4-structurer-la-sécurité","children":[]},{"title":"✔ Justification 5 : certification reconnue","anchor":"#justification-5-certification-reconnue","children":[]}]},{"title":"🧱 Structure de la norme ISO 27001","anchor":"#structure-de-la-norme-iso-27001","children":[]},{"title":"🏗️ Clause 4 — Contexte de l’organisation","anchor":"#️-clause-4-contexte-de-lorganisation","children":[{"title":"🎯 Objectif","anchor":"#objectif","children":[]},{"title":"📌 Contenu","anchor":"#contenu","children":[]},{"title":"✔ Justification","anchor":"#justification","children":[]},{"title":"🧪 Exemple concret","anchor":"#exemple-concret","children":[]},{"title":"❌ Erreurs fréquentes","anchor":"#erreurs-fréquentes","children":[]}]},{"title":"🏗️ Clause 5 — Leadership","anchor":"#️-clause-5-leadership","children":[{"title":"🎯 Objectif","anchor":"#objectif-1","children":[]},{"title":"📌 Exigences","anchor":"#exigences","children":[]},{"title":"✔ Justification","anchor":"#justification-1","children":[]},{"title":"🧪 Exemple concret","anchor":"#exemple-concret-1","children":[]}]},{"title":"🏗️ Clause 6 — Planification","anchor":"#️-clause-6-planification","children":[{"title":"🎯 Objectif","anchor":"#objectif-2","children":[]},{"title":"📌 Exigences","anchor":"#exigences-1","children":[]},{"title":"✔ Justification","anchor":"#justification-2","children":[]},{"title":"🧪 Exemple concret","anchor":"#exemple-concret-2","children":[]}]},{"title":"🏗️ Clause 7 — Support","anchor":"#️-clause-7-support","children":[{"title":"🎯 Objectif","anchor":"#objectif-3","children":[]},{"title":"📌 Exigences","anchor":"#exigences-2","children":[]},{"title":"✔ Justification","anchor":"#justification-3","children":[]},{"title":"🧪 Exemple concret","anchor":"#exemple-concret-3","children":[]}]},{"title":"🏗️ Clause 8 — Fonctionnement","anchor":"#️-clause-8-fonctionnement","children":[{"title":"🎯 Objectif","anchor":"#objectif-4","children":[]},{"title":"📌 Exemples","anchor":"#exemples","children":[]},{"title":"✔ Justification","anchor":"#justification-4","children":[]}]},{"title":"🏗️ Clause 9 — Évaluation des performances","anchor":"#️-clause-9-évaluation-des-performances","children":[{"title":"🎯 Objectif","anchor":"#objectif-5","children":[]},{"title":"📌 Exigences","anchor":"#exigences-3","children":[]},{"title":"✔ Justification","anchor":"#justification-5","children":[]},{"title":"🧪 Exemple concret","anchor":"#exemple-concret-4","children":[]}]},{"title":"🏗️ Clause 10 — Amélioration","anchor":"#️-clause-10-amélioration","children":[{"title":"🎯 Objectif","anchor":"#objectif-6","children":[]},{"title":"📌 Exigences","anchor":"#exigences-4","children":[]},{"title":"✔ Justification","anchor":"#justification-6","children":[]}]},{"title":"🧱 Annexe A — Les 93 mesures de sécurité","anchor":"#annexe-a-les-93-mesures-de-sécurité","children":[{"title":"✔ Justification","anchor":"#justification-7","children":[]},{"title":"🧪 Exemples","anchor":"#exemples-1","children":[]}]},{"title":"🧱 Liens entre ISO 27001, 27002 et 27005","anchor":"#liens-entre-iso-27001-27002-et-27005","children":[{"title":"✔ Justification","anchor":"#justification-8","children":[]}]},{"title":"🧱 Cas pratiques (mini‑études)","anchor":"#cas-pratiques-miniétudes","children":[{"title":"🧪 Cas 1 : PME victime d’un ransomware","anchor":"#cas-1-pme-victime-dun-ransomware","children":[]},{"title":"🧪 Cas 2 : Collectivité locale sans politique de sécurité","anchor":"#cas-2-collectivité-locale-sans-politique-de-sécurité","children":[]},{"title":"🧪 Cas 3 : Entreprise cloud sans journalisation","anchor":"#cas-3-entreprise-cloud-sans-journalisation","children":[]}]},{"title":"🧠 Synthèse générale","anchor":"#synthèse-générale","children":[]},{"title":"🧪 TP final complet","anchor":"#tp-final-complet","children":[]}]	markdown	2026-03-08T15:34:56.838Z	2026-03-08T16:07:08.689Z	markdown	en	1	1	{"js":"","css":""}
24	home/ISO27002	693a3348faaadfcf0ebd0e6049bef202876a325b	ISO27002 - Bonne pratique pour les mesures de sécurité		f	t	\N			# ISO/IEC 27002:2022 — Code de bonnes pratiques pour la sécurité de l'information\n\n## 🎯 Objectifs pédagogiques\n- Comprendre le rôle exact d’ISO 27002 dans un SMSI.\n- Apprendre à justifier chaque mesure de sécurité.\n- Savoir appliquer les 93 mesures dans des cas concrets.\n- Développer une vision globale de la sécurité opérationnelle.\n- Préparer les étudiants à un audit, un examen ou un TP.\n\n---\n\n# 🧩 Introduction générale\n\nISO 27002 est une norme **non certifiable**, mais essentielle.  \nElle sert de **guide pratique** pour mettre en œuvre les mesures de sécurité exigées par ISO 27001.\n\n### Pourquoi ISO 27002 est indispensable ?\n- ISO 27001 dit **“ce qu’il faut faire”**.  \n- ISO 27002 explique **“comment le faire”**.\n\nElle fournit :\n- des bonnes pratiques,\n- des exemples concrets,\n- des objectifs de sécurité,\n- des recommandations techniques,\n- des conseils organisationnels.\n\n---\n\n# 🧱 Structure de la norme\n\nLes 93 mesures sont réparties en 4 catégories :\n\n1. **Mesures organisationnelles (37)**\n2. **Mesures humaines (8)**\n3. **Mesures physiques (14)**\n4. **Mesures technologiques (34)**\n\nChaque mesure contient :\n- un **objectif** (ce qu’on veut atteindre),\n- une **justification** (pourquoi c’est important),\n- des **exemples de mise en œuvre**,\n- des **notes** (contexte, exceptions).\n\n---\n\n# 🧱 1. Mesures organisationnelles\n\n## 🎯 Objectif\nStructurer la sécurité au niveau de l’entreprise.\n\n## 📌 Exemples de mesures\n### 🔹 Politique de sécurité\n**Justification :**  \nSans politique, les équipes ne savent pas ce qui est autorisé ou interdit.\n\n**Exemples :**\n- règles d’accès,\n- règles de mots de passe,\n- règles d’usage des équipements.\n\n**Erreur fréquente :**  \nUne politique trop longue que personne ne lit.\n\n---\n\n### 🔹 Gestion des actifs\n**Justification :**  \nOn ne peut pas protéger ce qu’on ne connaît pas.\n\n**Exemples :**\n- inventaire matériel,\n- inventaire logiciel,\n- classification des données.\n\n**Cas concret :**  \nUn serveur oublié dans un coin → non patché → porte d’entrée d’un ransomware.\n\n---\n\n### 🔹 Relations avec les fournisseurs\n**Justification :**  \nLa chaîne d’approvisionnement est une source majeure de risques.\n\n**Exemples :**\n- clauses de sécurité dans les contrats,\n- audits fournisseurs,\n- gestion des accès prestataires.\n\n**Cas réel :**  \nAttaque SolarWinds → compromission via un fournisseur.\n\n---\n\n# 🧪 TP — Mesures organisationnelles\n1. Créer une politique de sécurité simple.  \n2. Faire un inventaire de 10 actifs.  \n3. Classer ces actifs (public / interne / confidentiel / critique).  \n4. Identifier 3 risques liés aux fournisseurs.  \n\n---\n\n# 🧱 2. Mesures humaines\n\n## 🎯 Objectif\nRéduire les risques liés au facteur humain.\n\n## 📌 Exemples de mesures\n### 🔹 Sensibilisation sécurité\n**Justification :**  \n80 % des incidents impliquent une erreur humaine.\n\n**Exemples :**\n- phishing,\n- mots de passe faibles,\n- mauvaise manipulation.\n\n**Bonne pratique :**  \nFormer régulièrement, pas seulement à l’embauche.\n\n---\n\n### 🔹 Clauses de confidentialité\n**Justification :**  \nProtéger les informations sensibles.\n\n**Exemples :**\n- NDA,\n- clauses contractuelles.\n\n---\n\n### 🔹 Gestion des accès lors des départs\n**Justification :**  \nUn compte non désactivé = un risque majeur.\n\n**Cas concret :**  \nUn ancien employé se connecte encore au VPN.\n\n---\n\n# 🧪 TP — Mesures humaines\n1. Créer un plan de sensibilisation annuel.  \n2. Décrire un processus de départ d’un employé.  \n\n---\n\n# 🧱 3. Mesures physiques\n\n## 🎯 Objectif\nProtéger les locaux, équipements et infrastructures.\n\n## 📌 Exemples de mesures\n### 🔹 Contrôle d’accès physique\n**Justification :**  \nUn attaquant dans les locaux peut tout compromettre.\n\n**Exemples :**\n- badges,\n- biométrie,\n- gardiennage.\n\n---\n\n### 🔹 Protection des équipements\n**Justification :**  \nUn serveur volé = données perdues.\n\n**Exemples :**\n- armoires verrouillées,\n- câbles anti-vol,\n- écrans de confidentialité.\n\n---\n\n### 🔹 Zones sécurisées\n**Justification :**  \nLimiter l’accès aux zones sensibles.\n\n**Exemples :**\n- salle serveur,\n- salle réseau.\n\n---\n\n# 🧪 TP — Mesures physiques\n1. Décrire les mesures physiques d’un datacenter.  \n2. Proposer des mesures pour un open-space.  \n\n---\n\n# 🧱 4. Mesures technologiques\n\n## 🎯 Objectif\nProtéger les systèmes, réseaux, applications et données.\n\n## 📌 Exemples de mesures\n### 🔹 Gestion des identités (IAM)\n**Justification :**  \nUn mauvais contrôle d’accès = compromission totale.\n\n**Exemples :**\n- MFA,\n- RBAC,\n- revues d’accès.\n\n---\n\n### 🔹 Chiffrement\n**Justification :**  \nProtéger les données en transit et au repos.\n\n**Exemples :**\n- TLS 1.3,\n- chiffrement disque,\n- gestion des clés.\n\n---\n\n### 🔹 Journalisation et supervision\n**Justification :**  \nImpossible de détecter un incident sans logs.\n\n**Exemples :**\n- SIEM,\n- alertes,\n- corrélation d’événements.\n\n---\n\n### 🔹 Sauvegardes\n**Justification :**  \nDernière ligne de défense contre les ransomwares.\n\n**Exemples :**\n- sauvegardes hors ligne,\n- tests de restauration.\n\n---\n\n# 🧪 TP — Mesures technologiques\n1. Créer une politique de mots de passe conforme ISO 27002.  \n2. Décrire un plan de sauvegarde complet.  \n3. Proposer une architecture de journalisation.  \n\n---\n\n# 🧠 Synthèse générale\n\nISO 27002 permet :\n- d’appliquer concrètement ISO 27001,\n- de structurer la sécurité,\n- de guider les équipes techniques,\n- de réduire les risques,\n- de préparer un audit.\n\n---\n\n# 🧪 TP final complet\n\n1. Choisir un service (ex : messagerie).  \n2. Identifier les risques.  \n3. Sélectionner 10 mesures ISO 27002.  \n4. Justifier leur pertinence.  \n5. Proposer un plan d’action.  \n	<h1 id="isoiec-270022022-code-de-bonnes-pratiques-pour-la-sécurité-de-linformation" class="toc-header"><a class="toc-anchor" href="#isoiec-270022022-code-de-bonnes-pratiques-pour-la-sécurité-de-linformation">¶</a> ISO/IEC 27002:2022 — Code de bonnes pratiques pour la sécurité de l'information</h1>\n<h2 id="objectifs-pédagogiques" class="toc-header"><a class="toc-anchor" href="#objectifs-pédagogiques">¶</a> 🎯 Objectifs pédagogiques</h2>\n<ul>\n<li>Comprendre le rôle exact d’ISO 27002 dans un SMSI.</li>\n<li>Apprendre à justifier chaque mesure de sécurité.</li>\n<li>Savoir appliquer les 93 mesures dans des cas concrets.</li>\n<li>Développer une vision globale de la sécurité opérationnelle.</li>\n<li>Préparer les étudiants à un audit, un examen ou un TP.</li>\n</ul>\n<hr>\n<h1 id="introduction-générale" class="toc-header"><a class="toc-anchor" href="#introduction-générale">¶</a> 🧩 Introduction générale</h1>\n<p>ISO 27002 est une norme <strong>non certifiable</strong>, mais essentielle.<br>\nElle sert de <strong>guide pratique</strong> pour mettre en œuvre les mesures de sécurité exigées par ISO 27001.</p>\n<h3 id="pourquoi-iso-27002-est-indispensable" class="toc-header"><a class="toc-anchor" href="#pourquoi-iso-27002-est-indispensable">¶</a> Pourquoi ISO 27002 est indispensable ?</h3>\n<ul>\n<li>ISO 27001 dit <strong>“ce qu’il faut faire”</strong>.</li>\n<li>ISO 27002 explique <strong>“comment le faire”</strong>.</li>\n</ul>\n<p>Elle fournit :</p>\n<ul>\n<li>des bonnes pratiques,</li>\n<li>des exemples concrets,</li>\n<li>des objectifs de sécurité,</li>\n<li>des recommandations techniques,</li>\n<li>des conseils organisationnels.</li>\n</ul>\n<hr>\n<h1 id="structure-de-la-norme" class="toc-header"><a class="toc-anchor" href="#structure-de-la-norme">¶</a> 🧱 Structure de la norme</h1>\n<p>Les 93 mesures sont réparties en 4 catégories :</p>\n<ol>\n<li><strong>Mesures organisationnelles (37)</strong></li>\n<li><strong>Mesures humaines (8)</strong></li>\n<li><strong>Mesures physiques (14)</strong></li>\n<li><strong>Mesures technologiques (34)</strong></li>\n</ol>\n<p>Chaque mesure contient :</p>\n<ul>\n<li>un <strong>objectif</strong> (ce qu’on veut atteindre),</li>\n<li>une <strong>justification</strong> (pourquoi c’est important),</li>\n<li>des <strong>exemples de mise en œuvre</strong>,</li>\n<li>des <strong>notes</strong> (contexte, exceptions).</li>\n</ul>\n<hr>\n<h1 id="h-1-mesures-organisationnelles" class="toc-header"><a class="toc-anchor" href="#h-1-mesures-organisationnelles">¶</a> 🧱 1. Mesures organisationnelles</h1>\n<h2 id="objectif" class="toc-header"><a class="toc-anchor" href="#objectif">¶</a> 🎯 Objectif</h2>\n<p>Structurer la sécurité au niveau de l’entreprise.</p>\n<h2 id="exemples-de-mesures" class="toc-header"><a class="toc-anchor" href="#exemples-de-mesures">¶</a> 📌 Exemples de mesures</h2>\n<h3 id="politique-de-sécurité" class="toc-header"><a class="toc-anchor" href="#politique-de-sécurité">¶</a> 🔹 Politique de sécurité</h3>\n<p><strong>Justification :</strong><br>\nSans politique, les équipes ne savent pas ce qui est autorisé ou interdit.</p>\n<p><strong>Exemples :</strong></p>\n<ul>\n<li>règles d’accès,</li>\n<li>règles de mots de passe,</li>\n<li>règles d’usage des équipements.</li>\n</ul>\n<p><strong>Erreur fréquente :</strong><br>\nUne politique trop longue que personne ne lit.</p>\n<hr>\n<h3 id="gestion-des-actifs" class="toc-header"><a class="toc-anchor" href="#gestion-des-actifs">¶</a> 🔹 Gestion des actifs</h3>\n<p><strong>Justification :</strong><br>\nOn ne peut pas protéger ce qu’on ne connaît pas.</p>\n<p><strong>Exemples :</strong></p>\n<ul>\n<li>inventaire matériel,</li>\n<li>inventaire logiciel,</li>\n<li>classification des données.</li>\n</ul>\n<p><strong>Cas concret :</strong><br>\nUn serveur oublié dans un coin → non patché → porte d’entrée d’un ransomware.</p>\n<hr>\n<h3 id="relations-avec-les-fournisseurs" class="toc-header"><a class="toc-anchor" href="#relations-avec-les-fournisseurs">¶</a> 🔹 Relations avec les fournisseurs</h3>\n<p><strong>Justification :</strong><br>\nLa chaîne d’approvisionnement est une source majeure de risques.</p>\n<p><strong>Exemples :</strong></p>\n<ul>\n<li>clauses de sécurité dans les contrats,</li>\n<li>audits fournisseurs,</li>\n<li>gestion des accès prestataires.</li>\n</ul>\n<p><strong>Cas réel :</strong><br>\nAttaque SolarWinds → compromission via un fournisseur.</p>\n<hr>\n<h1 id="tp-mesures-organisationnelles" class="toc-header"><a class="toc-anchor" href="#tp-mesures-organisationnelles">¶</a> 🧪 TP — Mesures organisationnelles</h1>\n<ol>\n<li>Créer une politique de sécurité simple.</li>\n<li>Faire un inventaire de 10 actifs.</li>\n<li>Classer ces actifs (public / interne / confidentiel / critique).</li>\n<li>Identifier 3 risques liés aux fournisseurs.</li>\n</ol>\n<hr>\n<h1 id="h-2-mesures-humaines" class="toc-header"><a class="toc-anchor" href="#h-2-mesures-humaines">¶</a> 🧱 2. Mesures humaines</h1>\n<h2 id="objectif-1" class="toc-header"><a class="toc-anchor" href="#objectif-1">¶</a> 🎯 Objectif</h2>\n<p>Réduire les risques liés au facteur humain.</p>\n<h2 id="exemples-de-mesures-1" class="toc-header"><a class="toc-anchor" href="#exemples-de-mesures-1">¶</a> 📌 Exemples de mesures</h2>\n<h3 id="sensibilisation-sécurité" class="toc-header"><a class="toc-anchor" href="#sensibilisation-sécurité">¶</a> 🔹 Sensibilisation sécurité</h3>\n<p><strong>Justification :</strong><br>\n80 % des incidents impliquent une erreur humaine.</p>\n<p><strong>Exemples :</strong></p>\n<ul>\n<li>phishing,</li>\n<li>mots de passe faibles,</li>\n<li>mauvaise manipulation.</li>\n</ul>\n<p><strong>Bonne pratique :</strong><br>\nFormer régulièrement, pas seulement à l’embauche.</p>\n<hr>\n<h3 id="clauses-de-confidentialité" class="toc-header"><a class="toc-anchor" href="#clauses-de-confidentialité">¶</a> 🔹 Clauses de confidentialité</h3>\n<p><strong>Justification :</strong><br>\nProtéger les informations sensibles.</p>\n<p><strong>Exemples :</strong></p>\n<ul>\n<li>NDA,</li>\n<li>clauses contractuelles.</li>\n</ul>\n<hr>\n<h3 id="gestion-des-accès-lors-des-départs" class="toc-header"><a class="toc-anchor" href="#gestion-des-accès-lors-des-départs">¶</a> 🔹 Gestion des accès lors des départs</h3>\n<p><strong>Justification :</strong><br>\nUn compte non désactivé = un risque majeur.</p>\n<p><strong>Cas concret :</strong><br>\nUn ancien employé se connecte encore au VPN.</p>\n<hr>\n<h1 id="tp-mesures-humaines" class="toc-header"><a class="toc-anchor" href="#tp-mesures-humaines">¶</a> 🧪 TP — Mesures humaines</h1>\n<ol>\n<li>Créer un plan de sensibilisation annuel.</li>\n<li>Décrire un processus de départ d’un employé.</li>\n</ol>\n<hr>\n<h1 id="h-3-mesures-physiques" class="toc-header"><a class="toc-anchor" href="#h-3-mesures-physiques">¶</a> 🧱 3. Mesures physiques</h1>\n<h2 id="objectif-2" class="toc-header"><a class="toc-anchor" href="#objectif-2">¶</a> 🎯 Objectif</h2>\n<p>Protéger les locaux, équipements et infrastructures.</p>\n<h2 id="exemples-de-mesures-2" class="toc-header"><a class="toc-anchor" href="#exemples-de-mesures-2">¶</a> 📌 Exemples de mesures</h2>\n<h3 id="contrôle-daccès-physique" class="toc-header"><a class="toc-anchor" href="#contrôle-daccès-physique">¶</a> 🔹 Contrôle d’accès physique</h3>\n<p><strong>Justification :</strong><br>\nUn attaquant dans les locaux peut tout compromettre.</p>\n<p><strong>Exemples :</strong></p>\n<ul>\n<li>badges,</li>\n<li>biométrie,</li>\n<li>gardiennage.</li>\n</ul>\n<hr>\n<h3 id="protection-des-équipements" class="toc-header"><a class="toc-anchor" href="#protection-des-équipements">¶</a> 🔹 Protection des équipements</h3>\n<p><strong>Justification :</strong><br>\nUn serveur volé = données perdues.</p>\n<p><strong>Exemples :</strong></p>\n<ul>\n<li>armoires verrouillées,</li>\n<li>câbles anti-vol,</li>\n<li>écrans de confidentialité.</li>\n</ul>\n<hr>\n<h3 id="zones-sécurisées" class="toc-header"><a class="toc-anchor" href="#zones-sécurisées">¶</a> 🔹 Zones sécurisées</h3>\n<p><strong>Justification :</strong><br>\nLimiter l’accès aux zones sensibles.</p>\n<p><strong>Exemples :</strong></p>\n<ul>\n<li>salle serveur,</li>\n<li>salle réseau.</li>\n</ul>\n<hr>\n<h1 id="tp-mesures-physiques" class="toc-header"><a class="toc-anchor" href="#tp-mesures-physiques">¶</a> 🧪 TP — Mesures physiques</h1>\n<ol>\n<li>Décrire les mesures physiques d’un datacenter.</li>\n<li>Proposer des mesures pour un open-space.</li>\n</ol>\n<hr>\n<h1 id="h-4-mesures-technologiques" class="toc-header"><a class="toc-anchor" href="#h-4-mesures-technologiques">¶</a> 🧱 4. Mesures technologiques</h1>\n<h2 id="objectif-3" class="toc-header"><a class="toc-anchor" href="#objectif-3">¶</a> 🎯 Objectif</h2>\n<p>Protéger les systèmes, réseaux, applications et données.</p>\n<h2 id="exemples-de-mesures-3" class="toc-header"><a class="toc-anchor" href="#exemples-de-mesures-3">¶</a> 📌 Exemples de mesures</h2>\n<h3 id="gestion-des-identités-iam" class="toc-header"><a class="toc-anchor" href="#gestion-des-identités-iam">¶</a> 🔹 Gestion des identités (IAM)</h3>\n<p><strong>Justification :</strong><br>\nUn mauvais contrôle d’accès = compromission totale.</p>\n<p><strong>Exemples :</strong></p>\n<ul>\n<li>MFA,</li>\n<li>RBAC,</li>\n<li>revues d’accès.</li>\n</ul>\n<hr>\n<h3 id="chiffrement" class="toc-header"><a class="toc-anchor" href="#chiffrement">¶</a> 🔹 Chiffrement</h3>\n<p><strong>Justification :</strong><br>\nProtéger les données en transit et au repos.</p>\n<p><strong>Exemples :</strong></p>\n<ul>\n<li>TLS 1.3,</li>\n<li>chiffrement disque,</li>\n<li>gestion des clés.</li>\n</ul>\n<hr>\n<h3 id="journalisation-et-supervision" class="toc-header"><a class="toc-anchor" href="#journalisation-et-supervision">¶</a> 🔹 Journalisation et supervision</h3>\n<p><strong>Justification :</strong><br>\nImpossible de détecter un incident sans logs.</p>\n<p><strong>Exemples :</strong></p>\n<ul>\n<li>SIEM,</li>\n<li>alertes,</li>\n<li>corrélation d’événements.</li>\n</ul>\n<hr>\n<h3 id="sauvegardes" class="toc-header"><a class="toc-anchor" href="#sauvegardes">¶</a> 🔹 Sauvegardes</h3>\n<p><strong>Justification :</strong><br>\nDernière ligne de défense contre les ransomwares.</p>\n<p><strong>Exemples :</strong></p>\n<ul>\n<li>sauvegardes hors ligne,</li>\n<li>tests de restauration.</li>\n</ul>\n<hr>\n<h1 id="tp-mesures-technologiques" class="toc-header"><a class="toc-anchor" href="#tp-mesures-technologiques">¶</a> 🧪 TP — Mesures technologiques</h1>\n<ol>\n<li>Créer une politique de mots de passe conforme ISO 27002.</li>\n<li>Décrire un plan de sauvegarde complet.</li>\n<li>Proposer une architecture de journalisation.</li>\n</ol>\n<hr>\n<h1 id="synthèse-générale" class="toc-header"><a class="toc-anchor" href="#synthèse-générale">¶</a> 🧠 Synthèse générale</h1>\n<p>ISO 27002 permet :</p>\n<ul>\n<li>d’appliquer concrètement ISO 27001,</li>\n<li>de structurer la sécurité,</li>\n<li>de guider les équipes techniques,</li>\n<li>de réduire les risques,</li>\n<li>de préparer un audit.</li>\n</ul>\n<hr>\n<h1 id="tp-final-complet" class="toc-header"><a class="toc-anchor" href="#tp-final-complet">¶</a> 🧪 TP final complet</h1>\n<ol>\n<li>Choisir un service (ex : messagerie).</li>\n<li>Identifier les risques.</li>\n<li>Sélectionner 10 mesures ISO 27002.</li>\n<li>Justifier leur pertinence.</li>\n<li>Proposer un plan d’action.</li>\n</ol>\n	[{"title":"ISO/IEC 27002:2022 — Code de bonnes pratiques pour la sécurité de l'information","anchor":"#isoiec-270022022-code-de-bonnes-pratiques-pour-la-sécurité-de-linformation","children":[{"title":"🎯 Objectifs pédagogiques","anchor":"#objectifs-pédagogiques","children":[]}]},{"title":"🧩 Introduction générale","anchor":"#introduction-générale","children":[]},{"title":"🧱 Structure de la norme","anchor":"#structure-de-la-norme","children":[]},{"title":"🧱 1. Mesures organisationnelles","anchor":"#h-1-mesures-organisationnelles","children":[{"title":"🎯 Objectif","anchor":"#objectif","children":[]},{"title":"📌 Exemples de mesures","anchor":"#exemples-de-mesures","children":[{"title":"🔹 Politique de sécurité","anchor":"#politique-de-sécurité","children":[]},{"title":"🔹 Gestion des actifs","anchor":"#gestion-des-actifs","children":[]},{"title":"🔹 Relations avec les fournisseurs","anchor":"#relations-avec-les-fournisseurs","children":[]}]}]},{"title":"🧪 TP — Mesures organisationnelles","anchor":"#tp-mesures-organisationnelles","children":[]},{"title":"🧱 2. Mesures humaines","anchor":"#h-2-mesures-humaines","children":[{"title":"🎯 Objectif","anchor":"#objectif-1","children":[]},{"title":"📌 Exemples de mesures","anchor":"#exemples-de-mesures-1","children":[{"title":"🔹 Sensibilisation sécurité","anchor":"#sensibilisation-sécurité","children":[]},{"title":"🔹 Clauses de confidentialité","anchor":"#clauses-de-confidentialité","children":[]},{"title":"🔹 Gestion des accès lors des départs","anchor":"#gestion-des-accès-lors-des-départs","children":[]}]}]},{"title":"🧪 TP — Mesures humaines","anchor":"#tp-mesures-humaines","children":[]},{"title":"🧱 3. Mesures physiques","anchor":"#h-3-mesures-physiques","children":[{"title":"🎯 Objectif","anchor":"#objectif-2","children":[]},{"title":"📌 Exemples de mesures","anchor":"#exemples-de-mesures-2","children":[{"title":"🔹 Contrôle d’accès physique","anchor":"#contrôle-daccès-physique","children":[]},{"title":"🔹 Protection des équipements","anchor":"#protection-des-équipements","children":[]},{"title":"🔹 Zones sécurisées","anchor":"#zones-sécurisées","children":[]}]}]},{"title":"🧪 TP — Mesures physiques","anchor":"#tp-mesures-physiques","children":[]},{"title":"🧱 4. Mesures technologiques","anchor":"#h-4-mesures-technologiques","children":[{"title":"🎯 Objectif","anchor":"#objectif-3","children":[]},{"title":"📌 Exemples de mesures","anchor":"#exemples-de-mesures-3","children":[{"title":"🔹 Gestion des identités (IAM)","anchor":"#gestion-des-identités-iam","children":[]},{"title":"🔹 Chiffrement","anchor":"#chiffrement","children":[]},{"title":"🔹 Journalisation et supervision","anchor":"#journalisation-et-supervision","children":[]},{"title":"🔹 Sauvegardes","anchor":"#sauvegardes","children":[]}]}]},{"title":"🧪 TP — Mesures technologiques","anchor":"#tp-mesures-technologiques","children":[]},{"title":"🧠 Synthèse générale","anchor":"#synthèse-générale","children":[]},{"title":"🧪 TP final complet","anchor":"#tp-final-complet","children":[]}]	markdown	2026-03-08T15:38:28.663Z	2026-03-08T15:59:53.652Z	markdown	en	1	1	{"js":"","css":""}
26	home/NIS2	5a451341a9927e5780ecb5370299b3fd36b7102a	NIS2 - Directive		f	t	\N			# Directive NIS2 — Sécurité des réseaux et systèmes d'information\n\n## 🎯 Objectifs pédagogiques\n- Comprendre le rôle et les objectifs de la directive NIS2.\n- Identifier les organisations concernées et leurs obligations.\n- Comprendre les exigences de cybersécurité imposées par l’UE.\n- Savoir justifier chaque exigence auprès d’étudiants ou d’auditeurs.\n- Apprendre les impacts concrets sur les entreprises.\n- Préparer les étudiants à un audit ou un TP de conformité NIS2.\n\n---\n\n# 🧩 Introduction générale\n\nLa directive **NIS2** (Network and Information Security 2) est une loi européenne visant à renforcer la cybersécurité des organisations essentielles au fonctionnement de la société.\n\nElle remplace la directive NIS1 (2016) et impose :\n- plus de secteurs concernés,\n- plus d’obligations,\n- plus de contrôles,\n- plus de sanctions.\n\nNIS2 est **obligatoire** pour les États membres, qui doivent la transposer dans leur droit national.\n\n---\n\n# 🧱 Pourquoi NIS2 existe ?\n\n## ✔ Justification 1 : explosion des cyberattaques\n- Ransomwares massifs\n- Attaques supply chain\n- Attaques sur les hôpitaux\n- Espionnage industriel\n\n## ✔ Justification 2 : dépendance numérique\nLes services essentiels (énergie, santé, transport…) reposent sur l’informatique.\n\n## ✔ Justification 3 : harmonisation européenne\nAvant NIS2, chaque pays avait son propre niveau d’exigence → incohérences.\n\n## ✔ Justification 4 : protéger la société\nUne attaque sur un hôpital ou un réseau électrique peut mettre des vies en danger.\n\n---\n\n# 🧱 Organisations concernées\n\nNIS2 distingue deux catégories :\n\n## 🔹 1. Entités essentielles\nExemples :\n- Énergie\n- Transport\n- Santé\n- Eau potable\n- Finance\n- Administration publique\n- Infrastructures numériques\n\n## 🔹 2. Entités importantes\nExemples :\n- Services numériques (cloud, data centers)\n- Fabrication (chimie, électronique)\n- Recherche\n- Gestion des déchets\n- Agroalimentaire\n\n## ✔ Justification\nCes secteurs sont critiques pour la société ou l’économie.\n\n---\n\n# 🧱 Obligations principales de NIS2\n\nNIS2 impose **10 obligations majeures**.  \nPour chaque obligation, je t’ajoute une justification + un exemple concret.\n\n---\n\n## 🔹 1. Gestion des risques de cybersécurité\n\n**Justification :**  \nImpossible de sécuriser sans connaître les risques.\n\n**Exemples :**\n- analyse de risques annuelle,\n- cartographie des actifs,\n- identification des dépendances critiques.\n\n---\n\n## 🔹 2. Politiques de sécurité documentées\n\n**Justification :**  \nLes équipes doivent savoir quoi faire.\n\n**Exemples :**\n- PSSI,\n- politique d’accès,\n- politique de sauvegarde.\n\n---\n\n## 🔹 3. Gestion des incidents\n\n**Justification :**  \nLes attaques sont inévitables → il faut savoir réagir.\n\n**Exemples :**\n- procédure d’alerte,\n- cellule de crise,\n- journalisation.\n\n---\n\n## 🔹 4. Continuité d’activité (PCA/PRA)\n\n**Justification :**  \nUn service essentiel ne peut pas s’arrêter.\n\n**Exemples :**\n- redondance,\n- PRA,\n- sauvegardes hors ligne.\n\n---\n\n## 🔹 5. Sécurité de la supply chain\n\n**Justification :**  \nLes fournisseurs sont souvent la porte d’entrée.\n\n**Exemples :**\n- audits fournisseurs,\n- clauses contractuelles,\n- contrôle des accès prestataires.\n\n---\n\n## 🔹 6. Sécurité des réseaux et systèmes\n\n**Justification :**  \nRéduire les surfaces d’attaque.\n\n**Exemples :**\n- segmentation réseau,\n- MFA,\n- patch management.\n\n---\n\n## 🔹 7. Authentification forte\n\n**Justification :**  \nLes mots de passe seuls ne suffisent plus.\n\n**Exemples :**\n- MFA obligatoire,\n- gestion des comptes à privilèges.\n\n---\n\n## 🔹 8. Journalisation et supervision\n\n**Justification :**  \nImpossible de détecter une attaque sans logs.\n\n**Exemples :**\n- SIEM,\n- alertes,\n- corrélation d’événements.\n\n---\n\n## 🔹 9. Formation et sensibilisation\n\n**Justification :**  \nLe facteur humain est la première cause d’incidents.\n\n**Exemples :**\n- formation anti‑phishing,\n- exercices de crise.\n\n---\n\n## 🔹 10. Notification des incidents\n\n**Justification :**  \nLes autorités doivent être informées rapidement.\n\n**Délais :**\n- 24h : alerte préliminaire\n- 72h : rapport détaillé\n- 1 mois : rapport final\n\n---\n\n# 🧱 Sanctions NIS2\n\nNIS2 introduit des sanctions **très élevées** :\n\n- jusqu’à **10 millions d’euros**  \n- ou **2 % du chiffre d’affaires mondial**\n\n## ✔ Justification\nCréer un effet dissuasif comparable au RGPD.\n\n---\n\n# 🧱 Impacts concrets pour les entreprises\n\n- obligation de mettre en place un SMSI,\n- audits réguliers,\n- documentation obligatoire,\n- renforcement des équipes SSI,\n- investissements dans la sécurité,\n- responsabilité personnelle des dirigeants.\n\n---\n\n# 🧱 Cas pratiques (mini‑études)\n\n## 🧪 Cas 1 : Hôpital attaqué par ransomware\n- service essentiel → obligations maximales  \n- impact direct sur la vie humaine  \n- obligation de notifier sous 24h  \n\n## 🧪 Cas 2 : Entreprise cloud victime d’une fuite de données\n- entité importante  \n- impact sur des milliers de clients  \n- obligation de renforcer la supply chain  \n\n## 🧪 Cas 3 : Collectivité locale sans MFA\n- non‑conformité  \n- risque de sanction  \n- obligation de mise en conformité immédiate  \n\n---\n\n# 🧠 Synthèse générale\n\nNIS2 impose :\n- une sécurité plus forte,\n- une gouvernance plus stricte,\n- une gestion des risques obligatoire,\n- une supervision continue,\n- une responsabilité accrue des dirigeants.\n\n---\n\n# 🧪 TP final complet\n\n1. Choisir une organisation (ex : hôpital, mairie, entreprise cloud).  \n2. Identifier si elle est “essentielle” ou “importante”.  \n3. Lister ses obligations NIS2.  \n4. Identifier 5 risques majeurs.  \n5. Proposer un plan de mise en conformité.  \n6. Rédiger une synthèse pour la direction.  \n	<h1 id="directive-nis2-sécurité-des-réseaux-et-systèmes-dinformation" class="toc-header"><a class="toc-anchor" href="#directive-nis2-sécurité-des-réseaux-et-systèmes-dinformation">¶</a> Directive NIS2 — Sécurité des réseaux et systèmes d'information</h1>\n<h2 id="objectifs-pédagogiques" class="toc-header"><a class="toc-anchor" href="#objectifs-pédagogiques">¶</a> 🎯 Objectifs pédagogiques</h2>\n<ul>\n<li>Comprendre le rôle et les objectifs de la directive NIS2.</li>\n<li>Identifier les organisations concernées et leurs obligations.</li>\n<li>Comprendre les exigences de cybersécurité imposées par l’UE.</li>\n<li>Savoir justifier chaque exigence auprès d’étudiants ou d’auditeurs.</li>\n<li>Apprendre les impacts concrets sur les entreprises.</li>\n<li>Préparer les étudiants à un audit ou un TP de conformité NIS2.</li>\n</ul>\n<hr>\n<h1 id="introduction-générale" class="toc-header"><a class="toc-anchor" href="#introduction-générale">¶</a> 🧩 Introduction générale</h1>\n<p>La directive <strong>NIS2</strong> (Network and Information Security 2) est une loi européenne visant à renforcer la cybersécurité des organisations essentielles au fonctionnement de la société.</p>\n<p>Elle remplace la directive NIS1 (2016) et impose :</p>\n<ul>\n<li>plus de secteurs concernés,</li>\n<li>plus d’obligations,</li>\n<li>plus de contrôles,</li>\n<li>plus de sanctions.</li>\n</ul>\n<p>NIS2 est <strong>obligatoire</strong> pour les États membres, qui doivent la transposer dans leur droit national.</p>\n<hr>\n<h1 id="pourquoi-nis2-existe" class="toc-header"><a class="toc-anchor" href="#pourquoi-nis2-existe">¶</a> 🧱 Pourquoi NIS2 existe ?</h1>\n<h2 id="justification-1-explosion-des-cyberattaques" class="toc-header"><a class="toc-anchor" href="#justification-1-explosion-des-cyberattaques">¶</a> ✔ Justification 1 : explosion des cyberattaques</h2>\n<ul>\n<li>Ransomwares massifs</li>\n<li>Attaques supply chain</li>\n<li>Attaques sur les hôpitaux</li>\n<li>Espionnage industriel</li>\n</ul>\n<h2 id="justification-2-dépendance-numérique" class="toc-header"><a class="toc-anchor" href="#justification-2-dépendance-numérique">¶</a> ✔ Justification 2 : dépendance numérique</h2>\n<p>Les services essentiels (énergie, santé, transport…) reposent sur l’informatique.</p>\n<h2 id="justification-3-harmonisation-européenne" class="toc-header"><a class="toc-anchor" href="#justification-3-harmonisation-européenne">¶</a> ✔ Justification 3 : harmonisation européenne</h2>\n<p>Avant NIS2, chaque pays avait son propre niveau d’exigence → incohérences.</p>\n<h2 id="justification-4-protéger-la-société" class="toc-header"><a class="toc-anchor" href="#justification-4-protéger-la-société">¶</a> ✔ Justification 4 : protéger la société</h2>\n<p>Une attaque sur un hôpital ou un réseau électrique peut mettre des vies en danger.</p>\n<hr>\n<h1 id="organisations-concernées" class="toc-header"><a class="toc-anchor" href="#organisations-concernées">¶</a> 🧱 Organisations concernées</h1>\n<p>NIS2 distingue deux catégories :</p>\n<h2 id="h-1-entités-essentielles" class="toc-header"><a class="toc-anchor" href="#h-1-entités-essentielles">¶</a> 🔹 1. Entités essentielles</h2>\n<p>Exemples :</p>\n<ul>\n<li>Énergie</li>\n<li>Transport</li>\n<li>Santé</li>\n<li>Eau potable</li>\n<li>Finance</li>\n<li>Administration publique</li>\n<li>Infrastructures numériques</li>\n</ul>\n<h2 id="h-2-entités-importantes" class="toc-header"><a class="toc-anchor" href="#h-2-entités-importantes">¶</a> 🔹 2. Entités importantes</h2>\n<p>Exemples :</p>\n<ul>\n<li>Services numériques (cloud, data centers)</li>\n<li>Fabrication (chimie, électronique)</li>\n<li>Recherche</li>\n<li>Gestion des déchets</li>\n<li>Agroalimentaire</li>\n</ul>\n<h2 id="justification" class="toc-header"><a class="toc-anchor" href="#justification">¶</a> ✔ Justification</h2>\n<p>Ces secteurs sont critiques pour la société ou l’économie.</p>\n<hr>\n<h1 id="obligations-principales-de-nis2" class="toc-header"><a class="toc-anchor" href="#obligations-principales-de-nis2">¶</a> 🧱 Obligations principales de NIS2</h1>\n<p>NIS2 impose <strong>10 obligations majeures</strong>.<br>\nPour chaque obligation, je t’ajoute une justification + un exemple concret.</p>\n<hr>\n<h2 id="h-1-gestion-des-risques-de-cybersécurité" class="toc-header"><a class="toc-anchor" href="#h-1-gestion-des-risques-de-cybersécurité">¶</a> 🔹 1. Gestion des risques de cybersécurité</h2>\n<p><strong>Justification :</strong><br>\nImpossible de sécuriser sans connaître les risques.</p>\n<p><strong>Exemples :</strong></p>\n<ul>\n<li>analyse de risques annuelle,</li>\n<li>cartographie des actifs,</li>\n<li>identification des dépendances critiques.</li>\n</ul>\n<hr>\n<h2 id="h-2-politiques-de-sécurité-documentées" class="toc-header"><a class="toc-anchor" href="#h-2-politiques-de-sécurité-documentées">¶</a> 🔹 2. Politiques de sécurité documentées</h2>\n<p><strong>Justification :</strong><br>\nLes équipes doivent savoir quoi faire.</p>\n<p><strong>Exemples :</strong></p>\n<ul>\n<li>PSSI,</li>\n<li>politique d’accès,</li>\n<li>politique de sauvegarde.</li>\n</ul>\n<hr>\n<h2 id="h-3-gestion-des-incidents" class="toc-header"><a class="toc-anchor" href="#h-3-gestion-des-incidents">¶</a> 🔹 3. Gestion des incidents</h2>\n<p><strong>Justification :</strong><br>\nLes attaques sont inévitables → il faut savoir réagir.</p>\n<p><strong>Exemples :</strong></p>\n<ul>\n<li>procédure d’alerte,</li>\n<li>cellule de crise,</li>\n<li>journalisation.</li>\n</ul>\n<hr>\n<h2 id="h-4-continuité-dactivité-pcapra" class="toc-header"><a class="toc-anchor" href="#h-4-continuité-dactivité-pcapra">¶</a> 🔹 4. Continuité d’activité (PCA/PRA)</h2>\n<p><strong>Justification :</strong><br>\nUn service essentiel ne peut pas s’arrêter.</p>\n<p><strong>Exemples :</strong></p>\n<ul>\n<li>redondance,</li>\n<li>PRA,</li>\n<li>sauvegardes hors ligne.</li>\n</ul>\n<hr>\n<h2 id="h-5-sécurité-de-la-supply-chain" class="toc-header"><a class="toc-anchor" href="#h-5-sécurité-de-la-supply-chain">¶</a> 🔹 5. Sécurité de la supply chain</h2>\n<p><strong>Justification :</strong><br>\nLes fournisseurs sont souvent la porte d’entrée.</p>\n<p><strong>Exemples :</strong></p>\n<ul>\n<li>audits fournisseurs,</li>\n<li>clauses contractuelles,</li>\n<li>contrôle des accès prestataires.</li>\n</ul>\n<hr>\n<h2 id="h-6-sécurité-des-réseaux-et-systèmes" class="toc-header"><a class="toc-anchor" href="#h-6-sécurité-des-réseaux-et-systèmes">¶</a> 🔹 6. Sécurité des réseaux et systèmes</h2>\n<p><strong>Justification :</strong><br>\nRéduire les surfaces d’attaque.</p>\n<p><strong>Exemples :</strong></p>\n<ul>\n<li>segmentation réseau,</li>\n<li>MFA,</li>\n<li>patch management.</li>\n</ul>\n<hr>\n<h2 id="h-7-authentification-forte" class="toc-header"><a class="toc-anchor" href="#h-7-authentification-forte">¶</a> 🔹 7. Authentification forte</h2>\n<p><strong>Justification :</strong><br>\nLes mots de passe seuls ne suffisent plus.</p>\n<p><strong>Exemples :</strong></p>\n<ul>\n<li>MFA obligatoire,</li>\n<li>gestion des comptes à privilèges.</li>\n</ul>\n<hr>\n<h2 id="h-8-journalisation-et-supervision" class="toc-header"><a class="toc-anchor" href="#h-8-journalisation-et-supervision">¶</a> 🔹 8. Journalisation et supervision</h2>\n<p><strong>Justification :</strong><br>\nImpossible de détecter une attaque sans logs.</p>\n<p><strong>Exemples :</strong></p>\n<ul>\n<li>SIEM,</li>\n<li>alertes,</li>\n<li>corrélation d’événements.</li>\n</ul>\n<hr>\n<h2 id="h-9-formation-et-sensibilisation" class="toc-header"><a class="toc-anchor" href="#h-9-formation-et-sensibilisation">¶</a> 🔹 9. Formation et sensibilisation</h2>\n<p><strong>Justification :</strong><br>\nLe facteur humain est la première cause d’incidents.</p>\n<p><strong>Exemples :</strong></p>\n<ul>\n<li>formation anti‑phishing,</li>\n<li>exercices de crise.</li>\n</ul>\n<hr>\n<h2 id="h-10-notification-des-incidents" class="toc-header"><a class="toc-anchor" href="#h-10-notification-des-incidents">¶</a> 🔹 10. Notification des incidents</h2>\n<p><strong>Justification :</strong><br>\nLes autorités doivent être informées rapidement.</p>\n<p><strong>Délais :</strong></p>\n<ul>\n<li>24h : alerte préliminaire</li>\n<li>72h : rapport détaillé</li>\n<li>1 mois : rapport final</li>\n</ul>\n<hr>\n<h1 id="sanctions-nis2" class="toc-header"><a class="toc-anchor" href="#sanctions-nis2">¶</a> 🧱 Sanctions NIS2</h1>\n<p>NIS2 introduit des sanctions <strong>très élevées</strong> :</p>\n<ul>\n<li>jusqu’à <strong>10 millions d’euros</strong></li>\n<li>ou <strong>2 % du chiffre d’affaires mondial</strong></li>\n</ul>\n<h2 id="justification-1" class="toc-header"><a class="toc-anchor" href="#justification-1">¶</a> ✔ Justification</h2>\n<p>Créer un effet dissuasif comparable au RGPD.</p>\n<hr>\n<h1 id="impacts-concrets-pour-les-entreprises" class="toc-header"><a class="toc-anchor" href="#impacts-concrets-pour-les-entreprises">¶</a> 🧱 Impacts concrets pour les entreprises</h1>\n<ul>\n<li>obligation de mettre en place un SMSI,</li>\n<li>audits réguliers,</li>\n<li>documentation obligatoire,</li>\n<li>renforcement des équipes SSI,</li>\n<li>investissements dans la sécurité,</li>\n<li>responsabilité personnelle des dirigeants.</li>\n</ul>\n<hr>\n<h1 id="cas-pratiques-miniétudes" class="toc-header"><a class="toc-anchor" href="#cas-pratiques-miniétudes">¶</a> 🧱 Cas pratiques (mini‑études)</h1>\n<h2 id="cas-1-hôpital-attaqué-par-ransomware" class="toc-header"><a class="toc-anchor" href="#cas-1-hôpital-attaqué-par-ransomware">¶</a> 🧪 Cas 1 : Hôpital attaqué par ransomware</h2>\n<ul>\n<li>service essentiel → obligations maximales</li>\n<li>impact direct sur la vie humaine</li>\n<li>obligation de notifier sous 24h</li>\n</ul>\n<h2 id="cas-2-entreprise-cloud-victime-dune-fuite-de-données" class="toc-header"><a class="toc-anchor" href="#cas-2-entreprise-cloud-victime-dune-fuite-de-données">¶</a> 🧪 Cas 2 : Entreprise cloud victime d’une fuite de données</h2>\n<ul>\n<li>entité importante</li>\n<li>impact sur des milliers de clients</li>\n<li>obligation de renforcer la supply chain</li>\n</ul>\n<h2 id="cas-3-collectivité-locale-sans-mfa" class="toc-header"><a class="toc-anchor" href="#cas-3-collectivité-locale-sans-mfa">¶</a> 🧪 Cas 3 : Collectivité locale sans MFA</h2>\n<ul>\n<li>non‑conformité</li>\n<li>risque de sanction</li>\n<li>obligation de mise en conformité immédiate</li>\n</ul>\n<hr>\n<h1 id="synthèse-générale" class="toc-header"><a class="toc-anchor" href="#synthèse-générale">¶</a> 🧠 Synthèse générale</h1>\n<p>NIS2 impose :</p>\n<ul>\n<li>une sécurité plus forte,</li>\n<li>une gouvernance plus stricte,</li>\n<li>une gestion des risques obligatoire,</li>\n<li>une supervision continue,</li>\n<li>une responsabilité accrue des dirigeants.</li>\n</ul>\n<hr>\n<h1 id="tp-final-complet" class="toc-header"><a class="toc-anchor" href="#tp-final-complet">¶</a> 🧪 TP final complet</h1>\n<ol>\n<li>Choisir une organisation (ex : hôpital, mairie, entreprise cloud).</li>\n<li>Identifier si elle est “essentielle” ou “importante”.</li>\n<li>Lister ses obligations NIS2.</li>\n<li>Identifier 5 risques majeurs.</li>\n<li>Proposer un plan de mise en conformité.</li>\n<li>Rédiger une synthèse pour la direction.</li>\n</ol>\n	[{"title":"Directive NIS2 — Sécurité des réseaux et systèmes d'information","anchor":"#directive-nis2-sécurité-des-réseaux-et-systèmes-dinformation","children":[{"title":"🎯 Objectifs pédagogiques","anchor":"#objectifs-pédagogiques","children":[]}]},{"title":"🧩 Introduction générale","anchor":"#introduction-générale","children":[]},{"title":"🧱 Pourquoi NIS2 existe ?","anchor":"#pourquoi-nis2-existe","children":[{"title":"✔ Justification 1 : explosion des cyberattaques","anchor":"#justification-1-explosion-des-cyberattaques","children":[]},{"title":"✔ Justification 2 : dépendance numérique","anchor":"#justification-2-dépendance-numérique","children":[]},{"title":"✔ Justification 3 : harmonisation européenne","anchor":"#justification-3-harmonisation-européenne","children":[]},{"title":"✔ Justification 4 : protéger la société","anchor":"#justification-4-protéger-la-société","children":[]}]},{"title":"🧱 Organisations concernées","anchor":"#organisations-concernées","children":[{"title":"🔹 1. Entités essentielles","anchor":"#h-1-entités-essentielles","children":[]},{"title":"🔹 2. Entités importantes","anchor":"#h-2-entités-importantes","children":[]},{"title":"✔ Justification","anchor":"#justification","children":[]}]},{"title":"🧱 Obligations principales de NIS2","anchor":"#obligations-principales-de-nis2","children":[{"title":"🔹 1. Gestion des risques de cybersécurité","anchor":"#h-1-gestion-des-risques-de-cybersécurité","children":[]},{"title":"🔹 2. Politiques de sécurité documentées","anchor":"#h-2-politiques-de-sécurité-documentées","children":[]},{"title":"🔹 3. Gestion des incidents","anchor":"#h-3-gestion-des-incidents","children":[]},{"title":"🔹 4. Continuité d’activité (PCA/PRA)","anchor":"#h-4-continuité-dactivité-pcapra","children":[]},{"title":"🔹 5. Sécurité de la supply chain","anchor":"#h-5-sécurité-de-la-supply-chain","children":[]},{"title":"🔹 6. Sécurité des réseaux et systèmes","anchor":"#h-6-sécurité-des-réseaux-et-systèmes","children":[]},{"title":"🔹 7. Authentification forte","anchor":"#h-7-authentification-forte","children":[]},{"title":"🔹 8. Journalisation et supervision","anchor":"#h-8-journalisation-et-supervision","children":[]},{"title":"🔹 9. Formation et sensibilisation","anchor":"#h-9-formation-et-sensibilisation","children":[]},{"title":"🔹 10. Notification des incidents","anchor":"#h-10-notification-des-incidents","children":[]}]},{"title":"🧱 Sanctions NIS2","anchor":"#sanctions-nis2","children":[{"title":"✔ Justification","anchor":"#justification-1","children":[]}]},{"title":"🧱 Impacts concrets pour les entreprises","anchor":"#impacts-concrets-pour-les-entreprises","children":[]},{"title":"🧱 Cas pratiques (mini‑études)","anchor":"#cas-pratiques-miniétudes","children":[{"title":"🧪 Cas 1 : Hôpital attaqué par ransomware","anchor":"#cas-1-hôpital-attaqué-par-ransomware","children":[]},{"title":"🧪 Cas 2 : Entreprise cloud victime d’une fuite de données","anchor":"#cas-2-entreprise-cloud-victime-dune-fuite-de-données","children":[]},{"title":"🧪 Cas 3 : Collectivité locale sans MFA","anchor":"#cas-3-collectivité-locale-sans-mfa","children":[]}]},{"title":"🧠 Synthèse générale","anchor":"#synthèse-générale","children":[]},{"title":"🧪 TP final complet","anchor":"#tp-final-complet","children":[]}]	markdown	2026-03-08T15:41:21.932Z	2026-03-08T18:15:50.120Z	markdown	en	1	1	{"js":"","css":""}
22	home/EbiosRM	3123cae6782d1f00cdaac94c2c3adc263218df68	Ebios RM		f	t	\N			# EBIOS Risk Manager — Cours complet + Intégration de l’outil EBIOS-RM-PRO\n\n## 🎯 Objectifs pédagogiques\n- Comprendre la méthode EBIOS RM en profondeur.\n- Apprendre à utiliser l’outil EBIOS-RM-PRO (Cyber-Autopsie).\n- Construire un scénario complet basé sur GitLab.\n- Générer un JSON compatible avec l’outil.\n- Préparer un TP complet d’analyse de risques.\n\n---\n\n# 🧩 Ressource officielle : EBIOS-RM-PRO (Cyber-Autopsie)\n\nL’outil **EBIOS-RM-PRO** est un générateur de fichiers JSON permettant de structurer et d’automatiser une analyse EBIOS RM.\n\n🔗 **Lien officiel du projet GitHub :**  \nhttps://github.com/Cyber-Autopsie/ebios-rm-pro\n\nCet outil permet :\n- de créer des fichiers JSON structurés,\n- de représenter les ateliers EBIOS RM,\n- d’automatiser la génération de scénarios,\n- d’intégrer l’analyse dans des pipelines DevSecOps,\n- de faciliter les TP étudiants.\n\nIl est particulièrement utile pour :\n- les formations,\n- les audits,\n- les projets DevOps,\n- les environnements GitLab / CI/CD.\n\n---\n\n# 🧩 Comment utiliser l’outil EBIOS-RM-PRO\n\n## 1. Télécharger le projet\nDepuis GitHub :\n- Télécharger le dépôt\n\n## 2. Structure du projet\nL’outil utilise un format JSON standardisé comprenant :\n- le périmètre,\n- les actifs essentiels,\n- les sources de risques,\n- les scénarios stratégiques,\n- les scénarios opérationnels,\n- les mesures de sécurité.\n\n## 3. Générer un fichier JSON\nIl suffit de créer un fichier `.json` conforme au modèle du projet.\n\n## 4. Charger le JSON dans l’outil\nL’outil peut :\n- lire un fichier JSON,\n- valider sa structure,\n- générer des livrables.\n\n## 5. Intégration dans un TP\nLes étudiants peuvent :\n- créer leur propre JSON,\n- le charger dans l’outil,\n- visualiser les scénarios,\n- produire un rapport final.\n\n---\n\n# 🏗️ Atelier 1 — Cadrage et socle de sécurité\n\n## 🎯 Objectifs\nDéfinir :\n- le périmètre GitLab,\n- les actifs essentiels,\n- les besoins de sécurité,\n- le socle existant.\n\n## 📌 Périmètre GitLab\n- Serveur GitLab interne\n- Dépôts de code source\n- Pipelines CI/CD\n- Runners\n- Secrets CI/CD\n- Utilisateurs internes\n\n## 📌 Actifs essentiels\n| Actif | Description | Criticité |\n|-------|-------------|-----------|\n| Code source | Propriété intellectuelle | Très élevé |\n| Secrets CI/CD | Tokens, clés SSH | Très élevé |\n| Pipelines | Automatisation des déploiements | Élevé |\n| Identités GitLab | Comptes utilisateurs | Élevé |\n| Serveur GitLab | Plateforme centrale | Élevé |\n\n## 📌 Besoins de sécurité\n- Confidentialité : secrets CI/CD, code source\n- Intégrité : pipelines, commits\n- Disponibilité : GitLab, runners\n\n## 📌 Socle existant\n- HTTPS obligatoire\n- Authentification LDAP\n- Sauvegardes quotidiennes\n- Runners isolés\n- Journalisation partielle\n\n---\n\n# 🧪 TP Atelier 1\n1. Définir le périmètre GitLab.  \n2. Identifier les actifs essentiels.  \n3. Définir les besoins C/I/D.  \n4. Décrire le socle existant.\n\n---\n\n# 🏗️ Atelier 2 — Sources de risques\n\n## 🎯 Objectifs\nIdentifier :\n- les acteurs menaçants,\n- leurs motivations,\n- leurs capacités.\n\n## 📌 Acteurs menaçants GitLab\n- Cybercriminel (ransomware)\n- Employé malveillant (accès interne)\n- Prestataire (maintenance)\n- Hacktiviste (défiguration)\n- État / APT (espionnage)\n\n---\n\n# 🧪 TP Atelier 2\nAssocier chaque acteur à :\n- une motivation,\n- une capacité,\n- une cible GitLab.\n\n---\n\n# 🏗️ Atelier 3 — Scénarios stratégiques\n\n## 🎯 Objectifs\nConstruire des scénarios de haut niveau.\n\n## 📌 Exemple GitLab\n### Événement redouté (ER1)\n**Compromission du pipeline CI/CD**\n\n### Scénario stratégique\n- Acteur : cybercriminel\n- Objectif : insérer un malware dans le pipeline\n- Cible : secrets CI/CD\n- Impact : déploiement d’un logiciel compromis\n\n---\n\n# 🧪 TP Atelier 3\nCréer 2 scénarios stratégiques :\n- un interne,\n- un externe.\n\n---\n\n# 🏗️ Atelier 4 — Scénarios opérationnels\n\n## 🎯 Objectifs\nDécrire les attaques techniques.\n\n## 📌 Exemple GitLab\n### Scénario opérationnel : Vol de token CI/CD\n1. Phishing d’un développeur  \n2. Accès au compte GitLab  \n3. Vol des variables CI/CD  \n4. Modification du pipeline  \n5. Déploiement d’un malware  \n\n---\n\n# 🧪 TP Atelier 4\nDécrire un scénario opérationnel complet.\n\n---\n\n# 🏗️ Atelier 5 — Traitement du risque\n\n## 🎯 Objectifs\nDéfinir les mesures de sécurité.\n\n## 📌 Mesures GitLab\n- MFA obligatoire  \n- Rotation des tokens  \n- Runners isolés  \n- Signature des commits  \n- Analyse SAST/DAST  \n- Revue de code obligatoire  \n\n---\n\n# 🧪 TP Atelier 5\nProposer 10 mesures pour réduire le risque.\n\n---\n\n# 🧩 JSON complet compatible EBIOS-RM-PRO (GitLab)\n\n```json\n{\n  "perimetre": {\n    "nom": "Plateforme GitLab interne",\n    "description": "Serveur GitLab, pipelines CI/CD, runners, secrets, dépôts de code."\n  },\n  "actifsEssentiels": [\n    {\n      "nom": "Code source",\n      "description": "Propriété intellectuelle de l'entreprise",\n      "criticite": "Très élevé"\n    },\n    {\n      "nom": "Secrets CI/CD",\n      "description": "Tokens, clés SSH, variables sensibles",\n      "criticite": "Très élevé"\n    },\n    {\n      "nom": "Pipeline CI/CD",\n      "description": "Chaîne d'automatisation des déploiements",\n      "criticite": "Élevé"\n    }\n  ],\n  "sourcesDeRisques": [\n    {\n      "acteur": "Cybercriminel",\n      "motivation": "Gain financier",\n      "capacite": "Élevée"\n    },\n    {\n      "acteur": "Employé malveillant",\n      "motivation": "Sabotage",\n      "capacite": "Très élevée"\n    }\n  ],\n  "scenariosStrategiques": [\n    {\n      "evenementRedoute": "Compromission du pipeline CI/CD",\n      "objectifAttaquant": "Injecter un malware dans les déploiements",\n      "cible": "Secrets CI/CD"\n    }\n  ],\n  "scenariosOperationnels": [\n    {\n      "nom": "Vol de token CI/CD",\n      "etapes": [\n        "Phishing d'un développeur",\n        "Accès au compte GitLab",\n        "Vol des variables CI/CD",\n        "Modification du pipeline",\n        "Déploiement du code malveillant"\n      ]\n    }\n  ],\n  "mesures": [\n    "MFA obligatoire",\n    "Rotation automatique des tokens",\n    "Isolation des runners",\n    "Analyse SAST/DAST",\n    "Signature des commits",\n    "Revue de code obligatoire"\n  ]\n}\n\n	<h1 id="ebios-risk-manager-cours-complet-intégration-de-loutil-ebios-rm-pro" class="toc-header"><a class="toc-anchor" href="#ebios-risk-manager-cours-complet-intégration-de-loutil-ebios-rm-pro">¶</a> EBIOS Risk Manager — Cours complet + Intégration de l’outil EBIOS-RM-PRO</h1>\n<h2 id="objectifs-pédagogiques" class="toc-header"><a class="toc-anchor" href="#objectifs-pédagogiques">¶</a> 🎯 Objectifs pédagogiques</h2>\n<ul>\n<li>Comprendre la méthode EBIOS RM en profondeur.</li>\n<li>Apprendre à utiliser l’outil EBIOS-RM-PRO (Cyber-Autopsie).</li>\n<li>Construire un scénario complet basé sur GitLab.</li>\n<li>Générer un JSON compatible avec l’outil.</li>\n<li>Préparer un TP complet d’analyse de risques.</li>\n</ul>\n<hr>\n<h1 id="ressource-officielle-ebios-rm-pro-cyber-autopsie" class="toc-header"><a class="toc-anchor" href="#ressource-officielle-ebios-rm-pro-cyber-autopsie">¶</a> 🧩 Ressource officielle : EBIOS-RM-PRO (Cyber-Autopsie)</h1>\n<p>L’outil <strong>EBIOS-RM-PRO</strong> est un générateur de fichiers JSON permettant de structurer et d’automatiser une analyse EBIOS RM.</p>\n<p>🔗 <strong>Lien officiel du projet GitHub :</strong><br>\n<a href="https://github.com/Cyber-Autopsie/ebios-rm-pro" class="is-external-link">https://github.com/Cyber-Autopsie/ebios-rm-pro</a></p>\n<p>Cet outil permet :</p>\n<ul>\n<li>de créer des fichiers JSON structurés,</li>\n<li>de représenter les ateliers EBIOS RM,</li>\n<li>d’automatiser la génération de scénarios,</li>\n<li>d’intégrer l’analyse dans des pipelines DevSecOps,</li>\n<li>de faciliter les TP étudiants.</li>\n</ul>\n<p>Il est particulièrement utile pour :</p>\n<ul>\n<li>les formations,</li>\n<li>les audits,</li>\n<li>les projets DevOps,</li>\n<li>les environnements GitLab / CI/CD.</li>\n</ul>\n<hr>\n<h1 id="comment-utiliser-loutil-ebios-rm-pro" class="toc-header"><a class="toc-anchor" href="#comment-utiliser-loutil-ebios-rm-pro">¶</a> 🧩 Comment utiliser l’outil EBIOS-RM-PRO</h1>\n<h2 id="h-1-télécharger-le-projet" class="toc-header"><a class="toc-anchor" href="#h-1-télécharger-le-projet">¶</a> 1. Télécharger le projet</h2>\n<p>Depuis GitHub :</p>\n<ul>\n<li>Télécharger le dépôt</li>\n</ul>\n<h2 id="h-2-structure-du-projet" class="toc-header"><a class="toc-anchor" href="#h-2-structure-du-projet">¶</a> 2. Structure du projet</h2>\n<p>L’outil utilise un format JSON standardisé comprenant :</p>\n<ul>\n<li>le périmètre,</li>\n<li>les actifs essentiels,</li>\n<li>les sources de risques,</li>\n<li>les scénarios stratégiques,</li>\n<li>les scénarios opérationnels,</li>\n<li>les mesures de sécurité.</li>\n</ul>\n<h2 id="h-3-générer-un-fichier-json" class="toc-header"><a class="toc-anchor" href="#h-3-générer-un-fichier-json">¶</a> 3. Générer un fichier JSON</h2>\n<p>Il suffit de créer un fichier <code>.json</code> conforme au modèle du projet.</p>\n<h2 id="h-4-charger-le-json-dans-loutil" class="toc-header"><a class="toc-anchor" href="#h-4-charger-le-json-dans-loutil">¶</a> 4. Charger le JSON dans l’outil</h2>\n<p>L’outil peut :</p>\n<ul>\n<li>lire un fichier JSON,</li>\n<li>valider sa structure,</li>\n<li>générer des livrables.</li>\n</ul>\n<h2 id="h-5-intégration-dans-un-tp" class="toc-header"><a class="toc-anchor" href="#h-5-intégration-dans-un-tp">¶</a> 5. Intégration dans un TP</h2>\n<p>Les étudiants peuvent :</p>\n<ul>\n<li>créer leur propre JSON,</li>\n<li>le charger dans l’outil,</li>\n<li>visualiser les scénarios,</li>\n<li>produire un rapport final.</li>\n</ul>\n<hr>\n<h1 id="️-atelier-1-cadrage-et-socle-de-sécurité" class="toc-header"><a class="toc-anchor" href="#️-atelier-1-cadrage-et-socle-de-sécurité">¶</a> 🏗️ Atelier 1 — Cadrage et socle de sécurité</h1>\n<h2 id="objectifs" class="toc-header"><a class="toc-anchor" href="#objectifs">¶</a> 🎯 Objectifs</h2>\n<p>Définir :</p>\n<ul>\n<li>le périmètre GitLab,</li>\n<li>les actifs essentiels,</li>\n<li>les besoins de sécurité,</li>\n<li>le socle existant.</li>\n</ul>\n<h2 id="périmètre-gitlab" class="toc-header"><a class="toc-anchor" href="#périmètre-gitlab">¶</a> 📌 Périmètre GitLab</h2>\n<ul>\n<li>Serveur GitLab interne</li>\n<li>Dépôts de code source</li>\n<li>Pipelines CI/CD</li>\n<li>Runners</li>\n<li>Secrets CI/CD</li>\n<li>Utilisateurs internes</li>\n</ul>\n<h2 id="actifs-essentiels" class="toc-header"><a class="toc-anchor" href="#actifs-essentiels">¶</a> 📌 Actifs essentiels</h2>\n<div class="table-container"><table>\n<thead>\n<tr>\n<th>Actif</th>\n<th>Description</th>\n<th>Criticité</th>\n</tr>\n</thead>\n<tbody>\n<tr>\n<td>Code source</td>\n<td>Propriété intellectuelle</td>\n<td>Très élevé</td>\n</tr>\n<tr>\n<td>Secrets CI/CD</td>\n<td>Tokens, clés SSH</td>\n<td>Très élevé</td>\n</tr>\n<tr>\n<td>Pipelines</td>\n<td>Automatisation des déploiements</td>\n<td>Élevé</td>\n</tr>\n<tr>\n<td>Identités GitLab</td>\n<td>Comptes utilisateurs</td>\n<td>Élevé</td>\n</tr>\n<tr>\n<td>Serveur GitLab</td>\n<td>Plateforme centrale</td>\n<td>Élevé</td>\n</tr>\n</tbody>\n</table></div>\n<h2 id="besoins-de-sécurité" class="toc-header"><a class="toc-anchor" href="#besoins-de-sécurité">¶</a> 📌 Besoins de sécurité</h2>\n<ul>\n<li>Confidentialité : secrets CI/CD, code source</li>\n<li>Intégrité : pipelines, commits</li>\n<li>Disponibilité : GitLab, runners</li>\n</ul>\n<h2 id="socle-existant" class="toc-header"><a class="toc-anchor" href="#socle-existant">¶</a> 📌 Socle existant</h2>\n<ul>\n<li>HTTPS obligatoire</li>\n<li>Authentification LDAP</li>\n<li>Sauvegardes quotidiennes</li>\n<li>Runners isolés</li>\n<li>Journalisation partielle</li>\n</ul>\n<hr>\n<h1 id="tp-atelier-1" class="toc-header"><a class="toc-anchor" href="#tp-atelier-1">¶</a> 🧪 TP Atelier 1</h1>\n<ol>\n<li>Définir le périmètre GitLab.</li>\n<li>Identifier les actifs essentiels.</li>\n<li>Définir les besoins C/I/D.</li>\n<li>Décrire le socle existant.</li>\n</ol>\n<hr>\n<h1 id="️-atelier-2-sources-de-risques" class="toc-header"><a class="toc-anchor" href="#️-atelier-2-sources-de-risques">¶</a> 🏗️ Atelier 2 — Sources de risques</h1>\n<h2 id="objectifs-1" class="toc-header"><a class="toc-anchor" href="#objectifs-1">¶</a> 🎯 Objectifs</h2>\n<p>Identifier :</p>\n<ul>\n<li>les acteurs menaçants,</li>\n<li>leurs motivations,</li>\n<li>leurs capacités.</li>\n</ul>\n<h2 id="acteurs-menaçants-gitlab" class="toc-header"><a class="toc-anchor" href="#acteurs-menaçants-gitlab">¶</a> 📌 Acteurs menaçants GitLab</h2>\n<ul>\n<li>Cybercriminel (ransomware)</li>\n<li>Employé malveillant (accès interne)</li>\n<li>Prestataire (maintenance)</li>\n<li>Hacktiviste (défiguration)</li>\n<li>État / APT (espionnage)</li>\n</ul>\n<hr>\n<h1 id="tp-atelier-2" class="toc-header"><a class="toc-anchor" href="#tp-atelier-2">¶</a> 🧪 TP Atelier 2</h1>\n<p>Associer chaque acteur à :</p>\n<ul>\n<li>une motivation,</li>\n<li>une capacité,</li>\n<li>une cible GitLab.</li>\n</ul>\n<hr>\n<h1 id="️-atelier-3-scénarios-stratégiques" class="toc-header"><a class="toc-anchor" href="#️-atelier-3-scénarios-stratégiques">¶</a> 🏗️ Atelier 3 — Scénarios stratégiques</h1>\n<h2 id="objectifs-2" class="toc-header"><a class="toc-anchor" href="#objectifs-2">¶</a> 🎯 Objectifs</h2>\n<p>Construire des scénarios de haut niveau.</p>\n<h2 id="exemple-gitlab" class="toc-header"><a class="toc-anchor" href="#exemple-gitlab">¶</a> 📌 Exemple GitLab</h2>\n<h3 id="événement-redouté-er1" class="toc-header"><a class="toc-anchor" href="#événement-redouté-er1">¶</a> Événement redouté (ER1)</h3>\n<p><strong>Compromission du pipeline CI/CD</strong></p>\n<h3 id="scénario-stratégique" class="toc-header"><a class="toc-anchor" href="#scénario-stratégique">¶</a> Scénario stratégique</h3>\n<ul>\n<li>Acteur : cybercriminel</li>\n<li>Objectif : insérer un malware dans le pipeline</li>\n<li>Cible : secrets CI/CD</li>\n<li>Impact : déploiement d’un logiciel compromis</li>\n</ul>\n<hr>\n<h1 id="tp-atelier-3" class="toc-header"><a class="toc-anchor" href="#tp-atelier-3">¶</a> 🧪 TP Atelier 3</h1>\n<p>Créer 2 scénarios stratégiques :</p>\n<ul>\n<li>un interne,</li>\n<li>un externe.</li>\n</ul>\n<hr>\n<h1 id="️-atelier-4-scénarios-opérationnels" class="toc-header"><a class="toc-anchor" href="#️-atelier-4-scénarios-opérationnels">¶</a> 🏗️ Atelier 4 — Scénarios opérationnels</h1>\n<h2 id="objectifs-3" class="toc-header"><a class="toc-anchor" href="#objectifs-3">¶</a> 🎯 Objectifs</h2>\n<p>Décrire les attaques techniques.</p>\n<h2 id="exemple-gitlab-1" class="toc-header"><a class="toc-anchor" href="#exemple-gitlab-1">¶</a> 📌 Exemple GitLab</h2>\n<h3 id="scénario-opérationnel-vol-de-token-cicd" class="toc-header"><a class="toc-anchor" href="#scénario-opérationnel-vol-de-token-cicd">¶</a> Scénario opérationnel : Vol de token CI/CD</h3>\n<ol>\n<li>Phishing d’un développeur</li>\n<li>Accès au compte GitLab</li>\n<li>Vol des variables CI/CD</li>\n<li>Modification du pipeline</li>\n<li>Déploiement d’un malware</li>\n</ol>\n<hr>\n<h1 id="tp-atelier-4" class="toc-header"><a class="toc-anchor" href="#tp-atelier-4">¶</a> 🧪 TP Atelier 4</h1>\n<p>Décrire un scénario opérationnel complet.</p>\n<hr>\n<h1 id="️-atelier-5-traitement-du-risque" class="toc-header"><a class="toc-anchor" href="#️-atelier-5-traitement-du-risque">¶</a> 🏗️ Atelier 5 — Traitement du risque</h1>\n<h2 id="objectifs-4" class="toc-header"><a class="toc-anchor" href="#objectifs-4">¶</a> 🎯 Objectifs</h2>\n<p>Définir les mesures de sécurité.</p>\n<h2 id="mesures-gitlab" class="toc-header"><a class="toc-anchor" href="#mesures-gitlab">¶</a> 📌 Mesures GitLab</h2>\n<ul>\n<li>MFA obligatoire</li>\n<li>Rotation des tokens</li>\n<li>Runners isolés</li>\n<li>Signature des commits</li>\n<li>Analyse SAST/DAST</li>\n<li>Revue de code obligatoire</li>\n</ul>\n<hr>\n<h1 id="tp-atelier-5" class="toc-header"><a class="toc-anchor" href="#tp-atelier-5">¶</a> 🧪 TP Atelier 5</h1>\n<p>Proposer 10 mesures pour réduire le risque.</p>\n<hr>\n<h1 id="json-complet-compatible-ebios-rm-pro-gitlab" class="toc-header"><a class="toc-anchor" href="#json-complet-compatible-ebios-rm-pro-gitlab">¶</a> 🧩 JSON complet compatible EBIOS-RM-PRO (GitLab)</h1>\n<pre class="prismjs line-numbers" v-pre="true"><code class="language-json">{\n  "perimetre": {\n    "nom": "Plateforme GitLab interne",\n    "description": "Serveur GitLab, pipelines CI/CD, runners, secrets, dépôts de code."\n  },\n  "actifsEssentiels": [\n    {\n      "nom": "Code source",\n      "description": "Propriété intellectuelle de l'entreprise",\n      "criticite": "Très élevé"\n    },\n    {\n      "nom": "Secrets CI/CD",\n      "description": "Tokens, clés SSH, variables sensibles",\n      "criticite": "Très élevé"\n    },\n    {\n      "nom": "Pipeline CI/CD",\n      "description": "Chaîne d'automatisation des déploiements",\n      "criticite": "Élevé"\n    }\n  ],\n  "sourcesDeRisques": [\n    {\n      "acteur": "Cybercriminel",\n      "motivation": "Gain financier",\n      "capacite": "Élevée"\n    },\n    {\n      "acteur": "Employé malveillant",\n      "motivation": "Sabotage",\n      "capacite": "Très élevée"\n    }\n  ],\n  "scenariosStrategiques": [\n    {\n      "evenementRedoute": "Compromission du pipeline CI/CD",\n      "objectifAttaquant": "Injecter un malware dans les déploiements",\n      "cible": "Secrets CI/CD"\n    }\n  ],\n  "scenariosOperationnels": [\n    {\n      "nom": "Vol de token CI/CD",\n      "etapes": [\n        "Phishing d'un développeur",\n        "Accès au compte GitLab",\n        "Vol des variables CI/CD",\n        "Modification du pipeline",\n        "Déploiement du code malveillant"\n      ]\n    }\n  ],\n  "mesures": [\n    "MFA obligatoire",\n    "Rotation automatique des tokens",\n    "Isolation des runners",\n    "Analyse SAST/DAST",\n    "Signature des commits",\n    "Revue de code obligatoire"\n  ]\n}\n\n</code></pre>\n	[{"title":"EBIOS Risk Manager — Cours complet + Intégration de l’outil EBIOS-RM-PRO","anchor":"#ebios-risk-manager-cours-complet-intégration-de-loutil-ebios-rm-pro","children":[{"title":"🎯 Objectifs pédagogiques","anchor":"#objectifs-pédagogiques","children":[]}]},{"title":"🧩 Ressource officielle : EBIOS-RM-PRO (Cyber-Autopsie)","anchor":"#ressource-officielle-ebios-rm-pro-cyber-autopsie","children":[]},{"title":"🧩 Comment utiliser l’outil EBIOS-RM-PRO","anchor":"#comment-utiliser-loutil-ebios-rm-pro","children":[{"title":"1. Télécharger le projet","anchor":"#h-1-télécharger-le-projet","children":[]},{"title":"2. Structure du projet","anchor":"#h-2-structure-du-projet","children":[]},{"title":"3. Générer un fichier JSON","anchor":"#h-3-générer-un-fichier-json","children":[]},{"title":"4. Charger le JSON dans l’outil","anchor":"#h-4-charger-le-json-dans-loutil","children":[]},{"title":"5. Intégration dans un TP","anchor":"#h-5-intégration-dans-un-tp","children":[]}]},{"title":"🏗️ Atelier 1 — Cadrage et socle de sécurité","anchor":"#️-atelier-1-cadrage-et-socle-de-sécurité","children":[{"title":"🎯 Objectifs","anchor":"#objectifs","children":[]},{"title":"📌 Périmètre GitLab","anchor":"#périmètre-gitlab","children":[]},{"title":"📌 Actifs essentiels","anchor":"#actifs-essentiels","children":[]},{"title":"📌 Besoins de sécurité","anchor":"#besoins-de-sécurité","children":[]},{"title":"📌 Socle existant","anchor":"#socle-existant","children":[]}]},{"title":"🧪 TP Atelier 1","anchor":"#tp-atelier-1","children":[]},{"title":"🏗️ Atelier 2 — Sources de risques","anchor":"#️-atelier-2-sources-de-risques","children":[{"title":"🎯 Objectifs","anchor":"#objectifs-1","children":[]},{"title":"📌 Acteurs menaçants GitLab","anchor":"#acteurs-menaçants-gitlab","children":[]}]},{"title":"🧪 TP Atelier 2","anchor":"#tp-atelier-2","children":[]},{"title":"🏗️ Atelier 3 — Scénarios stratégiques","anchor":"#️-atelier-3-scénarios-stratégiques","children":[{"title":"🎯 Objectifs","anchor":"#objectifs-2","children":[]},{"title":"📌 Exemple GitLab","anchor":"#exemple-gitlab","children":[{"title":"Événement redouté (ER1)","anchor":"#événement-redouté-er1","children":[]},{"title":"Scénario stratégique","anchor":"#scénario-stratégique","children":[]}]}]},{"title":"🧪 TP Atelier 3","anchor":"#tp-atelier-3","children":[]},{"title":"🏗️ Atelier 4 — Scénarios opérationnels","anchor":"#️-atelier-4-scénarios-opérationnels","children":[{"title":"🎯 Objectifs","anchor":"#objectifs-3","children":[]},{"title":"📌 Exemple GitLab","anchor":"#exemple-gitlab-1","children":[{"title":"Scénario opérationnel : Vol de token CI/CD","anchor":"#scénario-opérationnel-vol-de-token-cicd","children":[]}]}]},{"title":"🧪 TP Atelier 4","anchor":"#tp-atelier-4","children":[]},{"title":"🏗️ Atelier 5 — Traitement du risque","anchor":"#️-atelier-5-traitement-du-risque","children":[{"title":"🎯 Objectifs","anchor":"#objectifs-4","children":[]},{"title":"📌 Mesures GitLab","anchor":"#mesures-gitlab","children":[]}]},{"title":"🧪 TP Atelier 5","anchor":"#tp-atelier-5","children":[]},{"title":"🧩 JSON complet compatible EBIOS-RM-PRO (GitLab)","anchor":"#json-complet-compatible-ebios-rm-pro-gitlab","children":[]}]	markdown	2026-03-08T15:32:58.560Z	2026-03-08T15:55:55.756Z	markdown	en	1	1	{"js":"","css":""}
27	home/MEHARI	87121be462bf1559e0552cfb4163d92ccde2810a	MEHARI - Analyse de risques		f	t	\N			# MEHARI — Méthode Harmonisée d'Analyse des Risques\n\n## 🎯 Objectifs pédagogiques\n- Comprendre la logique complète de la méthode MEHARI.\n- Savoir analyser les risques avec les grilles de sécurité.\n- Comprendre les notions de scénarios, vulnérabilités et impacts.\n- Apprendre à justifier chaque étape de l’analyse.\n- Préparer les étudiants à un TP complet d’analyse de risques.\n- Développer une vision opérationnelle de la sécurité.\n\n---\n\n# 🧩 Introduction générale\n\nMEHARI est une méthode française d’analyse des risques développée par le **CLUSIF**.  \nElle est utilisée pour :\n- évaluer les risques,\n- définir les mesures de sécurité,\n- structurer une démarche SSI,\n- préparer un SMSI (ISO 27001).\n\nMEHARI repose sur :\n- des **grilles de vulnérabilités**,\n- des **grilles de menaces**,\n- des **grilles d’impacts**,\n- des **scénarios de risques**.\n\nElle est très pédagogique et adaptée aux étudiants.\n\n---\n\n# 🧱 Pourquoi MEHARI est utile ?\n\n## ✔ Justification 1 : méthode simple et structurée\nLes grilles permettent une analyse claire et reproductible.\n\n## ✔ Justification 2 : adaptée aux organisations de toutes tailles\nPME, collectivités, grandes entreprises.\n\n## ✔ Justification 3 : compatible avec ISO 27005\nMEHARI = outil pratique  \nISO 27005 = cadre méthodologique\n\n## ✔ Justification 4 : très pédagogique\nLes étudiants comprennent rapidement les liens entre :\n- actifs,\n- menaces,\n- vulnérabilités,\n- impacts.\n\n---\n\n# 🧱 Les grandes étapes de MEHARI\n\n1. **Identification des enjeux**\n2. **Analyse des risques**\n3. **Évaluation des vulnérabilités**\n4. **Construction des scénarios**\n5. **Évaluation des impacts**\n6. **Choix des mesures**\n7. **Plan d’action**\n\nChaque étape est détaillée ci‑dessous.\n\n---\n\n# 🏗️ 1. Identification des enjeux\n\n## 🎯 Objectif\nComprendre ce qui est important pour l’organisation.\n\n## 📌 On identifie :\n- les actifs essentiels,\n- les processus critiques,\n- les dépendances,\n- les contraintes légales.\n\n## ✔ Justification\nImpossible d’analyser un risque sans connaître les enjeux.\n\n## 🧪 Exemple concret\nActif : base de données clients  \nEnjeu : continuité du service + RGPD  \n\n---\n\n# 🏗️ 2. Analyse des risques\n\n## 🎯 Objectif\nLister les risques potentiels.\n\n## 📌 On identifie :\n- les menaces,\n- les vulnérabilités,\n- les scénarios possibles.\n\n## ✔ Justification\nUn risque = menace + vulnérabilité + impact.\n\n## 🧪 Exemple concret\nMenace : ransomware  \nVulnérabilité : absence de sauvegarde hors ligne  \n\n---\n\n# 🏗️ 3. Évaluation des vulnérabilités\n\nMEHARI utilise des **grilles de vulnérabilités** pour évaluer :\n- la robustesse des mesures existantes,\n- les faiblesses techniques,\n- les faiblesses organisationnelles.\n\n## ✔ Justification\nLes vulnérabilités déterminent la probabilité d’un risque.\n\n## 🧪 Exemple concret\nVulnérabilité :  \n- pas de MFA → vulnérabilité élevée  \n- pas de segmentation réseau → vulnérabilité critique  \n\n---\n\n# 🏗️ 4. Construction des scénarios\n\n## 🎯 Objectif\nDécrire comment une menace peut exploiter une vulnérabilité.\n\n## 📌 Exemple de scénario\n1. Phishing d’un employé  \n2. Vol d’identifiants  \n3. Accès au serveur  \n4. Déploiement d’un ransomware  \n\n## ✔ Justification\nLes scénarios permettent de comprendre **comment** une attaque se produit.\n\n---\n\n# 🏗️ 5. Évaluation des impacts\n\nMEHARI utilise des **grilles d’impacts** pour évaluer :\n- l’impact financier,\n- l’impact opérationnel,\n- l’impact juridique,\n- l’impact image.\n\n## ✔ Justification\nUn risque n’est pas grave si l’impact est faible.\n\n## 🧪 Exemple concret\nImpact :  \n- perte de données clients → impact très élevé  \n- indisponibilité 2h → impact faible  \n\n---\n\n# 🏗️ 6. Choix des mesures\n\n## 🎯 Objectif\nRéduire les risques à un niveau acceptable.\n\n## 📌 Types de mesures\n- organisationnelles,\n- techniques,\n- physiques,\n- humaines.\n\n## ✔ Justification\nLes mesures doivent être adaptées au risque.\n\n## 🧪 Exemple concret\nRisque : ransomware  \nMesures :  \n- sauvegardes hors ligne,  \n- MFA,  \n- segmentation réseau,  \n- formation anti‑phishing.  \n\n---\n\n# 🏗️ 7. Plan d’action\n\n## 🎯 Objectif\nPlanifier les mesures dans le temps.\n\n## 📌 On définit :\n- priorité,\n- budget,\n- responsable,\n- échéance.\n\n## ✔ Justification\nSans plan d’action → analyse inutile.\n\n---\n\n# 🧱 Cas pratiques (mini‑études)\n\n## 🧪 Cas 1 : PME victime d’un ransomware\n- vulnérabilité : absence de sauvegarde  \n- impact : perte de données  \n- mesure : sauvegarde hors ligne  \n\n## 🧪 Cas 2 : Collectivité locale sans MFA\n- vulnérabilité : comptes non protégés  \n- impact : vol de données  \n- mesure : MFA obligatoire  \n\n## 🧪 Cas 3 : Hôpital avec serveurs obsolètes\n- vulnérabilité : absence de patch  \n- impact : risque vital  \n- mesure : plan de mise à jour  \n\n---\n\n# 🧠 Synthèse générale\n\nMEHARI permet :\n- d’analyser les risques de manière structurée,\n- de comprendre les vulnérabilités,\n- de construire des scénarios réalistes,\n- de définir des mesures adaptées,\n- de préparer un SMSI.\n\n---\n\n# 🧪 TP final complet\n\n1. Choisir un périmètre (ex : service RH).  \n2. Identifier les actifs essentiels.  \n3. Lister les menaces et vulnérabilités.  \n4. Construire 2 scénarios de risques.  \n5. Évaluer les impacts.  \n6. Proposer un plan de traitement.  \n7. Rédiger un plan d’action.  \n	<h1 id="mehari-méthode-harmonisée-danalyse-des-risques" class="toc-header"><a class="toc-anchor" href="#mehari-méthode-harmonisée-danalyse-des-risques">¶</a> MEHARI — Méthode Harmonisée d'Analyse des Risques</h1>\n<h2 id="objectifs-pédagogiques" class="toc-header"><a class="toc-anchor" href="#objectifs-pédagogiques">¶</a> 🎯 Objectifs pédagogiques</h2>\n<ul>\n<li>Comprendre la logique complète de la méthode MEHARI.</li>\n<li>Savoir analyser les risques avec les grilles de sécurité.</li>\n<li>Comprendre les notions de scénarios, vulnérabilités et impacts.</li>\n<li>Apprendre à justifier chaque étape de l’analyse.</li>\n<li>Préparer les étudiants à un TP complet d’analyse de risques.</li>\n<li>Développer une vision opérationnelle de la sécurité.</li>\n</ul>\n<hr>\n<h1 id="introduction-générale" class="toc-header"><a class="toc-anchor" href="#introduction-générale">¶</a> 🧩 Introduction générale</h1>\n<p>MEHARI est une méthode française d’analyse des risques développée par le <strong>CLUSIF</strong>.<br>\nElle est utilisée pour :</p>\n<ul>\n<li>évaluer les risques,</li>\n<li>définir les mesures de sécurité,</li>\n<li>structurer une démarche SSI,</li>\n<li>préparer un SMSI (ISO 27001).</li>\n</ul>\n<p>MEHARI repose sur :</p>\n<ul>\n<li>des <strong>grilles de vulnérabilités</strong>,</li>\n<li>des <strong>grilles de menaces</strong>,</li>\n<li>des <strong>grilles d’impacts</strong>,</li>\n<li>des <strong>scénarios de risques</strong>.</li>\n</ul>\n<p>Elle est très pédagogique et adaptée aux étudiants.</p>\n<hr>\n<h1 id="pourquoi-mehari-est-utile" class="toc-header"><a class="toc-anchor" href="#pourquoi-mehari-est-utile">¶</a> 🧱 Pourquoi MEHARI est utile ?</h1>\n<h2 id="justification-1-méthode-simple-et-structurée" class="toc-header"><a class="toc-anchor" href="#justification-1-méthode-simple-et-structurée">¶</a> ✔ Justification 1 : méthode simple et structurée</h2>\n<p>Les grilles permettent une analyse claire et reproductible.</p>\n<h2 id="justification-2-adaptée-aux-organisations-de-toutes-tailles" class="toc-header"><a class="toc-anchor" href="#justification-2-adaptée-aux-organisations-de-toutes-tailles">¶</a> ✔ Justification 2 : adaptée aux organisations de toutes tailles</h2>\n<p>PME, collectivités, grandes entreprises.</p>\n<h2 id="justification-3-compatible-avec-iso-27005" class="toc-header"><a class="toc-anchor" href="#justification-3-compatible-avec-iso-27005">¶</a> ✔ Justification 3 : compatible avec ISO 27005</h2>\n<p>MEHARI = outil pratique<br>\nISO 27005 = cadre méthodologique</p>\n<h2 id="justification-4-très-pédagogique" class="toc-header"><a class="toc-anchor" href="#justification-4-très-pédagogique">¶</a> ✔ Justification 4 : très pédagogique</h2>\n<p>Les étudiants comprennent rapidement les liens entre :</p>\n<ul>\n<li>actifs,</li>\n<li>menaces,</li>\n<li>vulnérabilités,</li>\n<li>impacts.</li>\n</ul>\n<hr>\n<h1 id="les-grandes-étapes-de-mehari" class="toc-header"><a class="toc-anchor" href="#les-grandes-étapes-de-mehari">¶</a> 🧱 Les grandes étapes de MEHARI</h1>\n<ol>\n<li><strong>Identification des enjeux</strong></li>\n<li><strong>Analyse des risques</strong></li>\n<li><strong>Évaluation des vulnérabilités</strong></li>\n<li><strong>Construction des scénarios</strong></li>\n<li><strong>Évaluation des impacts</strong></li>\n<li><strong>Choix des mesures</strong></li>\n<li><strong>Plan d’action</strong></li>\n</ol>\n<p>Chaque étape est détaillée ci‑dessous.</p>\n<hr>\n<h1 id="️-1-identification-des-enjeux" class="toc-header"><a class="toc-anchor" href="#️-1-identification-des-enjeux">¶</a> 🏗️ 1. Identification des enjeux</h1>\n<h2 id="objectif" class="toc-header"><a class="toc-anchor" href="#objectif">¶</a> 🎯 Objectif</h2>\n<p>Comprendre ce qui est important pour l’organisation.</p>\n<h2 id="on-identifie" class="toc-header"><a class="toc-anchor" href="#on-identifie">¶</a> 📌 On identifie :</h2>\n<ul>\n<li>les actifs essentiels,</li>\n<li>les processus critiques,</li>\n<li>les dépendances,</li>\n<li>les contraintes légales.</li>\n</ul>\n<h2 id="justification" class="toc-header"><a class="toc-anchor" href="#justification">¶</a> ✔ Justification</h2>\n<p>Impossible d’analyser un risque sans connaître les enjeux.</p>\n<h2 id="exemple-concret" class="toc-header"><a class="toc-anchor" href="#exemple-concret">¶</a> 🧪 Exemple concret</h2>\n<p>Actif : base de données clients<br>\nEnjeu : continuité du service + RGPD</p>\n<hr>\n<h1 id="️-2-analyse-des-risques" class="toc-header"><a class="toc-anchor" href="#️-2-analyse-des-risques">¶</a> 🏗️ 2. Analyse des risques</h1>\n<h2 id="objectif-1" class="toc-header"><a class="toc-anchor" href="#objectif-1">¶</a> 🎯 Objectif</h2>\n<p>Lister les risques potentiels.</p>\n<h2 id="on-identifie-1" class="toc-header"><a class="toc-anchor" href="#on-identifie-1">¶</a> 📌 On identifie :</h2>\n<ul>\n<li>les menaces,</li>\n<li>les vulnérabilités,</li>\n<li>les scénarios possibles.</li>\n</ul>\n<h2 id="justification-1" class="toc-header"><a class="toc-anchor" href="#justification-1">¶</a> ✔ Justification</h2>\n<p>Un risque = menace + vulnérabilité + impact.</p>\n<h2 id="exemple-concret-1" class="toc-header"><a class="toc-anchor" href="#exemple-concret-1">¶</a> 🧪 Exemple concret</h2>\n<p>Menace : ransomware<br>\nVulnérabilité : absence de sauvegarde hors ligne</p>\n<hr>\n<h1 id="️-3-évaluation-des-vulnérabilités" class="toc-header"><a class="toc-anchor" href="#️-3-évaluation-des-vulnérabilités">¶</a> 🏗️ 3. Évaluation des vulnérabilités</h1>\n<p>MEHARI utilise des <strong>grilles de vulnérabilités</strong> pour évaluer :</p>\n<ul>\n<li>la robustesse des mesures existantes,</li>\n<li>les faiblesses techniques,</li>\n<li>les faiblesses organisationnelles.</li>\n</ul>\n<h2 id="justification-2" class="toc-header"><a class="toc-anchor" href="#justification-2">¶</a> ✔ Justification</h2>\n<p>Les vulnérabilités déterminent la probabilité d’un risque.</p>\n<h2 id="exemple-concret-2" class="toc-header"><a class="toc-anchor" href="#exemple-concret-2">¶</a> 🧪 Exemple concret</h2>\n<p>Vulnérabilité :</p>\n<ul>\n<li>pas de MFA → vulnérabilité élevée</li>\n<li>pas de segmentation réseau → vulnérabilité critique</li>\n</ul>\n<hr>\n<h1 id="️-4-construction-des-scénarios" class="toc-header"><a class="toc-anchor" href="#️-4-construction-des-scénarios">¶</a> 🏗️ 4. Construction des scénarios</h1>\n<h2 id="objectif-2" class="toc-header"><a class="toc-anchor" href="#objectif-2">¶</a> 🎯 Objectif</h2>\n<p>Décrire comment une menace peut exploiter une vulnérabilité.</p>\n<h2 id="exemple-de-scénario" class="toc-header"><a class="toc-anchor" href="#exemple-de-scénario">¶</a> 📌 Exemple de scénario</h2>\n<ol>\n<li>Phishing d’un employé</li>\n<li>Vol d’identifiants</li>\n<li>Accès au serveur</li>\n<li>Déploiement d’un ransomware</li>\n</ol>\n<h2 id="justification-3" class="toc-header"><a class="toc-anchor" href="#justification-3">¶</a> ✔ Justification</h2>\n<p>Les scénarios permettent de comprendre <strong>comment</strong> une attaque se produit.</p>\n<hr>\n<h1 id="️-5-évaluation-des-impacts" class="toc-header"><a class="toc-anchor" href="#️-5-évaluation-des-impacts">¶</a> 🏗️ 5. Évaluation des impacts</h1>\n<p>MEHARI utilise des <strong>grilles d’impacts</strong> pour évaluer :</p>\n<ul>\n<li>l’impact financier,</li>\n<li>l’impact opérationnel,</li>\n<li>l’impact juridique,</li>\n<li>l’impact image.</li>\n</ul>\n<h2 id="justification-4" class="toc-header"><a class="toc-anchor" href="#justification-4">¶</a> ✔ Justification</h2>\n<p>Un risque n’est pas grave si l’impact est faible.</p>\n<h2 id="exemple-concret-3" class="toc-header"><a class="toc-anchor" href="#exemple-concret-3">¶</a> 🧪 Exemple concret</h2>\n<p>Impact :</p>\n<ul>\n<li>perte de données clients → impact très élevé</li>\n<li>indisponibilité 2h → impact faible</li>\n</ul>\n<hr>\n<h1 id="️-6-choix-des-mesures" class="toc-header"><a class="toc-anchor" href="#️-6-choix-des-mesures">¶</a> 🏗️ 6. Choix des mesures</h1>\n<h2 id="objectif-3" class="toc-header"><a class="toc-anchor" href="#objectif-3">¶</a> 🎯 Objectif</h2>\n<p>Réduire les risques à un niveau acceptable.</p>\n<h2 id="types-de-mesures" class="toc-header"><a class="toc-anchor" href="#types-de-mesures">¶</a> 📌 Types de mesures</h2>\n<ul>\n<li>organisationnelles,</li>\n<li>techniques,</li>\n<li>physiques,</li>\n<li>humaines.</li>\n</ul>\n<h2 id="justification-5" class="toc-header"><a class="toc-anchor" href="#justification-5">¶</a> ✔ Justification</h2>\n<p>Les mesures doivent être adaptées au risque.</p>\n<h2 id="exemple-concret-4" class="toc-header"><a class="toc-anchor" href="#exemple-concret-4">¶</a> 🧪 Exemple concret</h2>\n<p>Risque : ransomware<br>\nMesures :</p>\n<ul>\n<li>sauvegardes hors ligne,</li>\n<li>MFA,</li>\n<li>segmentation réseau,</li>\n<li>formation anti‑phishing.</li>\n</ul>\n<hr>\n<h1 id="️-7-plan-daction" class="toc-header"><a class="toc-anchor" href="#️-7-plan-daction">¶</a> 🏗️ 7. Plan d’action</h1>\n<h2 id="objectif-4" class="toc-header"><a class="toc-anchor" href="#objectif-4">¶</a> 🎯 Objectif</h2>\n<p>Planifier les mesures dans le temps.</p>\n<h2 id="on-définit" class="toc-header"><a class="toc-anchor" href="#on-définit">¶</a> 📌 On définit :</h2>\n<ul>\n<li>priorité,</li>\n<li>budget,</li>\n<li>responsable,</li>\n<li>échéance.</li>\n</ul>\n<h2 id="justification-6" class="toc-header"><a class="toc-anchor" href="#justification-6">¶</a> ✔ Justification</h2>\n<p>Sans plan d’action → analyse inutile.</p>\n<hr>\n<h1 id="cas-pratiques-miniétudes" class="toc-header"><a class="toc-anchor" href="#cas-pratiques-miniétudes">¶</a> 🧱 Cas pratiques (mini‑études)</h1>\n<h2 id="cas-1-pme-victime-dun-ransomware" class="toc-header"><a class="toc-anchor" href="#cas-1-pme-victime-dun-ransomware">¶</a> 🧪 Cas 1 : PME victime d’un ransomware</h2>\n<ul>\n<li>vulnérabilité : absence de sauvegarde</li>\n<li>impact : perte de données</li>\n<li>mesure : sauvegarde hors ligne</li>\n</ul>\n<h2 id="cas-2-collectivité-locale-sans-mfa" class="toc-header"><a class="toc-anchor" href="#cas-2-collectivité-locale-sans-mfa">¶</a> 🧪 Cas 2 : Collectivité locale sans MFA</h2>\n<ul>\n<li>vulnérabilité : comptes non protégés</li>\n<li>impact : vol de données</li>\n<li>mesure : MFA obligatoire</li>\n</ul>\n<h2 id="cas-3-hôpital-avec-serveurs-obsolètes" class="toc-header"><a class="toc-anchor" href="#cas-3-hôpital-avec-serveurs-obsolètes">¶</a> 🧪 Cas 3 : Hôpital avec serveurs obsolètes</h2>\n<ul>\n<li>vulnérabilité : absence de patch</li>\n<li>impact : risque vital</li>\n<li>mesure : plan de mise à jour</li>\n</ul>\n<hr>\n<h1 id="synthèse-générale" class="toc-header"><a class="toc-anchor" href="#synthèse-générale">¶</a> 🧠 Synthèse générale</h1>\n<p>MEHARI permet :</p>\n<ul>\n<li>d’analyser les risques de manière structurée,</li>\n<li>de comprendre les vulnérabilités,</li>\n<li>de construire des scénarios réalistes,</li>\n<li>de définir des mesures adaptées,</li>\n<li>de préparer un SMSI.</li>\n</ul>\n<hr>\n<h1 id="tp-final-complet" class="toc-header"><a class="toc-anchor" href="#tp-final-complet">¶</a> 🧪 TP final complet</h1>\n<ol>\n<li>Choisir un périmètre (ex : service RH).</li>\n<li>Identifier les actifs essentiels.</li>\n<li>Lister les menaces et vulnérabilités.</li>\n<li>Construire 2 scénarios de risques.</li>\n<li>Évaluer les impacts.</li>\n<li>Proposer un plan de traitement.</li>\n<li>Rédiger un plan d’action.</li>\n</ol>\n	[{"title":"MEHARI — Méthode Harmonisée d'Analyse des Risques","anchor":"#mehari-méthode-harmonisée-danalyse-des-risques","children":[{"title":"🎯 Objectifs pédagogiques","anchor":"#objectifs-pédagogiques","children":[]}]},{"title":"🧩 Introduction générale","anchor":"#introduction-générale","children":[]},{"title":"🧱 Pourquoi MEHARI est utile ?","anchor":"#pourquoi-mehari-est-utile","children":[{"title":"✔ Justification 1 : méthode simple et structurée","anchor":"#justification-1-méthode-simple-et-structurée","children":[]},{"title":"✔ Justification 2 : adaptée aux organisations de toutes tailles","anchor":"#justification-2-adaptée-aux-organisations-de-toutes-tailles","children":[]},{"title":"✔ Justification 3 : compatible avec ISO 27005","anchor":"#justification-3-compatible-avec-iso-27005","children":[]},{"title":"✔ Justification 4 : très pédagogique","anchor":"#justification-4-très-pédagogique","children":[]}]},{"title":"🧱 Les grandes étapes de MEHARI","anchor":"#les-grandes-étapes-de-mehari","children":[]},{"title":"🏗️ 1. Identification des enjeux","anchor":"#️-1-identification-des-enjeux","children":[{"title":"🎯 Objectif","anchor":"#objectif","children":[]},{"title":"📌 On identifie :","anchor":"#on-identifie","children":[]},{"title":"✔ Justification","anchor":"#justification","children":[]},{"title":"🧪 Exemple concret","anchor":"#exemple-concret","children":[]}]},{"title":"🏗️ 2. Analyse des risques","anchor":"#️-2-analyse-des-risques","children":[{"title":"🎯 Objectif","anchor":"#objectif-1","children":[]},{"title":"📌 On identifie :","anchor":"#on-identifie-1","children":[]},{"title":"✔ Justification","anchor":"#justification-1","children":[]},{"title":"🧪 Exemple concret","anchor":"#exemple-concret-1","children":[]}]},{"title":"🏗️ 3. Évaluation des vulnérabilités","anchor":"#️-3-évaluation-des-vulnérabilités","children":[{"title":"✔ Justification","anchor":"#justification-2","children":[]},{"title":"🧪 Exemple concret","anchor":"#exemple-concret-2","children":[]}]},{"title":"🏗️ 4. Construction des scénarios","anchor":"#️-4-construction-des-scénarios","children":[{"title":"🎯 Objectif","anchor":"#objectif-2","children":[]},{"title":"📌 Exemple de scénario","anchor":"#exemple-de-scénario","children":[]},{"title":"✔ Justification","anchor":"#justification-3","children":[]}]},{"title":"🏗️ 5. Évaluation des impacts","anchor":"#️-5-évaluation-des-impacts","children":[{"title":"✔ Justification","anchor":"#justification-4","children":[]},{"title":"🧪 Exemple concret","anchor":"#exemple-concret-3","children":[]}]},{"title":"🏗️ 6. Choix des mesures","anchor":"#️-6-choix-des-mesures","children":[{"title":"🎯 Objectif","anchor":"#objectif-3","children":[]},{"title":"📌 Types de mesures","anchor":"#types-de-mesures","children":[]},{"title":"✔ Justification","anchor":"#justification-5","children":[]},{"title":"🧪 Exemple concret","anchor":"#exemple-concret-4","children":[]}]},{"title":"🏗️ 7. Plan d’action","anchor":"#️-7-plan-daction","children":[{"title":"🎯 Objectif","anchor":"#objectif-4","children":[]},{"title":"📌 On définit :","anchor":"#on-définit","children":[]},{"title":"✔ Justification","anchor":"#justification-6","children":[]}]},{"title":"🧱 Cas pratiques (mini‑études)","anchor":"#cas-pratiques-miniétudes","children":[{"title":"🧪 Cas 1 : PME victime d’un ransomware","anchor":"#cas-1-pme-victime-dun-ransomware","children":[]},{"title":"🧪 Cas 2 : Collectivité locale sans MFA","anchor":"#cas-2-collectivité-locale-sans-mfa","children":[]},{"title":"🧪 Cas 3 : Hôpital avec serveurs obsolètes","anchor":"#cas-3-hôpital-avec-serveurs-obsolètes","children":[]}]},{"title":"🧠 Synthèse générale","anchor":"#synthèse-générale","children":[]},{"title":"🧪 TP final complet","anchor":"#tp-final-complet","children":[]}]	markdown	2026-03-08T15:42:45.526Z	2026-03-08T18:15:18.927Z	markdown	en	1	1	{"js":"","css":""}
21	home/rgpd	19efc204f624cfefa2e1b15f99ad966c78d02d7c	RGPD		f	t	\N			# RGPD — Règlement Général sur la Protection des Données.\n\n## 🎯 Objectifs pédagogiques\n- Comprendre les principes fondamentaux du RGPD.\n- Identifier les obligations légales des organisations.\n- Comprendre les droits des personnes concernées.\n- Savoir justifier chaque exigence auprès d’étudiants ou d’auditeurs.\n- Apprendre les impacts concrets sur les entreprises.\n- Préparer les étudiants à un audit ou un TP RGPD.\n\n---\n\n# 🧩 Introduction générale\n\nLe **RGPD** (Règlement Général sur la Protection des Données) est la loi européenne qui encadre la protection des données personnelles.\n\nIl s’applique :\n- à toutes les organisations qui traitent des données personnelles,\n- aux entreprises européennes,\n- aux entreprises non européennes qui ciblent des résidents européens.\n\nLe RGPD vise à :\n- protéger les citoyens,\n- responsabiliser les entreprises,\n- harmoniser les règles en Europe.\n\n---\n\n# 🧱 Pourquoi le RGPD existe ?\n\n## ✔ Justification 1 : explosion des données personnelles\nLes entreprises collectent énormément de données (clients, employés, navigation…).\n\n## ✔ Justification 2 : multiplication des abus\nProfilage, revente de données, surveillance excessive.\n\n## ✔ Justification 3 : harmonisation européenne\nAvant le RGPD, chaque pays avait ses propres lois → incohérences.\n\n## ✔ Justification 4 : protéger les droits fondamentaux\nLa vie privée est un droit fondamental en Europe.\n\n---\n\n# 🧱 Définitions essentielles\n\n## 🔹 Donnée personnelle\nToute information permettant d’identifier une personne :\n- nom,\n- email,\n- IP,\n- localisation,\n- données de santé,\n- données biométriques.\n\n## 🔹 Traitement\nToute opération sur une donnée :\n- collecte,\n- stockage,\n- modification,\n- suppression.\n\n## 🔹 Responsable de traitement\nL’organisation qui décide du “pourquoi” et du “comment”.\n\n## 🔹 Sous‑traitant\nL’organisation qui traite les données pour le compte d’un autre.\n\n---\n\n# 🧱 Les 7 principes fondamentaux du RGPD\n\nPour chaque principe, je t’ajoute une justification + un exemple + une erreur fréquente.\n\n---\n\n## 🔹 1. Licéité, loyauté, transparence\n\n**Justification :**  \nLes personnes doivent savoir ce qu’on fait de leurs données.\n\n**Exemples :**\n- bannière cookies,\n- politique de confidentialité claire.\n\n**Erreur fréquente :**  \nTexte juridique incompréhensible.\n\n---\n\n## 🔹 2. Limitation des finalités\n\n**Justification :**  \nOn ne peut pas utiliser les données pour autre chose que prévu.\n\n**Exemple :**  \nCollecter un email pour une commande ≠ l’utiliser pour du marketing sans consentement.\n\n---\n\n## 🔹 3. Minimisation des données\n\n**Justification :**  \nMoins on collecte, moins on risque.\n\n**Exemple :**  \nNe pas demander la date de naissance si l’âge suffit.\n\n---\n\n## 🔹 4. Exactitude\n\n**Justification :**  \nDes données incorrectes peuvent causer des erreurs graves.\n\n**Exemple :**  \nAdresse erronée → livraison ratée.\n\n---\n\n## 🔹 5. Limitation de conservation\n\n**Justification :**  \nGarder des données trop longtemps augmente les risques.\n\n**Exemple :**  \nSupprimer les comptes inactifs après 3 ans.\n\n---\n\n## 🔹 6. Intégrité et confidentialité\n\n**Justification :**  \nProtéger les données contre les accès non autorisés.\n\n**Exemples :**\n- chiffrement,\n- MFA,\n- sauvegardes.\n\n---\n\n## 🔹 7. Responsabilité (Accountability)\n\n**Justification :**  \nL’entreprise doit prouver sa conformité.\n\n**Exemples :**\n- registre des traitements,\n- politiques internes,\n- preuves de formation.\n\n---\n\n# 🧱 Droits des personnes\n\n## 🔹 Droit d’accès\nVoir quelles données sont collectées.\n\n## 🔹 Droit de rectification\nCorriger les erreurs.\n\n## 🔹 Droit à l’effacement (“droit à l’oubli”)\nSupprimer les données si plus nécessaires.\n\n## 🔹 Droit à la portabilité\nRécupérer ses données dans un format lisible.\n\n## 🔹 Droit d’opposition\nRefuser certains traitements (ex : marketing).\n\n## 🔹 Droit à la limitation\nGeler temporairement un traitement.\n\n## 🔹 Droit d’être informé\nTransparence obligatoire.\n\n---\n\n# 🧱 Obligations des entreprises\n\n## 🔹 1. Registre des traitements\nDocument obligatoire listant :\n- finalités,\n- données collectées,\n- durées de conservation,\n- destinataires.\n\n## 🔹 2. DPO (Délégué à la Protection des Données)\nObligatoire pour :\n- organismes publics,\n- traitements sensibles,\n- surveillance à grande échelle.\n\n## 🔹 3. Analyse d’impact (AIPD)\nObligatoire si :\n- données sensibles,\n- surveillance,\n- risque élevé.\n\n## 🔹 4. Notification des violations\nDélais :\n- 72h à la CNIL,\n- sans délai aux personnes si risque élevé.\n\n## 🔹 5. Contrats sous‑traitants\nClauses obligatoires :\n- sécurité,\n- confidentialité,\n- assistance.\n\n---\n\n# 🧱 Sanctions RGPD\n\n- jusqu’à **20 millions d’euros**,  \n- ou **4 % du chiffre d’affaires mondial**.\n\n## ✔ Justification\nCréer un effet dissuasif réel.\n\n---\n\n# 🧱 Cas pratiques (mini‑études)\n\n## 🧪 Cas 1 : fuite de données clients\n- notification obligatoire,\n- analyse d’impact,\n- mesures correctives.\n\n## 🧪 Cas 2 : collecte excessive\nUne application demande l’accès aux contacts → non conforme.\n\n## 🧪 Cas 3 : absence de consentement\nNewsletter envoyée sans opt‑in → violation RGPD.\n\n---\n\n# 🧠 Synthèse générale\n\nLe RGPD impose :\n- transparence,\n- sécurité,\n- minimisation,\n- responsabilité.\n\nIl protège les citoyens et responsabilise les entreprises.\n\n---\n\n# 🧪 TP final complet\n\n1. Choisir un service (ex : site e‑commerce).  \n2. Identifier les données collectées.  \n3. Déterminer les finalités.  \n4. Construire un registre RGPD.  \n5. Identifier les risques.  \n6. Proposer des mesures de conformité.  \n7. Rédiger une politique de confidentialité.  \n	<h1 id="rgpd-règlement-général-sur-la-protection-des-données" class="toc-header"><a class="toc-anchor" href="#rgpd-règlement-général-sur-la-protection-des-données">¶</a> RGPD — Règlement Général sur la Protection des Données.</h1>\n<h2 id="objectifs-pédagogiques" class="toc-header"><a class="toc-anchor" href="#objectifs-pédagogiques">¶</a> 🎯 Objectifs pédagogiques</h2>\n<ul>\n<li>Comprendre les principes fondamentaux du RGPD.</li>\n<li>Identifier les obligations légales des organisations.</li>\n<li>Comprendre les droits des personnes concernées.</li>\n<li>Savoir justifier chaque exigence auprès d’étudiants ou d’auditeurs.</li>\n<li>Apprendre les impacts concrets sur les entreprises.</li>\n<li>Préparer les étudiants à un audit ou un TP RGPD.</li>\n</ul>\n<hr>\n<h1 id="introduction-générale" class="toc-header"><a class="toc-anchor" href="#introduction-générale">¶</a> 🧩 Introduction générale</h1>\n<p>Le <strong>RGPD</strong> (Règlement Général sur la Protection des Données) est la loi européenne qui encadre la protection des données personnelles.</p>\n<p>Il s’applique :</p>\n<ul>\n<li>à toutes les organisations qui traitent des données personnelles,</li>\n<li>aux entreprises européennes,</li>\n<li>aux entreprises non européennes qui ciblent des résidents européens.</li>\n</ul>\n<p>Le RGPD vise à :</p>\n<ul>\n<li>protéger les citoyens,</li>\n<li>responsabiliser les entreprises,</li>\n<li>harmoniser les règles en Europe.</li>\n</ul>\n<hr>\n<h1 id="pourquoi-le-rgpd-existe" class="toc-header"><a class="toc-anchor" href="#pourquoi-le-rgpd-existe">¶</a> 🧱 Pourquoi le RGPD existe ?</h1>\n<h2 id="justification-1-explosion-des-données-personnelles" class="toc-header"><a class="toc-anchor" href="#justification-1-explosion-des-données-personnelles">¶</a> ✔ Justification 1 : explosion des données personnelles</h2>\n<p>Les entreprises collectent énormément de données (clients, employés, navigation…).</p>\n<h2 id="justification-2-multiplication-des-abus" class="toc-header"><a class="toc-anchor" href="#justification-2-multiplication-des-abus">¶</a> ✔ Justification 2 : multiplication des abus</h2>\n<p>Profilage, revente de données, surveillance excessive.</p>\n<h2 id="justification-3-harmonisation-européenne" class="toc-header"><a class="toc-anchor" href="#justification-3-harmonisation-européenne">¶</a> ✔ Justification 3 : harmonisation européenne</h2>\n<p>Avant le RGPD, chaque pays avait ses propres lois → incohérences.</p>\n<h2 id="justification-4-protéger-les-droits-fondamentaux" class="toc-header"><a class="toc-anchor" href="#justification-4-protéger-les-droits-fondamentaux">¶</a> ✔ Justification 4 : protéger les droits fondamentaux</h2>\n<p>La vie privée est un droit fondamental en Europe.</p>\n<hr>\n<h1 id="définitions-essentielles" class="toc-header"><a class="toc-anchor" href="#définitions-essentielles">¶</a> 🧱 Définitions essentielles</h1>\n<h2 id="donnée-personnelle" class="toc-header"><a class="toc-anchor" href="#donnée-personnelle">¶</a> 🔹 Donnée personnelle</h2>\n<p>Toute information permettant d’identifier une personne :</p>\n<ul>\n<li>nom,</li>\n<li>email,</li>\n<li>IP,</li>\n<li>localisation,</li>\n<li>données de santé,</li>\n<li>données biométriques.</li>\n</ul>\n<h2 id="traitement" class="toc-header"><a class="toc-anchor" href="#traitement">¶</a> 🔹 Traitement</h2>\n<p>Toute opération sur une donnée :</p>\n<ul>\n<li>collecte,</li>\n<li>stockage,</li>\n<li>modification,</li>\n<li>suppression.</li>\n</ul>\n<h2 id="responsable-de-traitement" class="toc-header"><a class="toc-anchor" href="#responsable-de-traitement">¶</a> 🔹 Responsable de traitement</h2>\n<p>L’organisation qui décide du “pourquoi” et du “comment”.</p>\n<h2 id="soustraitant" class="toc-header"><a class="toc-anchor" href="#soustraitant">¶</a> 🔹 Sous‑traitant</h2>\n<p>L’organisation qui traite les données pour le compte d’un autre.</p>\n<hr>\n<h1 id="les-7-principes-fondamentaux-du-rgpd" class="toc-header"><a class="toc-anchor" href="#les-7-principes-fondamentaux-du-rgpd">¶</a> 🧱 Les 7 principes fondamentaux du RGPD</h1>\n<p>Pour chaque principe, je t’ajoute une justification + un exemple + une erreur fréquente.</p>\n<hr>\n<h2 id="h-1-licéité-loyauté-transparence" class="toc-header"><a class="toc-anchor" href="#h-1-licéité-loyauté-transparence">¶</a> 🔹 1. Licéité, loyauté, transparence</h2>\n<p><strong>Justification :</strong><br>\nLes personnes doivent savoir ce qu’on fait de leurs données.</p>\n<p><strong>Exemples :</strong></p>\n<ul>\n<li>bannière cookies,</li>\n<li>politique de confidentialité claire.</li>\n</ul>\n<p><strong>Erreur fréquente :</strong><br>\nTexte juridique incompréhensible.</p>\n<hr>\n<h2 id="h-2-limitation-des-finalités" class="toc-header"><a class="toc-anchor" href="#h-2-limitation-des-finalités">¶</a> 🔹 2. Limitation des finalités</h2>\n<p><strong>Justification :</strong><br>\nOn ne peut pas utiliser les données pour autre chose que prévu.</p>\n<p><strong>Exemple :</strong><br>\nCollecter un email pour une commande ≠ l’utiliser pour du marketing sans consentement.</p>\n<hr>\n<h2 id="h-3-minimisation-des-données" class="toc-header"><a class="toc-anchor" href="#h-3-minimisation-des-données">¶</a> 🔹 3. Minimisation des données</h2>\n<p><strong>Justification :</strong><br>\nMoins on collecte, moins on risque.</p>\n<p><strong>Exemple :</strong><br>\nNe pas demander la date de naissance si l’âge suffit.</p>\n<hr>\n<h2 id="h-4-exactitude" class="toc-header"><a class="toc-anchor" href="#h-4-exactitude">¶</a> 🔹 4. Exactitude</h2>\n<p><strong>Justification :</strong><br>\nDes données incorrectes peuvent causer des erreurs graves.</p>\n<p><strong>Exemple :</strong><br>\nAdresse erronée → livraison ratée.</p>\n<hr>\n<h2 id="h-5-limitation-de-conservation" class="toc-header"><a class="toc-anchor" href="#h-5-limitation-de-conservation">¶</a> 🔹 5. Limitation de conservation</h2>\n<p><strong>Justification :</strong><br>\nGarder des données trop longtemps augmente les risques.</p>\n<p><strong>Exemple :</strong><br>\nSupprimer les comptes inactifs après 3 ans.</p>\n<hr>\n<h2 id="h-6-intégrité-et-confidentialité" class="toc-header"><a class="toc-anchor" href="#h-6-intégrité-et-confidentialité">¶</a> 🔹 6. Intégrité et confidentialité</h2>\n<p><strong>Justification :</strong><br>\nProtéger les données contre les accès non autorisés.</p>\n<p><strong>Exemples :</strong></p>\n<ul>\n<li>chiffrement,</li>\n<li>MFA,</li>\n<li>sauvegardes.</li>\n</ul>\n<hr>\n<h2 id="h-7-responsabilité-accountability" class="toc-header"><a class="toc-anchor" href="#h-7-responsabilité-accountability">¶</a> 🔹 7. Responsabilité (Accountability)</h2>\n<p><strong>Justification :</strong><br>\nL’entreprise doit prouver sa conformité.</p>\n<p><strong>Exemples :</strong></p>\n<ul>\n<li>registre des traitements,</li>\n<li>politiques internes,</li>\n<li>preuves de formation.</li>\n</ul>\n<hr>\n<h1 id="droits-des-personnes" class="toc-header"><a class="toc-anchor" href="#droits-des-personnes">¶</a> 🧱 Droits des personnes</h1>\n<h2 id="droit-daccès" class="toc-header"><a class="toc-anchor" href="#droit-daccès">¶</a> 🔹 Droit d’accès</h2>\n<p>Voir quelles données sont collectées.</p>\n<h2 id="droit-de-rectification" class="toc-header"><a class="toc-anchor" href="#droit-de-rectification">¶</a> 🔹 Droit de rectification</h2>\n<p>Corriger les erreurs.</p>\n<h2 id="droit-à-leffacement-droit-à-loubli" class="toc-header"><a class="toc-anchor" href="#droit-à-leffacement-droit-à-loubli">¶</a> 🔹 Droit à l’effacement (“droit à l’oubli”)</h2>\n<p>Supprimer les données si plus nécessaires.</p>\n<h2 id="droit-à-la-portabilité" class="toc-header"><a class="toc-anchor" href="#droit-à-la-portabilité">¶</a> 🔹 Droit à la portabilité</h2>\n<p>Récupérer ses données dans un format lisible.</p>\n<h2 id="droit-dopposition" class="toc-header"><a class="toc-anchor" href="#droit-dopposition">¶</a> 🔹 Droit d’opposition</h2>\n<p>Refuser certains traitements (ex : marketing).</p>\n<h2 id="droit-à-la-limitation" class="toc-header"><a class="toc-anchor" href="#droit-à-la-limitation">¶</a> 🔹 Droit à la limitation</h2>\n<p>Geler temporairement un traitement.</p>\n<h2 id="droit-dêtre-informé" class="toc-header"><a class="toc-anchor" href="#droit-dêtre-informé">¶</a> 🔹 Droit d’être informé</h2>\n<p>Transparence obligatoire.</p>\n<hr>\n<h1 id="obligations-des-entreprises" class="toc-header"><a class="toc-anchor" href="#obligations-des-entreprises">¶</a> 🧱 Obligations des entreprises</h1>\n<h2 id="h-1-registre-des-traitements" class="toc-header"><a class="toc-anchor" href="#h-1-registre-des-traitements">¶</a> 🔹 1. Registre des traitements</h2>\n<p>Document obligatoire listant :</p>\n<ul>\n<li>finalités,</li>\n<li>données collectées,</li>\n<li>durées de conservation,</li>\n<li>destinataires.</li>\n</ul>\n<h2 id="h-2-dpo-délégué-à-la-protection-des-données" class="toc-header"><a class="toc-anchor" href="#h-2-dpo-délégué-à-la-protection-des-données">¶</a> 🔹 2. DPO (Délégué à la Protection des Données)</h2>\n<p>Obligatoire pour :</p>\n<ul>\n<li>organismes publics,</li>\n<li>traitements sensibles,</li>\n<li>surveillance à grande échelle.</li>\n</ul>\n<h2 id="h-3-analyse-dimpact-aipd" class="toc-header"><a class="toc-anchor" href="#h-3-analyse-dimpact-aipd">¶</a> 🔹 3. Analyse d’impact (AIPD)</h2>\n<p>Obligatoire si :</p>\n<ul>\n<li>données sensibles,</li>\n<li>surveillance,</li>\n<li>risque élevé.</li>\n</ul>\n<h2 id="h-4-notification-des-violations" class="toc-header"><a class="toc-anchor" href="#h-4-notification-des-violations">¶</a> 🔹 4. Notification des violations</h2>\n<p>Délais :</p>\n<ul>\n<li>72h à la CNIL,</li>\n<li>sans délai aux personnes si risque élevé.</li>\n</ul>\n<h2 id="h-5-contrats-soustraitants" class="toc-header"><a class="toc-anchor" href="#h-5-contrats-soustraitants">¶</a> 🔹 5. Contrats sous‑traitants</h2>\n<p>Clauses obligatoires :</p>\n<ul>\n<li>sécurité,</li>\n<li>confidentialité,</li>\n<li>assistance.</li>\n</ul>\n<hr>\n<h1 id="sanctions-rgpd" class="toc-header"><a class="toc-anchor" href="#sanctions-rgpd">¶</a> 🧱 Sanctions RGPD</h1>\n<ul>\n<li>jusqu’à <strong>20 millions d’euros</strong>,</li>\n<li>ou <strong>4 % du chiffre d’affaires mondial</strong>.</li>\n</ul>\n<h2 id="justification" class="toc-header"><a class="toc-anchor" href="#justification">¶</a> ✔ Justification</h2>\n<p>Créer un effet dissuasif réel.</p>\n<hr>\n<h1 id="cas-pratiques-miniétudes" class="toc-header"><a class="toc-anchor" href="#cas-pratiques-miniétudes">¶</a> 🧱 Cas pratiques (mini‑études)</h1>\n<h2 id="cas-1-fuite-de-données-clients" class="toc-header"><a class="toc-anchor" href="#cas-1-fuite-de-données-clients">¶</a> 🧪 Cas 1 : fuite de données clients</h2>\n<ul>\n<li>notification obligatoire,</li>\n<li>analyse d’impact,</li>\n<li>mesures correctives.</li>\n</ul>\n<h2 id="cas-2-collecte-excessive" class="toc-header"><a class="toc-anchor" href="#cas-2-collecte-excessive">¶</a> 🧪 Cas 2 : collecte excessive</h2>\n<p>Une application demande l’accès aux contacts → non conforme.</p>\n<h2 id="cas-3-absence-de-consentement" class="toc-header"><a class="toc-anchor" href="#cas-3-absence-de-consentement">¶</a> 🧪 Cas 3 : absence de consentement</h2>\n<p>Newsletter envoyée sans opt‑in → violation RGPD.</p>\n<hr>\n<h1 id="synthèse-générale" class="toc-header"><a class="toc-anchor" href="#synthèse-générale">¶</a> 🧠 Synthèse générale</h1>\n<p>Le RGPD impose :</p>\n<ul>\n<li>transparence,</li>\n<li>sécurité,</li>\n<li>minimisation,</li>\n<li>responsabilité.</li>\n</ul>\n<p>Il protège les citoyens et responsabilise les entreprises.</p>\n<hr>\n<h1 id="tp-final-complet" class="toc-header"><a class="toc-anchor" href="#tp-final-complet">¶</a> 🧪 TP final complet</h1>\n<ol>\n<li>Choisir un service (ex : site e‑commerce).</li>\n<li>Identifier les données collectées.</li>\n<li>Déterminer les finalités.</li>\n<li>Construire un registre RGPD.</li>\n<li>Identifier les risques.</li>\n<li>Proposer des mesures de conformité.</li>\n<li>Rédiger une politique de confidentialité.</li>\n</ol>\n	[{"title":"RGPD — Règlement Général sur la Protection des Données.","anchor":"#rgpd-règlement-général-sur-la-protection-des-données","children":[{"title":"🎯 Objectifs pédagogiques","anchor":"#objectifs-pédagogiques","children":[]}]},{"title":"🧩 Introduction générale","anchor":"#introduction-générale","children":[]},{"title":"🧱 Pourquoi le RGPD existe ?","anchor":"#pourquoi-le-rgpd-existe","children":[{"title":"✔ Justification 1 : explosion des données personnelles","anchor":"#justification-1-explosion-des-données-personnelles","children":[]},{"title":"✔ Justification 2 : multiplication des abus","anchor":"#justification-2-multiplication-des-abus","children":[]},{"title":"✔ Justification 3 : harmonisation européenne","anchor":"#justification-3-harmonisation-européenne","children":[]},{"title":"✔ Justification 4 : protéger les droits fondamentaux","anchor":"#justification-4-protéger-les-droits-fondamentaux","children":[]}]},{"title":"🧱 Définitions essentielles","anchor":"#définitions-essentielles","children":[{"title":"🔹 Donnée personnelle","anchor":"#donnée-personnelle","children":[]},{"title":"🔹 Traitement","anchor":"#traitement","children":[]},{"title":"🔹 Responsable de traitement","anchor":"#responsable-de-traitement","children":[]},{"title":"🔹 Sous‑traitant","anchor":"#soustraitant","children":[]}]},{"title":"🧱 Les 7 principes fondamentaux du RGPD","anchor":"#les-7-principes-fondamentaux-du-rgpd","children":[{"title":"🔹 1. Licéité, loyauté, transparence","anchor":"#h-1-licéité-loyauté-transparence","children":[]},{"title":"🔹 2. Limitation des finalités","anchor":"#h-2-limitation-des-finalités","children":[]},{"title":"🔹 3. Minimisation des données","anchor":"#h-3-minimisation-des-données","children":[]},{"title":"🔹 4. Exactitude","anchor":"#h-4-exactitude","children":[]},{"title":"🔹 5. Limitation de conservation","anchor":"#h-5-limitation-de-conservation","children":[]},{"title":"🔹 6. Intégrité et confidentialité","anchor":"#h-6-intégrité-et-confidentialité","children":[]},{"title":"🔹 7. Responsabilité (Accountability)","anchor":"#h-7-responsabilité-accountability","children":[]}]},{"title":"🧱 Droits des personnes","anchor":"#droits-des-personnes","children":[{"title":"🔹 Droit d’accès","anchor":"#droit-daccès","children":[]},{"title":"🔹 Droit de rectification","anchor":"#droit-de-rectification","children":[]},{"title":"🔹 Droit à l’effacement (“droit à l’oubli”)","anchor":"#droit-à-leffacement-droit-à-loubli","children":[]},{"title":"🔹 Droit à la portabilité","anchor":"#droit-à-la-portabilité","children":[]},{"title":"🔹 Droit d’opposition","anchor":"#droit-dopposition","children":[]},{"title":"🔹 Droit à la limitation","anchor":"#droit-à-la-limitation","children":[]},{"title":"🔹 Droit d’être informé","anchor":"#droit-dêtre-informé","children":[]}]},{"title":"🧱 Obligations des entreprises","anchor":"#obligations-des-entreprises","children":[{"title":"🔹 1. Registre des traitements","anchor":"#h-1-registre-des-traitements","children":[]},{"title":"🔹 2. DPO (Délégué à la Protection des Données)","anchor":"#h-2-dpo-délégué-à-la-protection-des-données","children":[]},{"title":"🔹 3. Analyse d’impact (AIPD)","anchor":"#h-3-analyse-dimpact-aipd","children":[]},{"title":"🔹 4. Notification des violations","anchor":"#h-4-notification-des-violations","children":[]},{"title":"🔹 5. Contrats sous‑traitants","anchor":"#h-5-contrats-soustraitants","children":[]}]},{"title":"🧱 Sanctions RGPD","anchor":"#sanctions-rgpd","children":[{"title":"✔ Justification","anchor":"#justification","children":[]}]},{"title":"🧱 Cas pratiques (mini‑études)","anchor":"#cas-pratiques-miniétudes","children":[{"title":"🧪 Cas 1 : fuite de données clients","anchor":"#cas-1-fuite-de-données-clients","children":[]},{"title":"🧪 Cas 2 : collecte excessive","anchor":"#cas-2-collecte-excessive","children":[]},{"title":"🧪 Cas 3 : absence de consentement","anchor":"#cas-3-absence-de-consentement","children":[]}]},{"title":"🧠 Synthèse générale","anchor":"#synthèse-générale","children":[]},{"title":"🧪 TP final complet","anchor":"#tp-final-complet","children":[]}]	markdown	2026-03-08T15:29:49.531Z	2026-03-08T18:16:39.502Z	markdown	en	1	1	{"js":"","css":""}
29	home/GIS	e3dd373234765557ed128ab26ca4480cd35906f9	Gestion des incidents de sécurité		f	t	\N			# Gestion des incidents de sécurité\n\n## 🎯 Objectifs pédagogiques\n- Comprendre le cycle complet de gestion des incidents.\n- Savoir détecter, analyser, contenir et résoudre un incident.\n- Comprendre les rôles, responsabilités et processus.\n- Apprendre à justifier chaque étape auprès d’étudiants ou d’auditeurs.\n- Préparer les étudiants à un TP de simulation d’incident.\n\n---\n\n# 🧩 Introduction générale\n\nUn **incident de sécurité** est un événement qui :\n- compromet la confidentialité, l’intégrité ou la disponibilité,\n- perturbe un service,\n- ou expose l’organisation à un risque.\n\nExemples :\n- ransomware,\n- phishing réussi,\n- fuite de données,\n- compromission de compte,\n- attaque DDoS.\n\nLa gestion des incidents est un **processus vital** pour limiter les dégâts.\n\n---\n\n# 🧱 Pourquoi gérer les incidents ?\n\n## ✔ Justification 1 : les attaques sont inévitables\nMême avec de bonnes mesures, un incident peut survenir.\n\n## ✔ Justification 2 : limiter l’impact\nUne réaction rapide peut sauver des millions.\n\n## ✔ Justification 3 : obligations légales\n- RGPD (notification 72h),\n- NIS2 (notification 24h),\n- contrats clients.\n\n## ✔ Justification 4 : améliorer la sécurité\nChaque incident est une opportunité d’apprentissage.\n\n---\n\n# 🧱 Cycle complet de gestion des incidents\n\n1. **Détection**\n2. **Analyse**\n3. **Confinement**\n4. **Éradication**\n5. **Rétablissement**\n6. **Retour d’expérience (RETEX)**\n\nChaque étape est détaillée ci‑dessous.\n\n---\n\n# 🏗️ 1. Détection\n\n## 🎯 Objectif\nIdentifier rapidement un incident.\n\n## 📌 Sources de détection\n- SIEM,\n- antivirus,\n- IDS/IPS,\n- logs,\n- utilisateurs,\n- prestataires.\n\n## ✔ Justification\nPlus un incident est détecté tôt, moins il coûte cher.\n\n## ❌ Erreurs fréquentes\n- logs insuffisants,\n- absence de supervision,\n- alertes ignorées.\n\n---\n\n# 🏗️ 2. Analyse\n\n## 🎯 Objectif\nComprendre ce qui se passe.\n\n## 📌 Questions clés\n- Quelle est la cause ?\n- Quel est l’impact ?\n- Quels systèmes sont touchés ?\n- L’attaque est-elle toujours en cours ?\n\n## ✔ Justification\nUne mauvaise analyse = mauvaise décision.\n\n---\n\n# 🏗️ 3. Confinement\n\n## 🎯 Objectif\nLimiter la propagation.\n\n## 📌 Exemples\n- isoler un poste infecté,\n- couper un accès VPN,\n- désactiver un compte compromis.\n\n## ✔ Justification\nEmpêcher l’attaquant d’aller plus loin.\n\n---\n\n# 🏗️ 4. Éradication\n\n## 🎯 Objectif\nSupprimer la cause de l’incident.\n\n## 📌 Exemples\n- supprimer un malware,\n- corriger une vulnérabilité,\n- réinitialiser des mots de passe.\n\n---\n\n# 🏗️ 5. Rétablissement\n\n## 🎯 Objectif\nRevenir à un état normal.\n\n## 📌 Exemples\n- restauration de sauvegardes,\n- redémarrage des services,\n- vérification de l’intégrité.\n\n---\n\n# 🏗️ 6. Retour d’expérience (RETEX)\n\n## 🎯 Objectif\nApprendre de l’incident.\n\n## 📌 Exemples\n- mise à jour des procédures,\n- renforcement des mesures,\n- formation des équipes.\n\n## ✔ Justification\nUn incident non analysé se reproduira.\n\n---\n\n# 🧱 Cas pratiques\n\n## 🧪 Cas 1 : ransomware\n- détection : fichiers chiffrés  \n- confinement : isoler le réseau  \n- éradication : supprimer le malware  \n- rétablissement : restaurer les sauvegardes  \n\n## 🧪 Cas 2 : phishing réussi\n- confinement : désactiver le compte  \n- éradication : changer les mots de passe  \n- RETEX : formation anti‑phishing  \n\n---\n\n# 🧪 TP final complet\n\n1. Simuler un incident (phishing, ransomware).  \n2. Décrire les étapes de gestion.  \n3. Proposer un plan de confinement.  \n4. Rédiger un rapport d’incident.  \n5. Proposer des mesures correctives.  \n	<h1 id="gestion-des-incidents-de-sécurité" class="toc-header"><a class="toc-anchor" href="#gestion-des-incidents-de-sécurité">¶</a> Gestion des incidents de sécurité</h1>\n<h2 id="objectifs-pédagogiques" class="toc-header"><a class="toc-anchor" href="#objectifs-pédagogiques">¶</a> 🎯 Objectifs pédagogiques</h2>\n<ul>\n<li>Comprendre le cycle complet de gestion des incidents.</li>\n<li>Savoir détecter, analyser, contenir et résoudre un incident.</li>\n<li>Comprendre les rôles, responsabilités et processus.</li>\n<li>Apprendre à justifier chaque étape auprès d’étudiants ou d’auditeurs.</li>\n<li>Préparer les étudiants à un TP de simulation d’incident.</li>\n</ul>\n<hr>\n<h1 id="introduction-générale" class="toc-header"><a class="toc-anchor" href="#introduction-générale">¶</a> 🧩 Introduction générale</h1>\n<p>Un <strong>incident de sécurité</strong> est un événement qui :</p>\n<ul>\n<li>compromet la confidentialité, l’intégrité ou la disponibilité,</li>\n<li>perturbe un service,</li>\n<li>ou expose l’organisation à un risque.</li>\n</ul>\n<p>Exemples :</p>\n<ul>\n<li>ransomware,</li>\n<li>phishing réussi,</li>\n<li>fuite de données,</li>\n<li>compromission de compte,</li>\n<li>attaque DDoS.</li>\n</ul>\n<p>La gestion des incidents est un <strong>processus vital</strong> pour limiter les dégâts.</p>\n<hr>\n<h1 id="pourquoi-gérer-les-incidents" class="toc-header"><a class="toc-anchor" href="#pourquoi-gérer-les-incidents">¶</a> 🧱 Pourquoi gérer les incidents ?</h1>\n<h2 id="justification-1-les-attaques-sont-inévitables" class="toc-header"><a class="toc-anchor" href="#justification-1-les-attaques-sont-inévitables">¶</a> ✔ Justification 1 : les attaques sont inévitables</h2>\n<p>Même avec de bonnes mesures, un incident peut survenir.</p>\n<h2 id="justification-2-limiter-limpact" class="toc-header"><a class="toc-anchor" href="#justification-2-limiter-limpact">¶</a> ✔ Justification 2 : limiter l’impact</h2>\n<p>Une réaction rapide peut sauver des millions.</p>\n<h2 id="justification-3-obligations-légales" class="toc-header"><a class="toc-anchor" href="#justification-3-obligations-légales">¶</a> ✔ Justification 3 : obligations légales</h2>\n<ul>\n<li>RGPD (notification 72h),</li>\n<li>NIS2 (notification 24h),</li>\n<li>contrats clients.</li>\n</ul>\n<h2 id="justification-4-améliorer-la-sécurité" class="toc-header"><a class="toc-anchor" href="#justification-4-améliorer-la-sécurité">¶</a> ✔ Justification 4 : améliorer la sécurité</h2>\n<p>Chaque incident est une opportunité d’apprentissage.</p>\n<hr>\n<h1 id="cycle-complet-de-gestion-des-incidents" class="toc-header"><a class="toc-anchor" href="#cycle-complet-de-gestion-des-incidents">¶</a> 🧱 Cycle complet de gestion des incidents</h1>\n<ol>\n<li><strong>Détection</strong></li>\n<li><strong>Analyse</strong></li>\n<li><strong>Confinement</strong></li>\n<li><strong>Éradication</strong></li>\n<li><strong>Rétablissement</strong></li>\n<li><strong>Retour d’expérience (RETEX)</strong></li>\n</ol>\n<p>Chaque étape est détaillée ci‑dessous.</p>\n<hr>\n<h1 id="️-1-détection" class="toc-header"><a class="toc-anchor" href="#️-1-détection">¶</a> 🏗️ 1. Détection</h1>\n<h2 id="objectif" class="toc-header"><a class="toc-anchor" href="#objectif">¶</a> 🎯 Objectif</h2>\n<p>Identifier rapidement un incident.</p>\n<h2 id="sources-de-détection" class="toc-header"><a class="toc-anchor" href="#sources-de-détection">¶</a> 📌 Sources de détection</h2>\n<ul>\n<li>SIEM,</li>\n<li>antivirus,</li>\n<li>IDS/IPS,</li>\n<li>logs,</li>\n<li>utilisateurs,</li>\n<li>prestataires.</li>\n</ul>\n<h2 id="justification" class="toc-header"><a class="toc-anchor" href="#justification">¶</a> ✔ Justification</h2>\n<p>Plus un incident est détecté tôt, moins il coûte cher.</p>\n<h2 id="erreurs-fréquentes" class="toc-header"><a class="toc-anchor" href="#erreurs-fréquentes">¶</a> ❌ Erreurs fréquentes</h2>\n<ul>\n<li>logs insuffisants,</li>\n<li>absence de supervision,</li>\n<li>alertes ignorées.</li>\n</ul>\n<hr>\n<h1 id="️-2-analyse" class="toc-header"><a class="toc-anchor" href="#️-2-analyse">¶</a> 🏗️ 2. Analyse</h1>\n<h2 id="objectif-1" class="toc-header"><a class="toc-anchor" href="#objectif-1">¶</a> 🎯 Objectif</h2>\n<p>Comprendre ce qui se passe.</p>\n<h2 id="questions-clés" class="toc-header"><a class="toc-anchor" href="#questions-clés">¶</a> 📌 Questions clés</h2>\n<ul>\n<li>Quelle est la cause ?</li>\n<li>Quel est l’impact ?</li>\n<li>Quels systèmes sont touchés ?</li>\n<li>L’attaque est-elle toujours en cours ?</li>\n</ul>\n<h2 id="justification-1" class="toc-header"><a class="toc-anchor" href="#justification-1">¶</a> ✔ Justification</h2>\n<p>Une mauvaise analyse = mauvaise décision.</p>\n<hr>\n<h1 id="️-3-confinement" class="toc-header"><a class="toc-anchor" href="#️-3-confinement">¶</a> 🏗️ 3. Confinement</h1>\n<h2 id="objectif-2" class="toc-header"><a class="toc-anchor" href="#objectif-2">¶</a> 🎯 Objectif</h2>\n<p>Limiter la propagation.</p>\n<h2 id="exemples" class="toc-header"><a class="toc-anchor" href="#exemples">¶</a> 📌 Exemples</h2>\n<ul>\n<li>isoler un poste infecté,</li>\n<li>couper un accès VPN,</li>\n<li>désactiver un compte compromis.</li>\n</ul>\n<h2 id="justification-2" class="toc-header"><a class="toc-anchor" href="#justification-2">¶</a> ✔ Justification</h2>\n<p>Empêcher l’attaquant d’aller plus loin.</p>\n<hr>\n<h1 id="️-4-éradication" class="toc-header"><a class="toc-anchor" href="#️-4-éradication">¶</a> 🏗️ 4. Éradication</h1>\n<h2 id="objectif-3" class="toc-header"><a class="toc-anchor" href="#objectif-3">¶</a> 🎯 Objectif</h2>\n<p>Supprimer la cause de l’incident.</p>\n<h2 id="exemples-1" class="toc-header"><a class="toc-anchor" href="#exemples-1">¶</a> 📌 Exemples</h2>\n<ul>\n<li>supprimer un malware,</li>\n<li>corriger une vulnérabilité,</li>\n<li>réinitialiser des mots de passe.</li>\n</ul>\n<hr>\n<h1 id="️-5-rétablissement" class="toc-header"><a class="toc-anchor" href="#️-5-rétablissement">¶</a> 🏗️ 5. Rétablissement</h1>\n<h2 id="objectif-4" class="toc-header"><a class="toc-anchor" href="#objectif-4">¶</a> 🎯 Objectif</h2>\n<p>Revenir à un état normal.</p>\n<h2 id="exemples-2" class="toc-header"><a class="toc-anchor" href="#exemples-2">¶</a> 📌 Exemples</h2>\n<ul>\n<li>restauration de sauvegardes,</li>\n<li>redémarrage des services,</li>\n<li>vérification de l’intégrité.</li>\n</ul>\n<hr>\n<h1 id="️-6-retour-dexpérience-retex" class="toc-header"><a class="toc-anchor" href="#️-6-retour-dexpérience-retex">¶</a> 🏗️ 6. Retour d’expérience (RETEX)</h1>\n<h2 id="objectif-5" class="toc-header"><a class="toc-anchor" href="#objectif-5">¶</a> 🎯 Objectif</h2>\n<p>Apprendre de l’incident.</p>\n<h2 id="exemples-3" class="toc-header"><a class="toc-anchor" href="#exemples-3">¶</a> 📌 Exemples</h2>\n<ul>\n<li>mise à jour des procédures,</li>\n<li>renforcement des mesures,</li>\n<li>formation des équipes.</li>\n</ul>\n<h2 id="justification-3" class="toc-header"><a class="toc-anchor" href="#justification-3">¶</a> ✔ Justification</h2>\n<p>Un incident non analysé se reproduira.</p>\n<hr>\n<h1 id="cas-pratiques" class="toc-header"><a class="toc-anchor" href="#cas-pratiques">¶</a> 🧱 Cas pratiques</h1>\n<h2 id="cas-1-ransomware" class="toc-header"><a class="toc-anchor" href="#cas-1-ransomware">¶</a> 🧪 Cas 1 : ransomware</h2>\n<ul>\n<li>détection : fichiers chiffrés</li>\n<li>confinement : isoler le réseau</li>\n<li>éradication : supprimer le malware</li>\n<li>rétablissement : restaurer les sauvegardes</li>\n</ul>\n<h2 id="cas-2-phishing-réussi" class="toc-header"><a class="toc-anchor" href="#cas-2-phishing-réussi">¶</a> 🧪 Cas 2 : phishing réussi</h2>\n<ul>\n<li>confinement : désactiver le compte</li>\n<li>éradication : changer les mots de passe</li>\n<li>RETEX : formation anti‑phishing</li>\n</ul>\n<hr>\n<h1 id="tp-final-complet" class="toc-header"><a class="toc-anchor" href="#tp-final-complet">¶</a> 🧪 TP final complet</h1>\n<ol>\n<li>Simuler un incident (phishing, ransomware).</li>\n<li>Décrire les étapes de gestion.</li>\n<li>Proposer un plan de confinement.</li>\n<li>Rédiger un rapport d’incident.</li>\n<li>Proposer des mesures correctives.</li>\n</ol>\n	[{"title":"Gestion des incidents de sécurité","anchor":"#gestion-des-incidents-de-sécurité","children":[{"title":"🎯 Objectifs pédagogiques","anchor":"#objectifs-pédagogiques","children":[]}]},{"title":"🧩 Introduction générale","anchor":"#introduction-générale","children":[]},{"title":"🧱 Pourquoi gérer les incidents ?","anchor":"#pourquoi-gérer-les-incidents","children":[{"title":"✔ Justification 1 : les attaques sont inévitables","anchor":"#justification-1-les-attaques-sont-inévitables","children":[]},{"title":"✔ Justification 2 : limiter l’impact","anchor":"#justification-2-limiter-limpact","children":[]},{"title":"✔ Justification 3 : obligations légales","anchor":"#justification-3-obligations-légales","children":[]},{"title":"✔ Justification 4 : améliorer la sécurité","anchor":"#justification-4-améliorer-la-sécurité","children":[]}]},{"title":"🧱 Cycle complet de gestion des incidents","anchor":"#cycle-complet-de-gestion-des-incidents","children":[]},{"title":"🏗️ 1. Détection","anchor":"#️-1-détection","children":[{"title":"🎯 Objectif","anchor":"#objectif","children":[]},{"title":"📌 Sources de détection","anchor":"#sources-de-détection","children":[]},{"title":"✔ Justification","anchor":"#justification","children":[]},{"title":"❌ Erreurs fréquentes","anchor":"#erreurs-fréquentes","children":[]}]},{"title":"🏗️ 2. Analyse","anchor":"#️-2-analyse","children":[{"title":"🎯 Objectif","anchor":"#objectif-1","children":[]},{"title":"📌 Questions clés","anchor":"#questions-clés","children":[]},{"title":"✔ Justification","anchor":"#justification-1","children":[]}]},{"title":"🏗️ 3. Confinement","anchor":"#️-3-confinement","children":[{"title":"🎯 Objectif","anchor":"#objectif-2","children":[]},{"title":"📌 Exemples","anchor":"#exemples","children":[]},{"title":"✔ Justification","anchor":"#justification-2","children":[]}]},{"title":"🏗️ 4. Éradication","anchor":"#️-4-éradication","children":[{"title":"🎯 Objectif","anchor":"#objectif-3","children":[]},{"title":"📌 Exemples","anchor":"#exemples-1","children":[]}]},{"title":"🏗️ 5. Rétablissement","anchor":"#️-5-rétablissement","children":[{"title":"🎯 Objectif","anchor":"#objectif-4","children":[]},{"title":"📌 Exemples","anchor":"#exemples-2","children":[]}]},{"title":"🏗️ 6. Retour d’expérience (RETEX)","anchor":"#️-6-retour-dexpérience-retex","children":[{"title":"🎯 Objectif","anchor":"#objectif-5","children":[]},{"title":"📌 Exemples","anchor":"#exemples-3","children":[]},{"title":"✔ Justification","anchor":"#justification-3","children":[]}]},{"title":"🧱 Cas pratiques","anchor":"#cas-pratiques","children":[{"title":"🧪 Cas 1 : ransomware","anchor":"#cas-1-ransomware","children":[]},{"title":"🧪 Cas 2 : phishing réussi","anchor":"#cas-2-phishing-réussi","children":[]}]},{"title":"🧪 TP final complet","anchor":"#tp-final-complet","children":[]}]	markdown	2026-03-08T18:14:49.449Z	2026-03-08T18:14:50.822Z	markdown	en	1	1	{"js":"","css":""}
28	home/PSSI	b7f51409dfd753a4af9c0afc78e2c4da6475933d	PSSI — Politique de Sécurité des Systèmes d’Information		f	t	\N			# PSSI — Politique de Sécurité des Systèmes d’Information\n\n## 🎯 Objectifs pédagogiques\n- Comprendre le rôle stratégique d’une PSSI dans une organisation.\n- Savoir rédiger une PSSI claire, efficace et adaptée.\n- Comprendre les responsabilités, les règles et les exigences de sécurité.\n- Apprendre à justifier chaque section auprès d’étudiants ou d’auditeurs.\n- Préparer les étudiants à un TP de rédaction ou d’audit de PSSI.\n\n---\n\n# 🧩 Introduction générale\n\nLa **PSSI** (Politique de Sécurité des Systèmes d’Information) est un document stratégique qui définit :\n- les objectifs de sécurité,\n- les règles à respecter,\n- les responsabilités,\n- les exigences techniques et organisationnelles.\n\nElle constitue la **colonne vertébrale** de la sécurité dans une organisation.\n\n---\n\n# 🧱 Pourquoi une PSSI est indispensable ?\n\n## ✔ Justification 1 : aligner toute l’organisation\nSans règles claires → chacun fait “à sa manière”.\n\n## ✔ Justification 2 : répondre aux obligations légales\n- ISO 27001 (clause 5)\n- NIS2\n- RGPD\n- Contrats clients\n\n## ✔ Justification 3 : réduire les risques humains\n80 % des incidents viennent d’erreurs humaines.\n\n## ✔ Justification 4 : protéger l’image et la réputation\nUne fuite de données peut ruiner la confiance.\n\n## ✔ Justification 5 : base de tous les audits\nUne PSSI est systématiquement demandée.\n\n---\n\n# 🧱 Structure d’une PSSI complète\n\nUne PSSI efficace contient généralement :\n\n1. **Objectifs et portée**\n2. **Rôles et responsabilités**\n3. **Gestion des accès**\n4. **Sécurité des postes de travail**\n5. **Sécurité réseau**\n6. **Gestion des incidents**\n7. **Sauvegardes**\n8. **Continuité d’activité**\n9. **Sensibilisation**\n10. **Conformité et sanctions**\n\nChaque section est détaillée ci‑dessous.\n\n---\n\n# 🏗️ 1. Objectifs et portée\n\n## 🎯 Objectif\nDéfinir ce que couvre la PSSI.\n\n## 📌 Contenu\n- objectifs de sécurité,\n- périmètre (SI, utilisateurs, équipements),\n- principes généraux.\n\n## ✔ Justification\nUne PSSI sans périmètre → document inutile.\n\n## 🧪 Exemple\n« La PSSI s’applique à tous les employés, prestataires et équipements connectés au réseau interne. »\n\n---\n\n# 🏗️ 2. Rôles et responsabilités\n\n## 🎯 Objectif\nClarifier qui fait quoi.\n\n## 📌 Acteurs typiques\n- Direction\n- RSSI\n- DSI\n- Administrateurs\n- Utilisateurs\n- Prestataires\n\n## ✔ Justification\nSans responsabilités → aucune règle n’est appliquée.\n\n## 🧪 Exemple\nLe RSSI valide les règles de sécurité.  \nLa DSI les met en œuvre.  \nLes utilisateurs doivent les respecter.\n\n---\n\n# 🏗️ 3. Gestion des accès\n\n## 🎯 Objectif\nContrôler qui accède à quoi.\n\n## 📌 Exigences\n- comptes individuels,\n- MFA obligatoire,\n- gestion des droits selon le besoin d’en connaître,\n- révocation immédiate lors des départs.\n\n## ✔ Justification\nUn accès mal géré = compromission totale.\n\n## ❌ Erreurs fréquentes\n- comptes partagés,\n- droits trop élevés,\n- comptes non supprimés.\n\n---\n\n# 🏗️ 4. Sécurité des postes de travail\n\n## 🎯 Objectif\nProtéger les équipements utilisateurs.\n\n## 📌 Exigences\n- antivirus,\n- chiffrement disque,\n- mises à jour automatiques,\n- verrouillage automatique.\n\n## ✔ Justification\nLe poste utilisateur est la première cible des attaquants.\n\n---\n\n# 🏗️ 5. Sécurité réseau\n\n## 🎯 Objectif\nProtéger les communications et l’infrastructure.\n\n## 📌 Exigences\n- segmentation réseau,\n- pare-feu,\n- VPN sécurisé,\n- interdiction des Wi-Fi non sécurisés.\n\n## ✔ Justification\nUn réseau plat = propagation rapide d’un ransomware.\n\n---\n\n# 🏗️ 6. Gestion des incidents\n\n## 🎯 Objectif\nSavoir réagir rapidement.\n\n## 📌 Exigences\n- procédure d’alerte,\n- cellule de crise,\n- journalisation,\n- rapport post‑incident.\n\n## ✔ Justification\nUne mauvaise réaction peut aggraver l’incident.\n\n---\n\n# 🏗️ 7. Sauvegardes\n\n## 🎯 Objectif\nAssurer la récupération des données.\n\n## 📌 Exigences\n- sauvegardes régulières,\n- tests de restauration,\n- sauvegardes hors ligne.\n\n## ✔ Justification\nDernière ligne de défense contre les ransomwares.\n\n---\n\n# 🏗️ 8. Continuité d’activité\n\n## 🎯 Objectif\nAssurer la disponibilité des services essentiels.\n\n## 📌 Exigences\n- PCA,\n- PRA,\n- redondance,\n- tests réguliers.\n\n## ✔ Justification\nUne panne peut coûter des millions.\n\n---\n\n# 🏗️ 9. Sensibilisation\n\n## 🎯 Objectif\nFormer les utilisateurs.\n\n## 📌 Exigences\n- formation annuelle,\n- campagnes anti‑phishing,\n- rappels réguliers.\n\n## ✔ Justification\nL’humain est le maillon le plus faible.\n\n---\n\n# 🏗️ 10. Conformité et sanctions\n\n## 🎯 Objectif\nGarantir le respect de la PSSI.\n\n## 📌 Exigences\n- audits internes,\n- sanctions disciplinaires,\n- suivi des non‑conformités.\n\n## ✔ Justification\nUne règle sans sanction = règle inutile.\n\n---\n\n# 🧱 Cas pratiques (mini‑études)\n\n## 🧪 Cas 1 : Employé qui partage son mot de passe\n→ violation de la PSSI  \n→ risque de compromission  \n→ sanction + formation\n\n## 🧪 Cas 2 : Prestataire avec accès non contrôlé\n→ violation de la PSSI  \n→ risque supply chain  \n→ mise à jour des contrats\n\n## 🧪 Cas 3 : Absence de sauvegardes testées\n→ violation de la PSSI  \n→ risque ransomware  \n→ plan d’action immédiat\n\n---\n\n# 🧠 Synthèse générale\n\nUne PSSI permet :\n- d’unifier les règles de sécurité,\n- de responsabiliser les acteurs,\n- de réduire les risques,\n- de structurer la sécurité,\n- de préparer les audits.\n\n---\n\n# 🧪 TP final complet\n\n1. Définir le périmètre d’une PSSI.  \n2. Rédiger les rôles et responsabilités.  \n3. Décrire les règles de gestion des accès.  \n4. Proposer un plan de sensibilisation.  \n5. Définir les règles de sauvegarde.  \n6. Rédiger une section “sanctions”.  \n7. Présenter la PSSI à la direction.  \n	<h1 id="pssi-politique-de-sécurité-des-systèmes-dinformation" class="toc-header"><a class="toc-anchor" href="#pssi-politique-de-sécurité-des-systèmes-dinformation">¶</a> PSSI — Politique de Sécurité des Systèmes d’Information</h1>\n<h2 id="objectifs-pédagogiques" class="toc-header"><a class="toc-anchor" href="#objectifs-pédagogiques">¶</a> 🎯 Objectifs pédagogiques</h2>\n<ul>\n<li>Comprendre le rôle stratégique d’une PSSI dans une organisation.</li>\n<li>Savoir rédiger une PSSI claire, efficace et adaptée.</li>\n<li>Comprendre les responsabilités, les règles et les exigences de sécurité.</li>\n<li>Apprendre à justifier chaque section auprès d’étudiants ou d’auditeurs.</li>\n<li>Préparer les étudiants à un TP de rédaction ou d’audit de PSSI.</li>\n</ul>\n<hr>\n<h1 id="introduction-générale" class="toc-header"><a class="toc-anchor" href="#introduction-générale">¶</a> 🧩 Introduction générale</h1>\n<p>La <strong>PSSI</strong> (Politique de Sécurité des Systèmes d’Information) est un document stratégique qui définit :</p>\n<ul>\n<li>les objectifs de sécurité,</li>\n<li>les règles à respecter,</li>\n<li>les responsabilités,</li>\n<li>les exigences techniques et organisationnelles.</li>\n</ul>\n<p>Elle constitue la <strong>colonne vertébrale</strong> de la sécurité dans une organisation.</p>\n<hr>\n<h1 id="pourquoi-une-pssi-est-indispensable" class="toc-header"><a class="toc-anchor" href="#pourquoi-une-pssi-est-indispensable">¶</a> 🧱 Pourquoi une PSSI est indispensable ?</h1>\n<h2 id="justification-1-aligner-toute-lorganisation" class="toc-header"><a class="toc-anchor" href="#justification-1-aligner-toute-lorganisation">¶</a> ✔ Justification 1 : aligner toute l’organisation</h2>\n<p>Sans règles claires → chacun fait “à sa manière”.</p>\n<h2 id="justification-2-répondre-aux-obligations-légales" class="toc-header"><a class="toc-anchor" href="#justification-2-répondre-aux-obligations-légales">¶</a> ✔ Justification 2 : répondre aux obligations légales</h2>\n<ul>\n<li>ISO 27001 (clause 5)</li>\n<li>NIS2</li>\n<li>RGPD</li>\n<li>Contrats clients</li>\n</ul>\n<h2 id="justification-3-réduire-les-risques-humains" class="toc-header"><a class="toc-anchor" href="#justification-3-réduire-les-risques-humains">¶</a> ✔ Justification 3 : réduire les risques humains</h2>\n<p>80 % des incidents viennent d’erreurs humaines.</p>\n<h2 id="justification-4-protéger-limage-et-la-réputation" class="toc-header"><a class="toc-anchor" href="#justification-4-protéger-limage-et-la-réputation">¶</a> ✔ Justification 4 : protéger l’image et la réputation</h2>\n<p>Une fuite de données peut ruiner la confiance.</p>\n<h2 id="justification-5-base-de-tous-les-audits" class="toc-header"><a class="toc-anchor" href="#justification-5-base-de-tous-les-audits">¶</a> ✔ Justification 5 : base de tous les audits</h2>\n<p>Une PSSI est systématiquement demandée.</p>\n<hr>\n<h1 id="structure-dune-pssi-complète" class="toc-header"><a class="toc-anchor" href="#structure-dune-pssi-complète">¶</a> 🧱 Structure d’une PSSI complète</h1>\n<p>Une PSSI efficace contient généralement :</p>\n<ol>\n<li><strong>Objectifs et portée</strong></li>\n<li><strong>Rôles et responsabilités</strong></li>\n<li><strong>Gestion des accès</strong></li>\n<li><strong>Sécurité des postes de travail</strong></li>\n<li><strong>Sécurité réseau</strong></li>\n<li><strong>Gestion des incidents</strong></li>\n<li><strong>Sauvegardes</strong></li>\n<li><strong>Continuité d’activité</strong></li>\n<li><strong>Sensibilisation</strong></li>\n<li><strong>Conformité et sanctions</strong></li>\n</ol>\n<p>Chaque section est détaillée ci‑dessous.</p>\n<hr>\n<h1 id="️-1-objectifs-et-portée" class="toc-header"><a class="toc-anchor" href="#️-1-objectifs-et-portée">¶</a> 🏗️ 1. Objectifs et portée</h1>\n<h2 id="objectif" class="toc-header"><a class="toc-anchor" href="#objectif">¶</a> 🎯 Objectif</h2>\n<p>Définir ce que couvre la PSSI.</p>\n<h2 id="contenu" class="toc-header"><a class="toc-anchor" href="#contenu">¶</a> 📌 Contenu</h2>\n<ul>\n<li>objectifs de sécurité,</li>\n<li>périmètre (SI, utilisateurs, équipements),</li>\n<li>principes généraux.</li>\n</ul>\n<h2 id="justification" class="toc-header"><a class="toc-anchor" href="#justification">¶</a> ✔ Justification</h2>\n<p>Une PSSI sans périmètre → document inutile.</p>\n<h2 id="exemple" class="toc-header"><a class="toc-anchor" href="#exemple">¶</a> 🧪 Exemple</h2>\n<p>« La PSSI s’applique à tous les employés, prestataires et équipements connectés au réseau interne. »</p>\n<hr>\n<h1 id="️-2-rôles-et-responsabilités" class="toc-header"><a class="toc-anchor" href="#️-2-rôles-et-responsabilités">¶</a> 🏗️ 2. Rôles et responsabilités</h1>\n<h2 id="objectif-1" class="toc-header"><a class="toc-anchor" href="#objectif-1">¶</a> 🎯 Objectif</h2>\n<p>Clarifier qui fait quoi.</p>\n<h2 id="acteurs-typiques" class="toc-header"><a class="toc-anchor" href="#acteurs-typiques">¶</a> 📌 Acteurs typiques</h2>\n<ul>\n<li>Direction</li>\n<li>RSSI</li>\n<li>DSI</li>\n<li>Administrateurs</li>\n<li>Utilisateurs</li>\n<li>Prestataires</li>\n</ul>\n<h2 id="justification-1" class="toc-header"><a class="toc-anchor" href="#justification-1">¶</a> ✔ Justification</h2>\n<p>Sans responsabilités → aucune règle n’est appliquée.</p>\n<h2 id="exemple-1" class="toc-header"><a class="toc-anchor" href="#exemple-1">¶</a> 🧪 Exemple</h2>\n<p>Le RSSI valide les règles de sécurité.<br>\nLa DSI les met en œuvre.<br>\nLes utilisateurs doivent les respecter.</p>\n<hr>\n<h1 id="️-3-gestion-des-accès" class="toc-header"><a class="toc-anchor" href="#️-3-gestion-des-accès">¶</a> 🏗️ 3. Gestion des accès</h1>\n<h2 id="objectif-2" class="toc-header"><a class="toc-anchor" href="#objectif-2">¶</a> 🎯 Objectif</h2>\n<p>Contrôler qui accède à quoi.</p>\n<h2 id="exigences" class="toc-header"><a class="toc-anchor" href="#exigences">¶</a> 📌 Exigences</h2>\n<ul>\n<li>comptes individuels,</li>\n<li>MFA obligatoire,</li>\n<li>gestion des droits selon le besoin d’en connaître,</li>\n<li>révocation immédiate lors des départs.</li>\n</ul>\n<h2 id="justification-2" class="toc-header"><a class="toc-anchor" href="#justification-2">¶</a> ✔ Justification</h2>\n<p>Un accès mal géré = compromission totale.</p>\n<h2 id="erreurs-fréquentes" class="toc-header"><a class="toc-anchor" href="#erreurs-fréquentes">¶</a> ❌ Erreurs fréquentes</h2>\n<ul>\n<li>comptes partagés,</li>\n<li>droits trop élevés,</li>\n<li>comptes non supprimés.</li>\n</ul>\n<hr>\n<h1 id="️-4-sécurité-des-postes-de-travail" class="toc-header"><a class="toc-anchor" href="#️-4-sécurité-des-postes-de-travail">¶</a> 🏗️ 4. Sécurité des postes de travail</h1>\n<h2 id="objectif-3" class="toc-header"><a class="toc-anchor" href="#objectif-3">¶</a> 🎯 Objectif</h2>\n<p>Protéger les équipements utilisateurs.</p>\n<h2 id="exigences-1" class="toc-header"><a class="toc-anchor" href="#exigences-1">¶</a> 📌 Exigences</h2>\n<ul>\n<li>antivirus,</li>\n<li>chiffrement disque,</li>\n<li>mises à jour automatiques,</li>\n<li>verrouillage automatique.</li>\n</ul>\n<h2 id="justification-3" class="toc-header"><a class="toc-anchor" href="#justification-3">¶</a> ✔ Justification</h2>\n<p>Le poste utilisateur est la première cible des attaquants.</p>\n<hr>\n<h1 id="️-5-sécurité-réseau" class="toc-header"><a class="toc-anchor" href="#️-5-sécurité-réseau">¶</a> 🏗️ 5. Sécurité réseau</h1>\n<h2 id="objectif-4" class="toc-header"><a class="toc-anchor" href="#objectif-4">¶</a> 🎯 Objectif</h2>\n<p>Protéger les communications et l’infrastructure.</p>\n<h2 id="exigences-2" class="toc-header"><a class="toc-anchor" href="#exigences-2">¶</a> 📌 Exigences</h2>\n<ul>\n<li>segmentation réseau,</li>\n<li>pare-feu,</li>\n<li>VPN sécurisé,</li>\n<li>interdiction des Wi-Fi non sécurisés.</li>\n</ul>\n<h2 id="justification-4" class="toc-header"><a class="toc-anchor" href="#justification-4">¶</a> ✔ Justification</h2>\n<p>Un réseau plat = propagation rapide d’un ransomware.</p>\n<hr>\n<h1 id="️-6-gestion-des-incidents" class="toc-header"><a class="toc-anchor" href="#️-6-gestion-des-incidents">¶</a> 🏗️ 6. Gestion des incidents</h1>\n<h2 id="objectif-5" class="toc-header"><a class="toc-anchor" href="#objectif-5">¶</a> 🎯 Objectif</h2>\n<p>Savoir réagir rapidement.</p>\n<h2 id="exigences-3" class="toc-header"><a class="toc-anchor" href="#exigences-3">¶</a> 📌 Exigences</h2>\n<ul>\n<li>procédure d’alerte,</li>\n<li>cellule de crise,</li>\n<li>journalisation,</li>\n<li>rapport post‑incident.</li>\n</ul>\n<h2 id="justification-5" class="toc-header"><a class="toc-anchor" href="#justification-5">¶</a> ✔ Justification</h2>\n<p>Une mauvaise réaction peut aggraver l’incident.</p>\n<hr>\n<h1 id="️-7-sauvegardes" class="toc-header"><a class="toc-anchor" href="#️-7-sauvegardes">¶</a> 🏗️ 7. Sauvegardes</h1>\n<h2 id="objectif-6" class="toc-header"><a class="toc-anchor" href="#objectif-6">¶</a> 🎯 Objectif</h2>\n<p>Assurer la récupération des données.</p>\n<h2 id="exigences-4" class="toc-header"><a class="toc-anchor" href="#exigences-4">¶</a> 📌 Exigences</h2>\n<ul>\n<li>sauvegardes régulières,</li>\n<li>tests de restauration,</li>\n<li>sauvegardes hors ligne.</li>\n</ul>\n<h2 id="justification-6" class="toc-header"><a class="toc-anchor" href="#justification-6">¶</a> ✔ Justification</h2>\n<p>Dernière ligne de défense contre les ransomwares.</p>\n<hr>\n<h1 id="️-8-continuité-dactivité" class="toc-header"><a class="toc-anchor" href="#️-8-continuité-dactivité">¶</a> 🏗️ 8. Continuité d’activité</h1>\n<h2 id="objectif-7" class="toc-header"><a class="toc-anchor" href="#objectif-7">¶</a> 🎯 Objectif</h2>\n<p>Assurer la disponibilité des services essentiels.</p>\n<h2 id="exigences-5" class="toc-header"><a class="toc-anchor" href="#exigences-5">¶</a> 📌 Exigences</h2>\n<ul>\n<li>PCA,</li>\n<li>PRA,</li>\n<li>redondance,</li>\n<li>tests réguliers.</li>\n</ul>\n<h2 id="justification-7" class="toc-header"><a class="toc-anchor" href="#justification-7">¶</a> ✔ Justification</h2>\n<p>Une panne peut coûter des millions.</p>\n<hr>\n<h1 id="️-9-sensibilisation" class="toc-header"><a class="toc-anchor" href="#️-9-sensibilisation">¶</a> 🏗️ 9. Sensibilisation</h1>\n<h2 id="objectif-8" class="toc-header"><a class="toc-anchor" href="#objectif-8">¶</a> 🎯 Objectif</h2>\n<p>Former les utilisateurs.</p>\n<h2 id="exigences-6" class="toc-header"><a class="toc-anchor" href="#exigences-6">¶</a> 📌 Exigences</h2>\n<ul>\n<li>formation annuelle,</li>\n<li>campagnes anti‑phishing,</li>\n<li>rappels réguliers.</li>\n</ul>\n<h2 id="justification-8" class="toc-header"><a class="toc-anchor" href="#justification-8">¶</a> ✔ Justification</h2>\n<p>L’humain est le maillon le plus faible.</p>\n<hr>\n<h1 id="️-10-conformité-et-sanctions" class="toc-header"><a class="toc-anchor" href="#️-10-conformité-et-sanctions">¶</a> 🏗️ 10. Conformité et sanctions</h1>\n<h2 id="objectif-9" class="toc-header"><a class="toc-anchor" href="#objectif-9">¶</a> 🎯 Objectif</h2>\n<p>Garantir le respect de la PSSI.</p>\n<h2 id="exigences-7" class="toc-header"><a class="toc-anchor" href="#exigences-7">¶</a> 📌 Exigences</h2>\n<ul>\n<li>audits internes,</li>\n<li>sanctions disciplinaires,</li>\n<li>suivi des non‑conformités.</li>\n</ul>\n<h2 id="justification-9" class="toc-header"><a class="toc-anchor" href="#justification-9">¶</a> ✔ Justification</h2>\n<p>Une règle sans sanction = règle inutile.</p>\n<hr>\n<h1 id="cas-pratiques-miniétudes" class="toc-header"><a class="toc-anchor" href="#cas-pratiques-miniétudes">¶</a> 🧱 Cas pratiques (mini‑études)</h1>\n<h2 id="cas-1-employé-qui-partage-son-mot-de-passe" class="toc-header"><a class="toc-anchor" href="#cas-1-employé-qui-partage-son-mot-de-passe">¶</a> 🧪 Cas 1 : Employé qui partage son mot de passe</h2>\n<p>→ violation de la PSSI<br>\n→ risque de compromission<br>\n→ sanction + formation</p>\n<h2 id="cas-2-prestataire-avec-accès-non-contrôlé" class="toc-header"><a class="toc-anchor" href="#cas-2-prestataire-avec-accès-non-contrôlé">¶</a> 🧪 Cas 2 : Prestataire avec accès non contrôlé</h2>\n<p>→ violation de la PSSI<br>\n→ risque supply chain<br>\n→ mise à jour des contrats</p>\n<h2 id="cas-3-absence-de-sauvegardes-testées" class="toc-header"><a class="toc-anchor" href="#cas-3-absence-de-sauvegardes-testées">¶</a> 🧪 Cas 3 : Absence de sauvegardes testées</h2>\n<p>→ violation de la PSSI<br>\n→ risque ransomware<br>\n→ plan d’action immédiat</p>\n<hr>\n<h1 id="synthèse-générale" class="toc-header"><a class="toc-anchor" href="#synthèse-générale">¶</a> 🧠 Synthèse générale</h1>\n<p>Une PSSI permet :</p>\n<ul>\n<li>d’unifier les règles de sécurité,</li>\n<li>de responsabiliser les acteurs,</li>\n<li>de réduire les risques,</li>\n<li>de structurer la sécurité,</li>\n<li>de préparer les audits.</li>\n</ul>\n<hr>\n<h1 id="tp-final-complet" class="toc-header"><a class="toc-anchor" href="#tp-final-complet">¶</a> 🧪 TP final complet</h1>\n<ol>\n<li>Définir le périmètre d’une PSSI.</li>\n<li>Rédiger les rôles et responsabilités.</li>\n<li>Décrire les règles de gestion des accès.</li>\n<li>Proposer un plan de sensibilisation.</li>\n<li>Définir les règles de sauvegarde.</li>\n<li>Rédiger une section “sanctions”.</li>\n<li>Présenter la PSSI à la direction.</li>\n</ol>\n	[{"title":"PSSI — Politique de Sécurité des Systèmes d’Information","anchor":"#pssi-politique-de-sécurité-des-systèmes-dinformation","children":[{"title":"🎯 Objectifs pédagogiques","anchor":"#objectifs-pédagogiques","children":[]}]},{"title":"🧩 Introduction générale","anchor":"#introduction-générale","children":[]},{"title":"🧱 Pourquoi une PSSI est indispensable ?","anchor":"#pourquoi-une-pssi-est-indispensable","children":[{"title":"✔ Justification 1 : aligner toute l’organisation","anchor":"#justification-1-aligner-toute-lorganisation","children":[]},{"title":"✔ Justification 2 : répondre aux obligations légales","anchor":"#justification-2-répondre-aux-obligations-légales","children":[]},{"title":"✔ Justification 3 : réduire les risques humains","anchor":"#justification-3-réduire-les-risques-humains","children":[]},{"title":"✔ Justification 4 : protéger l’image et la réputation","anchor":"#justification-4-protéger-limage-et-la-réputation","children":[]},{"title":"✔ Justification 5 : base de tous les audits","anchor":"#justification-5-base-de-tous-les-audits","children":[]}]},{"title":"🧱 Structure d’une PSSI complète","anchor":"#structure-dune-pssi-complète","children":[]},{"title":"🏗️ 1. Objectifs et portée","anchor":"#️-1-objectifs-et-portée","children":[{"title":"🎯 Objectif","anchor":"#objectif","children":[]},{"title":"📌 Contenu","anchor":"#contenu","children":[]},{"title":"✔ Justification","anchor":"#justification","children":[]},{"title":"🧪 Exemple","anchor":"#exemple","children":[]}]},{"title":"🏗️ 2. Rôles et responsabilités","anchor":"#️-2-rôles-et-responsabilités","children":[{"title":"🎯 Objectif","anchor":"#objectif-1","children":[]},{"title":"📌 Acteurs typiques","anchor":"#acteurs-typiques","children":[]},{"title":"✔ Justification","anchor":"#justification-1","children":[]},{"title":"🧪 Exemple","anchor":"#exemple-1","children":[]}]},{"title":"🏗️ 3. Gestion des accès","anchor":"#️-3-gestion-des-accès","children":[{"title":"🎯 Objectif","anchor":"#objectif-2","children":[]},{"title":"📌 Exigences","anchor":"#exigences","children":[]},{"title":"✔ Justification","anchor":"#justification-2","children":[]},{"title":"❌ Erreurs fréquentes","anchor":"#erreurs-fréquentes","children":[]}]},{"title":"🏗️ 4. Sécurité des postes de travail","anchor":"#️-4-sécurité-des-postes-de-travail","children":[{"title":"🎯 Objectif","anchor":"#objectif-3","children":[]},{"title":"📌 Exigences","anchor":"#exigences-1","children":[]},{"title":"✔ Justification","anchor":"#justification-3","children":[]}]},{"title":"🏗️ 5. Sécurité réseau","anchor":"#️-5-sécurité-réseau","children":[{"title":"🎯 Objectif","anchor":"#objectif-4","children":[]},{"title":"📌 Exigences","anchor":"#exigences-2","children":[]},{"title":"✔ Justification","anchor":"#justification-4","children":[]}]},{"title":"🏗️ 6. Gestion des incidents","anchor":"#️-6-gestion-des-incidents","children":[{"title":"🎯 Objectif","anchor":"#objectif-5","children":[]},{"title":"📌 Exigences","anchor":"#exigences-3","children":[]},{"title":"✔ Justification","anchor":"#justification-5","children":[]}]},{"title":"🏗️ 7. Sauvegardes","anchor":"#️-7-sauvegardes","children":[{"title":"🎯 Objectif","anchor":"#objectif-6","children":[]},{"title":"📌 Exigences","anchor":"#exigences-4","children":[]},{"title":"✔ Justification","anchor":"#justification-6","children":[]}]},{"title":"🏗️ 8. Continuité d’activité","anchor":"#️-8-continuité-dactivité","children":[{"title":"🎯 Objectif","anchor":"#objectif-7","children":[]},{"title":"📌 Exigences","anchor":"#exigences-5","children":[]},{"title":"✔ Justification","anchor":"#justification-7","children":[]}]},{"title":"🏗️ 9. Sensibilisation","anchor":"#️-9-sensibilisation","children":[{"title":"🎯 Objectif","anchor":"#objectif-8","children":[]},{"title":"📌 Exigences","anchor":"#exigences-6","children":[]},{"title":"✔ Justification","anchor":"#justification-8","children":[]}]},{"title":"🏗️ 10. Conformité et sanctions","anchor":"#️-10-conformité-et-sanctions","children":[{"title":"🎯 Objectif","anchor":"#objectif-9","children":[]},{"title":"📌 Exigences","anchor":"#exigences-7","children":[]},{"title":"✔ Justification","anchor":"#justification-9","children":[]}]},{"title":"🧱 Cas pratiques (mini‑études)","anchor":"#cas-pratiques-miniétudes","children":[{"title":"🧪 Cas 1 : Employé qui partage son mot de passe","anchor":"#cas-1-employé-qui-partage-son-mot-de-passe","children":[]},{"title":"🧪 Cas 2 : Prestataire avec accès non contrôlé","anchor":"#cas-2-prestataire-avec-accès-non-contrôlé","children":[]},{"title":"🧪 Cas 3 : Absence de sauvegardes testées","anchor":"#cas-3-absence-de-sauvegardes-testées","children":[]}]},{"title":"🧠 Synthèse générale","anchor":"#synthèse-générale","children":[]},{"title":"🧪 TP final complet","anchor":"#tp-final-complet","children":[]}]	markdown	2026-03-08T18:12:28.173Z	2026-03-08T18:16:16.730Z	markdown	en	1	1	{"js":"","css":""}
30	home/GDR	96f9296d59146418ffd7339a274ec41338b8d605	Gestion des risques		f	t	\N			# Gestion des risques en cybersécurité.\n\n## 🎯 Objectifs pédagogiques\n- Comprendre les concepts fondamentaux de la gestion des risques.\n- Savoir identifier, analyser, évaluer et traiter les risques.\n- Comprendre les liens avec ISO 27005, EBIOS RM et MEHARI.\n- Apprendre à justifier chaque étape auprès d’étudiants ou d’auditeurs.\n- Préparer les étudiants à un TP complet d’analyse de risques.\n\n---\n\n# 🧩 Introduction générale\n\nLa gestion des risques est la **base de toute stratégie de cybersécurité**.  \nElle permet de :\n- prioriser les actions,\n- optimiser les budgets,\n- réduire les risques majeurs,\n- justifier les mesures de sécurité.\n\n---\n\n# 🧱 Pourquoi gérer les risques ?\n\n## ✔ Justification 1 : impossible de tout protéger\nLes ressources sont limitées → il faut prioriser.\n\n## ✔ Justification 2 : les menaces évoluent\nNouveaux ransomwares, nouvelles vulnérabilités.\n\n## ✔ Justification 3 : obligations légales\n- ISO 27001,\n- NIS2,\n- RGPD (AIPD).\n\n## ✔ Justification 4 : base de la gouvernance SSI\nSans analyse → sécurité improvisée.\n\n---\n\n# 🧱 Étapes de la gestion des risques\n\n1. **Identification**\n2. **Analyse**\n3. **Évaluation**\n4. **Traitement**\n5. **Suivi**\n\n---\n\n# 🏗️ 1. Identification\n\n## 🎯 Objectif\nLister les risques potentiels.\n\n## 📌 On identifie :\n- actifs,\n- menaces,\n- vulnérabilités,\n- impacts.\n\n## 🧪 Exemple\nActif : base de données clients  \nMenace : ransomware  \nVulnérabilité : absence de sauvegarde hors ligne  \n\n---\n\n# 🏗️ 2. Analyse\n\n## 🎯 Objectif\nÉvaluer probabilité + impact.\n\n## 📌 Méthodes\n- qualitative,\n- semi‑quantitative,\n- quantitative.\n\n## 🧪 Exemple\nProbabilité : élevée  \nImpact : très élevé  \nRisque : critique  \n\n---\n\n# 🏗️ 3. Évaluation\n\n## 🎯 Objectif\nClasser les risques :\n- acceptable,\n- tolérable,\n- inacceptable.\n\n---\n\n# 🏗️ 4. Traitement\n\n## 🎯 Objectif\nChoisir une stratégie :\n- réduire,\n- éviter,\n- transférer,\n- accepter.\n\n## 🧪 Exemple\nRisque : ransomware  \nTraitement : sauvegardes + MFA + segmentation  \n\n---\n\n# 🏗️ 5. Suivi\n\n## 🎯 Objectif\nSurveiller l’évolution des risques.\n\n## 📌 Exemples\n- nouveaux incidents,\n- nouvelles vulnérabilités,\n- changements techniques.\n\n---\n\n# 🧱 Cas pratiques\n\n## 🧪 Cas 1 : PME\nRisque critique → plan d’action immédiat.\n\n## 🧪 Cas 2 : Collectivité locale\nRisque moyen → planification.\n\n## 🧪 Cas 3 : Entreprise cloud\nRisque faible → surveillance.\n\n---\n\n# 🧪 TP final complet\n\n1. Identifier 5 actifs essentiels.  \n2. Lister les menaces et vulnérabilités.  \n3. Évaluer probabilité + impact.  \n4. Classer les risques.  \n5. Proposer un plan de traitement.  \n6. Rédiger une synthèse.  \n	<h1 id="gestion-des-risques-en-cybersécurité" class="toc-header"><a class="toc-anchor" href="#gestion-des-risques-en-cybersécurité">¶</a> Gestion des risques en cybersécurité.</h1>\n<h2 id="objectifs-pédagogiques" class="toc-header"><a class="toc-anchor" href="#objectifs-pédagogiques">¶</a> 🎯 Objectifs pédagogiques</h2>\n<ul>\n<li>Comprendre les concepts fondamentaux de la gestion des risques.</li>\n<li>Savoir identifier, analyser, évaluer et traiter les risques.</li>\n<li>Comprendre les liens avec ISO 27005, EBIOS RM et MEHARI.</li>\n<li>Apprendre à justifier chaque étape auprès d’étudiants ou d’auditeurs.</li>\n<li>Préparer les étudiants à un TP complet d’analyse de risques.</li>\n</ul>\n<hr>\n<h1 id="introduction-générale" class="toc-header"><a class="toc-anchor" href="#introduction-générale">¶</a> 🧩 Introduction générale</h1>\n<p>La gestion des risques est la <strong>base de toute stratégie de cybersécurité</strong>.<br>\nElle permet de :</p>\n<ul>\n<li>prioriser les actions,</li>\n<li>optimiser les budgets,</li>\n<li>réduire les risques majeurs,</li>\n<li>justifier les mesures de sécurité.</li>\n</ul>\n<hr>\n<h1 id="pourquoi-gérer-les-risques" class="toc-header"><a class="toc-anchor" href="#pourquoi-gérer-les-risques">¶</a> 🧱 Pourquoi gérer les risques ?</h1>\n<h2 id="justification-1-impossible-de-tout-protéger" class="toc-header"><a class="toc-anchor" href="#justification-1-impossible-de-tout-protéger">¶</a> ✔ Justification 1 : impossible de tout protéger</h2>\n<p>Les ressources sont limitées → il faut prioriser.</p>\n<h2 id="justification-2-les-menaces-évoluent" class="toc-header"><a class="toc-anchor" href="#justification-2-les-menaces-évoluent">¶</a> ✔ Justification 2 : les menaces évoluent</h2>\n<p>Nouveaux ransomwares, nouvelles vulnérabilités.</p>\n<h2 id="justification-3-obligations-légales" class="toc-header"><a class="toc-anchor" href="#justification-3-obligations-légales">¶</a> ✔ Justification 3 : obligations légales</h2>\n<ul>\n<li>ISO 27001,</li>\n<li>NIS2,</li>\n<li>RGPD (AIPD).</li>\n</ul>\n<h2 id="justification-4-base-de-la-gouvernance-ssi" class="toc-header"><a class="toc-anchor" href="#justification-4-base-de-la-gouvernance-ssi">¶</a> ✔ Justification 4 : base de la gouvernance SSI</h2>\n<p>Sans analyse → sécurité improvisée.</p>\n<hr>\n<h1 id="étapes-de-la-gestion-des-risques" class="toc-header"><a class="toc-anchor" href="#étapes-de-la-gestion-des-risques">¶</a> 🧱 Étapes de la gestion des risques</h1>\n<ol>\n<li><strong>Identification</strong></li>\n<li><strong>Analyse</strong></li>\n<li><strong>Évaluation</strong></li>\n<li><strong>Traitement</strong></li>\n<li><strong>Suivi</strong></li>\n</ol>\n<hr>\n<h1 id="️-1-identification" class="toc-header"><a class="toc-anchor" href="#️-1-identification">¶</a> 🏗️ 1. Identification</h1>\n<h2 id="objectif" class="toc-header"><a class="toc-anchor" href="#objectif">¶</a> 🎯 Objectif</h2>\n<p>Lister les risques potentiels.</p>\n<h2 id="on-identifie" class="toc-header"><a class="toc-anchor" href="#on-identifie">¶</a> 📌 On identifie :</h2>\n<ul>\n<li>actifs,</li>\n<li>menaces,</li>\n<li>vulnérabilités,</li>\n<li>impacts.</li>\n</ul>\n<h2 id="exemple" class="toc-header"><a class="toc-anchor" href="#exemple">¶</a> 🧪 Exemple</h2>\n<p>Actif : base de données clients<br>\nMenace : ransomware<br>\nVulnérabilité : absence de sauvegarde hors ligne</p>\n<hr>\n<h1 id="️-2-analyse" class="toc-header"><a class="toc-anchor" href="#️-2-analyse">¶</a> 🏗️ 2. Analyse</h1>\n<h2 id="objectif-1" class="toc-header"><a class="toc-anchor" href="#objectif-1">¶</a> 🎯 Objectif</h2>\n<p>Évaluer probabilité + impact.</p>\n<h2 id="méthodes" class="toc-header"><a class="toc-anchor" href="#méthodes">¶</a> 📌 Méthodes</h2>\n<ul>\n<li>qualitative,</li>\n<li>semi‑quantitative,</li>\n<li>quantitative.</li>\n</ul>\n<h2 id="exemple-1" class="toc-header"><a class="toc-anchor" href="#exemple-1">¶</a> 🧪 Exemple</h2>\n<p>Probabilité : élevée<br>\nImpact : très élevé<br>\nRisque : critique</p>\n<hr>\n<h1 id="️-3-évaluation" class="toc-header"><a class="toc-anchor" href="#️-3-évaluation">¶</a> 🏗️ 3. Évaluation</h1>\n<h2 id="objectif-2" class="toc-header"><a class="toc-anchor" href="#objectif-2">¶</a> 🎯 Objectif</h2>\n<p>Classer les risques :</p>\n<ul>\n<li>acceptable,</li>\n<li>tolérable,</li>\n<li>inacceptable.</li>\n</ul>\n<hr>\n<h1 id="️-4-traitement" class="toc-header"><a class="toc-anchor" href="#️-4-traitement">¶</a> 🏗️ 4. Traitement</h1>\n<h2 id="objectif-3" class="toc-header"><a class="toc-anchor" href="#objectif-3">¶</a> 🎯 Objectif</h2>\n<p>Choisir une stratégie :</p>\n<ul>\n<li>réduire,</li>\n<li>éviter,</li>\n<li>transférer,</li>\n<li>accepter.</li>\n</ul>\n<h2 id="exemple-2" class="toc-header"><a class="toc-anchor" href="#exemple-2">¶</a> 🧪 Exemple</h2>\n<p>Risque : ransomware<br>\nTraitement : sauvegardes + MFA + segmentation</p>\n<hr>\n<h1 id="️-5-suivi" class="toc-header"><a class="toc-anchor" href="#️-5-suivi">¶</a> 🏗️ 5. Suivi</h1>\n<h2 id="objectif-4" class="toc-header"><a class="toc-anchor" href="#objectif-4">¶</a> 🎯 Objectif</h2>\n<p>Surveiller l’évolution des risques.</p>\n<h2 id="exemples" class="toc-header"><a class="toc-anchor" href="#exemples">¶</a> 📌 Exemples</h2>\n<ul>\n<li>nouveaux incidents,</li>\n<li>nouvelles vulnérabilités,</li>\n<li>changements techniques.</li>\n</ul>\n<hr>\n<h1 id="cas-pratiques" class="toc-header"><a class="toc-anchor" href="#cas-pratiques">¶</a> 🧱 Cas pratiques</h1>\n<h2 id="cas-1-pme" class="toc-header"><a class="toc-anchor" href="#cas-1-pme">¶</a> 🧪 Cas 1 : PME</h2>\n<p>Risque critique → plan d’action immédiat.</p>\n<h2 id="cas-2-collectivité-locale" class="toc-header"><a class="toc-anchor" href="#cas-2-collectivité-locale">¶</a> 🧪 Cas 2 : Collectivité locale</h2>\n<p>Risque moyen → planification.</p>\n<h2 id="cas-3-entreprise-cloud" class="toc-header"><a class="toc-anchor" href="#cas-3-entreprise-cloud">¶</a> 🧪 Cas 3 : Entreprise cloud</h2>\n<p>Risque faible → surveillance.</p>\n<hr>\n<h1 id="tp-final-complet" class="toc-header"><a class="toc-anchor" href="#tp-final-complet">¶</a> 🧪 TP final complet</h1>\n<ol>\n<li>Identifier 5 actifs essentiels.</li>\n<li>Lister les menaces et vulnérabilités.</li>\n<li>Évaluer probabilité + impact.</li>\n<li>Classer les risques.</li>\n<li>Proposer un plan de traitement.</li>\n<li>Rédiger une synthèse.</li>\n</ol>\n	[{"title":"Gestion des risques en cybersécurité.","anchor":"#gestion-des-risques-en-cybersécurité","children":[{"title":"🎯 Objectifs pédagogiques","anchor":"#objectifs-pédagogiques","children":[]}]},{"title":"🧩 Introduction générale","anchor":"#introduction-générale","children":[]},{"title":"🧱 Pourquoi gérer les risques ?","anchor":"#pourquoi-gérer-les-risques","children":[{"title":"✔ Justification 1 : impossible de tout protéger","anchor":"#justification-1-impossible-de-tout-protéger","children":[]},{"title":"✔ Justification 2 : les menaces évoluent","anchor":"#justification-2-les-menaces-évoluent","children":[]},{"title":"✔ Justification 3 : obligations légales","anchor":"#justification-3-obligations-légales","children":[]},{"title":"✔ Justification 4 : base de la gouvernance SSI","anchor":"#justification-4-base-de-la-gouvernance-ssi","children":[]}]},{"title":"🧱 Étapes de la gestion des risques","anchor":"#étapes-de-la-gestion-des-risques","children":[]},{"title":"🏗️ 1. Identification","anchor":"#️-1-identification","children":[{"title":"🎯 Objectif","anchor":"#objectif","children":[]},{"title":"📌 On identifie :","anchor":"#on-identifie","children":[]},{"title":"🧪 Exemple","anchor":"#exemple","children":[]}]},{"title":"🏗️ 2. Analyse","anchor":"#️-2-analyse","children":[{"title":"🎯 Objectif","anchor":"#objectif-1","children":[]},{"title":"📌 Méthodes","anchor":"#méthodes","children":[]},{"title":"🧪 Exemple","anchor":"#exemple-1","children":[]}]},{"title":"🏗️ 3. Évaluation","anchor":"#️-3-évaluation","children":[{"title":"🎯 Objectif","anchor":"#objectif-2","children":[]}]},{"title":"🏗️ 4. Traitement","anchor":"#️-4-traitement","children":[{"title":"🎯 Objectif","anchor":"#objectif-3","children":[]},{"title":"🧪 Exemple","anchor":"#exemple-2","children":[]}]},{"title":"🏗️ 5. Suivi","anchor":"#️-5-suivi","children":[{"title":"🎯 Objectif","anchor":"#objectif-4","children":[]},{"title":"📌 Exemples","anchor":"#exemples","children":[]}]},{"title":"🧱 Cas pratiques","anchor":"#cas-pratiques","children":[{"title":"🧪 Cas 1 : PME","anchor":"#cas-1-pme","children":[]},{"title":"🧪 Cas 2 : Collectivité locale","anchor":"#cas-2-collectivité-locale","children":[]},{"title":"🧪 Cas 3 : Entreprise cloud","anchor":"#cas-3-entreprise-cloud","children":[]}]},{"title":"🧪 TP final complet","anchor":"#tp-final-complet","children":[]}]	markdown	2026-03-08T18:18:10.414Z	2026-03-08T18:18:11.598Z	markdown	en	1	1	{"js":"","css":""}
31	home/PCA-PRA	7a1155b5344c67251a341aa3629e63ef961f2a97	PCA/PRA		f	t	\N			# PCA / PRA — Continuité et reprise d’activité.\n\n## 🎯 Objectifs pédagogiques\n- Comprendre la différence entre PCA et PRA.\n- Savoir définir les RTO et RPO.\n- Comprendre les enjeux de continuité d’activité.\n- Apprendre à justifier chaque exigence auprès d’étudiants ou d’auditeurs.\n- Préparer les étudiants à un TP de construction de PCA/PRA.\n\n---\n\n# 🧩 Introduction générale\n\nLe **PCA** (Plan de Continuité d’Activité) et le **PRA** (Plan de Reprise d’Activité) sont essentiels pour assurer la disponibilité des services.\n\nIls permettent de :\n- maintenir l’activité en cas de crise (PCA),\n- restaurer les services après un incident majeur (PRA).\n\n---\n\n# 🧱 Pourquoi un PCA/PRA est indispensable ?\n\n## ✔ Justification 1 : dépendance au numérique\nUne panne peut arrêter toute l’entreprise.\n\n## ✔ Justification 2 : cyberattaques\nLes ransomwares peuvent paralyser un SI.\n\n## ✔ Justification 3 : obligations légales\n- NIS2,\n- contrats clients,\n- assurance cyber.\n\n## ✔ Justification 4 : image et réputation\nUne indisponibilité prolongée peut ruiner la confiance.\n\n---\n\n# 🧱 Concepts clés\n\n## 🔹 RTO (Recovery Time Objective)\nTemps maximal d’interruption acceptable.\n\n## 🔹 RPO (Recovery Point Objective)\nPerte de données maximale acceptable.\n\n## 🔹 MTPD (Maximum Tolerable Period of Disruption)\nDurée maximale d’interruption avant impact critique.\n\n---\n\n# 🧱 PCA — Plan de Continuité d’Activité\n\n## 🎯 Objectif\nMaintenir les services essentiels pendant une crise.\n\n## 📌 Exemples\n- bascule automatique,\n- redondance,\n- travail à distance,\n- procédures manuelles.\n\n## ✔ Justification\nCertains services ne peuvent pas s’arrêter.\n\n---\n\n# 🧱 PRA — Plan de Reprise d’Activité\n\n## 🎯 Objectif\nRestaurer les services après un incident majeur.\n\n## 📌 Exemples\n- restauration de sauvegardes,\n- redémarrage des serveurs,\n- reconstruction du SI.\n\n## ✔ Justification\nAprès une attaque, il faut repartir rapidement.\n\n---\n\n# 🧱 Cas pratiques\n\n## 🧪 Cas 1 : ransomware\n- PCA : bascule vers un environnement sain  \n- PRA : restauration des sauvegardes  \n\n## 🧪 Cas 2 : panne électrique\n- PCA : groupe électrogène  \n- PRA : redémarrage des services  \n\n## 🧪 Cas 3 : incendie\n- PCA : site secondaire  \n- PRA : reconstruction du SI  \n\n---\n\n# 🧪 TP final complet\n\n1. Choisir un service (ex : messagerie).  \n2. Définir RTO et RPO.  \n3. Décrire les scénarios de crise.  \n4. Construire un PCA.  \n5. Construire un PRA.  \n6. Tester un scénario.  \n	<h1 id="pca-pra-continuité-et-reprise-dactivité" class="toc-header"><a class="toc-anchor" href="#pca-pra-continuité-et-reprise-dactivité">¶</a> PCA / PRA — Continuité et reprise d’activité.</h1>\n<h2 id="objectifs-pédagogiques" class="toc-header"><a class="toc-anchor" href="#objectifs-pédagogiques">¶</a> 🎯 Objectifs pédagogiques</h2>\n<ul>\n<li>Comprendre la différence entre PCA et PRA.</li>\n<li>Savoir définir les RTO et RPO.</li>\n<li>Comprendre les enjeux de continuité d’activité.</li>\n<li>Apprendre à justifier chaque exigence auprès d’étudiants ou d’auditeurs.</li>\n<li>Préparer les étudiants à un TP de construction de PCA/PRA.</li>\n</ul>\n<hr>\n<h1 id="introduction-générale" class="toc-header"><a class="toc-anchor" href="#introduction-générale">¶</a> 🧩 Introduction générale</h1>\n<p>Le <strong>PCA</strong> (Plan de Continuité d’Activité) et le <strong>PRA</strong> (Plan de Reprise d’Activité) sont essentiels pour assurer la disponibilité des services.</p>\n<p>Ils permettent de :</p>\n<ul>\n<li>maintenir l’activité en cas de crise (PCA),</li>\n<li>restaurer les services après un incident majeur (PRA).</li>\n</ul>\n<hr>\n<h1 id="pourquoi-un-pcapra-est-indispensable" class="toc-header"><a class="toc-anchor" href="#pourquoi-un-pcapra-est-indispensable">¶</a> 🧱 Pourquoi un PCA/PRA est indispensable ?</h1>\n<h2 id="justification-1-dépendance-au-numérique" class="toc-header"><a class="toc-anchor" href="#justification-1-dépendance-au-numérique">¶</a> ✔ Justification 1 : dépendance au numérique</h2>\n<p>Une panne peut arrêter toute l’entreprise.</p>\n<h2 id="justification-2-cyberattaques" class="toc-header"><a class="toc-anchor" href="#justification-2-cyberattaques">¶</a> ✔ Justification 2 : cyberattaques</h2>\n<p>Les ransomwares peuvent paralyser un SI.</p>\n<h2 id="justification-3-obligations-légales" class="toc-header"><a class="toc-anchor" href="#justification-3-obligations-légales">¶</a> ✔ Justification 3 : obligations légales</h2>\n<ul>\n<li>NIS2,</li>\n<li>contrats clients,</li>\n<li>assurance cyber.</li>\n</ul>\n<h2 id="justification-4-image-et-réputation" class="toc-header"><a class="toc-anchor" href="#justification-4-image-et-réputation">¶</a> ✔ Justification 4 : image et réputation</h2>\n<p>Une indisponibilité prolongée peut ruiner la confiance.</p>\n<hr>\n<h1 id="concepts-clés" class="toc-header"><a class="toc-anchor" href="#concepts-clés">¶</a> 🧱 Concepts clés</h1>\n<h2 id="rto-recovery-time-objective" class="toc-header"><a class="toc-anchor" href="#rto-recovery-time-objective">¶</a> 🔹 RTO (Recovery Time Objective)</h2>\n<p>Temps maximal d’interruption acceptable.</p>\n<h2 id="rpo-recovery-point-objective" class="toc-header"><a class="toc-anchor" href="#rpo-recovery-point-objective">¶</a> 🔹 RPO (Recovery Point Objective)</h2>\n<p>Perte de données maximale acceptable.</p>\n<h2 id="mtpd-maximum-tolerable-period-of-disruption" class="toc-header"><a class="toc-anchor" href="#mtpd-maximum-tolerable-period-of-disruption">¶</a> 🔹 MTPD (Maximum Tolerable Period of Disruption)</h2>\n<p>Durée maximale d’interruption avant impact critique.</p>\n<hr>\n<h1 id="pca-plan-de-continuité-dactivité" class="toc-header"><a class="toc-anchor" href="#pca-plan-de-continuité-dactivité">¶</a> 🧱 PCA — Plan de Continuité d’Activité</h1>\n<h2 id="objectif" class="toc-header"><a class="toc-anchor" href="#objectif">¶</a> 🎯 Objectif</h2>\n<p>Maintenir les services essentiels pendant une crise.</p>\n<h2 id="exemples" class="toc-header"><a class="toc-anchor" href="#exemples">¶</a> 📌 Exemples</h2>\n<ul>\n<li>bascule automatique,</li>\n<li>redondance,</li>\n<li>travail à distance,</li>\n<li>procédures manuelles.</li>\n</ul>\n<h2 id="justification" class="toc-header"><a class="toc-anchor" href="#justification">¶</a> ✔ Justification</h2>\n<p>Certains services ne peuvent pas s’arrêter.</p>\n<hr>\n<h1 id="pra-plan-de-reprise-dactivité" class="toc-header"><a class="toc-anchor" href="#pra-plan-de-reprise-dactivité">¶</a> 🧱 PRA — Plan de Reprise d’Activité</h1>\n<h2 id="objectif-1" class="toc-header"><a class="toc-anchor" href="#objectif-1">¶</a> 🎯 Objectif</h2>\n<p>Restaurer les services après un incident majeur.</p>\n<h2 id="exemples-1" class="toc-header"><a class="toc-anchor" href="#exemples-1">¶</a> 📌 Exemples</h2>\n<ul>\n<li>restauration de sauvegardes,</li>\n<li>redémarrage des serveurs,</li>\n<li>reconstruction du SI.</li>\n</ul>\n<h2 id="justification-1" class="toc-header"><a class="toc-anchor" href="#justification-1">¶</a> ✔ Justification</h2>\n<p>Après une attaque, il faut repartir rapidement.</p>\n<hr>\n<h1 id="cas-pratiques" class="toc-header"><a class="toc-anchor" href="#cas-pratiques">¶</a> 🧱 Cas pratiques</h1>\n<h2 id="cas-1-ransomware" class="toc-header"><a class="toc-anchor" href="#cas-1-ransomware">¶</a> 🧪 Cas 1 : ransomware</h2>\n<ul>\n<li>PCA : bascule vers un environnement sain</li>\n<li>PRA : restauration des sauvegardes</li>\n</ul>\n<h2 id="cas-2-panne-électrique" class="toc-header"><a class="toc-anchor" href="#cas-2-panne-électrique">¶</a> 🧪 Cas 2 : panne électrique</h2>\n<ul>\n<li>PCA : groupe électrogène</li>\n<li>PRA : redémarrage des services</li>\n</ul>\n<h2 id="cas-3-incendie" class="toc-header"><a class="toc-anchor" href="#cas-3-incendie">¶</a> 🧪 Cas 3 : incendie</h2>\n<ul>\n<li>PCA : site secondaire</li>\n<li>PRA : reconstruction du SI</li>\n</ul>\n<hr>\n<h1 id="tp-final-complet" class="toc-header"><a class="toc-anchor" href="#tp-final-complet">¶</a> 🧪 TP final complet</h1>\n<ol>\n<li>Choisir un service (ex : messagerie).</li>\n<li>Définir RTO et RPO.</li>\n<li>Décrire les scénarios de crise.</li>\n<li>Construire un PCA.</li>\n<li>Construire un PRA.</li>\n<li>Tester un scénario.</li>\n</ol>\n	[{"title":"PCA / PRA — Continuité et reprise d’activité.","anchor":"#pca-pra-continuité-et-reprise-dactivité","children":[{"title":"🎯 Objectifs pédagogiques","anchor":"#objectifs-pédagogiques","children":[]}]},{"title":"🧩 Introduction générale","anchor":"#introduction-générale","children":[]},{"title":"🧱 Pourquoi un PCA/PRA est indispensable ?","anchor":"#pourquoi-un-pcapra-est-indispensable","children":[{"title":"✔ Justification 1 : dépendance au numérique","anchor":"#justification-1-dépendance-au-numérique","children":[]},{"title":"✔ Justification 2 : cyberattaques","anchor":"#justification-2-cyberattaques","children":[]},{"title":"✔ Justification 3 : obligations légales","anchor":"#justification-3-obligations-légales","children":[]},{"title":"✔ Justification 4 : image et réputation","anchor":"#justification-4-image-et-réputation","children":[]}]},{"title":"🧱 Concepts clés","anchor":"#concepts-clés","children":[{"title":"🔹 RTO (Recovery Time Objective)","anchor":"#rto-recovery-time-objective","children":[]},{"title":"🔹 RPO (Recovery Point Objective)","anchor":"#rpo-recovery-point-objective","children":[]},{"title":"🔹 MTPD (Maximum Tolerable Period of Disruption)","anchor":"#mtpd-maximum-tolerable-period-of-disruption","children":[]}]},{"title":"🧱 PCA — Plan de Continuité d’Activité","anchor":"#pca-plan-de-continuité-dactivité","children":[{"title":"🎯 Objectif","anchor":"#objectif","children":[]},{"title":"📌 Exemples","anchor":"#exemples","children":[]},{"title":"✔ Justification","anchor":"#justification","children":[]}]},{"title":"🧱 PRA — Plan de Reprise d’Activité","anchor":"#pra-plan-de-reprise-dactivité","children":[{"title":"🎯 Objectif","anchor":"#objectif-1","children":[]},{"title":"📌 Exemples","anchor":"#exemples-1","children":[]},{"title":"✔ Justification","anchor":"#justification-1","children":[]}]},{"title":"🧱 Cas pratiques","anchor":"#cas-pratiques","children":[{"title":"🧪 Cas 1 : ransomware","anchor":"#cas-1-ransomware","children":[]},{"title":"🧪 Cas 2 : panne électrique","anchor":"#cas-2-panne-électrique","children":[]},{"title":"🧪 Cas 3 : incendie","anchor":"#cas-3-incendie","children":[]}]},{"title":"🧪 TP final complet","anchor":"#tp-final-complet","children":[]}]	markdown	2026-03-08T18:46:22.026Z	2026-03-08T18:46:23.467Z	markdown	en	1	1	{"js":"","css":""}
\.


--
-- Data for Name: renderers; Type: TABLE DATA; Schema: public; Owner: wikijs
--

COPY public.renderers (key, "isEnabled", config) FROM stdin;
asciidocCore	t	{"safeMode":"server"}
htmlAsciinema	f	{}
htmlBlockquotes	t	{}
htmlCodehighlighter	t	{}
htmlCore	t	{"absoluteLinks":false,"openExternalLinkNewTab":false,"relAttributeExternalLink":"noreferrer"}
htmlDiagram	t	{}
htmlImagePrefetch	f	{}
htmlMediaplayers	t	{}
htmlMermaid	t	{}
htmlSecurity	t	{"safeHTML":true,"allowDrawIoUnsafe":true,"allowIFrames":false}
htmlTabset	t	{}
htmlTwemoji	t	{}
markdownAbbr	t	{}
markdownCore	t	{"allowHTML":true,"linkify":true,"linebreaks":true,"underline":false,"typographer":false,"quotes":"English"}
markdownEmoji	t	{}
markdownExpandtabs	t	{"tabWidth":4}
markdownFootnotes	t	{}
markdownImsize	t	{}
markdownKatex	t	{"useInline":true,"useBlocks":true}
markdownKroki	f	{"server":"https://kroki.io","openMarker":"```kroki","closeMarker":"```"}
markdownMathjax	f	{"useInline":true,"useBlocks":true}
markdownMultiTable	f	{"multilineEnabled":true,"headerlessEnabled":true,"rowspanEnabled":true}
markdownPivotTable	f	{}
markdownPlantuml	t	{"server":"https://plantuml.requarks.io","openMarker":"```plantuml","closeMarker":"```","imageFormat":"svg"}
markdownSupsub	t	{"subEnabled":true,"supEnabled":true}
markdownTasklists	t	{}
openapiCore	t	{}
\.


--
-- Data for Name: searchEngines; Type: TABLE DATA; Schema: public; Owner: wikijs
--

COPY public."searchEngines" (key, "isEnabled", config) FROM stdin;
algolia	f	{"appId":"","apiKey":"","indexName":"wiki"}
aws	f	{"domain":"","endpoint":"","region":"us-east-1","accessKeyId":"","secretAccessKey":"","AnalysisSchemeLang":"en"}
azure	f	{"serviceName":"","adminKey":"","indexName":"wiki"}
db	t	{}
elasticsearch	f	{"apiVersion":"7.x","hosts":"","verifyTLSCertificate":true,"tlsCertPath":"","indexName":"wiki","analyzer":"simple","sniffOnStart":false,"sniffInterval":0}
manticore	f	{}
postgres	f	{"dictLanguage":"english"}
solr	f	{"host":"solr","port":8983,"core":"wiki","protocol":"http"}
sphinx	f	{}
\.


--
-- Data for Name: sessions; Type: TABLE DATA; Schema: public; Owner: wikijs
--

COPY public.sessions (sid, sess, expired) FROM stdin;
\.


--
-- Data for Name: settings; Type: TABLE DATA; Schema: public; Owner: wikijs
--

COPY public.settings (key, value, "updatedAt") FROM stdin;
auth	{"audience":"urn:wiki.js","tokenExpiration":"30m","tokenRenewal":"14d"}	2026-03-08T13:42:15.918Z
certs	{"jwk":{"kty":"RSA","n":"3j3eBQ-l1g_MephrFtA4P9nZuiJfCPWZ4-8NSf_ZT5COmZas5PiVUhrZbqWWi4_uHGdQIk54C_Mr76ieuq8AIRtK7pw2YfBLkojIrMVDvsDgXG48ANy4YGgev6J00fkXGQAF-_c0uCXYxZBYUwJbtjadccJBf5AYsSQ43Zlzi0bzQs_D3RHoH6e7CFBa4JnRzZz1p0DLSG1vPy0rG9fjYzxXAYYSlBpIRK1rQkaeKB9ID6hX4ueZz65dxpEEzEP9zfVPgZ24LEbtJjtoFlFCGm6po9RS1M2Teq8lag2ihPyhYcOnbYXEl-0pVDfzLGPXzm4NxJuw07DRL6jzlycYsQ","e":"AQAB"},"public":"-----BEGIN RSA PUBLIC KEY-----\\nMIIBCgKCAQEA3j3eBQ+l1g/MephrFtA4P9nZuiJfCPWZ4+8NSf/ZT5COmZas5PiV\\nUhrZbqWWi4/uHGdQIk54C/Mr76ieuq8AIRtK7pw2YfBLkojIrMVDvsDgXG48ANy4\\nYGgev6J00fkXGQAF+/c0uCXYxZBYUwJbtjadccJBf5AYsSQ43Zlzi0bzQs/D3RHo\\nH6e7CFBa4JnRzZz1p0DLSG1vPy0rG9fjYzxXAYYSlBpIRK1rQkaeKB9ID6hX4ueZ\\nz65dxpEEzEP9zfVPgZ24LEbtJjtoFlFCGm6po9RS1M2Teq8lag2ihPyhYcOnbYXE\\nl+0pVDfzLGPXzm4NxJuw07DRL6jzlycYsQIDAQAB\\n-----END RSA PUBLIC KEY-----\\n","private":"-----BEGIN RSA PRIVATE KEY-----\\nProc-Type: 4,ENCRYPTED\\nDEK-Info: AES-256-CBC,81AD5EFFAAE12C9D07EC5D386C38E605\\n\\nzt3oXrB9x4l8MOtA+k+t1+S53HpRZ0v5wiVOENbgxlOETap6PXz3MrK6pUoyOQ10\\n1ZEiWVLgZs6H3dpeox3kbGkREJLtsqCqihOfFLFXfrnYKehzA3LJj9C/S8qOaU9w\\nCct7+OFYAaqelrECDPsra6dDQl/vKOnfnnlDZp8p1QSrt+kVolEQTFrjUofC05Nk\\n+53dIzFxkzUWMKQbAYvjdldyH0Ly17g13Pxr1/grcSK79WRIpUEjlsBLgf+oJnQP\\nPrCDp4MU3F+0xBEEKWAjjYeHoiK1/IK1U0dN2MYBzRCF3trM1JxwiLH59kzcm1gw\\nh9igW8rNFJZWH68mPVJUrLL5rYawLMHKR+W7+jaR++lJKzB9XRDYSsS8zqLKnhB8\\n5r2eOCWIYUivvNgFm9n8FcFM7L5SzXx/WGnpwzADJ07g50zxyBa/Kl2b3ySdtiam\\n+wGXHYtSLgrSgXvu7ILFd1ySR9p9loW6U5xx7i6ZFqnYnX0UDxNLkCIO/BgefzEv\\nIRweLjdV1t6N/SSGagYG51IoSyd0CS3EFdvXbrbIWUD1onBoVn9w+jdBp5jeHY82\\nBGBgT5Dt4oDdhTr9hWJ5/PaYbX6rLuH620cXHN4vMG4r9Dwxf38+PKV01CBvMPFw\\nW6az43fkovRrdMeXD/3ym/Cr4nI7/exYYcLC0CuEOV0vEhC8+URKi4BOHPcZj5Tp\\nmwJ7gmvmDwHQwL+G31ptIfP77zuq2LFfqmqnfehyiprx3oqFak0oyL/JBV/u7m4H\\nc9kNSW1h9OaW218glKtQ9XM0t5Ur5uPM21mdInvCihE30IfJ9fFKbLrs9Dt0XsUN\\n5nOo5F7LnE1/9pzTcSMt0vOTA7NtG6pj/B14b3R4ZjZzolpqWaak2g+fysAGaCqN\\nJ7qaCR2m9eMiaqw7bTalp/5CE5WynQYyzjLr4Mh89P0VrUyb7q/iWr4cbllx7LwO\\n4cQhx4H62HA2tpRLhb3fbScqqzaU4v7XNDN3C8+2ak9nvlqbQr1c0jdyDVaXPO/W\\nG5l9N+tUTGZDz5Yrt0wamsOxzI/4p5S+qENOcjRTZlY/1YXpO4dnhOkmvHwzsdjO\\nIEfGALm4loajB8IUaMELMxIui8VZIB68AEv2OXIIe2ea9HRUPnYw426lv4/5gJ2T\\nJh4LzOenq19QZzMY9T83zg0O9j7tiwf3sLBiDICyeeVRW5fA0ria/UDnvQzWqNit\\nWpxUUeU8eAjEcJGztBKll8kkzIZsFfPRbqB2jcjrgq50SHcqG934k4CIDFSkDiHV\\naf5j7jIn6b0c/VUz/bPkvXDDiJMXiqTlA8rm0BvCxQ4DV52PmCVZhFnB618Naaek\\niT8RPrihdIb8Zb/bPTttdPcXBeESRzmSZN1mzgil5F58zfk1A4GU1FDWVLN0fftr\\nEPCWbBOexSFYIlyB+ZdtOt2zO3P98SH52cRp5wFKem1i39c//DKddgDz4LFQXyQw\\nF8zvB+12ny/lWRMeMp/o6ckId6n1dhleH5twLb9VoNT+DDjcORDvhCaBmF495GVm\\nOe8VZyZdW54IAjkDZObDrClxilMjHiaSO7O+XiGiGXannmsBwJLVmycdTKdYY+lG\\n-----END RSA PRIVATE KEY-----\\n"}	2026-03-08T13:42:15.929Z
company	{"v":""}	2026-03-08T13:42:15.964Z
features	{"featurePageRatings":true,"featurePageComments":true,"featurePersonalWikis":true}	2026-03-08T13:42:15.968Z
graphEndpoint	{"v":"https://graph.requarks.io"}	2026-03-08T13:42:15.971Z
host	{"v":"https://wiki.yourdomain.com"}	2026-03-08T13:42:15.972Z
logo	{"hasLogo":false,"logoIsSquare":false}	2026-03-08T13:42:15.981Z
mail	{"senderName":"","senderEmail":"","host":"","port":465,"name":"","secure":true,"verifySSL":true,"user":"","pass":"","useDKIM":false,"dkimDomainName":"","dkimKeySelector":"","dkimPrivateKey":""}	2026-03-08T13:42:15.985Z
seo	{"description":"","robots":["index","follow"],"analyticsService":"","analyticsId":""}	2026-03-08T13:42:15.987Z
sessionSecret	{"v":"6ee360ac4f5abc0b2547217c4b6e83b37a3f0d7d0644dfb78497f91a24065077"}	2026-03-08T13:42:15.997Z
telemetry	{"isEnabled":true,"clientId":"29d46337-8e1f-447b-a732-b2dced4aee4a"}	2026-03-08T13:42:15.998Z
theming	{"theme":"default","darkMode":false,"iconset":"mdi","injectCSS":"","injectHead":"","injectBody":""}	2026-03-08T13:42:16.017Z
uploads	{"maxFileSize":5242880,"maxFiles":10,"scanSVG":true,"forceDownload":true}	2026-03-08T13:42:16.022Z
title	{"v":"Wiki.js"}	2026-03-08T13:42:16.025Z
api	{"isEnabled":true}	2026-03-08T13:47:16.410Z
lang	{"code":"en","autoUpdate":true,"namespacing":false,"namespaces":["fr","en"],"rtl":false}	2026-03-08T15:11:29.681Z
nav	{"mode":"TREE"}	2026-03-08T15:30:13.220Z
\.


--
-- Data for Name: storage; Type: TABLE DATA; Schema: public; Owner: wikijs
--

COPY public.storage (key, "isEnabled", mode, config, "syncInterval", state) FROM stdin;
azure	f	push	{"accountName":"","accountKey":"","containerName":"wiki","storageTier":"Cool"}	P0D	{"status":"pending","message":"","lastAttempt":null}
box	f	push	{"clientId":"","clientSecret":"","rootFolder":""}	P0D	{"status":"pending","message":"","lastAttempt":null}
digitalocean	f	push	{"endpoint":"nyc3.digitaloceanspaces.com","bucket":"","accessKeyId":"","secretAccessKey":""}	P0D	{"status":"pending","message":"","lastAttempt":null}
disk	f	push	{"path":"","createDailyBackups":false}	P0D	{"status":"pending","message":"","lastAttempt":null}
dropbox	f	push	{"appKey":"","appSecret":""}	P0D	{"status":"pending","message":"","lastAttempt":null}
gdrive	f	push	{"clientId":"","clientSecret":""}	P0D	{"status":"pending","message":"","lastAttempt":null}
git	f	sync	{"authType":"ssh","repoUrl":"","branch":"master","sshPrivateKeyMode":"path","sshPrivateKeyPath":"","sshPrivateKeyContent":"","verifySSL":true,"basicUsername":"","basicPassword":"","defaultEmail":"name@company.com","defaultName":"John Smith","localRepoPath":"./data/repo","alwaysNamespace":false,"gitBinaryPath":""}	PT5M	{"status":"pending","message":"","lastAttempt":null}
onedrive	f	push	{"clientId":"","clientSecret":""}	P0D	{"status":"pending","message":"","lastAttempt":null}
s3	f	push	{"region":"","bucket":"","accessKeyId":"","secretAccessKey":""}	P0D	{"status":"pending","message":"","lastAttempt":null}
s3generic	f	push	{"endpoint":"https://service.region.example.com","bucket":"","accessKeyId":"","secretAccessKey":"","sslEnabled":true,"s3ForcePathStyle":false,"s3BucketEndpoint":false}	P0D	{"status":"pending","message":"","lastAttempt":null}
sftp	f	push	{"host":"","port":22,"authMode":"privateKey","username":"","privateKey":"","passphrase":"","password":"","basePath":"/root/wiki"}	P0D	{"status":"pending","message":"","lastAttempt":null}
\.


--
-- Data for Name: tags; Type: TABLE DATA; Schema: public; Owner: wikijs
--

COPY public.tags (id, tag, title, "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: userAvatars; Type: TABLE DATA; Schema: public; Owner: wikijs
--

COPY public."userAvatars" (id, data) FROM stdin;
\.


--
-- Data for Name: userGroups; Type: TABLE DATA; Schema: public; Owner: wikijs
--

COPY public."userGroups" (id, "userId", "groupId") FROM stdin;
1	1	1
2	2	2
\.


--
-- Data for Name: userKeys; Type: TABLE DATA; Schema: public; Owner: wikijs
--

COPY public."userKeys" (id, kind, token, "createdAt", "validUntil", "userId") FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: wikijs
--

COPY public.users (id, email, name, "providerId", password, "tfaIsActive", "tfaSecret", "jobTitle", location, "pictureUrl", timezone, "isSystem", "isActive", "isVerified", "mustChangePwd", "createdAt", "updatedAt", "providerKey", "localeCode", "defaultEditor", "lastLoginAt", "dateFormat", appearance) FROM stdin;
2	guest@example.com	Guest	\N		f	\N			\N	America/New_York	t	t	t	f	2026-03-08T13:42:16.558Z	2026-03-08T13:42:16.558Z	local	en	markdown	\N		
1	eleves@eleve.edu.com	Administrator	\N	$2a$12$zkXFy9xztz32rZaMZz/ttuXccPS4nRZHTfeqXi.cjK62CURpFIUti	f	\N			\N	America/New_York	f	t	t	f	2026-03-08T13:42:16.325Z	2026-03-08T13:42:16.325Z	local	en	markdown	2026-03-09T14:49:09.896Z		
\.


--
-- Name: apiKeys_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wikijs
--

SELECT pg_catalog.setval('public."apiKeys_id_seq"', 4, true);


--
-- Name: assetFolders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wikijs
--

SELECT pg_catalog.setval('public."assetFolders_id_seq"', 1, false);


--
-- Name: assets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wikijs
--

SELECT pg_catalog.setval('public.assets_id_seq', 1, false);


--
-- Name: comments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wikijs
--

SELECT pg_catalog.setval('public.comments_id_seq', 1, false);


--
-- Name: groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wikijs
--

SELECT pg_catalog.setval('public.groups_id_seq', 2, true);


--
-- Name: migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wikijs
--

SELECT pg_catalog.setval('public.migrations_id_seq', 16, true);


--
-- Name: migrations_lock_index_seq; Type: SEQUENCE SET; Schema: public; Owner: wikijs
--

SELECT pg_catalog.setval('public.migrations_lock_index_seq', 1, true);


--
-- Name: pageHistoryTags_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wikijs
--

SELECT pg_catalog.setval('public."pageHistoryTags_id_seq"', 1, false);


--
-- Name: pageHistory_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wikijs
--

SELECT pg_catalog.setval('public."pageHistory_id_seq"', 18, true);


--
-- Name: pageLinks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wikijs
--

SELECT pg_catalog.setval('public."pageLinks_id_seq"', 1, true);


--
-- Name: pageTags_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wikijs
--

SELECT pg_catalog.setval('public."pageTags_id_seq"', 1, false);


--
-- Name: pages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wikijs
--

SELECT pg_catalog.setval('public.pages_id_seq', 31, true);


--
-- Name: tags_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wikijs
--

SELECT pg_catalog.setval('public.tags_id_seq', 1, false);


--
-- Name: userGroups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wikijs
--

SELECT pg_catalog.setval('public."userGroups_id_seq"', 2, true);


--
-- Name: userKeys_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wikijs
--

SELECT pg_catalog.setval('public."userKeys_id_seq"', 1, false);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wikijs
--

SELECT pg_catalog.setval('public.users_id_seq', 2, true);


--
-- Name: analytics analytics_pkey; Type: CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.analytics
    ADD CONSTRAINT analytics_pkey PRIMARY KEY (key);


--
-- Name: apiKeys apiKeys_pkey; Type: CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."apiKeys"
    ADD CONSTRAINT "apiKeys_pkey" PRIMARY KEY (id);


--
-- Name: assetData assetData_pkey; Type: CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."assetData"
    ADD CONSTRAINT "assetData_pkey" PRIMARY KEY (id);


--
-- Name: assetFolders assetFolders_pkey; Type: CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."assetFolders"
    ADD CONSTRAINT "assetFolders_pkey" PRIMARY KEY (id);


--
-- Name: assets assets_pkey; Type: CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.assets
    ADD CONSTRAINT assets_pkey PRIMARY KEY (id);


--
-- Name: authentication authentication_pkey; Type: CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.authentication
    ADD CONSTRAINT authentication_pkey PRIMARY KEY (key);


--
-- Name: commentProviders commentProviders_pkey; Type: CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."commentProviders"
    ADD CONSTRAINT "commentProviders_pkey" PRIMARY KEY (key);


--
-- Name: comments comments_pkey; Type: CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_pkey PRIMARY KEY (id);


--
-- Name: editors editors_pkey; Type: CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.editors
    ADD CONSTRAINT editors_pkey PRIMARY KEY (key);


--
-- Name: groups groups_pkey; Type: CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.groups
    ADD CONSTRAINT groups_pkey PRIMARY KEY (id);


--
-- Name: locales locales_pkey; Type: CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.locales
    ADD CONSTRAINT locales_pkey PRIMARY KEY (code);


--
-- Name: loggers loggers_pkey; Type: CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.loggers
    ADD CONSTRAINT loggers_pkey PRIMARY KEY (key);


--
-- Name: migrations_lock migrations_lock_pkey; Type: CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.migrations_lock
    ADD CONSTRAINT migrations_lock_pkey PRIMARY KEY (index);


--
-- Name: migrations migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.migrations
    ADD CONSTRAINT migrations_pkey PRIMARY KEY (id);


--
-- Name: navigation navigation_pkey; Type: CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.navigation
    ADD CONSTRAINT navigation_pkey PRIMARY KEY (key);


--
-- Name: pageHistoryTags pageHistoryTags_pkey; Type: CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."pageHistoryTags"
    ADD CONSTRAINT "pageHistoryTags_pkey" PRIMARY KEY (id);


--
-- Name: pageHistory pageHistory_pkey; Type: CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."pageHistory"
    ADD CONSTRAINT "pageHistory_pkey" PRIMARY KEY (id);


--
-- Name: pageLinks pageLinks_pkey; Type: CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."pageLinks"
    ADD CONSTRAINT "pageLinks_pkey" PRIMARY KEY (id);


--
-- Name: pageTags pageTags_pkey; Type: CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."pageTags"
    ADD CONSTRAINT "pageTags_pkey" PRIMARY KEY (id);


--
-- Name: pageTree pageTree_pkey; Type: CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."pageTree"
    ADD CONSTRAINT "pageTree_pkey" PRIMARY KEY (id);


--
-- Name: pages pages_pkey; Type: CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.pages
    ADD CONSTRAINT pages_pkey PRIMARY KEY (id);


--
-- Name: renderers renderers_pkey; Type: CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.renderers
    ADD CONSTRAINT renderers_pkey PRIMARY KEY (key);


--
-- Name: searchEngines searchEngines_pkey; Type: CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."searchEngines"
    ADD CONSTRAINT "searchEngines_pkey" PRIMARY KEY (key);


--
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (sid);


--
-- Name: settings settings_pkey; Type: CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.settings
    ADD CONSTRAINT settings_pkey PRIMARY KEY (key);


--
-- Name: storage storage_pkey; Type: CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.storage
    ADD CONSTRAINT storage_pkey PRIMARY KEY (key);


--
-- Name: tags tags_pkey; Type: CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.tags
    ADD CONSTRAINT tags_pkey PRIMARY KEY (id);


--
-- Name: tags tags_tag_unique; Type: CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.tags
    ADD CONSTRAINT tags_tag_unique UNIQUE (tag);


--
-- Name: userAvatars userAvatars_pkey; Type: CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."userAvatars"
    ADD CONSTRAINT "userAvatars_pkey" PRIMARY KEY (id);


--
-- Name: userGroups userGroups_pkey; Type: CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."userGroups"
    ADD CONSTRAINT "userGroups_pkey" PRIMARY KEY (id);


--
-- Name: userKeys userKeys_pkey; Type: CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."userKeys"
    ADD CONSTRAINT "userKeys_pkey" PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: users users_providerkey_email_unique; Type: CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_providerkey_email_unique UNIQUE ("providerKey", email);


--
-- Name: pagelinks_path_localecode_index; Type: INDEX; Schema: public; Owner: wikijs
--

CREATE INDEX pagelinks_path_localecode_index ON public."pageLinks" USING btree (path, "localeCode");


--
-- Name: sessions_expired_index; Type: INDEX; Schema: public; Owner: wikijs
--

CREATE INDEX sessions_expired_index ON public.sessions USING btree (expired);


--
-- Name: assetFolders assetfolders_parentid_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."assetFolders"
    ADD CONSTRAINT assetfolders_parentid_foreign FOREIGN KEY ("parentId") REFERENCES public."assetFolders"(id);


--
-- Name: assets assets_authorid_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.assets
    ADD CONSTRAINT assets_authorid_foreign FOREIGN KEY ("authorId") REFERENCES public.users(id);


--
-- Name: assets assets_folderid_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.assets
    ADD CONSTRAINT assets_folderid_foreign FOREIGN KEY ("folderId") REFERENCES public."assetFolders"(id);


--
-- Name: comments comments_authorid_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_authorid_foreign FOREIGN KEY ("authorId") REFERENCES public.users(id);


--
-- Name: comments comments_pageid_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_pageid_foreign FOREIGN KEY ("pageId") REFERENCES public.pages(id);


--
-- Name: pageHistory pagehistory_authorid_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."pageHistory"
    ADD CONSTRAINT pagehistory_authorid_foreign FOREIGN KEY ("authorId") REFERENCES public.users(id);


--
-- Name: pageHistory pagehistory_editorkey_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."pageHistory"
    ADD CONSTRAINT pagehistory_editorkey_foreign FOREIGN KEY ("editorKey") REFERENCES public.editors(key);


--
-- Name: pageHistory pagehistory_localecode_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."pageHistory"
    ADD CONSTRAINT pagehistory_localecode_foreign FOREIGN KEY ("localeCode") REFERENCES public.locales(code);


--
-- Name: pageHistoryTags pagehistorytags_pageid_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."pageHistoryTags"
    ADD CONSTRAINT pagehistorytags_pageid_foreign FOREIGN KEY ("pageId") REFERENCES public."pageHistory"(id) ON DELETE CASCADE;


--
-- Name: pageHistoryTags pagehistorytags_tagid_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."pageHistoryTags"
    ADD CONSTRAINT pagehistorytags_tagid_foreign FOREIGN KEY ("tagId") REFERENCES public.tags(id) ON DELETE CASCADE;


--
-- Name: pageLinks pagelinks_pageid_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."pageLinks"
    ADD CONSTRAINT pagelinks_pageid_foreign FOREIGN KEY ("pageId") REFERENCES public.pages(id) ON DELETE CASCADE;


--
-- Name: pages pages_authorid_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.pages
    ADD CONSTRAINT pages_authorid_foreign FOREIGN KEY ("authorId") REFERENCES public.users(id);


--
-- Name: pages pages_creatorid_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.pages
    ADD CONSTRAINT pages_creatorid_foreign FOREIGN KEY ("creatorId") REFERENCES public.users(id);


--
-- Name: pages pages_editorkey_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.pages
    ADD CONSTRAINT pages_editorkey_foreign FOREIGN KEY ("editorKey") REFERENCES public.editors(key);


--
-- Name: pages pages_localecode_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.pages
    ADD CONSTRAINT pages_localecode_foreign FOREIGN KEY ("localeCode") REFERENCES public.locales(code);


--
-- Name: pageTags pagetags_pageid_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."pageTags"
    ADD CONSTRAINT pagetags_pageid_foreign FOREIGN KEY ("pageId") REFERENCES public.pages(id) ON DELETE CASCADE;


--
-- Name: pageTags pagetags_tagid_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."pageTags"
    ADD CONSTRAINT pagetags_tagid_foreign FOREIGN KEY ("tagId") REFERENCES public.tags(id) ON DELETE CASCADE;


--
-- Name: pageTree pagetree_localecode_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."pageTree"
    ADD CONSTRAINT pagetree_localecode_foreign FOREIGN KEY ("localeCode") REFERENCES public.locales(code);


--
-- Name: pageTree pagetree_pageid_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."pageTree"
    ADD CONSTRAINT pagetree_pageid_foreign FOREIGN KEY ("pageId") REFERENCES public.pages(id) ON DELETE CASCADE;


--
-- Name: pageTree pagetree_parent_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."pageTree"
    ADD CONSTRAINT pagetree_parent_foreign FOREIGN KEY (parent) REFERENCES public."pageTree"(id) ON DELETE CASCADE;


--
-- Name: userGroups usergroups_groupid_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."userGroups"
    ADD CONSTRAINT usergroups_groupid_foreign FOREIGN KEY ("groupId") REFERENCES public.groups(id) ON DELETE CASCADE;


--
-- Name: userGroups usergroups_userid_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."userGroups"
    ADD CONSTRAINT usergroups_userid_foreign FOREIGN KEY ("userId") REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: userKeys userkeys_userid_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public."userKeys"
    ADD CONSTRAINT userkeys_userid_foreign FOREIGN KEY ("userId") REFERENCES public.users(id);


--
-- Name: users users_defaulteditor_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_defaulteditor_foreign FOREIGN KEY ("defaultEditor") REFERENCES public.editors(key);


--
-- Name: users users_localecode_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_localecode_foreign FOREIGN KEY ("localeCode") REFERENCES public.locales(code);


--
-- Name: users users_providerkey_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wikijs
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_providerkey_foreign FOREIGN KEY ("providerKey") REFERENCES public.authentication(key);


--
-- PostgreSQL database dump complete
--

\unrestrict RDdcpJf4ngJxHo6ZXdZaJ5RysLsyvGr6OXRRSCdfJrcifkTpBfEJDalVgKD1KZ0

