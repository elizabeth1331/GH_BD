set serveroutput on
create or replace trigger tr_descuentos_venta 
before insert 
on pago_vivienda
for each row
declare
v_vivienda_id vivienda.vivienda_id%type;
v_monto_pagado number;
v_precio_inicial vivienda_venta.precio_inicial%type;
v_ult_num_pag number;
v_importe number;
v_usuario_id usuario.usuario_id%type;
v_var varchar2(200);
v_restante number;
begin











select  u.usuario_id,q1.vivienda_id,vv.precio_inicial, q1.monto_pagado, q1.num_ult_pago  
into v_usuario_id, v_vivienda_id,v_precio_inicial, v_monto_pagado,v_ult_num_pag
from  usuario u
join vivienda_venta vv
on u.usuario_id=vv.usuario_id
join (
  select vv.usuario_id,v.vivienda_id, sum(pv.importe) as monto_pagado, max(num_pago) as num_ult_pago
  from vivienda v
  join vivienda_venta vv
  on v.vivienda_id=vv.vivienda_id
  join pago_vivienda pv
  on pv.vivienda_id=vv.vivienda_id
  group by vv.usuario_id,v.vivienda_id
) q1 on q1.usuario_id=u.usuario_id
where vv.vivienda_id=:new.vivienda_id   ;
v_importe:= :new.importe;
 dbms_output.put_line(v_importe);
case v_ult_num_pag
  when 8 then
   /* v_var :='El usuario cuenta con lo siguientes datos ';
    v_var :='Id_cliente  Id_auto   Precio Inicial   #Importe total de los pagos registrados  #Total de pagos registrados ';
    v_var :=v_usuario_id||' , '||v_vivienda_id||' , '||v_precio_inicial||' , '|| v_monto_pagado||' , '||v_ult_num_pag;
    v_var :='A este usuario de le dara un descuento del 10% sobre su pago ';
    v_var :='Salgo actual '||(v_importe*0.90)+v_monto_pagado||' Saldo restante '||v_precio_inicial-((v_importe*0.90)+v_monto_pagado)||'  Se le desconto  '||(v_importe*0.90)||' Número de pago '|| v_ult_num_pag+1; 
    insert into REGISTRO_PROMOCION(registro_promocion_id, vivienda_id,usuario_id,precio_inicial,monto_pagado,numero_pago, tipo_descuento) 
    values (registro_promocion_seq.nextval,v_vivienda_id,v_usuario_id,v_precio_inicial,v_monto_pagado,v_ult_num_pag+1, 'V1' );
  */
   dbms_output.put_line('caso 8');  
  when 13 then
 /*   v_var :='El usuario cuenta con lo siguientes datos  Id_cliente  Id_auto   Precio Inicial   #Importe total de los pagos registrados  #Total de pagos registrados ';
    v_var :=v_usuario_id||' , '||v_vivienda_id||' , '||v_precio_inicial||' , '|| v_monto_pagado||' , '||v_ult_num_pag
    ||'A este usuario de le dara un descuento del 10% sobre su pago  Salgo actual '||(v_importe*0.85)+v_monto_pagado||' Saldo restante '
    ||v_precio_inicial-((v_importe*0.85)+v_monto_pagado)||'  Se le desconto  '||(v_importe*0.85)||' Número de pago '|| v_ult_num_pag+1;
    insert into REGISTRO_PROMOCION(registro_promocion_id, vivienda_id,usuario_id,precio_inicial,monto_pagado,numero_pago,tipo_descuento) 
    values (registro_promocion_seq.nextval,v_vivienda_id,v_usuario_id,v_precio_inicial ,v_monto_pagado,v_ult_num_pag+1,'V2');
    dbms_output.put_line(v_var); */
    dbms_output.put_line('caso 13');  
  else
    v_var :='Pago realizado con exito ';
    dbms_output.put_line(v_var); 
     dbms_output.put_line('else');   
  end case;
end;
/
show errors;

