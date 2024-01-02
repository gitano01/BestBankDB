--
-- PostgreSQL database dump
--

-- Dumped from database version 10.23
-- Dumped by pg_dump version 10.23

-- Started on 2024-01-02 12:49:06

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

--
-- TOC entry 232 (class 1255 OID 25129)
-- Name: addtarjeta(character varying, character varying, character varying, character varying, character varying, character varying, double precision, timestamp with time zone, character varying, boolean, timestamp with time zone, integer, integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.addtarjeta(num_tarj character varying, mes_exp character varying, "año_exp" character varying, cvv character varying, nip character varying, tipo_tarj character varying, balance double precision, fecha_alt timestamp with time zone, status_tarj character varying, tarj_activa boolean, fecha_act timestamp with time zone, cuentaid integer, clienteid integer, invid integer) RETURNS character varying
    LANGUAGE plpgsql
    AS $_$
DECLARE 
    query text;
BEGIN
    query := 'INSERT INTO tarjetas_clientes(numero_tarjeta, mes_expiracion, año_expiracion, cvv, nip, tipo_tarjeta, balance, estatus_tarjeta, tarjeta_activa, fecha_activacion, fecha_alta, cuenta_id, cliente_id, inventario_tarjeta_id, tarjeta_migrada, tarjeta_cancelada, bloqueo_temporal, bloqueo_permanente) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, false, false, false, false)';
    
    RAISE NOTICE '%', query;
    
    EXECUTE query USING 
        num_tarj, mes_exp, año_exp, cvv, nip, tipo_tarj, balance, status_tarj, tarj_activa, fecha_act, fecha_alt, cuentaid, clienteid, invid; 
    --    CASE WHEN cuentaid = 0 THEN null ELSE cuentaid END,
     --   CASE WHEN clienteid = 0 THEN null ELSE clienteid END;

    RETURN 'OK';
EXCEPTION 
    WHEN others THEN
        RAISE EXCEPTION '% | %', SQLSTATE, SQLERRM;
END	
$_$;


ALTER FUNCTION public.addtarjeta(num_tarj character varying, mes_exp character varying, "año_exp" character varying, cvv character varying, nip character varying, tipo_tarj character varying, balance double precision, fecha_alt timestamp with time zone, status_tarj character varying, tarj_activa boolean, fecha_act timestamp with time zone, cuentaid integer, clienteid integer, invid integer) OWNER TO postgres;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 217 (class 1259 OID 33418)
-- Name: catalogo_plazas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.catalogo_plazas (
    plaza_id integer NOT NULL,
    codigo_plaza character varying NOT NULL,
    poblacion character varying NOT NULL
);


ALTER TABLE public.catalogo_plazas OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 33416)
-- Name: catalogo_plazas_plaza_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.catalogo_plazas_plaza_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.catalogo_plazas_plaza_id_seq OWNER TO postgres;

--
-- TOC entry 2958 (class 0 OID 0)
-- Dependencies: 216
-- Name: catalogo_plazas_plaza_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.catalogo_plazas_plaza_id_seq OWNED BY public.catalogo_plazas.plaza_id;


--
-- TOC entry 201 (class 1259 OID 18295)
-- Name: clientes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.clientes (
    cliente_id integer NOT NULL,
    nombre character varying(50) NOT NULL,
    apellido_paterno character varying(50) NOT NULL,
    apellido_materno character varying(50) NOT NULL,
    direccion character varying(100) NOT NULL,
    telefono character varying(10),
    colonia character varying(50) NOT NULL,
    codigo_postal character varying(5) NOT NULL,
    ciudad character varying(50) NOT NULL,
    estado character varying(50) NOT NULL,
    email character varying(50),
    estatus character varying(50),
    activo boolean,
    sucursal_id smallint,
    empleado_id smallint,
    fecha_alta timestamp with time zone NOT NULL,
    fecha_baja timestamp with time zone
);


ALTER TABLE public.clientes OWNER TO postgres;

--
-- TOC entry 200 (class 1259 OID 18293)
-- Name: cliente_cliente_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cliente_cliente_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cliente_cliente_id_seq OWNER TO postgres;

--
-- TOC entry 2959 (class 0 OID 0)
-- Dependencies: 200
-- Name: cliente_cliente_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cliente_cliente_id_seq OWNED BY public.clientes.cliente_id;


--
-- TOC entry 207 (class 1259 OID 24646)
-- Name: cuentas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cuentas (
    cuenta_id integer NOT NULL,
    fecha_apertura timestamp with time zone NOT NULL,
    fecha_cierre timestamp with time zone,
    numero_cuenta character varying(50) NOT NULL,
    clabe character varying(20) NOT NULL,
    tipo_cuenta character varying(50) NOT NULL,
    saldo_inicial numeric NOT NULL,
    saldo_maximo numeric NOT NULL,
    saldo_anterior numeric NOT NULL,
    balance numeric NOT NULL,
    activo boolean,
    estatus_cuenta character varying(50),
    cliente_id smallint
);


ALTER TABLE public.cuentas OWNER TO postgres;

--
-- TOC entry 206 (class 1259 OID 24644)
-- Name: cuenta_cuenta_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cuenta_cuenta_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cuenta_cuenta_id_seq OWNER TO postgres;

--
-- TOC entry 2960 (class 0 OID 0)
-- Dependencies: 206
-- Name: cuenta_cuenta_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cuenta_cuenta_id_seq OWNED BY public.cuentas.cuenta_id;


--
-- TOC entry 199 (class 1259 OID 18279)
-- Name: empleados; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.empleados (
    empleado_id integer NOT NULL,
    nombre character varying(50) NOT NULL,
    apellido_paterno character varying(50) NOT NULL,
    apellido_materno character varying(50) NOT NULL,
    telefono character varying(10),
    direccion character varying(100),
    colonia character varying(100),
    ciudad character varying(100),
    estado character varying(100),
    codigo_postal character varying(10),
    departamento character varying(50),
    email character varying(50),
    activo boolean,
    fecha_alta timestamp with time zone NOT NULL,
    fecha_baja timestamp with time zone,
    sucursal_id smallint
);


ALTER TABLE public.empleados OWNER TO postgres;

--
-- TOC entry 198 (class 1259 OID 18277)
-- Name: empleado_empleado_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.empleado_empleado_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.empleado_empleado_id_seq OWNER TO postgres;

--
-- TOC entry 2961 (class 0 OID 0)
-- Dependencies: 198
-- Name: empleado_empleado_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.empleado_empleado_id_seq OWNED BY public.empleados.empleado_id;


--
-- TOC entry 219 (class 1259 OID 33435)
-- Name: entidades_financieras; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.entidades_financieras (
    entidad_id integer NOT NULL,
    numero_abm character varying NOT NULL,
    nombre_abreviado character varying NOT NULL,
    nombre_institucion character varying
);


ALTER TABLE public.entidades_financieras OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 33433)
-- Name: entidades_financieras_entidad_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.entidades_financieras_entidad_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.entidades_financieras_entidad_id_seq OWNER TO postgres;

--
-- TOC entry 2962 (class 0 OID 0)
-- Dependencies: 218
-- Name: entidades_financieras_entidad_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.entidades_financieras_entidad_id_seq OWNED BY public.entidades_financieras.entidad_id;


--
-- TOC entry 209 (class 1259 OID 24988)
-- Name: inventario_tarjetas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.inventario_tarjetas (
    inventario_tarjeta_id integer NOT NULL,
    numero_tarjeta character varying(16) NOT NULL,
    mes_expiracion character varying(2) NOT NULL,
    "año_expiracion" character varying(2) NOT NULL,
    cvv character varying(3) NOT NULL,
    nip character varying(4),
    tarjeta_asignada boolean,
    "tarjeta_dañada" boolean,
    proveedor character varying(50),
    fecha_recepcion timestamp with time zone,
    fecha_modificacion timestamp with time zone,
    fecha_asignacion timestamp with time zone,
    fecha_baja timestamp with time zone,
    sucursal_id smallint
);


ALTER TABLE public.inventario_tarjetas OWNER TO postgres;

--
-- TOC entry 208 (class 1259 OID 24986)
-- Name: inventario_tarjetas_inventario_tarjeta_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.inventario_tarjetas_inventario_tarjeta_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.inventario_tarjetas_inventario_tarjeta_id_seq OWNER TO postgres;

--
-- TOC entry 2963 (class 0 OID 0)
-- Dependencies: 208
-- Name: inventario_tarjetas_inventario_tarjeta_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.inventario_tarjetas_inventario_tarjeta_id_seq OWNED BY public.inventario_tarjetas.inventario_tarjeta_id;


--
-- TOC entry 215 (class 1259 OID 25176)
-- Name: movimientos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.movimientos (
    movimiento_id integer NOT NULL,
    fecha_movimiento timestamp with time zone NOT NULL,
    descripcion character varying(100) NOT NULL,
    balance numeric,
    tipo_movimiento character varying(100) NOT NULL,
    saldo_anterior numeric,
    tarjeta_id smallint,
    cuenta_id smallint,
    usuario_id smallint,
    sucursal_id smallint,
    cliente_id smallint
);


ALTER TABLE public.movimientos OWNER TO postgres;

--
-- TOC entry 214 (class 1259 OID 25174)
-- Name: movimientos_movimiento_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.movimientos_movimiento_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.movimientos_movimiento_id_seq OWNER TO postgres;

--
-- TOC entry 2964 (class 0 OID 0)
-- Dependencies: 214
-- Name: movimientos_movimiento_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.movimientos_movimiento_id_seq OWNED BY public.movimientos.movimiento_id;


--
-- TOC entry 205 (class 1259 OID 18324)
-- Name: permisos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.permisos (
    permiso_id integer NOT NULL,
    permiso character varying(50) NOT NULL,
    descripcion character varying(100) NOT NULL
);


ALTER TABLE public.permisos OWNER TO postgres;

--
-- TOC entry 204 (class 1259 OID 18322)
-- Name: permisos_permiso_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.permisos_permiso_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.permisos_permiso_id_seq OWNER TO postgres;

--
-- TOC entry 2965 (class 0 OID 0)
-- Dependencies: 204
-- Name: permisos_permiso_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.permisos_permiso_id_seq OWNED BY public.permisos.permiso_id;


--
-- TOC entry 203 (class 1259 OID 18316)
-- Name: roles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.roles (
    rol_id integer NOT NULL,
    rol character varying(50) NOT NULL,
    descripcion character varying(100) NOT NULL
);


ALTER TABLE public.roles OWNER TO postgres;

--
-- TOC entry 202 (class 1259 OID 18314)
-- Name: roles_rol_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.roles_rol_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.roles_rol_id_seq OWNER TO postgres;

--
-- TOC entry 2966 (class 0 OID 0)
-- Dependencies: 202
-- Name: roles_rol_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.roles_rol_id_seq OWNED BY public.roles.rol_id;


--
-- TOC entry 197 (class 1259 OID 18271)
-- Name: sucursales; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sucursales (
    sucursal_id integer NOT NULL,
    nombre character varying(50) NOT NULL,
    numero_sucursal character varying(4) NOT NULL,
    direccion character varying(100) NOT NULL,
    telefono character varying(10) NOT NULL,
    ciudad character varying(50) NOT NULL,
    estado character varying(50) NOT NULL,
    fecha_apertura timestamp with time zone NOT NULL,
    fecha_cierre timestamp with time zone,
    plaza_id smallint
);


ALTER TABLE public.sucursales OWNER TO postgres;

