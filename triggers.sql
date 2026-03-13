delimiter //

create trigger trg_cuota_pagada
before update on Cuota
for each row
begin
	if new.fecha_pago is not null then
		set NEW.estado = 'Pagada';
	end if;
end //
		

delimiter //

create trigger trg_cuota_vencida
before update on cuota
for each row
begin
	if new.fecha_vencimiento < curdate()
		and new.fecha_pago is null then
			set new.estado = 'Vencida';
	end if;
end //
