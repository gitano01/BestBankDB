PGDMP                         {         	   best_bank    10.23    10.23 U    ]           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                       false            ^           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                       false            _           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                       false                        2615    2200    public    SCHEMA        CREATE SCHEMA public;
    DROP SCHEMA public;
             postgres    false            `           0    0    SCHEMA public    COMMENT     6   COMMENT ON SCHEMA public IS 'standard public schema';
                  postgres    false    3            �            1259    16395    cliente    TABLE     �  CREATE TABLE public.cliente (
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
    DROP TABLE public.cliente;
       public         postgres    false    3            �            1259    16401    cliente_cliente_id_seq    SEQUENCE     �   CREATE SEQUENCE public.cliente_cliente_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.cliente_cliente_id_seq;
       public       postgres    false    3    196            a           0    0    cliente_cliente_id_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public.cliente_cliente_id_seq OWNED BY public.cliente.cliente_id;
            public       postgres    false    197            �            1259    16403    cuenta    TABLE     �  CREATE TABLE public.cuenta (
    cuenta_id integer NOT NULL,
    fecha_apertura timestamp with time zone NOT NULL,
    fecha_cierre timestamp with time zone,
    numero_cuenta character varying(50) NOT NULL,
    clabe character varying(20) NOT NULL,
    saldo_inicial numeric NOT NULL,
    saldo_maximo numeric NOT NULL,
    balance numeric NOT NULL,
    activo boolean,
    estatus_cuenta character varying(50),
    cliente_id smallint
);
    DROP TABLE public.cuenta;
       public         postgres    false    3            �            1259    16409    cuenta_cuenta_id_seq    SEQUENCE     �   CREATE SEQUENCE public.cuenta_cuenta_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.cuenta_cuenta_id_seq;
       public       postgres    false    198    3            b           0    0    cuenta_cuenta_id_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE public.cuenta_cuenta_id_seq OWNED BY public.cuenta.cuenta_id;
            public       postgres    false    199            �            1259    16411    empleado    TABLE     �  CREATE TABLE public.empleado (
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
    DROP TABLE public.empleado;
       public         postgres    false    3            �            1259    16417    empleado_empleado_id_seq    SEQUENCE     �   CREATE SEQUENCE public.empleado_empleado_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE public.empleado_empleado_id_seq;
       public       postgres    false    200    3            c           0    0    empleado_empleado_id_seq    SEQUENCE OWNED BY     U   ALTER SEQUENCE public.empleado_empleado_id_seq OWNED BY public.empleado.empleado_id;
            public       postgres    false    201            �            1259    16419 
   movimiento    TABLE     �  CREATE TABLE public.movimiento (
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
    DROP TABLE public.movimiento;
       public         postgres    false    3            �            1259    16425    movimiento_movimiento_id_seq    SEQUENCE     �   CREATE SEQUENCE public.movimiento_movimiento_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 3   DROP SEQUENCE public.movimiento_movimiento_id_seq;
       public       postgres    false    202    3            d           0    0    movimiento_movimiento_id_seq    SEQUENCE OWNED BY     ]   ALTER SEQUENCE public.movimiento_movimiento_id_seq OWNED BY public.movimiento.movimiento_id;
            public       postgres    false    203            �            1259    16427    permisos    TABLE     �   CREATE TABLE public.permisos (
    permiso_id integer NOT NULL,
    permiso character varying(50) NOT NULL,
    descripcion character varying(100) NOT NULL
);
    DROP TABLE public.permisos;
       public         postgres    false    3            �            1259    16430    permisos_permiso_id_seq    SEQUENCE     �   CREATE SEQUENCE public.permisos_permiso_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.permisos_permiso_id_seq;
       public       postgres    false    204    3            e           0    0    permisos_permiso_id_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public.permisos_permiso_id_seq OWNED BY public.permisos.permiso_id;
            public       postgres    false    205            �            1259    16432    roles    TABLE     �   CREATE TABLE public.roles (
    rol_id integer NOT NULL,
    rol character varying(50) NOT NULL,
    descripcion character varying(100) NOT NULL,
    activo boolean
);
    DROP TABLE public.roles;
       public         postgres    false    3            �            1259    16435    roles_rol_id_seq    SEQUENCE     �   CREATE SEQUENCE public.roles_rol_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.roles_rol_id_seq;
       public       postgres    false    3    206            f           0    0    roles_rol_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.roles_rol_id_seq OWNED BY public.roles.rol_id;
            public       postgres    false    207            �            1259    16437    sucursal    TABLE     �  CREATE TABLE public.sucursal (
    sucursal_id integer NOT NULL,
    nombre character varying(50) NOT NULL,
    numero_sucursal character varying(4) NOT NULL,
    direccion character varying(100) NOT NULL,
    telefono character varying(10) NOT NULL,
    ciudad character varying(50) NOT NULL,
    estado character varying(50) NOT NULL,
    fecha_apertura timestamp with time zone NOT NULL,
    fecha_cierre timestamp with time zone
);
    DROP TABLE public.sucursal;
       public         postgres    false    3            �            1259    16440    sucursal_sucursal_id_seq    SEQUENCE     �   CREATE SEQUENCE public.sucursal_sucursal_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE public.sucursal_sucursal_id_seq;
       public       postgres    false    3    208            g           0    0    sucursal_sucursal_id_seq    SEQUENCE OWNED BY     U   ALTER SEQUENCE public.sucursal_sucursal_id_seq OWNED BY public.sucursal.sucursal_id;
            public       postgres    false    209            �            1259    16442    tarjeta    TABLE     �  CREATE TABLE public.tarjeta (
    tarjeta_id integer NOT NULL,
    fecha_activacion timestamp with time zone NOT NULL,
    mes_expiracion character varying(2) NOT NULL,
    "año_expiracion" character varying(2) NOT NULL,
    cvv character varying(3) NOT NULL,
    nip character varying(4),
    estatus_tarjeta character varying(25),
    fecha_cancelacion timestamp with time zone,
    fecha_migrado timestamp with time zone,
    cuenta_id smallint,
    cliente_id smallint
);
    DROP TABLE public.tarjeta;
       public         postgres    false    3            �            1259    16445    tarjeta_tarjeta_id_seq    SEQUENCE     �   CREATE SEQUENCE public.tarjeta_tarjeta_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.tarjeta_tarjeta_id_seq;
       public       postgres    false    3    210            h           0    0    tarjeta_tarjeta_id_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public.tarjeta_tarjeta_id_seq OWNED BY public.tarjeta.tarjeta_id;
            public       postgres    false    211            �            1259    16447    usuarios    TABLE     �  CREATE TABLE public.usuarios (
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
    fecha_modificacion timestamp(3) with time zone,
    cliente_id integer
);
    DROP TABLE public.usuarios;
       public         postgres    false    3            �            1259    16450    usuario_usuario_id_seq    SEQUENCE     �   CREATE SEQUENCE public.usuario_usuario_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.usuario_usuario_id_seq;
       public       postgres    false    3    212            i           0    0    usuario_usuario_id_seq    SEQUENCE OWNED BY     R   ALTER SEQUENCE public.usuario_usuario_id_seq OWNED BY public.usuarios.usuario_id;
            public       postgres    false    213            �
           2604    16452    cliente cliente_id    DEFAULT     x   ALTER TABLE ONLY public.cliente ALTER COLUMN cliente_id SET DEFAULT nextval('public.cliente_cliente_id_seq'::regclass);
 A   ALTER TABLE public.cliente ALTER COLUMN cliente_id DROP DEFAULT;
       public       postgres    false    197    196            �
           2604    16453    cuenta cuenta_id    DEFAULT     t   ALTER TABLE ONLY public.cuenta ALTER COLUMN cuenta_id SET DEFAULT nextval('public.cuenta_cuenta_id_seq'::regclass);
 ?   ALTER TABLE public.cuenta ALTER COLUMN cuenta_id DROP DEFAULT;
       public       postgres    false    199    198            �
           2604    16454    empleado empleado_id    DEFAULT     |   ALTER TABLE ONLY public.empleado ALTER COLUMN empleado_id SET DEFAULT nextval('public.empleado_empleado_id_seq'::regclass);
 C   ALTER TABLE public.empleado ALTER COLUMN empleado_id DROP DEFAULT;
       public       postgres    false    201    200            �
           2604    16455    movimiento movimiento_id    DEFAULT     �   ALTER TABLE ONLY public.movimiento ALTER COLUMN movimiento_id SET DEFAULT nextval('public.movimiento_movimiento_id_seq'::regclass);
 G   ALTER TABLE public.movimiento ALTER COLUMN movimiento_id DROP DEFAULT;
       public       postgres    false    203    202            �
           2604    16456    permisos permiso_id    DEFAULT     z   ALTER TABLE ONLY public.permisos ALTER COLUMN permiso_id SET DEFAULT nextval('public.permisos_permiso_id_seq'::regclass);
 B   ALTER TABLE public.permisos ALTER COLUMN permiso_id DROP DEFAULT;
       public       postgres    false    205    204            �
           2604    16457    roles rol_id    DEFAULT     l   ALTER TABLE ONLY public.roles ALTER COLUMN rol_id SET DEFAULT nextval('public.roles_rol_id_seq'::regclass);
 ;   ALTER TABLE public.roles ALTER COLUMN rol_id DROP DEFAULT;
       public       postgres    false    207    206            �
           2604    16458    sucursal sucursal_id    DEFAULT     |   ALTER TABLE ONLY public.sucursal ALTER COLUMN sucursal_id SET DEFAULT nextval('public.sucursal_sucursal_id_seq'::regclass);
 C   ALTER TABLE public.sucursal ALTER COLUMN sucursal_id DROP DEFAULT;
       public       postgres    false    209    208            �
           2604    16459    tarjeta tarjeta_id    DEFAULT     x   ALTER TABLE ONLY public.tarjeta ALTER COLUMN tarjeta_id SET DEFAULT nextval('public.tarjeta_tarjeta_id_seq'::regclass);
 A   ALTER TABLE public.tarjeta ALTER COLUMN tarjeta_id DROP DEFAULT;
       public       postgres    false    211    210            �
           2604    16460    usuarios usuario_id    DEFAULT     y   ALTER TABLE ONLY public.usuarios ALTER COLUMN usuario_id SET DEFAULT nextval('public.usuario_usuario_id_seq'::regclass);
 B   ALTER TABLE public.usuarios ALTER COLUMN usuario_id DROP DEFAULT;
       public       postgres    false    213    212            I          0    16395    cliente 
   TABLE DATA               �   COPY public.cliente (cliente_id, nombre, apellido_paterno, apellido_materno, direccion, telefono, colonia, codigo_postal, ciudad, estado, email, estatus, activo, sucursal_id, empleado_id, fecha_alta, fecha_baja) FROM stdin;
    public       postgres    false    196   �n       K          0    16403    cuenta 
   TABLE DATA               �   COPY public.cuenta (cuenta_id, fecha_apertura, fecha_cierre, numero_cuenta, clabe, saldo_inicial, saldo_maximo, balance, activo, estatus_cuenta, cliente_id) FROM stdin;
    public       postgres    false    198   �o       M          0    16411    empleado 
   TABLE DATA               �   COPY public.empleado (empleado_id, nombre, apellido_paterno, apellido_materno, telefono, direccion, colonia, ciudad, estado, codigo_postal, departamento, email, activo, fecha_alta, fecha_baja, sucursal_id) FROM stdin;
    public       postgres    false    200   'p       O          0    16419 
   movimiento 
   TABLE DATA               �   COPY public.movimiento (movimiento_id, fecha_movimiento, descripcion, balance, tipo_movimiento, saldo_anterior, tarjeta_id, cuenta_id, usuario_id, sucursal_id, cliente_id) FROM stdin;
    public       postgres    false    202   Hq       Q          0    16427    permisos 
   TABLE DATA               D   COPY public.permisos (permiso_id, permiso, descripcion) FROM stdin;
    public       postgres    false    204   �q       S          0    16432    roles 
   TABLE DATA               A   COPY public.roles (rol_id, rol, descripcion, activo) FROM stdin;
    public       postgres    false    206   =r       U          0    16437    sucursal 
   TABLE DATA               �   COPY public.sucursal (sucursal_id, nombre, numero_sucursal, direccion, telefono, ciudad, estado, fecha_apertura, fecha_cierre) FROM stdin;
    public       postgres    false    208   �r       W          0    16442    tarjeta 
   TABLE DATA               �   COPY public.tarjeta (tarjeta_id, fecha_activacion, mes_expiracion, "año_expiracion", cvv, nip, estatus_tarjeta, fecha_cancelacion, fecha_migrado, cuenta_id, cliente_id) FROM stdin;
    public       postgres    false    210   s       Y          0    16447    usuarios 
   TABLE DATA               �   COPY public.usuarios (usuario_id, usuario, contrasenia, email, activo, rol_id, permiso_id, empleado_id, fecha_alta, fecha_baja, fecha_modificacion, cliente_id) FROM stdin;
    public       postgres    false    212   is       j           0    0    cliente_cliente_id_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.cliente_cliente_id_seq', 17, true);
            public       postgres    false    197            k           0    0    cuenta_cuenta_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.cuenta_cuenta_id_seq', 1, true);
            public       postgres    false    199            l           0    0    empleado_empleado_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.empleado_empleado_id_seq', 2, true);
            public       postgres    false    201            m           0    0    movimiento_movimiento_id_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('public.movimiento_movimiento_id_seq', 1, true);
            public       postgres    false    203            n           0    0    permisos_permiso_id_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.permisos_permiso_id_seq', 3, true);
            public       postgres    false    205            o           0    0    roles_rol_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.roles_rol_id_seq', 6, true);
            public       postgres    false    207            p           0    0    sucursal_sucursal_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.sucursal_sucursal_id_seq', 1, true);
            public       postgres    false    209            q           0    0    tarjeta_tarjeta_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.tarjeta_tarjeta_id_seq', 1, true);
            public       postgres    false    211            r           0    0    usuario_usuario_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.usuario_usuario_id_seq', 3, true);
            public       postgres    false    213            �
           2606    16462    cliente cliente_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.cliente
    ADD CONSTRAINT cliente_pkey PRIMARY KEY (cliente_id);
 >   ALTER TABLE ONLY public.cliente DROP CONSTRAINT cliente_pkey;
       public         postgres    false    196            �
           2606    16464    cuenta cuenta_pkey 
   CONSTRAINT     W   ALTER TABLE ONLY public.cuenta
    ADD CONSTRAINT cuenta_pkey PRIMARY KEY (cuenta_id);
 <   ALTER TABLE ONLY public.cuenta DROP CONSTRAINT cuenta_pkey;
       public         postgres    false    198            �
           2606    16466    empleado empleado_pkey 
   CONSTRAINT     ]   ALTER TABLE ONLY public.empleado
    ADD CONSTRAINT empleado_pkey PRIMARY KEY (empleado_id);
 @   ALTER TABLE ONLY public.empleado DROP CONSTRAINT empleado_pkey;
       public         postgres    false    200            �
           2606    16468    movimiento movimiento_pkey 
   CONSTRAINT     c   ALTER TABLE ONLY public.movimiento
    ADD CONSTRAINT movimiento_pkey PRIMARY KEY (movimiento_id);
 D   ALTER TABLE ONLY public.movimiento DROP CONSTRAINT movimiento_pkey;
       public         postgres    false    202            �
           2606    16557    permisos permiso_uk 
   CONSTRAINT     Q   ALTER TABLE ONLY public.permisos
    ADD CONSTRAINT permiso_uk UNIQUE (permiso);
 =   ALTER TABLE ONLY public.permisos DROP CONSTRAINT permiso_uk;
       public         postgres    false    204            �
           2606    16470    permisos permisos_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.permisos
    ADD CONSTRAINT permisos_pkey PRIMARY KEY (permiso_id);
 @   ALTER TABLE ONLY public.permisos DROP CONSTRAINT permisos_pkey;
       public         postgres    false    204            �
           2606    16555    roles rol_uk 
   CONSTRAINT     F   ALTER TABLE ONLY public.roles
    ADD CONSTRAINT rol_uk UNIQUE (rol);
 6   ALTER TABLE ONLY public.roles DROP CONSTRAINT rol_uk;
       public         postgres    false    206            �
           2606    16472    roles roles_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (rol_id);
 :   ALTER TABLE ONLY public.roles DROP CONSTRAINT roles_pkey;
       public         postgres    false    206            �
           2606    16474    sucursal sucursal_pkey 
   CONSTRAINT     ]   ALTER TABLE ONLY public.sucursal
    ADD CONSTRAINT sucursal_pkey PRIMARY KEY (sucursal_id);
 @   ALTER TABLE ONLY public.sucursal DROP CONSTRAINT sucursal_pkey;
       public         postgres    false    208            �
           2606    16476    tarjeta tarjeta_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.tarjeta
    ADD CONSTRAINT tarjeta_pkey PRIMARY KEY (tarjeta_id);
 >   ALTER TABLE ONLY public.tarjeta DROP CONSTRAINT tarjeta_pkey;
       public         postgres    false    210            �
           2606    16478    usuarios usuario_pkey 
   CONSTRAINT     [   ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuario_pkey PRIMARY KEY (usuario_id);
 ?   ALTER TABLE ONLY public.usuarios DROP CONSTRAINT usuario_pkey;
       public         postgres    false    212            �
           2606    16479     cliente cliente_empleado_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.cliente
    ADD CONSTRAINT cliente_empleado_id_fkey FOREIGN KEY (empleado_id) REFERENCES public.empleado(empleado_id);
 J   ALTER TABLE ONLY public.cliente DROP CONSTRAINT cliente_empleado_id_fkey;
       public       postgres    false    196    200    2736            �
           2606    16484     cliente cliente_sucursal_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.cliente
    ADD CONSTRAINT cliente_sucursal_id_fkey FOREIGN KEY (sucursal_id) REFERENCES public.sucursal(sucursal_id);
 J   ALTER TABLE ONLY public.cliente DROP CONSTRAINT cliente_sucursal_id_fkey;
       public       postgres    false    196    2748    208            �
           2606    16489    cuenta cuenta_cliente_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.cuenta
    ADD CONSTRAINT cuenta_cliente_id_fkey FOREIGN KEY (cliente_id) REFERENCES public.cliente(cliente_id);
 G   ALTER TABLE ONLY public.cuenta DROP CONSTRAINT cuenta_cliente_id_fkey;
       public       postgres    false    198    2732    196            �
           2606    16494 "   empleado empleado_sucursal_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.empleado
    ADD CONSTRAINT empleado_sucursal_id_fkey FOREIGN KEY (sucursal_id) REFERENCES public.sucursal(sucursal_id);
 L   ALTER TABLE ONLY public.empleado DROP CONSTRAINT empleado_sucursal_id_fkey;
       public       postgres    false    208    2748    200            �
           2606    16499 %   movimiento movimiento_cliente_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.movimiento
    ADD CONSTRAINT movimiento_cliente_id_fkey FOREIGN KEY (cliente_id) REFERENCES public.cliente(cliente_id);
 O   ALTER TABLE ONLY public.movimiento DROP CONSTRAINT movimiento_cliente_id_fkey;
       public       postgres    false    2732    202    196            �
           2606    16504 $   movimiento movimiento_cuenta_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.movimiento
    ADD CONSTRAINT movimiento_cuenta_id_fkey FOREIGN KEY (cuenta_id) REFERENCES public.cuenta(cuenta_id);
 N   ALTER TABLE ONLY public.movimiento DROP CONSTRAINT movimiento_cuenta_id_fkey;
       public       postgres    false    202    2734    198            �
           2606    16509 &   movimiento movimiento_sucursal_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.movimiento
    ADD CONSTRAINT movimiento_sucursal_id_fkey FOREIGN KEY (sucursal_id) REFERENCES public.sucursal(sucursal_id);
 P   ALTER TABLE ONLY public.movimiento DROP CONSTRAINT movimiento_sucursal_id_fkey;
       public       postgres    false    202    208    2748            �
           2606    16514 %   movimiento movimiento_tarjeta_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.movimiento
    ADD CONSTRAINT movimiento_tarjeta_id_fkey FOREIGN KEY (tarjeta_id) REFERENCES public.tarjeta(tarjeta_id);
 O   ALTER TABLE ONLY public.movimiento DROP CONSTRAINT movimiento_tarjeta_id_fkey;
       public       postgres    false    202    2750    210            �
           2606    16519 %   movimiento movimiento_usuario_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.movimiento
    ADD CONSTRAINT movimiento_usuario_id_fkey FOREIGN KEY (usuario_id) REFERENCES public.usuarios(usuario_id);
 O   ALTER TABLE ONLY public.movimiento DROP CONSTRAINT movimiento_usuario_id_fkey;
       public       postgres    false    212    2752    202            �
           2606    16524    tarjeta tarjeta_cliente_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.tarjeta
    ADD CONSTRAINT tarjeta_cliente_id_fkey FOREIGN KEY (cliente_id) REFERENCES public.cliente(cliente_id);
 I   ALTER TABLE ONLY public.tarjeta DROP CONSTRAINT tarjeta_cliente_id_fkey;
       public       postgres    false    210    2732    196            �
           2606    16529    tarjeta tarjeta_cuenta_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.tarjeta
    ADD CONSTRAINT tarjeta_cuenta_id_fkey FOREIGN KEY (cuenta_id) REFERENCES public.cuenta(cuenta_id);
 H   ALTER TABLE ONLY public.tarjeta DROP CONSTRAINT tarjeta_cuenta_id_fkey;
       public       postgres    false    2734    210    198            �
           2606    16549     usuarios usuario_cliente_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuario_cliente_id_fkey FOREIGN KEY (cliente_id) REFERENCES public.cliente(cliente_id);
 J   ALTER TABLE ONLY public.usuarios DROP CONSTRAINT usuario_cliente_id_fkey;
       public       postgres    false    212    2732    196            �
           2606    16534 !   usuarios usuario_empleado_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuario_empleado_id_fkey FOREIGN KEY (empleado_id) REFERENCES public.empleado(empleado_id);
 K   ALTER TABLE ONLY public.usuarios DROP CONSTRAINT usuario_empleado_id_fkey;
       public       postgres    false    200    212    2736            �
           2606    16539     usuarios usuario_permiso_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuario_permiso_id_fkey FOREIGN KEY (permiso_id) REFERENCES public.permisos(permiso_id);
 J   ALTER TABLE ONLY public.usuarios DROP CONSTRAINT usuario_permiso_id_fkey;
       public       postgres    false    212    2742    204            �
           2606    16544    usuarios usuario_rol_id_fkey    FK CONSTRAINT     ~   ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuario_rol_id_fkey FOREIGN KEY (rol_id) REFERENCES public.roles(rol_id);
 F   ALTER TABLE ONLY public.usuarios DROP CONSTRAINT usuario_rol_id_fkey;
       public       postgres    false    212    2746    206            I     x�=��j1�ϳO�p�$1�{�-���-��fSY7��}�=� }��X�����������\$ۦ�-���ҙ`t�jVY6�����5X&����
