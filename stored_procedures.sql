delimiter //
create procedure registrar_venta (
	in p_fecha date,
    in p_precio int,
    in p_forma_pago varchar(50),
    in p_id_cliente int,
    in p_id_empleado int,
    in p_id_vehiculo int
)
	begin
		
        declare v_estado varchar(50);
        
        select estado into v_estado from vehiculo where id_vehiculo = p_id_vehiculo;
        
        if v_estado = 'Disponible' 
			then 
				insert into compraventa (fecha_venta,precio_venta,forma_pago,titulo_entregado,id_cliente,id_empleado,id_vehiculo)
					values (p_fecha,p_precio,p_forma_pago,false,p_id_cliente,p_id_empleado,p_id_vehiculo);
				update vehiculo set estado = 'Vendido' where id_vehiculo = p_id_vehiculo;
		end if;
	
    end //

    
call registrar_venta('2026-02-25',38200,'CONTADO',49,5,9); 
select * from compraventa;
select * from vehiculo where id_vehiculo = 9;

delimiter //
create procedure generar_cuotas (in p_id_venta int)
begin

	declare v_precio int;
    declare v_forma varchar(50);
    declare i int default 1;

	select precio_venta, forma_pago 
		into v_precio, v_forma
        from compraventa
        where id_venta = p_id_venta;
        
        if v_forma = 'FINANCIADO' then
			while i <= 6 do
				insert into cuota (nro_cuota, monto, fecha_vencimiento, estado, id_venta)
					values (i, v_precio/6, date_add(curdate(), interval i month),
                    'Pendiente',
                    p_id_venta);
                    
				set i = i + 1;
			end while;
		end if;
end //

call registrar_venta('2026-02-25',48990,'FINANCIADO',4,5,29);
select * from compraventa;
call generar_cuotas(52);
select * from cuota where id_venta = 52;

