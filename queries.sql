----- crear tabla sucursal y agregar registro
drop table if exists sucursales cascade;

CREATE TABLE sucursales (
	sucursal_id serial NOT NULL,
	nombre varchar(50) not NULL,
	numero_sucursal varchar(4) not null,
	direccion varchar(100) not NULL,
	telefono varchar(10) not NULL,
	ciudad varchar(50) not NULL,
	estado varchar(50) not NULL,
	fecha_apertura timestamptz not null,
	fecha_cierre timestamptz,
	primary key (sucursal_id)
);

alter table sucursales 
	add column plaza_id smallint references catalogo_plazas(plaza_id);	

insert into sucursales(nombre, numero_sucursal, direccion, telefono, ciudad, estado, fecha_apertura)
values('Best Bank Ixtepec', '1018', 'Av. 16 de Septiembre 88', '9717135899', 'Ixtepec', 'Oaxaca', now());

select * from sucursales;

----- crear tabla empleado y agregar registro
drop table if exists empleados cascade;

create table empleados
(
    empleado_id serial NOT NULL,
    nombre varchar(50) not null,
    apellido_paterno varchar(50) not null,
    apellido_materno varchar(50) not null,
    telefono character varying(10),
    direccion character varying(100),
    colonia character varying(100),
    ciudad character varying(100),
    estado character varying(100),
    codigo_postal character varying(10),
    departamento character varying(50),
    email character varying(50),
    activo boolean,
    fecha_alta timestamptz not null,
    fecha_baja timestamptz,
    sucursal_id smallint references sucursales(sucursal_id),
    primary key(empleado_id)
);

ALTER TABLE public.empleado RENAME TO empleados;

insert into empleados(nombre, apellido_paterno, apellido_materno, telefono, direccion, colonia, ciudad, estado, codigo_postal, departamento, email, activo, fecha_alta, fecha_baja)
values('Gabriel', 'Morales', 'Espinoza', '9711307946', 'Valerio Trujano Interior s/n', 'Sexta Sección', 'Ixtepec', 'Oaxaca', '70110', 'Sistemas', 'gbmres2704@gmail.com', true, now(), null);

select * from empleados;

----- crear tabla cliente y agregar registro
drop table if exists clientes cascade;

CREATE TABLE clientes (
	cliente_id serial NOT NULL,
	nombre varchar(50) not NULL,
	apellido_paterno varchar(50) not null,
	apellido_materno varchar(50) not null,
	direccion varchar(100) not NULL,
	telefono varchar(10),
	colonia varchar(50) not null,
	codigo_postal varchar(5) not null,
	ciudad varchar(50) not NULL,
	estado varchar(50) not NULL,
	email varchar(50),
	estatus varchar(50),
	activo boolean,
	sucursal_id smallint references sucursales(sucursal_id),
	empleado_id smallint references empleados(empleado_id),
	fecha_alta timestamptz not null,
	fecha_baja timestamptz,
	primary key (cliente_id)
);

insert into clientes(nombre, apellido_paterno, apellido_materno, direccion, telefono, colonia, codigo_postal, ciudad, estado, activo, fecha_alta)
values('Margarita', 'Mendoza', 'Saldaña', 'Av. 16 de Septiembre 233', '5621471002', 'Estación', '70110', 'Ixtepec', 'Oaxaca', true, now());

select * from clientes;

----- crear tabla roles y agregar registro
drop table if exists roles cascade;

create table roles(
	rol_id serial not null,
	rol varchar(50) not null,
	descripcion varchar(100) not null,
	primary key(rol_id)
);

insert into roles(rol, descripcion)
values('superuser', 'Usuario con permisos de super usuario que puede acceder a todas las funcionalidades del sistema');

select * from roles;
----- crear tabla permisos y agregar registro
drop table if exists permisos cascade;

create table permisos(
	permiso_id serial not null,
	permiso varchar(50) not null,
	descripcion varchar(100) not null,
	primary key(permiso_id)
);

insert into permisos(permiso, descripcion)
values('Lectura y Escritura', 'El usuario puede efectuar acciones de lectura y escritura en el sistema');

select * from permisos;
----- crear tabla usuario y agregar registro
drop table if exists usuarios cascade;

create table usuarios(
	usuario_id serial not null,
	usuario varchar(25) not null,
	contrasenia char(32) not null,
	email varchar(50) not null,
	activo boolean,
	rol_id smallint references roles(rol_id),
	permiso_id smallint references permisos(permiso_id),
	empleado_id smallint references empleado(empleado_id),
	fecha_alta timestamptz not null,
	fecha_baja timestamptz,
	fecha_modificacion timestamptz,
	cliente_id smallint references clientes(cliente_id),
	primary key(usuario_id)
);

insert into usuarios(usuario, contrasenia, email, activo, fecha_alta)
values('gabo2791', md5('Lpawdev03'), 'gbmres2704gmail.com', true, now());

select * from usuarios;

----- crear tabla cuenta y agregar registro
drop table if exists cuentas cascade;

create table cuentas(
	cuenta_id serial not null,
	fecha_apertura timestamptz not null,
	fecha_cierre timestamptz,
	numero_cuenta varchar(50) not null,
	clabe varchar(20) not null,
	tipo_cuenta varchar(50) not null,
	saldo_inicial decimal not null,
	saldo_anterior decimal not null,
	saldo_maximo decimal not null,
	balance decimal not null,
	activo boolean,
	estatus_cuenta varchar(50),
	cliente_id smallint references clientes(cliente_id),
	primary key(cuenta_id)
);