�\��.�q黁�#rx<F����H�`>�l�s���!���8�rP� �B)-z\w*��/}`�ڮ����;[������n�����T��t�;��>��;&D=Tȇ0��u\��io�]L����~]�v���rM�΍_�-�� ����u)U�"^X�Q��(K��ud�<˲��b�      K   W   x�-��� �d�. ��	C0ct�~,�w2������G�!4I=��5��p��h�=��J��3��3��;��5m3� Y�0      M     x�u��N�0��y��8)�:��!1��v���,Ai�%�4�6;r��x��;a�b�%�g�Z�-��@VG���|OP����u^�|L���)�^�y6q��X<s0Ӈ��L+e�/�C�7Z�H�����N�a�l�����ź%c3�[�@p!S���FV�Y%�u�XL�N̇ՍW/����J[z#�k;��N��BU���iElj�O�����L��ו��n�^L7�I;�I�~�?�m��,r�U#����Dy/�$I�2Xm`      O   Q   x�3�4202�54�54U00�2��22г4752��50�t,H-*)-JTHIUH.M�+I�450�30�L��@�8a�+F��� �p      Q   �   x�=�A
B1C׿��	����Gp3��a��|:���w*�]H^�����G#��[l2��g�DqN>&E�he������Wp��u.nk}��n��V�tR�bT�T�����O�|�/QW󽊢I[x^B_25B/      S   F   x�3�,.-H-*-N-�-.M,��WH��S ��f�+��*�U(�Beusrҋ�JRS8c��b���� �(|      U   o   x�5�1�0��9�/�(�@��֥XYx��"�F��w�h�o��/�]U]	B���7�I�����Q���:ə��Q��j|,`ѱG�Gr-bD�>�|7�3�� �M�      W   G   x�3�4202�54�54U00�2��22�354072�50�40�42�42�4404�LL.�,���#�=... �:      Y   �   x�u�;n1k������*'�	�pei!���EN'1��+g�7�G��M��l�Rm���Z�k�vI5+�Ɯ��4�x��˶븺z�pz���KdٟH
�إ,F8�>)[��K,���/H�l��Ѯ���$��q����2�(���*�}�wN������pB*��.��� y�C��c>/8F     