--
-- TOC entry 196 (class 1259 OID 18269)
-- Name: sucursal_sucursal_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sucursal_sucursal_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sucursal_sucursal_id_seq OWNER TO postgres;

--
-- TOC entry 2967 (class 0 OID 0)
-- Dependencies: 196
-- Name: sucursal_sucursal_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sucursal_sucursal_id_seq OWNED BY public.sucursales.sucursal_id;


--
-- TOC entry 211 (class 1259 OID 25102)
-- Name: tarjetas_clientes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tarjetas_clientes (
    tarjeta_cliente_id integer NOT NULL,
    mes_expiracion character varying(2) NOT NULL,
    "año_expiracion" character varying(2) NOT NULL,
    cvv character varying(3) NOT NULL,
    nip character varying(4),
    balance numeric NOT NULL,
    numero_tarjeta character varying(16) NOT NULL,
    tipo_tarjeta character varying(50) NOT NULL,
    estatus_tarjeta character varying(25),
    tarjeta_activa boolean,
    tarjeta_cancelada boolean,
    tarjeta_migrada boolean,
    bloqueo_temporal boolean,
    bloqueo_permanente boolean,
    fecha_alta timestamp with time zone,
    fecha_modificacion timestamp with time zone,
    fecha_activacion timestamp with time zone,
    fecha_cancelacion timestamp with time zone,
    fecha_migrado timestamp with time zone,
    fecha_bloqueo timestamp with time zone,
    cuenta_id smallint NOT NULL,
    cliente_id smallint NOT NULL,
    inventario_tarjeta_id smallint NOT NULL
);


ALTER TABLE public.tarjetas_clientes OWNER TO postgres;

--
-- TOC entry 210 (class 1259 OID 25100)
-- Name: tarjeta_cliente_tarjeta_cliente_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tarjeta_cliente_tarjeta_cliente_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tarjeta_cliente_tarjeta_cliente_id_seq OWNER TO postgres;

--
-- TOC entry 2968 (class 0 OID 0)
-- Dependencies: 210
-- Name: tarjeta_cliente_tarjeta_cliente_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tarjeta_cliente_tarjeta_cliente_id_seq OWNED BY public.tarjetas_clientes.tarjeta_cliente_id;


--
-- TOC entry 213 (class 1259 OID 25132)
-- Name: usuarios; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.usuarios (
    usuario_id integer NOT NULL,
    usuario character varying(25) NOT NULL,
    contrasenia character(32) NOT NULL,
    email character varying(50) NOT NULL,
    activo boolean,
    rol_id smallint,
    permiso_id smallint,
    empleado_id smallint,
    fecha_alta timestamp with time zone NOT NULL,
    fecha_baja timestamp with time zone,
    fecha_modificacion timestamp with time zone,
    cliente_id smallint
);


ALTER TABLE public.usuarios OWNER TO postgres;

--
-- TOC entry 212 (class 1259 OID 25130)
-- Name: usuarios_usuario_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.usuarios_usuario_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.usuarios_usuario_id_seq OWNER TO postgres;

--
-- TOC entry 2969 (class 0 OID 0)
-- Dependencies: 212
-- Name: usuarios_usuario_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.usuarios_usuario_id_seq OWNED BY public.usuarios.usuario_id;


--
-- TOC entry 2754 (class 2604 OID 33421)
-- Name: catalogo_plazas plaza_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.catalogo_plazas ALTER COLUMN plaza_id SET DEFAULT nextval('public.catalogo_plazas_plaza_id_seq'::regclass);


--
-- TOC entry 2746 (class 2604 OID 18298)
-- Name: clientes cliente_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clientes ALTER COLUMN cliente_id SET DEFAULT nextval('public.cliente_cliente_id_seq'::regclass);


--
-- TOC entry 2749 (class 2604 OID 24649)
-- Name: cuentas cuenta_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cuentas ALTER COLUMN cuenta_id SET DEFAULT nextval('public.cuenta_cuenta_id_seq'::regclass);


--
-- TOC entry 2745 (class 2604 OID 18282)
-- Name: empleados empleado_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.empleados ALTER COLUMN empleado_id SET DEFAULT nextval('public.empleado_empleado_id_seq'::regclass);


--
-- TOC entry 2755 (class 2604 OID 33438)
-- Name: entidades_financieras entidad_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.entidades_financieras ALTER COLUMN entidad_id SET DEFAULT nextval('public.entidades_financieras_entidad_id_seq'::regclass);


--
-- TOC entry 2750 (class 2604 OID 24991)
-- Name: inventario_tarjetas inventario_tarjeta_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inventario_tarjetas ALTER COLUMN inventario_tarjeta_id SET DEFAULT nextval('public.inventario_tarjetas_inventario_tarjeta_id_seq'::regclass);


--
-- TOC entry 2753 (class 2604 OID 25179)
-- Name: movimientos movimiento_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.movimientos ALTER COLUMN movimiento_id SET DEFAULT nextval('public.movimientos_movimiento_id_seq'::regclass);


--
-- TOC entry 2748 (class 2604 OID 18327)
-- Name: permisos permiso_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.permisos ALTER COLUMN permiso_id SET DEFAULT nextval('public.permisos_permiso_id_seq'::regclass);


--
-- TOC entry 2747 (class 2604 OID 18319)
-- Name: roles rol_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles ALTER COLUMN rol_id SET DEFAULT nextval('public.roles_rol_id_seq'::regclass);


--
-- TOC entry 2744 (class 2604 OID 18274)
-- Name: sucursales sucursal_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sucursales ALTER COLUMN sucursal_id SET DEFAULT nextval('public.sucursal_sucursal_id_seq'::regclass);


--
-- TOC entry 2751 (class 2604 OID 25105)
-- Name: tarjetas_clientes tarjeta_cliente_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tarjetas_clientes ALTER COLUMN tarjeta_cliente_id SET DEFAULT nextval('public.tarjeta_cliente_tarjeta_cliente_id_seq'::regclass);


--
-- TOC entry 2752 (class 2604 OID 25135)
-- Name: usuarios usuario_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios ALTER COLUMN usuario_id SET DEFAULT nextval('public.usuarios_usuario_id_seq'::regclass);


