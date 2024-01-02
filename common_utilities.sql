select * from empleado;

select * from tarjeta;

select  * from inventario_tarjetas where tarjeta_asignada = false and tarjeta_dañada = false;

select tarjeta_cliente_id from tarjeta_cliente where numero_tarjeta = '4128201025556301' and tarjeta_migrada = false and tarjeta_activa = true;

select * from cuenta where cuenta_id = 6 and cliente_id = 14;

CREATE OR REPLACE FUNCTION public.addtarjeta(num_tarj character varying, mes_exp character varying, "año_exp" character varying, cvv character varying, nip character varying, tipo_tarj character varying, balance float, fecha_alt timestamp with time zone, status_tarj character varying, tarj_activa boolean, fecha_act timestamp with time zone, cuentaid integer, clienteid integer, invid integer)
 RETURNS character varying
 LANGUAGE plpgsql
AS $function$
DECLARE 
    query text;
BEGIN
    query := 'INSERT INTO tarjeta_cliente(numero_tarjeta, mes_expiracion, año_expiracion, cvv, nip, tipo_tarjeta, balance, estatus_tarjeta, tarjeta_activa, fecha_activacion, fecha_alta, cuenta_id, cliente_id, inventario_tarjeta_id, tarjeta_migrada, tarjeta_cancelada, bloqueo_temporal, bloqueo_permanente) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, false, false, false, false)';
    
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
$function$
;

update tarjeta_cliente set tarjeta_activa = true, fecha_activacion = '2023-12-11 20:25:09.018-06', estatus_tarjeta = 'activa', fecha_modificacion = '2023-12-11 20:25:09.018-06' where numero_tarjeta =4128201025556301
	
--Testing SP
select * from addTarjeta('4128663210004896','07','28','963',NULL,'débito','2023-12-10 18:47:06.677-06','inactiva','FALSE',NULL,NULL,NULL,11)

select cp.codigo_plaza  from sucursales s 
join clientes c on c.sucursal_id = s.sucursal_id 
join catalogo_plazas cp on cp.plaza_id =s.plaza_id 
where c.cliente_id ='14';
