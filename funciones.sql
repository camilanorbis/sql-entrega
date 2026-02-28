delimiter //
create function deuda_restante (p_id_venta int)
returns int
deterministic
begin 
	declare deuda int;
    
    select ifnull(sum(monto),0)
		into deuda
		from cuota where id_venta = p_id_venta and estado = 'Pendiente';
    
    return deuda;
end //

select deuda_restante(5);

delimiter //

create function total_vendido_empleado (p_id_empleado int, p_anio int)
returns int
deterministic
begin
	declare total int;
    
    select ifnull(sum(precio_venta),0)
    into total
    from compraventa where id_empleado = p_id_empleado and year(fecha_venta) = p_anio;
    
    return total;
end //

select total_vendido_empleado(6,2025);