--
-- TOC entry 2948 (class 0 OID 33418)
-- Dependencies: 217
-- Data for Name: catalogo_plazas; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.catalogo_plazas VALUES (1, '010', 'Aguascalientes');
INSERT INTO public.catalogo_plazas VALUES (2, '012', 'Calvillo');
INSERT INTO public.catalogo_plazas VALUES (3, '014', 'Jesús María');
INSERT INTO public.catalogo_plazas VALUES (4, '020', 'Mexicali');
INSERT INTO public.catalogo_plazas VALUES (5, '022', 'Ensenada');
INSERT INTO public.catalogo_plazas VALUES (6, '027', 'Tecate');
INSERT INTO public.catalogo_plazas VALUES (7, '027', 'Tijuana');
INSERT INTO public.catalogo_plazas VALUES (8, '028', 'La Mesa');
INSERT INTO public.catalogo_plazas VALUES (9, '028', 'Rosarito');
INSERT INTO public.catalogo_plazas VALUES (10, '028', 'Tijuana');
INSERT INTO public.catalogo_plazas VALUES (11, '040', 'La Paz');
INSERT INTO public.catalogo_plazas VALUES (12, '041', 'Cabo San Lucas');
INSERT INTO public.catalogo_plazas VALUES (13, '042', 'Ciudad Constitución');
INSERT INTO public.catalogo_plazas VALUES (14, '043', 'Guerrero Negro');
INSERT INTO public.catalogo_plazas VALUES (15, '045', 'San José del Cabo');
INSERT INTO public.catalogo_plazas VALUES (16, '046', 'Santa Rosalía');
INSERT INTO public.catalogo_plazas VALUES (17, '050', 'Campeche');
INSERT INTO public.catalogo_plazas VALUES (18, '051', 'Calkiní');
INSERT INTO public.catalogo_plazas VALUES (19, '052', 'Ciudad del Carmen');
INSERT INTO public.catalogo_plazas VALUES (20, '053', 'Champotón');
INSERT INTO public.catalogo_plazas VALUES (21, '060', 'Gómez Palacio');
INSERT INTO public.catalogo_plazas VALUES (22, '060', 'Torreón');
INSERT INTO public.catalogo_plazas VALUES (23, '062', 'Ciudad Acuña');
INSERT INTO public.catalogo_plazas VALUES (24, '068', 'Monclova');
INSERT INTO public.catalogo_plazas VALUES (25, '071', 'Nava');
INSERT INTO public.catalogo_plazas VALUES (26, '072', 'Nueva Rosita');
INSERT INTO public.catalogo_plazas VALUES (27, '074', 'Parras de la Fuente');
INSERT INTO public.catalogo_plazas VALUES (28, '075', 'Piedras Negras');
INSERT INTO public.catalogo_plazas VALUES (29, '076', 'Ramos Arizpe');
INSERT INTO public.catalogo_plazas VALUES (30, '077', 'Sabinas');
INSERT INTO public.catalogo_plazas VALUES (31, '078', 'Saltillo');
INSERT INTO public.catalogo_plazas VALUES (32, '080', 'San Pedro de las Colonias');
INSERT INTO public.catalogo_plazas VALUES (33, '090', 'Colima');
INSERT INTO public.catalogo_plazas VALUES (34, '095', 'Manzanillo');
INSERT INTO public.catalogo_plazas VALUES (35, '097', 'Tecomán');
INSERT INTO public.catalogo_plazas VALUES (36, '100', 'Terán');
INSERT INTO public.catalogo_plazas VALUES (37, '100', 'Tuxtla Gutiérrez');
INSERT INTO public.catalogo_plazas VALUES (38, '103', 'Arriaga');
INSERT INTO public.catalogo_plazas VALUES (39, '107', 'Cintalapa');
INSERT INTO public.catalogo_plazas VALUES (40, '109', 'Comitán');
INSERT INTO public.catalogo_plazas VALUES (41, '109', 'Villa Las Rosas');
INSERT INTO public.catalogo_plazas VALUES (42, '111', 'Chiapa de Corso');
INSERT INTO public.catalogo_plazas VALUES (43, '113', 'F. Comalapa');
INSERT INTO public.catalogo_plazas VALUES (44, '114', 'Huixtla');
INSERT INTO public.catalogo_plazas VALUES (45, '123', 'Ocosingo');
INSERT INTO public.catalogo_plazas VALUES (46, '124', 'Ocozocuautla');
INSERT INTO public.catalogo_plazas VALUES (47, '125', 'Palenque');
INSERT INTO public.catalogo_plazas VALUES (48, '126', 'Pichucalco');
INSERT INTO public.catalogo_plazas VALUES (49, '127', 'Pijijiapan');
INSERT INTO public.catalogo_plazas VALUES (50, '128', 'Reforma');
INSERT INTO public.catalogo_plazas VALUES (51, '130', 'San Cristóbal de las Casas');
INSERT INTO public.catalogo_plazas VALUES (52, '131', 'Simojovel');
INSERT INTO public.catalogo_plazas VALUES (53, '133', 'Tapachula');
INSERT INTO public.catalogo_plazas VALUES (54, '135', 'Tonala');
INSERT INTO public.catalogo_plazas VALUES (55, '137', 'Venustiano Carranza');
INSERT INTO public.catalogo_plazas VALUES (56, '138', 'Villa Flores');
INSERT INTO public.catalogo_plazas VALUES (57, '140', 'Yajalón');
INSERT INTO public.catalogo_plazas VALUES (58, '150', 'Chihuahua');
INSERT INTO public.catalogo_plazas VALUES (59, '150', 'Ciudad Delicias');
INSERT INTO public.catalogo_plazas VALUES (60, '152', 'Ciudad Anáhuac');
INSERT INTO public.catalogo_plazas VALUES (61, '155', 'Ciudad Camargo');
INSERT INTO public.catalogo_plazas VALUES (62, '158', 'Ciudad Cuauhtémoc');
INSERT INTO public.catalogo_plazas VALUES (63, '161', 'Ciudad Guerrero');
INSERT INTO public.catalogo_plazas VALUES (64, '162', 'Parral');
INSERT INTO public.catalogo_plazas VALUES (65, '163', 'Ciudad Jiménez');
INSERT INTO public.catalogo_plazas VALUES (66, '164', 'Ciudad Juárez');
INSERT INTO public.catalogo_plazas VALUES (67, '165', 'Ciudad Madera');
INSERT INTO public.catalogo_plazas VALUES (68, '167', 'El Molino de Namiquipa');
INSERT INTO public.catalogo_plazas VALUES (69, '168', 'Nuevo Casas Grandes');
INSERT INTO public.catalogo_plazas VALUES (70, '180', 'Atizapan');
INSERT INTO public.catalogo_plazas VALUES (71, '180', 'Chalco');
INSERT INTO public.catalogo_plazas VALUES (72, '180', 'Ciudad de México');
INSERT INTO public.catalogo_plazas VALUES (73, '180', 'Coacalco');
INSERT INTO public.catalogo_plazas VALUES (74, '180', 'Cuautitlán');
INSERT INTO public.catalogo_plazas VALUES (75, '180', 'Cuautitlán Izcalli');
INSERT INTO public.catalogo_plazas VALUES (76, '180', 'Ecatepec');
INSERT INTO public.catalogo_plazas VALUES (77, '180', 'Huehuetoca');
INSERT INTO public.catalogo_plazas VALUES (78, '180', 'Huixquilucan');
INSERT INTO public.catalogo_plazas VALUES (79, '180', 'Ixtapaluca');
INSERT INTO public.catalogo_plazas VALUES (80, '180', 'Los Reyes La Paz');
INSERT INTO public.catalogo_plazas VALUES (81, '180', 'Naucalpan');
INSERT INTO public.catalogo_plazas VALUES (82, '180', 'Nezahualcóyotl');
INSERT INTO public.catalogo_plazas VALUES (83, '180', 'Tecamac');
INSERT INTO public.catalogo_plazas VALUES (84, '180', 'Teotihuacán');
INSERT INTO public.catalogo_plazas VALUES (85, '180', 'Texcoco');
INSERT INTO public.catalogo_plazas VALUES (86, '180', 'Tlalnepantla');
INSERT INTO public.catalogo_plazas VALUES (87, '190', 'Durango');
INSERT INTO public.catalogo_plazas VALUES (88, '201', 'Tepehuanes');
INSERT INTO public.catalogo_plazas VALUES (89, '202', 'Vicente Guerrero');
INSERT INTO public.catalogo_plazas VALUES (90, '210', 'Guanajuato');
INSERT INTO public.catalogo_plazas VALUES (91, '211', 'Abasolo');
INSERT INTO public.catalogo_plazas VALUES (92, '212', 'Acámbaro');
INSERT INTO public.catalogo_plazas VALUES (93, '213', 'Apaseo el Alto');
INSERT INTO public.catalogo_plazas VALUES (94, '214', 'Apaseo el Grande');
INSERT INTO public.catalogo_plazas VALUES (95, '215', 'Celaya');
INSERT INTO public.catalogo_plazas VALUES (96, '216', 'Comonfort');
INSERT INTO public.catalogo_plazas VALUES (97, '217', 'Coroneo');
INSERT INTO public.catalogo_plazas VALUES (98, '218', 'Cortazar');
INSERT INTO public.catalogo_plazas VALUES (99, '219', 'Cuerámaro');
INSERT INTO public.catalogo_plazas VALUES (100, '220', 'Dolores Hidalgo');
INSERT INTO public.catalogo_plazas VALUES (101, '222', 'Irapuato');
INSERT INTO public.catalogo_plazas VALUES (102, '223', 'Jaral del Progreso');
INSERT INTO public.catalogo_plazas VALUES (103, '224', 'Jerécuaro');
INSERT INTO public.catalogo_plazas VALUES (104, '225', 'León');
INSERT INTO public.catalogo_plazas VALUES (105, '226', 'Cd. Manuel Doblado');
INSERT INTO public.catalogo_plazas VALUES (106, '227', 'Moroleón');
INSERT INTO public.catalogo_plazas VALUES (107, '229', 'Pénjamo');
INSERT INTO public.catalogo_plazas VALUES (108, '232', 'Romita');
INSERT INTO public.catalogo_plazas VALUES (109, '233', 'Salamanca');
INSERT INTO public.catalogo_plazas VALUES (110, '234', 'Salvatierra');
INSERT INTO public.catalogo_plazas VALUES (111, '236', 'San Felipe');
INSERT INTO public.catalogo_plazas VALUES (112, '237', 'Purísima de Bustos');
INSERT INTO public.catalogo_plazas VALUES (113, '237', 'San Francisco del Rincoón');
INSERT INTO public.catalogo_plazas VALUES (114, '238', 'San José Iturbide');
INSERT INTO public.catalogo_plazas VALUES (115, '239', 'San Luis de la Paz');
INSERT INTO public.catalogo_plazas VALUES (116, '240', 'San Miguel Allende');
INSERT INTO public.catalogo_plazas VALUES (117, '244', 'Silao');
INSERT INTO public.catalogo_plazas VALUES (118, '247', 'Uriangato');
INSERT INTO public.catalogo_plazas VALUES (119, '248', 'Valle de Santiago');
INSERT INTO public.catalogo_plazas VALUES (120, '249', 'Yuriria');
INSERT INTO public.catalogo_plazas VALUES (121, '260', 'Chilpancingo');
INSERT INTO public.catalogo_plazas VALUES (122, '261', 'Acapulco');
INSERT INTO public.catalogo_plazas VALUES (123, '263', 'Arcelia');
INSERT INTO public.catalogo_plazas VALUES (124, '264', 'Atoyac de Álvarez');
INSERT INTO public.catalogo_plazas VALUES (125, '266', 'Ciudad Altamirano');
INSERT INTO public.catalogo_plazas VALUES (126, '267', 'Coyuca de Benítez');
INSERT INTO public.catalogo_plazas VALUES (127, '270', 'Chilapa');
INSERT INTO public.catalogo_plazas VALUES (128, '271', 'Huitzuco');
INSERT INTO public.catalogo_plazas VALUES (129, '272', 'Iguala');
INSERT INTO public.catalogo_plazas VALUES (130, '272', 'La Sabana');
INSERT INTO public.catalogo_plazas VALUES (131, '274', 'Cuajinicuilapa');
INSERT INTO public.catalogo_plazas VALUES (132, '274', 'Ometepec');
INSERT INTO public.catalogo_plazas VALUES (133, '275', 'San Marcos');
INSERT INTO public.catalogo_plazas VALUES (134, '276', 'Taxco');
INSERT INTO public.catalogo_plazas VALUES (135, '278', 'Teloloapan');
INSERT INTO public.catalogo_plazas VALUES (136, '281', 'Tlapa');
INSERT INTO public.catalogo_plazas VALUES (137, '282', 'Ixtapa Zihuatanejo');
INSERT INTO public.catalogo_plazas VALUES (138, '282', 'Zihuatanejo');
INSERT INTO public.catalogo_plazas VALUES (139, '290', 'Pachuca');
INSERT INTO public.catalogo_plazas VALUES (140, '291', 'Actopan');
INSERT INTO public.catalogo_plazas VALUES (141, '292', 'Apam');
INSERT INTO public.catalogo_plazas VALUES (142, '293', 'Atotonilco el Grande');
INSERT INTO public.catalogo_plazas VALUES (143, '294', 'Ciudad Sahagún');
INSERT INTO public.catalogo_plazas VALUES (144, '294', 'Teocaltiche');
INSERT INTO public.catalogo_plazas VALUES (145, '295', 'Cuautepec');
INSERT INTO public.catalogo_plazas VALUES (146, '296', 'Huejutla');
INSERT INTO public.catalogo_plazas VALUES (147, '297', 'Huichapan');
INSERT INTO public.catalogo_plazas VALUES (148, '298', 'Ixmiquilpan');
INSERT INTO public.catalogo_plazas VALUES (149, '303', 'Progreso de Obregón');
INSERT INTO public.catalogo_plazas VALUES (150, '305', 'Tepeapulco');
INSERT INTO public.catalogo_plazas VALUES (151, '308', 'Tizayuca');
INSERT INTO public.catalogo_plazas VALUES (152, '311', 'Tula de Allende');
INSERT INTO public.catalogo_plazas VALUES (153, '312', 'Tulancingo');
INSERT INTO public.catalogo_plazas VALUES (154, '313', 'Zacualtipán');
INSERT INTO public.catalogo_plazas VALUES (155, '314', 'Zimapán');
INSERT INTO public.catalogo_plazas VALUES (156, '320', 'El Salto');
INSERT INTO public.catalogo_plazas VALUES (157, '320', 'Guadalajara');
INSERT INTO public.catalogo_plazas VALUES (158, '320', 'San Pedro Tlaquepaque');
INSERT INTO public.catalogo_plazas VALUES (159, '320', 'Tlajomulco');
INSERT INTO public.catalogo_plazas VALUES (160, '320', 'Tonala');
INSERT INTO public.catalogo_plazas VALUES (161, '320', 'Zapopan');
INSERT INTO public.catalogo_plazas VALUES (162, '326', 'Ameca');
INSERT INTO public.catalogo_plazas VALUES (163, '327', 'Arandas');
INSERT INTO public.catalogo_plazas VALUES (164, '330', 'Atotonilco el Alto');
INSERT INTO public.catalogo_plazas VALUES (165, '331', 'Atequiza');
INSERT INTO public.catalogo_plazas VALUES (166, '333', 'Autlán');
INSERT INTO public.catalogo_plazas VALUES (167, '340', 'Casimiro Castillo');
INSERT INTO public.catalogo_plazas VALUES (168, '341', 'Cihuatlán');
INSERT INTO public.catalogo_plazas VALUES (169, '342', 'Ciudad Guzmán');
INSERT INTO public.catalogo_plazas VALUES (170, '346', 'Chapala');
INSERT INTO public.catalogo_plazas VALUES (171, '348', 'El Grullo');
INSERT INTO public.catalogo_plazas VALUES (172, '355', 'Ixtlahuacán del Río');
INSERT INTO public.catalogo_plazas VALUES (173, '356', 'Jalostotitlán');
INSERT INTO public.catalogo_plazas VALUES (174, '357', 'Jamay');
INSERT INTO public.catalogo_plazas VALUES (175, '361', 'La Barca');
INSERT INTO public.catalogo_plazas VALUES (176, '362', 'Lagos de Moreno');
INSERT INTO public.catalogo_plazas VALUES (177, '370', 'Ocotlán');
INSERT INTO public.catalogo_plazas VALUES (178, '373', 'Pihuamo');
INSERT INTO public.catalogo_plazas VALUES (179, '375', 'Las Juntas');
INSERT INTO public.catalogo_plazas VALUES (180, '375', 'Nuevo Vallarta');
INSERT INTO public.catalogo_plazas VALUES (181, '375', 'Pitillal');
INSERT INTO public.catalogo_plazas VALUES (182, '375', 'Puerto Vallarta');
INSERT INTO public.catalogo_plazas VALUES (183, '381', 'San Juan de los Lagos');
INSERT INTO public.catalogo_plazas VALUES (184, '384', 'San Miguel el Alto');
INSERT INTO public.catalogo_plazas VALUES (185, '385', 'San Patricio Melaque');
INSERT INTO public.catalogo_plazas VALUES (186, '386', 'Sayula');
INSERT INTO public.catalogo_plazas VALUES (187, '387', 'Tala');
INSERT INTO public.catalogo_plazas VALUES (188, '389', 'Tamazula de Gordiano');
INSERT INTO public.catalogo_plazas VALUES (189, '391', 'Tecalitlán');
INSERT INTO public.catalogo_plazas VALUES (190, '396', 'Tepatitlán');
INSERT INTO public.catalogo_plazas VALUES (191, '397', 'Tequila');
INSERT INTO public.catalogo_plazas VALUES (192, '403', 'Tototlán');
INSERT INTO public.catalogo_plazas VALUES (193, '404', 'Túxpam');
INSERT INTO public.catalogo_plazas VALUES (194, '411', 'Villa Hidalgo');
INSERT INTO public.catalogo_plazas VALUES (195, '413', 'Zacoalco de Torres');
INSERT INTO public.catalogo_plazas VALUES (196, '414', 'Zapotiltic');
INSERT INTO public.catalogo_plazas VALUES (197, '416', 'Zapotlanejo');
INSERT INTO public.catalogo_plazas VALUES (198, '420', 'Toluca');
INSERT INTO public.catalogo_plazas VALUES (199, '421', 'Acambay');
INSERT INTO public.catalogo_plazas VALUES (200, '422', 'Almoloya de Juárez');
INSERT INTO public.catalogo_plazas VALUES (201, '424', 'Amecameca');
INSERT INTO public.catalogo_plazas VALUES (202, '425', 'Apaxco');
INSERT INTO public.catalogo_plazas VALUES (203, '426', 'Atlacomulco');
INSERT INTO public.catalogo_plazas VALUES (204, '428', 'Coatepec de Harinas');
INSERT INTO public.catalogo_plazas VALUES (205, '430', 'Chicoloapan');
INSERT INTO public.catalogo_plazas VALUES (206, '431', 'Chiconcuac');
INSERT INTO public.catalogo_plazas VALUES (207, '432', 'El Oro');
INSERT INTO public.catalogo_plazas VALUES (208, '433', 'Ixtapan de la Sal');
INSERT INTO public.catalogo_plazas VALUES (209, '434', 'Ixtlahuaca');
INSERT INTO public.catalogo_plazas VALUES (210, '435', 'Jilotepec');
INSERT INTO public.catalogo_plazas VALUES (211, '438', 'Lerma');
INSERT INTO public.catalogo_plazas VALUES (212, '441', 'Metepec');
INSERT INTO public.catalogo_plazas VALUES (213, '443', 'Otumba');
INSERT INTO public.catalogo_plazas VALUES (214, '445', 'San Mateo Atenco');
INSERT INTO public.catalogo_plazas VALUES (215, '446', 'Tejupilco');
INSERT INTO public.catalogo_plazas VALUES (216, '448', 'Temascaltepec');
INSERT INTO public.catalogo_plazas VALUES (217, '449', 'Temoaya');
INSERT INTO public.catalogo_plazas VALUES (218, '450', 'Tenancingo');
INSERT INTO public.catalogo_plazas VALUES (219, '451', 'Tenago del Valle');
INSERT INTO public.catalogo_plazas VALUES (220, '453', 'Santiago Tiangistenco');
INSERT INTO public.catalogo_plazas VALUES (221, '455', 'Tultepec');
INSERT INTO public.catalogo_plazas VALUES (222, '456', 'Tultitlán');
INSERT INTO public.catalogo_plazas VALUES (223, '457', 'Valle de Bravo');
INSERT INTO public.catalogo_plazas VALUES (224, '460', 'Villa Nicolás Romero');
INSERT INTO public.catalogo_plazas VALUES (225, '463', 'Zumpango');
INSERT INTO public.catalogo_plazas VALUES (226, '470', 'Morelia');
INSERT INTO public.catalogo_plazas VALUES (227, '472', 'Aguililla');
INSERT INTO public.catalogo_plazas VALUES (228, '476', 'Apatzingán');
INSERT INTO public.catalogo_plazas VALUES (229, '480', 'Ciudad Hidalgo');
INSERT INTO public.catalogo_plazas VALUES (230, '483', 'Cotija');
INSERT INTO public.catalogo_plazas VALUES (231, '484', 'Cuitzeo');
INSERT INTO public.catalogo_plazas VALUES (232, '492', 'Huetamo');
INSERT INTO public.catalogo_plazas VALUES (233, '493', 'Jacona');
INSERT INTO public.catalogo_plazas VALUES (234, '494', 'Jiquilpan');
INSERT INTO public.catalogo_plazas VALUES (235, '496', 'La Piedad');
INSERT INTO public.catalogo_plazas VALUES (236, '497', 'Lázaro Cárdenas');
INSERT INTO public.catalogo_plazas VALUES (237, '498', 'Los Reyes');
INSERT INTO public.catalogo_plazas VALUES (238, '499', 'Maravatío');
INSERT INTO public.catalogo_plazas VALUES (239, '501', 'Nueva Italia');
INSERT INTO public.catalogo_plazas VALUES (240, '506', 'Pátzcuaro');
INSERT INTO public.catalogo_plazas VALUES (241, '508', 'Purépero');
INSERT INTO public.catalogo_plazas VALUES (242, '509', 'Puruandiro');
INSERT INTO public.catalogo_plazas VALUES (243, '512', 'Sahuayo');
INSERT INTO public.catalogo_plazas VALUES (244, '515', 'Tacámbaro');
INSERT INTO public.catalogo_plazas VALUES (245, '517', 'Tangancícuaro');
INSERT INTO public.catalogo_plazas VALUES (246, '519', 'Tepalcatepec');
INSERT INTO public.catalogo_plazas VALUES (247, '523', 'Tlazazalca');
INSERT INTO public.catalogo_plazas VALUES (248, '528', 'Uruapan');
INSERT INTO public.catalogo_plazas VALUES (249, '533', 'Yurécuaro');
INSERT INTO public.catalogo_plazas VALUES (250, '534', 'Zacapu');
INSERT INTO public.catalogo_plazas VALUES (251, '535', 'Zamora');
INSERT INTO public.catalogo_plazas VALUES (252, '536', 'Zinapécuaro');
INSERT INTO public.catalogo_plazas VALUES (253, '537', 'Zitácuaro');
INSERT INTO public.catalogo_plazas VALUES (254, '540', 'Cuernavaca');
INSERT INTO public.catalogo_plazas VALUES (255, '542', 'Cuautla');
INSERT INTO public.catalogo_plazas VALUES (256, '542', 'Oaxtepec, Morelos');
INSERT INTO public.catalogo_plazas VALUES (257, '543', 'Jiutepec');
INSERT INTO public.catalogo_plazas VALUES (258, '544', 'Jojutla');
INSERT INTO public.catalogo_plazas VALUES (259, '545', 'Puente de Ixtla');
INSERT INTO public.catalogo_plazas VALUES (260, '546', 'Temixco');
INSERT INTO public.catalogo_plazas VALUES (261, '548', 'Tetecala');
INSERT INTO public.catalogo_plazas VALUES (262, '549', 'Yautepec');
INSERT INTO public.catalogo_plazas VALUES (263, '552', 'Zacatepec');
INSERT INTO public.catalogo_plazas VALUES (264, '560', 'Tepic');
INSERT INTO public.catalogo_plazas VALUES (265, '561', 'Acaponeta');
INSERT INTO public.catalogo_plazas VALUES (266, '562', 'Ahuacatlán');
INSERT INTO public.catalogo_plazas VALUES (267, '564', 'Compostela');
INSERT INTO public.catalogo_plazas VALUES (268, '566', 'Ixtlán del Río');
INSERT INTO public.catalogo_plazas VALUES (269, '571', 'San Blas');
INSERT INTO public.catalogo_plazas VALUES (270, '573', 'Santiago Ixcuintla');
INSERT INTO public.catalogo_plazas VALUES (271, '575', 'Túxpam');
INSERT INTO public.catalogo_plazas VALUES (272, '580', 'Apodaca');
INSERT INTO public.catalogo_plazas VALUES (273, '580', 'Cadereyta');
INSERT INTO public.catalogo_plazas VALUES (274, '580', 'Cd. Guadalupe');
INSERT INTO public.catalogo_plazas VALUES (275, '580', 'General Escobedo');
INSERT INTO public.catalogo_plazas VALUES (276, '580', 'Monterrey');
INSERT INTO public.catalogo_plazas VALUES (277, '580', 'San Nicolás de los Garza');
INSERT INTO public.catalogo_plazas VALUES (278, '580', 'San Pedro Garza García');
INSERT INTO public.catalogo_plazas VALUES (279, '580', 'Santa Catarina');
INSERT INTO public.catalogo_plazas VALUES (280, '583', 'Allende');
INSERT INTO public.catalogo_plazas VALUES (281, '592', 'General Zuazua');
INSERT INTO public.catalogo_plazas VALUES (282, '595', 'Linares');
INSERT INTO public.catalogo_plazas VALUES (283, '597', 'Montemorelos');
INSERT INTO public.catalogo_plazas VALUES (284, '599', 'Sabinas Hidalgo');
INSERT INTO public.catalogo_plazas VALUES (285, '600', 'Salinas Victoria');
INSERT INTO public.catalogo_plazas VALUES (286, '601', 'El Cercado');
INSERT INTO public.catalogo_plazas VALUES (287, '601', 'Villa de Santiago');
INSERT INTO public.catalogo_plazas VALUES (288, '610', 'Oaxaca');
INSERT INTO public.catalogo_plazas VALUES (289, '613', 'Tlaxiaco');
INSERT INTO public.catalogo_plazas VALUES (290, '614', 'Huajuapan de León');
INSERT INTO public.catalogo_plazas VALUES (291, '616', 'Ixtepec');
INSERT INTO public.catalogo_plazas VALUES (292, '617', 'Juchitán');
INSERT INTO public.catalogo_plazas VALUES (293, '619', 'Loma Bonita');
INSERT INTO public.catalogo_plazas VALUES (294, '620', 'Matías Romero');
INSERT INTO public.catalogo_plazas VALUES (295, '621', 'Miahuatlán');
INSERT INTO public.catalogo_plazas VALUES (296, '622', 'Ocotlán');
INSERT INTO public.catalogo_plazas VALUES (297, '624', 'Puerto Escondido');
INSERT INTO public.catalogo_plazas VALUES (298, '626', 'Salina Cruz');
INSERT INTO public.catalogo_plazas VALUES (299, '627', 'Lagunas');
INSERT INTO public.catalogo_plazas VALUES (300, '628', 'Tuxtepec');
INSERT INTO public.catalogo_plazas VALUES (301, '630', 'Pochutla');
INSERT INTO public.catalogo_plazas VALUES (302, '631', 'San Pedro Tapanatepec');
INSERT INTO public.catalogo_plazas VALUES (303, '632', 'Santa Lucía del Camino, Oaxaca');
INSERT INTO public.catalogo_plazas VALUES (304, '634', 'Bahías de Huatulco');
INSERT INTO public.catalogo_plazas VALUES (305, '635', 'Santiago Juxtlahuaca');
INSERT INTO public.catalogo_plazas VALUES (306, '636', 'Pinotepa Nacional');
INSERT INTO public.catalogo_plazas VALUES (307, '637', 'Tehuantepec');
INSERT INTO public.catalogo_plazas VALUES (308, '638', 'Tlacolula');
INSERT INTO public.catalogo_plazas VALUES (309, '640', 'Zimatlán');
INSERT INTO public.catalogo_plazas VALUES (310, '650', 'Cholula');
INSERT INTO public.catalogo_plazas VALUES (311, '650', 'La Resurrección');
INSERT INTO public.catalogo_plazas VALUES (312, '650', 'Puebla');
INSERT INTO public.catalogo_plazas VALUES (313, '650', 'San Baltazar Campeche');
INSERT INTO public.catalogo_plazas VALUES (314, '652', 'Acatzingo');
INSERT INTO public.catalogo_plazas VALUES (315, '654', 'Atlixco');
INSERT INTO public.catalogo_plazas VALUES (316, '656', 'Cuetzalan');
INSERT INTO public.catalogo_plazas VALUES (317, '659', 'Huauchinango');
INSERT INTO public.catalogo_plazas VALUES (318, '662', 'Izúcar de Matamoros');
INSERT INTO public.catalogo_plazas VALUES (319, '667', 'San Martín Texmelucan');
INSERT INTO public.catalogo_plazas VALUES (320, '668', 'San Felipe Hueyotlipan');
INSERT INTO public.catalogo_plazas VALUES (321, '669', 'Tecamachalco');
INSERT INTO public.catalogo_plazas VALUES (322, '670', 'Tehuacán');
INSERT INTO public.catalogo_plazas VALUES (323, '671', 'San Lorenzo');
INSERT INTO public.catalogo_plazas VALUES (324, '672', 'Teziutlán');
INSERT INTO public.catalogo_plazas VALUES (325, '674', 'Xicotepec de Juárez');
INSERT INTO public.catalogo_plazas VALUES (326, '676', 'Zacatlán');
INSERT INTO public.catalogo_plazas VALUES (327, '680', 'Pedro Escobedo');
INSERT INTO public.catalogo_plazas VALUES (328, '680', 'Querétaro');
INSERT INTO public.catalogo_plazas VALUES (329, '680', 'Villa Corregidora');
INSERT INTO public.catalogo_plazas VALUES (330, '681', 'Amealco');
INSERT INTO public.catalogo_plazas VALUES (331, '685', 'San Juan del Río');
INSERT INTO public.catalogo_plazas VALUES (332, '686', 'Tequisquiapan');
INSERT INTO public.catalogo_plazas VALUES (333, '690', 'Chetumal');
INSERT INTO public.catalogo_plazas VALUES (334, '691', 'Cancún');
INSERT INTO public.catalogo_plazas VALUES (335, '691', 'Col. Puerto Juárez');
INSERT INTO public.catalogo_plazas VALUES (336, '692', 'Cozumel');
INSERT INTO public.catalogo_plazas VALUES (337, '694', 'Playa del Carmen');
INSERT INTO public.catalogo_plazas VALUES (338, '700', 'San Luis Potosí');
INSERT INTO public.catalogo_plazas VALUES (339, '703', 'Cerritos');
INSERT INTO public.catalogo_plazas VALUES (340, '705', 'Ciudad Valles');
INSERT INTO public.catalogo_plazas VALUES (341, '709', 'Matehuala');
INSERT INTO public.catalogo_plazas VALUES (342, '711', 'Río Verde');
INSERT INTO public.catalogo_plazas VALUES (343, '716', 'Tamuín');
INSERT INTO public.catalogo_plazas VALUES (344, '730', 'Culiacán');
INSERT INTO public.catalogo_plazas VALUES (345, '735', 'Concordia');
INSERT INTO public.catalogo_plazas VALUES (346, '736', 'Cosala');
INSERT INTO public.catalogo_plazas VALUES (347, '737', 'Choix');
INSERT INTO public.catalogo_plazas VALUES (348, '738', 'El Fuerte');
INSERT INTO public.catalogo_plazas VALUES (349, '739', 'Escuinapa');
INSERT INTO public.catalogo_plazas VALUES (350, '740', 'Guamúchil');
INSERT INTO public.catalogo_plazas VALUES (351, '741', 'Guasave');
INSERT INTO public.catalogo_plazas VALUES (352, '743', 'Los Mochis');
INSERT INTO public.catalogo_plazas VALUES (353, '743', 'Topolobampo');
INSERT INTO public.catalogo_plazas VALUES (354, '744', 'Mazatlán');
INSERT INTO public.catalogo_plazas VALUES (355, '745', 'Mocorito');
INSERT INTO public.catalogo_plazas VALUES (356, '746', 'Navolato');
INSERT INTO public.catalogo_plazas VALUES (357, '760', 'Hermosillo');
INSERT INTO public.catalogo_plazas VALUES (358, '761', 'Agua Prieta');
INSERT INTO public.catalogo_plazas VALUES (359, '765', 'Caborca');
INSERT INTO public.catalogo_plazas VALUES (360, '766', 'Cananea');
INSERT INTO public.catalogo_plazas VALUES (361, '767', 'Ciudad Obregón');
INSERT INTO public.catalogo_plazas VALUES (362, '767', 'Esperanza');
INSERT INTO public.catalogo_plazas VALUES (363, '769', 'Empalme');
INSERT INTO public.catalogo_plazas VALUES (364, '770', 'Guaymas');
INSERT INTO public.catalogo_plazas VALUES (365, '770', 'San Carlos');
INSERT INTO public.catalogo_plazas VALUES (366, '771', 'Huatabampo');
INSERT INTO public.catalogo_plazas VALUES (367, '773', 'Magdalena');
INSERT INTO public.catalogo_plazas VALUES (368, '776', 'Nacozari de García');
INSERT INTO public.catalogo_plazas VALUES (369, '777', 'Navojoa');
INSERT INTO public.catalogo_plazas VALUES (370, '778', 'Nogales');
INSERT INTO public.catalogo_plazas VALUES (371, '779', 'Puerto Peñasco');
INSERT INTO public.catalogo_plazas VALUES (372, '780', 'San Luis Río Colorado');
INSERT INTO public.catalogo_plazas VALUES (373, '790', 'Tamulte');
INSERT INTO public.catalogo_plazas VALUES (374, '790', 'Villa Hermosa');
INSERT INTO public.catalogo_plazas VALUES (375, '792', 'Cárdenas');
INSERT INTO public.catalogo_plazas VALUES (376, '793', 'Ciudad Pemex');
INSERT INTO public.catalogo_plazas VALUES (377, '794', 'Comalcalco');
INSERT INTO public.catalogo_plazas VALUES (378, '796', 'Emiliano Zapata');
INSERT INTO public.catalogo_plazas VALUES (379, '797', 'Frontera');
INSERT INTO public.catalogo_plazas VALUES (380, '798', 'Huimanguillo');
INSERT INTO public.catalogo_plazas VALUES (381, '800', 'Jalpa de Méndez');
INSERT INTO public.catalogo_plazas VALUES (382, '802', 'Macuspana');
INSERT INTO public.catalogo_plazas VALUES (383, '803', 'Nacajuca');
INSERT INTO public.catalogo_plazas VALUES (384, '804', 'Paraíso');
INSERT INTO public.catalogo_plazas VALUES (385, '805', 'Tacotalpa');
INSERT INTO public.catalogo_plazas VALUES (386, '806', 'Teapa');
INSERT INTO public.catalogo_plazas VALUES (387, '807', 'Tenosique');
INSERT INTO public.catalogo_plazas VALUES (388, '810', 'Ciudad Victoria');
INSERT INTO public.catalogo_plazas VALUES (389, '811', 'Altamira');
INSERT INTO public.catalogo_plazas VALUES (390, '813', 'Ciudad Madero');
INSERT INTO public.catalogo_plazas VALUES (391, '813', 'Tampico');
INSERT INTO public.catalogo_plazas VALUES (392, '814', 'Ciudad Mante');
INSERT INTO public.catalogo_plazas VALUES (393, '818', 'Matamoros');
INSERT INTO public.catalogo_plazas VALUES (394, '821', 'Colombia');
INSERT INTO public.catalogo_plazas VALUES (395, '821', 'Nuevo Laredo');
INSERT INTO public.catalogo_plazas VALUES (396, '822', 'Reynosa');
INSERT INTO public.catalogo_plazas VALUES (397, '823', 'Río Bravo');
INSERT INTO public.catalogo_plazas VALUES (398, '825', 'Soto La Marina');
INSERT INTO public.catalogo_plazas VALUES (399, '826', 'Valle Hermoso');
INSERT INTO public.catalogo_plazas VALUES (400, '830', 'Tlaxcala');
INSERT INTO public.catalogo_plazas VALUES (401, '832', 'Apizaco');
INSERT INTO public.catalogo_plazas VALUES (402, '834', 'Santa Ana Chiautempan');
INSERT INTO public.catalogo_plazas VALUES (403, '840', 'Jalapa');
INSERT INTO public.catalogo_plazas VALUES (404, '841', 'Acayucan');
INSERT INTO public.catalogo_plazas VALUES (405, '843', 'Agua Dulce');
INSERT INTO public.catalogo_plazas VALUES (406, '845', 'Álamo');
INSERT INTO public.catalogo_plazas VALUES (407, '846', 'Altotonga');
INSERT INTO public.catalogo_plazas VALUES (408, '848', 'Banderilla');
INSERT INTO public.catalogo_plazas VALUES (409, '849', 'Boca del Río');
INSERT INTO public.catalogo_plazas VALUES (410, '852', 'Ciudad Mendoza');
INSERT INTO public.catalogo_plazas VALUES (411, '853', 'Coatepec');
INSERT INTO public.catalogo_plazas VALUES (412, '854', 'Coatzacoalcos');
INSERT INTO public.catalogo_plazas VALUES (413, '855', 'Córdoba');
INSERT INTO public.catalogo_plazas VALUES (414, '856', 'Cosamaloapan');
INSERT INTO public.catalogo_plazas VALUES (415, '860', 'Cuitláhuac');
INSERT INTO public.catalogo_plazas VALUES (416, '863', 'Fortín de las Flores');
INSERT INTO public.catalogo_plazas VALUES (417, '864', 'Gutiérrez Zamora');
INSERT INTO public.catalogo_plazas VALUES (418, '865', 'Huatusco');
INSERT INTO public.catalogo_plazas VALUES (419, '867', 'Isla');
INSERT INTO public.catalogo_plazas VALUES (420, '868', 'Ixtaczoquitlán');
INSERT INTO public.catalogo_plazas VALUES (421, '869', 'Jáltipan');
INSERT INTO public.catalogo_plazas VALUES (422, '871', 'Juan Rodríguez Clara');
INSERT INTO public.catalogo_plazas VALUES (423, '872', 'Villa José Cardel');
INSERT INTO public.catalogo_plazas VALUES (424, '873', 'Las Choapas');
INSERT INTO public.catalogo_plazas VALUES (425, '875', 'Naranjos');
INSERT INTO public.catalogo_plazas VALUES (426, '876', 'Martínez de la Torre');
INSERT INTO public.catalogo_plazas VALUES (427, '877', 'Minatitlán');
INSERT INTO public.catalogo_plazas VALUES (428, '878', 'Misantla');
INSERT INTO public.catalogo_plazas VALUES (429, '879', 'Nanchital');
INSERT INTO public.catalogo_plazas VALUES (430, '882', 'Orizaba');
INSERT INTO public.catalogo_plazas VALUES (431, '885', 'Papantla');
INSERT INTO public.catalogo_plazas VALUES (432, '886', 'Perote');
INSERT INTO public.catalogo_plazas VALUES (433, '888', 'Poza Rica');
INSERT INTO public.catalogo_plazas VALUES (434, '889', 'Río Blanco');
INSERT INTO public.catalogo_plazas VALUES (435, '890', 'San Andrés Tuxtla');
INSERT INTO public.catalogo_plazas VALUES (436, '891', 'San Rafael');
INSERT INTO public.catalogo_plazas VALUES (437, '894', 'Platón Sánchez');
INSERT INTO public.catalogo_plazas VALUES (438, '894', 'Tantoyuca');
INSERT INTO public.catalogo_plazas VALUES (439, '895', 'Tempoal');
INSERT INTO public.catalogo_plazas VALUES (440, '898', 'Tierra Blanca');
INSERT INTO public.catalogo_plazas VALUES (441, '901', 'Tlapacoyan');
INSERT INTO public.catalogo_plazas VALUES (442, '903', 'Túxpam de Rodríguez Cano');
INSERT INTO public.catalogo_plazas VALUES (443, '905', 'Cd. Industrial Framboyan');
INSERT INTO public.catalogo_plazas VALUES (444, '905', 'Veracruz');
INSERT INTO public.catalogo_plazas VALUES (445, '910', 'Mérida');
INSERT INTO public.catalogo_plazas VALUES (446, '913', 'Motul');
INSERT INTO public.catalogo_plazas VALUES (447, '914', 'Oxkutzcab');
INSERT INTO public.catalogo_plazas VALUES (448, '915', 'Progreso');
INSERT INTO public.catalogo_plazas VALUES (449, '917', 'Ticul');
INSERT INTO public.catalogo_plazas VALUES (450, '918', 'Tizimín');
INSERT INTO public.catalogo_plazas VALUES (451, '920', 'Valladolid');
INSERT INTO public.catalogo_plazas VALUES (452, '930', 'Zacatecas');
INSERT INTO public.catalogo_plazas VALUES (453, '933', 'Fresnillo');
INSERT INTO public.catalogo_plazas VALUES (454, '934', 'Guadalupe');
INSERT INTO public.catalogo_plazas VALUES (455, '935', 'Jalpa');
INSERT INTO public.catalogo_plazas VALUES (456, '936', 'Jerez de G. Salinas');
INSERT INTO public.catalogo_plazas VALUES (457, '938', 'Juchipila');
INSERT INTO public.catalogo_plazas VALUES (458, '939', 'Loreto');
INSERT INTO public.catalogo_plazas VALUES (459, '946', 'Nochistlán');
INSERT INTO public.catalogo_plazas VALUES (460, '958', 'Valparaíso');
INSERT INTO public.catalogo_plazas VALUES (461, '960', 'Calera de V. Rosales');


