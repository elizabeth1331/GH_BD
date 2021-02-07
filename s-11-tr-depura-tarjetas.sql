--@Autores: GARCIA MENESES JEREMY, MENDOZA DE LA VEGA DULCE ELIZABETH
--@Fecha: 03/02/2021
--@Descripción: CREACION DE UN PROCEDIMIENTO USADO EN LIMPIEZA DE LA TABLA TARJETA_CREDITO Y USUARIOS



create or replace view v_usuario
select u.nombre_usuario, u.email, t.tarjeta_id, t.num_tarjeta
  into v_nombre_usuario,v_email,v_tarjeta_id,v_num_tarjeta
  from  usuario u
  natural join tarjeta_credito t
  where usuario_id=v_usuario_id;



Prompt procedimiento necesario  para el trigger de cambios en tabla tarjeta de credito y depurando registros
@@s-13-p-datos-usuario.sql
set serveroutput on
create or replace trigger tr_tarjetas_credito
  before 
    insert
    or update 
    or delete
  on tarjeta_credito
  for each row 
declare
v_num_tarjeta tarjeta_credito.num_tarjeta%type;
v_activo number;
v_email usuario.email%type;
v_nombre_usuario usuario.nombre_usuario%type;
v_usuario_id usuario.usuario_id%type;
v_var varchar2(300);
v_rp_id number;
v_tipo varchar2(2);
begin
case


    when inserting then 
      v_usuario_id:=  :new.usuario_id;
      v_tipo:='IN';
      if buscar_usuario(v_usuario_id)>0 then 
        datos_usuario( v_usuario_id,usuario_activo(v_usuario_id),v_tipo);
       end if;
      if (buscar_usuario(v_usuario_id))=0 then
        v_var:=' Primero es necesaro crear un usuario ';
        dbms_output.put_line(v_var); 
      end if;
    when deleting then
      v_tipo:='DE';
      v_usuario_id:=  :old.usuario_id;

      if buscar_usuario(v_usuario_id)>0 then 

        datos_usuario(v_usuario_id,usuario_activo(v_usuario_id),v_tipo);

      end if;
      if buscar_usuario(v_usuario_id)=0 then
        v_var:=' Registro inexistente ';
        dbms_output.put_line(v_var); 

      end if;
     
  end case;


end;
/

show errors;
commit;



