alter table cuentas
  add constraint UQ_cuentas_clabe
  unique (clabe);
 
alter table numero_cuenta
  add constraint UQ_cuentas_numero_cuenta
  unique (numero_cuenta);

insert into cuentas(fecha_apertura, numero_cuenta, clabe, saldo_inicial, saldo_maximo, balance, activo)
values(now(), '10023988229104610927', '500932210088190298', 500.00, 10000, 500.00, true);

select * from cuentas;

----- crear tabla tarjeta y agregar registro
drop table if exists tarjetas_clientes cascade;

create table tarjetas_clientes(
	tarjeta_cliente_id serial not null,
	mes_expiracion varchar(2) not null,
	año_expiracion varchar(2) not null,
	cvv varchar(3) not null,
	nip varchar(4),
	balance decimal not null,
	numero_tarjeta varchar(16) not null,
	tipo_tarjeta varchar(50) not null,
	estatus_tarjeta varchar(25),
	tarjeta_activa boolean,
	tarjeta_cancelada boolean,
	tarjeta_migrada boolean,
	bloqueo_temporal boolean,
	bloqueo_permanente boolean,
	fecha_alta timestamptz,
	fecha_modificacion timestamptz,
	fecha_activacion timestamptz,
	fecha_cancelacion timestamptz,
	fecha_migrado timestamptz,
	fecha_bloqueo timestamptz,
	cuenta_id smallint references cuentas(cuenta_id) not null,
	cliente_id smallint references clientes(cliente_id) not null,
	inventario_tarjeta_id smallint references inventario_tarjetas(inventario_tarjeta_id) not null,
	primary key(tarjeta_cliente_id)
);

alter table tarjetas_clientes
  add constraint UQ_tarjetas_clientes_numero_tarjeta
  unique (numero_tarjeta);

  
insert into tarjetas_clientes(fecha_creacion, numero_tarjeta, mes_expiracion, año_expiracion, cvv, nip, tipo_tarjeta, tarjeta_activa, estatus_tarjeta)
values(now(), '4169160857928107', '04', '27', '922', '1010', 'débito', false, 'inactivo');

select * from tarjetas_clientes;

----- crear tabla inventario_tarjetas y agregar registro
drop table if exists inventario_Tarjetas cascade;

create table inventario_tarjetas(
	inventario_tarjeta_id serial not null,
	numero_tarjeta varchar(16) not null,
	mes_expiracion varchar(2) not null,
	año_expiracion varchar(2) not null,
	cvv varchar(3) not null,
	nip varchar(4),
	tarjeta_asignada boolean,
	tarjeta_dañada boolean,
	proveedor varchar(50),
	fecha_recepcion timestamptz,
	fecha_modificacion timestamptz,
	fecha_asignacion timestamptz,
	fecha_baja timestamptz,
	primary key(inventario_tarjeta_id)
);

alter table inventario_tarjetas
  add constraint UQ_inventario_tarjetas_numero_tarjeta
  unique (numero_tarjeta);
 
alter table inventario_tarjetas 
	add column sucursal_id smallint references sucursal(sucursal_id);

----- crear tabla movimiento y agregar registro
drop table if exists movimientos;

create table movimientos(
	movimiento_id serial not null,
	fecha_movimiento timestamptz not null,
	descripcion varchar(100) not null,
	balance decimal,
	tipo_movimiento varchar(100) not null,
	saldo_anterior decimal,
	tarjeta_id smallint references tarjetas_clientes(tarjeta_cliente_id),
	cuenta_id smallint references cuentas(cuenta_id),
	usuario_id smallint references usuarios(usuario_id),
	sucursal_id smallint references sucursales(sucursal_id),
	cliente_id smallint references clientes(cliente_id),
	primary key(movimiento_id)
);

insert into movimientos(fecha_movimiento, descripcion, balance, tipo_movimiento, saldo_anterior, tarjeta_id, cuenta_id, usuario_id, cliente_id, sucursal_id)
values(now(), 'Apertura de cuenta', 500.00, 'apertura cuenta', 0, 1, 1, 1, 1, 1);

select * from movimientos;

----- crear tabla entidades financieras y agregar registro
drop table if exists entidades_financieras;

create table entidades_financieras(
	entidad_id serial not null,
	numero_abm varchar not null,
	nombre_abreviado varchar not null,
	nombre_institucion varchar,
	primary key(entidad_id)
);

----- crear tabla catalogo de plazas y agregar registro
drop table if exists catalogo_plazas;

create table catalogo_plazas(
	plaza_id serial not null,
	codigo_plaza varchar not null,
	poblacion varchar not null,
	primary key(plaza_id)
);

select * from catalogo_plazas where poblacion = 'Ixtepec'

select cp.plaza_id, cp.codigo_plaza,  cp.poblacion from catalogo_plazas cp 
join sucursales s on s.plaza_id  = cp.plaza_id
where s.plaza_id = 291;

select ef.numero_abm  from entidades_financieras ef where lower(ef.nombre_abreviado) like lower('Bancoppel');