--
-- TOC entry 2932 (class 0 OID 18295)
-- Dependencies: 201
-- Data for Name: clientes; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.clientes VALUES (14, 'Víctor Alejandro', 'Celaya', 'Velázquez', 'Privada Niños Héroes 32', '9711694109', 'Moderna', '70000', 'Juchitán', 'Oaxaca', 'celaya_vlzq04@gmail.com', 'Baja', false, 1, 1, '2023-11-16 23:34:12.271-06', '2023-11-17 02:11:45.6-06');
INSERT INTO public.clientes VALUES (1, 'Margarita', 'Mendoza', 'Saldaña', 'Av. 16 de Septiembre 233', '5621471002', 'Estación', '70110', 'Ixtepec', 'Oaxaca', NULL, NULL, true, 1, 1, '2023-11-15 01:38:18.324462-06', NULL);


--
-- TOC entry 2938 (class 0 OID 24646)
-- Dependencies: 207
-- Data for Name: cuentas; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.cuentas VALUES (1, '2023-12-29 17:20:04.75-06', NULL, '13771875569', '05461613771875569', 'cheques', 500, 15000, 0, 500, true, 'activa', 1);


--
-- TOC entry 2930 (class 0 OID 18279)
-- Dependencies: 199
-- Data for Name: empleados; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.empleados VALUES (1, 'Gabriel', 'Morales', 'Espinoza', '9711052158', 'Valerio Trujano Interior s/n', 'Sexta Sección', 'Ixtepec', 'Oaxaca', '70110', 'Sistemas', 'gbmres2704@gmail.com', true, '2023-11-15 01:38:17.832199-06', NULL, 1);


