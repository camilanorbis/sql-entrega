use automotora;
SET SQL_SAFE_UPDATES = 0;


#seteo el estado del vehiculo según si tiene una compraventa o no
update vehiculo v
	set estado = 'VENDIDO' where exists 
		(select 1 from compraventa cv where cv.id_vehiculo = v.id_vehiculo);
        
update vehiculo v
	set estado = 'DISPONIBLE' where estado = "";
    
#se completa la información de cuotas según los vehículos que tienen compraventas financiadas    
insert into cuota (id_cuota, nro_cuota, monto, fecha_vencimiento, fecha_pago, estado, id_venta)
	select 
		null, 
        n.nro, 
        cv.precio_venta / 6, 
        date_add(cv.fecha_Venta, interval n.nro month), 
        case 
			when date_add(cv.fecha_venta, interval n.nro month) < curdate()
				and rand() < 0.7
            then date_add(cv.fecha_venta, interval n.nro month)
            else null
		end,
		case
			when date_add(cv.fecha_venta, interval n.nro month) < curdate()
				and rand() < 0.7
            then 'Pagada'
            else 'Pendiente'
		end,
        cv.id_venta
	from 
		compraventa cv
	join (
		select 1 nro 
			union select 2 
            union select 3
            union select 4
            union select 5
            union select 6
    ) n
    where cv.forma_pago = 'FINANCIADO';   
    
select * from cuota where estado = 'pendiente';

#agrego info de seguro para los vehículos que estan vendidos
insert into seguro (nro_poliza, titular, matricula, vigencia, aseguradora, id_vehiculo)
	select
		concat('POL', floor(rand()*1000000)),
        concat(c.nombre, ' ', c.apellido),
        v.matricula,
        date_add(cv.fecha_venta, interval 1 year),
        case floor(rand()*4)
			when 0 then 'Sura'
            when 1 then 'Mapfre'
            when 2 then 'Porto'
            else 'San Cristobal'
		end,
        v.id_vehiculo
	from compraventa cv
    join vehiculo v on cv.id_vehiculo = v.id_vehiculo
    join cliente c on cv.id_cliente = c.id_cliente;
    
select * from seguro;
select * from vehiculo where matricula = '3VWAL7AJ2AM914998';
select * from compraventa where id_vehiculo = 6;

delete cv1
	from compraventa cv1
    join compraventa cv2
		on cv1.id_vehiculo = cv2.id_vehiculo
        and cv1.id_venta > cv2.id_venta;


insert into gasto (descripcion, monto, fecha, id_vehiculo)
	select
		case floor(rand()*4)
			when 0 then 'Patente'
            when 1 then 'Chapa y pintura'
            when 2 then 'Mecánica'
            else 'Escribanía'
		end,
        floor(1000 + (rand() * 4001)),
        date_add('2023-01-01', interval floor(rand() * datediff('2025-12-31','2023-01-01')) day),
        id_vehiculo
	from vehiculo;

select * from gasto where id_vehiculo = 36;

