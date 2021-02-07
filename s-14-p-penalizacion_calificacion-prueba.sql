--@Autores: GARCIA MENESES JEREMY, MENDOZA DE LA VEGA DULCE ELIZABETH
--@Fecha: 03/02/2021
--@Descripción: Procedimiento para penalizar la calificación de una vivienda para alquiler que no responde mensajes.
connect gm_proy_admin/mg

set serveroutput on

select q.mensaje_id,q.visto,q.respuesta_id,q.vivienda_id,v.usuario_id,
  a.alquiler_id, ca.calificacion_alquiler_id,ca.calificacion,v.estatus_vivienda_id
  from(
    select *
      from mensaje
    where visto = 1
  intersect
    select *
      from mensaje
    where respuesta_id is null
  intersect
    select *
      from mensaje 
  ) q 
  join vivienda v
  on v.vivienda_id = q.vivienda_id
  join vivienda_vacacionar vv
  on v.vivienda_id = vv.vivienda_id
  join alquiler a
  on vv.vivienda_id = a.vivienda_id
  join calificacion_alquiler ca
  on ca.alquiler_id = a.alquiler_id; 
declare
v_salida number(1,0);

begin
  dbms_output.put_line('Empezando proceso de penalización en la calificación de viviendas para alquilar');
  penalizacion_calificacion();
  if v_salida = 0 then
    dbms_output.put_line('El Procedimiento finalizo correctamente');
  end if; 
  commit;
  exception
    when others then
      dbms_output.put_line('Codigo: ' || sqlcode);
      dbms_output.put_line('Mensaje: ' || sqlerrm);
      rollback;
end;
/

select q.mensaje_id,q.visto,q.respuesta_id,q.vivienda_id,v.usuario_id,
  a.alquiler_id, ca.calificacion_alquiler_id,ca.calificacion,v.estatus_vivienda_id
  from(
    select *
      from mensaje
    where visto = 1
  intersect
    select *
      from mensaje
    where respuesta_id is null
  intersect
    select *
      from mensaje 
  ) q 
  join vivienda v
  on v.vivienda_id = q.vivienda_id
  join vivienda_vacacionar vv
  on v.vivienda_id = vv.vivienda_id
  join alquiler a
  on vv.vivienda_id = a.vivienda_id
  join calificacion_alquiler ca
  on ca.alquiler_id = a.alquiler_id; 

select * from hist_estatus_vivienda
where fecha_estatus = sysdate;