--
-- TOC entry 2950 (class 0 OID 33435)
-- Dependencies: 219
-- Data for Name: entidades_financieras; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.entidades_financieras VALUES (1, '002', 'BANAMEX', 'Banco Nacional de México, S.A.');
INSERT INTO public.entidades_financieras VALUES (2, '006', 'BANCOMEXT', 'Banco Nacional de Comercio Exterior');
INSERT INTO public.entidades_financieras VALUES (3, '009', 'BANOBRAS', 'Banco Nacional de Obras y Servicios Públicos');
INSERT INTO public.entidades_financieras VALUES (4, '012', 'BBVA BANCOMER', 'BBVA Bancomer, S.A.');
INSERT INTO public.entidades_financieras VALUES (5, '014', 'SANTANDER', 'Banco Santander, S.A.');
INSERT INTO public.entidades_financieras VALUES (6, '019', 'BANJERCITO', 'Banco Nacional del Ejército, Fuerza Aérea y Armada');
INSERT INTO public.entidades_financieras VALUES (7, '021', 'HSBC', 'HSBC México, S.A.');
INSERT INTO public.entidades_financieras VALUES (8, '030', 'BAJÍO', 'Banco del Bajío, S.A.');
INSERT INTO public.entidades_financieras VALUES (9, '036', 'INBURSA', 'Banco Inbursa, S.A.');
INSERT INTO public.entidades_financieras VALUES (10, '042', 'MIFEL', 'Banca Mifel, S.A.');
INSERT INTO public.entidades_financieras VALUES (11, '044', 'SCOTIABANK', 'Scotiabank Inverlat, S.A.');
INSERT INTO public.entidades_financieras VALUES (13, '058', 'BANREGIO', 'Banco Regional de Monterrey, S.A.');
INSERT INTO public.entidades_financieras VALUES (14, '059', 'INVEX', 'Banco Invex, S.A.');
INSERT INTO public.entidades_financieras VALUES (15, '060', 'BANSI', 'Bansi, S.A.');
INSERT INTO public.entidades_financieras VALUES (16, '062', 'AFIRME', 'Banca Afirme, S.A.');
INSERT INTO public.entidades_financieras VALUES (17, '072', 'BANORTE', 'Banco Mercantil del Norte, S.A.');
INSERT INTO public.entidades_financieras VALUES (18, '106', 'BANK OF AMERICA', 'Bank of America México, S.A.');
INSERT INTO public.entidades_financieras VALUES (19, '108', 'MUFG', 'MUFG Bank México, S.A., Institución de Banca Múltiple Filial');
INSERT INTO public.entidades_financieras VALUES (20, '110', 'JP MORGAN', 'Banco J.P. Morgan, S.A.');
INSERT INTO public.entidades_financieras VALUES (21, '112', 'BMONEX', 'Banco Monex, S.A.');
INSERT INTO public.entidades_financieras VALUES (22, '113', 'VE POR MAS', 'Banco Ve por Mas, S.A.');
INSERT INTO public.entidades_financieras VALUES (23, '126', 'CREDIT SUISSE', 'Banco Credit Suisse (México), S.A.');
INSERT INTO public.entidades_financieras VALUES (24, '127', 'AZTECA', 'Banco Azteca, S.A.');
INSERT INTO public.entidades_financieras VALUES (25, '128', 'AUTOFIN', 'Banco Autofin México, S.A.');
INSERT INTO public.entidades_financieras VALUES (26, '129', 'BARCLAYS', 'Barclays Bank México, S.A.');
INSERT INTO public.entidades_financieras VALUES (27, '130', 'COMPARTAMOS', 'Banco Compartamos, S.A.');
INSERT INTO public.entidades_financieras VALUES (28, '132', 'MULTIVA BANCO', 'Banco Multiva, S.A.');
INSERT INTO public.entidades_financieras VALUES (29, '133', 'ACTINVER', 'Banco Actinver, S.A.');
INSERT INTO public.entidades_financieras VALUES (30, '135', 'NAFIN', 'Nacional Financiera, S.N.C.');
INSERT INTO public.entidades_financieras VALUES (31, '136', 'INTERCAM BANCO', 'Intercam Banco, S.A., Institución de Banca Múltiple, Intercam Grupo Financiero');
INSERT INTO public.entidades_financieras VALUES (32, '137', 'BANCOPPEL', 'BanCoppel, S.A.');
INSERT INTO public.entidades_financieras VALUES (33, '138', 'ABC CAPITAL', 'ABC Capital, S.A. I.B.M.');
INSERT INTO public.entidades_financieras VALUES (34, '140', 'CONSUBANCO', 'Consubanco, S.A.');
INSERT INTO public.entidades_financieras VALUES (35, '141', 'VOLKSWAGEN', 'Volkswagen Bank S.A. Institución de Banca Múltiple');
INSERT INTO public.entidades_financieras VALUES (36, '143', 'CIBanco', 'Consultoría Internacional Banco, S.A.');
INSERT INTO public.entidades_financieras VALUES (37, '145', 'BBASE', 'Banco BASE, S.A. de I.B.M.');
INSERT INTO public.entidades_financieras VALUES (38, '147', 'BANKAOOL', 'Bankaool, S.A., Institución de Banca Múltiple');
INSERT INTO public.entidades_financieras VALUES (39, '148', 'PagaTodo', 'Banco PagaTodo S.A., Institución de Banca Múltiple');
INSERT INTO public.entidades_financieras VALUES (40, '150', 'INMOBILIARIO', 'Banco Inmobiliario Mexicano, S.A., Institución de Banca Múltiple');
INSERT INTO public.entidades_financieras VALUES (41, '151', 'Donde', '');
INSERT INTO public.entidades_financieras VALUES (42, '152', 'BANCREA', 'Banco Bancrea, S.A., Institución de Banca Múltiple');
INSERT INTO public.entidades_financieras VALUES (43, '154', 'BANCO COVALTO', 'Banco Covalto, S.A., Institución de Banca Múltiple');
INSERT INTO public.entidades_financieras VALUES (44, '155', 'ICBC', 'Industrial and Commercial Bank of China, S.A., Institución de Banca Múltiple');
INSERT INTO public.entidades_financieras VALUES (45, '156', 'SABADELL', 'Banco Sabadell, S.A. I.B.M.');
INSERT INTO public.entidades_financieras VALUES (46, '157', 'SHINHAN', 'Banco Shinhan de México, S.A., Institución de Banca Múltiple');
INSERT INTO public.entidades_financieras VALUES (47, '158', 'MIZUHO BANK', 'Mizuho Bank México, S.A., Institución de Banca Múltiple');
INSERT INTO public.entidades_financieras VALUES (48, '159', 'BANK OF CHINA', 'Bank of China México, S.A., Institución de Banca Múltiple');
INSERT INTO public.entidades_financieras VALUES (49, '160', 'BANCO S3', 'Banco S3 Caceis México, S.A., Institución de Banca Múltiple');
INSERT INTO public.entidades_financieras VALUES (50, '166', 'Banco del Bienestar', 'Banco del Bienestar, Sociedad Nacional de Crédito, Institución de Banca de Desarrollo');
INSERT INTO public.entidades_financieras VALUES (51, '168', 'HIPOTECARIA FEDERAL', 'Sociedad Hipotecaria Federal, S.N.C.');
INSERT INTO public.entidades_financieras VALUES (52, '600', 'MONEXCB', 'Monex Casa de Bolsa, S.A. de C.V.');
INSERT INTO public.entidades_financieras VALUES (53, '601', 'GBM', 'GBM Grupo Bursátil Mexicano, S.A. de C.V.');
INSERT INTO public.entidades_financieras VALUES (54, '602', 'MASARI CB', 'Masari Casa de Bolsa, S.A.');
INSERT INTO public.entidades_financieras VALUES (55, '605', 'VALUÉ', 'Valué, S.A. de C.V., Casa de Bolsa');
INSERT INTO public.entidades_financieras VALUES (56, '608', 'VECTOR', 'Vector Casa de Bolsa, S.A. de C.V.');
INSERT INTO public.entidades_financieras VALUES (57, '610', 'B&B', 'B y B Casa de Cambio, S.A. de C.V.');
INSERT INTO public.entidades_financieras VALUES (58, '613', 'MULTIVA CBOLSA', 'Banco Multiva, S.A. Institución de Banca Múltiple, Grupo Financiero Multiva');
INSERT INTO public.entidades_financieras VALUES (59, '616', 'FINAMEX', 'Casa de Bolsa Finamex, S.A. de C.V.');
INSERT INTO public.entidades_financieras VALUES (60, '617', 'VALMEX', 'Valores Mexicanos Casa de Bolsa, S.A. de C.V.');
INSERT INTO public.entidades_financieras VALUES (61, '618', 'ÚNICA', 'Única Casa de Cambio, S.A. de C.V.');
INSERT INTO public.entidades_financieras VALUES (62, '619', 'MAPFRE', 'MAPFRE Tepeyac S.A.');
INSERT INTO public.entidades_financieras VALUES (63, '620', 'PROFUTURO', 'Profuturo G.N.P., S.A. de C.V.');
INSERT INTO public.entidades_financieras VALUES (64, '621', 'CB ACTINBER', 'Actinver Casa de Bolsa, S.A. de C.V.');
INSERT INTO public.entidades_financieras VALUES (65, '622', 'OACTIN', 'OPERADORA ACTINVER, S.A. DE C.V.');
INSERT INTO public.entidades_financieras VALUES (66, '623', 'SKANDIA', 'Skandia Vida S.A. de C.V.');
INSERT INTO public.entidades_financieras VALUES (67, '626', 'CBDEUTSCHE', 'Deutsche Securities, S.A. de C.V.');
INSERT INTO public.entidades_financieras VALUES (68, '627', 'ZURICH', 'Zúrich Compañía de Seguros, S.A.');
INSERT INTO public.entidades_financieras VALUES (69, '628', 'ZURICHVI', 'Zúrich Vida, Compañía de Seguros, S.A.');
INSERT INTO public.entidades_financieras VALUES (70, '629', 'SU CASITA', 'Hipotecaria su Casita, S.A. de C.V.');
INSERT INTO public.entidades_financieras VALUES (71, '630', 'C.B. INTERCAM', 'Intercam Casa de Bolsa, S.A. de C.V.');
INSERT INTO public.entidades_financieras VALUES (72, '631', 'C.I. BOLSA', 'CI Casa de Bolsa, S.A. de C.V.');
INSERT INTO public.entidades_financieras VALUES (73, '632', 'BULLTICK C.B.', 'Bulltick Casa de Bolsa, S.A. de C.V.');
INSERT INTO public.entidades_financieras VALUES (74, '633', 'STERLING', 'Sterling Casa de Cambio, S.A. de C.V.');
INSERT INTO public.entidades_financieras VALUES (75, '634', 'FINCOMUN', 'Fincomún, Servicios Financieros Comunitarios, S.A. de C.V.');
INSERT INTO public.entidades_financieras VALUES (76, '636', 'HDI SEGUROS', 'HDI Seguros, S.A. de C.V.');
INSERT INTO public.entidades_financieras VALUES (77, '637', 'ORDER', 'OrderExpress Casa de Cambio , S.A. de C.V. AAC');
INSERT INTO public.entidades_financieras VALUES (78, '638', 'AKALA', 'Akala, S.A. de C.V., Sociedad Financiera Popular');
INSERT INTO public.entidades_financieras VALUES (79, '640', 'C.B. JP MORGAN', 'J.P. Morgan Casa de Bolsa, S.A. de C.V.');
INSERT INTO public.entidades_financieras VALUES (80, '642', 'REFORMA', 'Operadora de Recursos Reforma, S.A. de C.V.');
INSERT INTO public.entidades_financieras VALUES (81, '646', 'STP', 'Sistema de Transferencias y Pagos STP, S.A. de C.V., SOFOM E.N.R.');
INSERT INTO public.entidades_financieras VALUES (82, '647', 'TELECOMM', 'Telecomunicaciones de México');
INSERT INTO public.entidades_financieras VALUES (83, '648', 'EVERCORE', 'Evercore Casa de Bolsa, S.A. de C.V.');
INSERT INTO public.entidades_financieras VALUES (84, '649', 'SKANDIA', 'Skandia Operadora S.A. de C.V.');
INSERT INTO public.entidades_financieras VALUES (85, '651', 'SEGMTY', 'Seguros Monterrey New York Life, S.A de C.V.');
INSERT INTO public.entidades_financieras VALUES (86, '652', 'ASEA', 'Solución Asea, S.A. de C.V., Sociedad Financiera Popular');
INSERT INTO public.entidades_financieras VALUES (87, '653', 'KUSPIT', 'Kuspit Casa de Bolsa, S.A. de C.V.');
INSERT INTO public.entidades_financieras VALUES (88, '655', 'SOFIEXPRESS', 'J.P. SOFIEXPRESS, S.A. de C.V., S.F.P.');
INSERT INTO public.entidades_financieras VALUES (89, '656', 'UNAGRA', 'UNAGRA, S.A. de C.V., S.F.P.');
INSERT INTO public.entidades_financieras VALUES (90, '659', 'OPCIONES EMPRESARIALES DEL NOROESTE', 'Opciones Empresariales Del Noreste, S.A. DE C.V.');
INSERT INTO public.entidades_financieras VALUES (91, '670', 'LIBERTAD', 'Libertad Servicios Financieros, S.A. De C.V.');
INSERT INTO public.entidades_financieras VALUES (92, '674', 'AXA', 'AXA Seguros, S.A. De C.V.');
INSERT INTO public.entidades_financieras VALUES (93, '677', 'CAJA POP MEXICA', 'Caja Popular Mexicana, S.C. de A.P. de R.L. De C.V.');
INSERT INTO public.entidades_financieras VALUES (94, '679', 'FND', 'Financiera Nacional De Desarrollo Agropecuario, Rural, F y P.');
INSERT INTO public.entidades_financieras VALUES (95, '684', 'TRANSFER', 'Operadora De Pagos Móviles De México, S.A. De C.V.');
INSERT INTO public.entidades_financieras VALUES (96, '901', 'CLS', 'CLS Bank International');
INSERT INTO public.entidades_financieras VALUES (97, '902', 'INDEVAL', 'SD. INDEVAL, S.A. de C.V.');
INSERT INTO public.entidades_financieras VALUES (98, '999', 'N/A', 'N/A');
INSERT INTO public.entidades_financieras VALUES (12, '054', 'Best Bank', 'Best Bank S.A.');


