--@Autores: GARCIA MENESES JEREMY, MENDOZA DE LA VEGA DULCE ELIZABETH
--@Fecha: 03/02/2021
--@Descripción: CREACION DE TRIGGER TIPO ROW LEVEL

 @@funciones_anonimas.sql

set serveroutput on
declare
cursor cur_ver_elim_tarjeta is
select tarjeta_id,num_seguridad,num_tarjeta, mes_exp,anio_exp
from aux_elim_tarjeta;



v_mes number;
v_anio number;
v_tarjeta_id number;
v_num_seguridad number;
v_num_tarjeta number;
v_mes_exp number(2);
v_anio_exp number(4);
v_tipo char(2);
v_nombre_usuario varchar2(30);
v_nombre varchar2(30);
v_ap_paterno varchar2(30);
v_ap_materno varchar2(30);
v_var varchar2(300);
v_email varchar2(300);
v_contrasena varchar2(30);
v_tipo_u char(2);
v_tipo_t char(2);


begin
  v_mes:=09;
  v_anio:=2020;
  datos_usuario (09,2020);
  open cur_ver_elim_tarjeta;
    
    dbms_output.put_line('-----------------------REGISTROS DE TARJETAS_CADUCAS--------------------');
    dbms_output.put_line('--------------------------VISTOS DESDE UN CURSOR-----------------------');

    v_var:=' Tarjeta_id ---------------- Número de tarjeta   Caduco el  MM/YYYY ----------  hace  NN años con NN meses ---------------Número de seguridad  ' 
      ||v_num_seguridad;
      dbms_output.put_line(v_var);
    loop
      fetch cur_ver_elim_tarjeta 
      into v_tarjeta_id,v_num_seguridad,v_num_tarjeta, v_mes_exp,v_anio_exp;
    exit when cur_ver_elim_tarjeta%notfound;

      v_var:='     '
      ||v_tarjeta_id
      ||'  ----------  '
      || v_num_tarjeta
      ||'  ----------  '
      || v_anio_exp
      ||'/' 
      ||v_mes_exp
      ||'  ----------  '
      ||resta_anio(v_anio,v_anio_exp) 
      ||'  años con  '
      ||resta_mes(v_mes_exp,v_mes)  
      ||'  meses      ----------  ' 
      ||v_num_seguridad;
      dbms_output.put_line(v_var);



  end loop;
  close cur_ver_elim_tarjeta;
/*
  dbms_output.put_line('---------------------REGISTROS DE TARJETAS_CADUCAS----------------------');
  dbms_output.put_line('------------------------VISTOS DESDE UNA VISTA--------------------------');
*/



----instrucciones, invocación de procedimientos, etc.
---commit al final de las operaciones, todo se ejecutó correctamente.
commit;
exception
when others then
--algo salio mal, se aplica rollback
rollback;
end;
/
show errors




set serveroutput on
declare

cursor cur_ver_vista is
select nombre_usuario, email
from v_usuario;

cursor cur_ver_elim_usuario is
select nombre_usuario,nombre,ap_paterno,ap_materno,email,contraseña,tipo
from aux_elim_usuario;
v_tipo char(2);
v_nombre_usuario varchar2(30);
v_nombre varchar2(30);
v_ap_paterno varchar2(30);
v_ap_materno varchar2(30);
v_var varchar2(300);
v_email varchar2(300);
v_contrasena varchar2(30);
v_tipo_u char(2);
v_user varchar2(30);
v_v_email varchar(300);
v_v_anio_exp number;
v_v_mes_exp number;
begin

  open cur_ver_elim_usuario;
    
    dbms_output.put_line('---------------------REGISTROS DE USUARIOS ACTIVOS--------------------');
    dbms_output.put_line('------------------------VISTOS DESDE UN CURSOR------------------------');
    v_var:=' Usuario_id ---------------- User  ----------------  Nombre ---------------- Apellido Paterno ---------------- Apellido Materno ---------------- Email ---------------- Contraseña ---------------- Tipo (NA sin actividad, VR vivienda Rentada, VV Vivienda Vendida y VA vivienda Alquilada)';
    dbms_output.put_line(v_var);

    loop
      fetch cur_ver_elim_usuario  
      into v_nombre_usuario,v_nombre,v_ap_paterno,v_ap_materno,v_email,v_contrasena,v_tipo;
    exit when cur_ver_elim_usuario%notfound;

     v_var:='      '
      ||buscar_id_usuario(v_email)
      ||' ----------------  '
      || v_nombre_usuario
      ||'  ----------------  '
      || v_nombre
      ||'  ----------------  '
      ||v_ap_paterno
      ||'  ----------------  '
      ||v_ap_materno
      ||'  ----------------  ' 
      ||v_email
      ||'  ----------------  '
      ||v_contrasena
      ||'  ----------------  '
      ||v_tipo;
      dbms_output.put_line(v_var);

   end loop;
  close cur_ver_elim_usuario;
  open  cur_ver_vista;
  dbms_output.put_line('---------------CREANDO REGISTRO DE USUARIOS ACTIVOS--------------------');
  dbms_output.put_line('--------------------REGISTROS DE USUARIOS ACTIVOS----------------------');
  dbms_output.put_line('-----------------------VISTOS DESDE UNA VISTA--------------------------');
  v_var:=' Usuario_id ---------------- User  ----------------  Email ---------------- ';
    dbms_output.put_line(v_var);

   loop
      fetch  cur_ver_vista  
      into v_user, v_v_email;
    exit when  cur_ver_vista%notfound;

     v_var:='      '
      ||buscar_id_usuario(v_v_email)
      ||' ----------------  '
      || v_user
      ||'  ----------------  '
      || v_v_email;
      dbms_output.put_line(v_var);

   end loop;
  close  cur_ver_vista;


----instrucciones, invocación de procedimientos, etc.
---commit al final de las operaciones, todo se ejecutó correctamente.

commit;
exception
when others then
--algo salio mal, se aplica rollback
rollback;
end;
/
show errors
