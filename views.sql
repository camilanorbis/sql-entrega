create or replace view vw_ventas_ultimoanio_empleado as 
	select 
		e.id_empleado,
        concat (e.nombre, ' ', e.apellido),
        year (cv.fecha_venta) as anio,
        count(*) as cantidad_ventas
	from compraventa cv
    join empleado e on cv.id_empleado = e.id_empleado
    where year(cv.fecha_venta) = (2025)
    group by
		e.id_empleado,
        anio
	order by e.id_empleado;

create view vw_ganancias_vehiculos as
	select 
		v.id_vehiculo,
        v.marca,
        v.modelo,
        v.matricula,
        cv.precio_venta,
        ifnull(sum(g.monto),0) as total_gastos,
        (cv.precio_venta - ifnull(sum(g.monto),0)) as ganancia
	from vehiculo v
    join compraventa cv on v.id_vehiculo = cv.id_vehiculo
    left join gasto g on v.id_vehiculo = g.id_vehiculo
    group by
		v.id_vehiculo,
        v.marca,
        v.modelo,
        v.matricula,
        cv.precio_venta;
        
create or replace view vw_ventas_forma_pago as
	select 
		year(fecha_venta) as anio,
        forma_pago,
        count(*) as cantidad_ventas,
        sum(precio_venta) as total_facturado
	from compraventa
    group by year(fecha_venta), forma_pago;

create or replace view vw_cuotas_vencidas as
	select 
		c.id_cuota,
        c.id_venta,
        c.fecha_vencimiento,
        c.monto,
        cl.cedula,
        concat(cl.nombre,' ',cl.apellido) as nombre_cliente,
        cv.titulo_entregado
	from cuota c
    join compraventa cv on cv.id_venta = c.id_venta
    join cliente cl on cv.id_cliente = cl.id_cliente
    where c.estado = 'Pendiente' and c.fecha_vencimiento < curdate();


create view vw_vehiculos_disponibles as
	select * from vehiculo where estado = 'Disponible';