--
-- TOC entry 2940 (class 0 OID 24988)
-- Dependencies: 209
-- Data for Name: inventario_tarjetas; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.inventario_tarjetas VALUES (6, '4128954103580025', '10', '28', '186', NULL, false, true, 'Aeton', '2023-12-09 17:22:20.625-06', NULL, NULL, '2023-12-10 14:40:35.317-06', 1);
INSERT INTO public.inventario_tarjetas VALUES (2, '4128401088520963', '02', '28', '305', NULL, false, false, 'Maxcomm', '2023-12-09 17:21:11.412-06', NULL, NULL, NULL, 1);
INSERT INTO public.inventario_tarjetas VALUES (3, '4128987410125983', '06', '28', '211', '3982', false, false, 'Aeton', '2023-12-09 17:21:32.523-06', NULL, NULL, NULL, 1);
INSERT INTO public.inventario_tarjetas VALUES (8, '4128964101789663', '04', '28', '763', NULL, false, false, 'Maxcomm', '2023-12-09 17:22:58.98-06', NULL, NULL, NULL, 1);
INSERT INTO public.inventario_tarjetas VALUES (9, '4128201025556301', '01', '29', '693', NULL, false, false, 'Omsa', '2023-12-09 17:23:12.969-06', NULL, NULL, NULL, 1);
INSERT INTO public.inventario_tarjetas VALUES (10, '4128984105932258', '12', '28', '358', '1025', false, false, 'Maxcomm', '2023-12-09 17:23:43.634-06', NULL, NULL, NULL, 2);
INSERT INTO public.inventario_tarjetas VALUES (11, '4128663210004896', '07', '28', '963', NULL, false, false, 'Omsa', '2023-12-09 17:24:01.505-06', NULL, NULL, NULL, 2);
INSERT INTO public.inventario_tarjetas VALUES (4, '4128842188741623', '05', '28', '504', NULL, false, false, 'Omsa', '2023-12-09 17:21:48.522-06', NULL, NULL, NULL, 2);
INSERT INTO public.inventario_tarjetas VALUES (1, '4128514705861860', '10', '28', '593', '8765', false, false, 'Maxcomm', '2023-12-09 16:53:22.255-06', NULL, NULL, NULL, 2);
INSERT INTO public.inventario_tarjetas VALUES (5, '4128522014789658', '11', '28', '589', '2856', false, false, 'Maxcomm', '2023-12-09 17:22:05.54-06', NULL, NULL, NULL, 2);
INSERT INTO public.inventario_tarjetas VALUES (7, '4128976610335830', '06', '28', '863', '7097', false, false, 'Omsa', '2023-12-09 17:22:44.182-06', NULL, NULL, NULL, 2);


