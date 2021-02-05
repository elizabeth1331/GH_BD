--@Autores: GARCIA MENESES JEREMY, MENDOZA DE LA VEGA DULCE ELIZABETH
--@Fecha: 03/02/2021
--@Descripción: CREACION DE TRIGGER TIPO ROW LEVEL


--FECHA DE PROMOCIONES, PARA LOS CLIENTES QUE HAN COMPRADO UNA CASA SE LES DARA
-- UN DESCUESTO AL REALIZAR SU PAGO NUMERO 8 DEL 10% O UN PAGO DE 15% PARA SU PAGO NUMERO 13
--TAMBIÉN SE SOLICITA CREAR UNA NUEVA TABLA DONDE SE LLEVARA EL REGISTRO DE LOS DESCUENTOS, 
--DICHA TABLA DEBERA LLAMARSE 'REGISTRO_PROMOCION' Y USANDO UNA SECUENCIA LLAMADA registro_promocion_seq



set serveroutput on

Prompt Probando trigger tr_descuentos_cobro.
--Escenario 1:
--Validando Auditoria para inserción
Prompt Prueba 1 Inserción del pago de una vivienda 

declare

cursor cur_registro_cliente is
select pv.num_pago, pv.importe,vv.folio,vv.precio_inicial,u.nombre_usuario
from pago_vivienda pv
join vivienda_venta vv
on pv.vivienda_id=vv.vivienda_id
join usuario u
on u.usuario_id=vv.usuario_id
where vv.vivienda_id=3;
--declaración de variables
v_registro_promocion_id  registro_promocion.registro_promocion_id%type;
v_vivienda_id registro_promocion.vivienda_id%type;
v_usuario_id  registro_promocion.usuario_id%type;
v_precio_inicial  registro_promocion.precio_inicial%type;
v_monto_pagado  registro_promocion.monto_pagado%type;
v_numero_pago  registro_promocion.numero_pago%type;
v_tipo_descuento  registro_promocion.tipo_descuento%type;
v_count number;
v_nombre_usuario usuario.nombre_usuario%type;
v_folio vivienda_venta.folio%type;
v_ult_num_pag number(7,2);
v_importe number;
begin

insert into PAGO_VIVIENDA(vivienda_id,num_pago,fecha,pdf_pago,importe) values (3,32,to_date('24/09/2010','dd/mm/yyyy'),empty_blob(),9500);
dbms_output.put_line('Validando datos');
dbms_output.put_line('Insertando registro  con vivienda id 3, numero de pago 32 fecha del registro 09/24/2010 y un importe de 9500');

select registro_promocion_id,vivienda_id,usuario_id,precio_inicial,monto_pagado,numero_pago,tipo_descuento,count(*)
into  v_registro_promocion_id,v_vivienda_id,v_usuario_id,v_precio_inicial,v_monto_pagado,v_numero_pago,v_tipo_descuento,v_count 
from  REGISTRO_PROMOCION rp
where rp.vivienda_id=3
and rp.numero_pago=32;

if v_count>0 then 
  
  if v_tipo_descuento <>'V1' then 
    dbms_output.put_line('El usuario obtuvo un descuento en su pago del 10%');
    dbms_output.put_line('Los datos del registro son  ');
    dbms_output.put_line('Salgo actual '||v_monto_pagado||' Saldo restante '||v_precio_inicial-v_monto_pagado);
    dbms_output.put_line('El registro de la tabla contiene Numero de registro de la promocion'
    ||v_registro_promocion_id
    ||' Vivienda_id '
    ||v_vivienda_id
    ||' Usuario id '
    ||v_usuario_id
    ||' Precio inicial '
    ||v_precio_inicial
    || ' Monto pagado '
    ||v_monto_pagado
    ||'Número de pago'
    ||v_numero_pago);
    
  else 
    dbms_output.put_line('El usuario obtuvo un descuento en su pago del 10%');
    dbms_output.put_line('Los datos del registro son  ');
    dbms_output.put_line('Salgo actual '||v_monto_pagado||' Saldo restante '||v_precio_inicial-v_monto_pagado);
        dbms_output.put_line('El registro de la tabla contiene Numero de registro de la promocion'
    ||v_registro_promocion_id
    ||' Vivienda_id '
    ||v_vivienda_id
    ||' Usuario id '
    ||v_usuario_id
    ||' Precio inicial '
    ||v_precio_inicial
    || ' Monto pagado '
    ||v_monto_pagado
    ||'Número de pago'
    ||v_numero_pago);

  end if;

else 

  open cur_registro_cliente;
  dbms_output.put_line('---------------Usuario sin descuento en su pago---------------');
  dbms_output.put_line('Registro de pagos del cliente');
  loop
    fetch cur_registro_cliente 
    into v_ult_num_pag,v_importe,v_folio,v_precio_inicial,v_nombre_usuario;
    exit when cur_registro_cliente%notfound;
  
    dbms_output.put_line('Nombre de usuario '||v_nombre_usuario||' folio  '||v_folio||' Saldo del deposito '||v_importe||' Número de pago '|| v_ult_num_pag);
  
  end loop;
  close cur_registro_cliente;
  
end if;

end;
/
show errors;