--
-- TOC entry 2946 (class 0 OID 25176)
-- Dependencies: 215
-- Data for Name: movimientos; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2936 (class 0 OID 18324)
-- Dependencies: 205
-- Data for Name: permisos; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.permisos VALUES (1, 'Lectura y Escritura', 'El usuario puede efectuar acciones de lectura y escritura en el sistema');


--
-- TOC entry 2934 (class 0 OID 18316)
-- Dependencies: 203
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.roles VALUES (1, 'superuser', 'Usuario con permisos de super usuario que puede acceder a todas las funcionalidades del sistema');


--
-- TOC entry 2928 (class 0 OID 18271)
-- Dependencies: 197
-- Data for Name: sucursales; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.sucursales VALUES (2, 'Best Bank Juchitán', '1013', '2 de Abril No.30, colonia centro', '9717110156', 'Juchitán', 'Oaxaca', '2023-11-23 14:37:29.801-06', NULL, 292);
INSERT INTO public.sucursales VALUES (1, 'Best Bank Ixtepec', '1018', 'Av. 16 de Septiembre 88', '9717135899', 'Ixtepec', 'Oaxaca', '2023-11-15 01:38:17.416613-06', NULL, 291);


--
-- TOC entry 2942 (class 0 OID 25102)
-- Dependencies: 211
-- Data for Name: tarjetas_clientes; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2944 (class 0 OID 25132)
-- Dependencies: 213
-- Data for Name: usuarios; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.usuarios VALUES (1, 'gabo2791', 'a384786d6a20b16efb790568410e9c8c', 'gbmres2704gmail.com', true, NULL, NULL, NULL, '2023-12-13 20:15:03.819447-06', NULL, NULL, NULL);


--
-- TOC entry 2970 (class 0 OID 0)
-- Dependencies: 216
-- Name: catalogo_plazas_plaza_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.catalogo_plazas_plaza_id_seq', 461, true);


--
-- TOC entry 2971 (class 0 OID 0)
-- Dependencies: 200
-- Name: cliente_cliente_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cliente_cliente_id_seq', 17, true);


--
-- TOC entry 2972 (class 0 OID 0)
-- Dependencies: 206
-- Name: cuenta_cuenta_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cuenta_cuenta_id_seq', 34, true);


--
-- TOC entry 2973 (class 0 OID 0)
-- Dependencies: 198
-- Name: empleado_empleado_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.empleado_empleado_id_seq', 2, true);


--
-- TOC entry 2974 (class 0 OID 0)
-- Dependencies: 218
-- Name: entidades_financieras_entidad_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.entidades_financieras_entidad_id_seq', 98, true);


--
-- TOC entry 2975 (class 0 OID 0)
-- Dependencies: 208
-- Name: inventario_tarjetas_inventario_tarjeta_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.inventario_tarjetas_inventario_tarjeta_id_seq', 12, true);


--
-- TOC entry 2976 (class 0 OID 0)
-- Dependencies: 214
-- Name: movimientos_movimiento_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.movimientos_movimiento_id_seq', 1, false);


--
-- TOC entry 2977 (class 0 OID 0)
-- Dependencies: 204
-- Name: permisos_permiso_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.permisos_permiso_id_seq', 1, true);


--
-- TOC entry 2978 (class 0 OID 0)
-- Dependencies: 202
-- Name: roles_rol_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.roles_rol_id_seq', 1, true);


--
-- TOC entry 2979 (class 0 OID 0)
-- Dependencies: 196
-- Name: sucursal_sucursal_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sucursal_sucursal_id_seq', 3, true);


--
-- TOC entry 2980 (class 0 OID 0)
-- Dependencies: 210
-- Name: tarjeta_cliente_tarjeta_cliente_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tarjeta_cliente_tarjeta_cliente_id_seq', 25, true);


--
-- TOC entry 2981 (class 0 OID 0)
-- Dependencies: 212
-- Name: usuarios_usuario_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.usuarios_usuario_id_seq', 1, true);


--
-- TOC entry 2785 (class 2606 OID 33426)
-- Name: catalogo_plazas catalogo_plazas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.catalogo_plazas
    ADD CONSTRAINT catalogo_plazas_pkey PRIMARY KEY (plaza_id);


--
-- TOC entry 2761 (class 2606 OID 18303)
-- Name: clientes cliente_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clientes
    ADD CONSTRAINT cliente_pkey PRIMARY KEY (cliente_id);


--
-- TOC entry 2767 (class 2606 OID 24654)
-- Name: cuentas cuenta_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cuentas
    ADD CONSTRAINT cuenta_pkey PRIMARY KEY (cuenta_id);


--
-- TOC entry 2759 (class 2606 OID 18287)
-- Name: empleados empleado_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.empleados
    ADD CONSTRAINT empleado_pkey PRIMARY KEY (empleado_id);


--
-- TOC entry 2787 (class 2606 OID 33443)
-- Name: entidades_financieras entidades_financieras_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.entidades_financieras
    ADD CONSTRAINT entidades_financieras_pkey PRIMARY KEY (entidad_id);


--
-- TOC entry 2773 (class 2606 OID 24993)
-- Name: inventario_tarjetas inventario_tarjetas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inventario_tarjetas
    ADD CONSTRAINT inventario_tarjetas_pkey PRIMARY KEY (inventario_tarjeta_id);


--
-- TOC entry 2783 (class 2606 OID 25184)
-- Name: movimientos movimientos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.movimientos
    ADD CONSTRAINT movimientos_pkey PRIMARY KEY (movimiento_id);


--
-- TOC entry 2765 (class 2606 OID 18329)
-- Name: permisos permisos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.permisos
    ADD CONSTRAINT permisos_pkey PRIMARY KEY (permiso_id);


--
-- TOC entry 2763 (class 2606 OID 18321)
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (rol_id);


--
-- TOC entry 2757 (class 2606 OID 18276)
-- Name: sucursales sucursal_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sucursales
    ADD CONSTRAINT sucursal_pkey PRIMARY KEY (sucursal_id);


--
-- TOC entry 2777 (class 2606 OID 25110)
-- Name: tarjetas_clientes tarjeta_cliente_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tarjetas_clientes
    ADD CONSTRAINT tarjeta_cliente_pkey PRIMARY KEY (tarjeta_cliente_id);


--
-- TOC entry 2769 (class 2606 OID 24663)
-- Name: cuentas uq_cuenta_clabe; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cuentas
    ADD CONSTRAINT uq_cuenta_clabe UNIQUE (clabe);


--
-- TOC entry 2771 (class 2606 OID 24661)
-- Name: cuentas uq_cuenta_numero_cuenta; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cuentas
    ADD CONSTRAINT uq_cuenta_numero_cuenta UNIQUE (numero_cuenta);


--
-- TOC entry 2775 (class 2606 OID 24995)
-- Name: inventario_tarjetas uq_inventario_tarjetas_numero_tarjeta; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inventario_tarjetas
    ADD CONSTRAINT uq_inventario_tarjetas_numero_tarjeta UNIQUE (numero_tarjeta);


--
-- TOC entry 2779 (class 2606 OID 25127)
-- Name: tarjetas_clientes uq_tarjeta_cliente_numero_tarjeta; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tarjetas_clientes
    ADD CONSTRAINT uq_tarjeta_cliente_numero_tarjeta UNIQUE (numero_tarjeta);


--
-- TOC entry 2781 (class 2606 OID 25137)
-- Name: usuarios usuarios_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_pkey PRIMARY KEY (usuario_id);


--
-- TOC entry 2791 (class 2606 OID 18309)
-- Name: clientes cliente_empleado_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clientes
    ADD CONSTRAINT cliente_empleado_id_fkey FOREIGN KEY (empleado_id) REFERENCES public.empleados(empleado_id);


--
-- TOC entry 2790 (class 2606 OID 18304)
-- Name: clientes cliente_sucursal_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clientes
    ADD CONSTRAINT cliente_sucursal_id_fkey FOREIGN KEY (sucursal_id) REFERENCES public.sucursales(sucursal_id);


--
-- TOC entry 2792 (class 2606 OID 24655)
-- Name: cuentas cuenta_cliente_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cuentas
    ADD CONSTRAINT cuenta_cliente_id_fkey FOREIGN KEY (cliente_id) REFERENCES public.clientes(cliente_id);


--
-- TOC entry 2789 (class 2606 OID 18288)
-- Name: empleados empleado_sucursal_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.empleados
    ADD CONSTRAINT empleado_sucursal_id_fkey FOREIGN KEY (sucursal_id) REFERENCES public.sucursales(sucursal_id);


--
-- TOC entry 2793 (class 2606 OID 25158)
-- Name: inventario_tarjetas inventario_tarjetas_sucursal_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inventario_tarjetas
    ADD CONSTRAINT inventario_tarjetas_sucursal_id_fkey FOREIGN KEY (sucursal_id) REFERENCES public.sucursales(sucursal_id);


--
-- TOC entry 2805 (class 2606 OID 25205)
-- Name: movimientos movimientos_cliente_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.movimientos
    ADD CONSTRAINT movimientos_cliente_id_fkey FOREIGN KEY (cliente_id) REFERENCES public.clientes(cliente_id);


--
-- TOC entry 2802 (class 2606 OID 25190)
-- Name: movimientos movimientos_cuenta_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.movimientos
    ADD CONSTRAINT movimientos_cuenta_id_fkey FOREIGN KEY (cuenta_id) REFERENCES public.cuentas(cuenta_id);


--
-- TOC entry 2804 (class 2606 OID 25200)
-- Name: movimientos movimientos_sucursal_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.movimientos
    ADD CONSTRAINT movimientos_sucursal_id_fkey FOREIGN KEY (sucursal_id) REFERENCES public.sucursales(sucursal_id);


--
-- TOC entry 2801 (class 2606 OID 25185)
-- Name: movimientos movimientos_tarjeta_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.movimientos
    ADD CONSTRAINT movimientos_tarjeta_id_fkey FOREIGN KEY (tarjeta_id) REFERENCES public.tarjetas_clientes(tarjeta_cliente_id);


--
-- TOC entry 2803 (class 2606 OID 25195)
-- Name: movimientos movimientos_usuario_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.movimientos
    ADD CONSTRAINT movimientos_usuario_id_fkey FOREIGN KEY (usuario_id) REFERENCES public.usuarios(usuario_id);


--
-- TOC entry 2788 (class 2606 OID 33427)
-- Name: sucursales sucursales_codigo_plaza_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sucursales
    ADD CONSTRAINT sucursales_codigo_plaza_fkey FOREIGN KEY (plaza_id) REFERENCES public.catalogo_plazas(plaza_id);


--
-- TOC entry 2795 (class 2606 OID 25116)
-- Name: tarjetas_clientes tarjeta_cliente_cliente_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tarjetas_clientes
    ADD CONSTRAINT tarjeta_cliente_cliente_id_fkey FOREIGN KEY (cliente_id) REFERENCES public.clientes(cliente_id);


--
-- TOC entry 2794 (class 2606 OID 25111)
-- Name: tarjetas_clientes tarjeta_cliente_cuenta_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tarjetas_clientes
    ADD CONSTRAINT tarjeta_cliente_cuenta_id_fkey FOREIGN KEY (cuenta_id) REFERENCES public.cuentas(cuenta_id);


--
-- TOC entry 2796 (class 2606 OID 25121)
-- Name: tarjetas_clientes tarjeta_cliente_inventario_tarjeta_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tarjetas_clientes
    ADD CONSTRAINT tarjeta_cliente_inventario_tarjeta_id_fkey FOREIGN KEY (inventario_tarjeta_id) REFERENCES public.inventario_tarjetas(inventario_tarjeta_id);


--
-- TOC entry 2800 (class 2606 OID 25153)
-- Name: usuarios usuarios_cliente_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_cliente_id_fkey FOREIGN KEY (cliente_id) REFERENCES public.clientes(cliente_id);


--
-- TOC entry 2799 (class 2606 OID 25148)
-- Name: usuarios usuarios_empleado_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_empleado_id_fkey FOREIGN KEY (empleado_id) REFERENCES public.empleados(empleado_id);


--
-- TOC entry 2798 (class 2606 OID 25143)
-- Name: usuarios usuarios_permiso_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_permiso_id_fkey FOREIGN KEY (permiso_id) REFERENCES public.permisos(permiso_id);


--
-- TOC entry 2797 (class 2606 OID 25138)
-- Name: usuarios usuarios_rol_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_rol_id_fkey FOREIGN KEY (rol_id) REFERENCES public.roles(rol_id);


--
-- TOC entry 2957 (class 0 OID 0)
-- Dependencies: 6
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2024-01-02 12:49:07

--
-- PostgreSQL database dump complete
--

