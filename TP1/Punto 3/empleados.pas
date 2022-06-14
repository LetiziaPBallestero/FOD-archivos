program empleadosP; 
CONST 
  fin = 'fin';
TYPE 
  empleados = record 
    nro : integer; 
    ape : string; 
    nom : string;
    edad : integer; 
    dni : string; 
  end;
  archivoEmpleados = file of empleados;
// modulos 
// general: 
procedure listarEmpleado (e : empleados); 
begin
  writeln ('El empleado numero',e.nro,' - ',e.ape,', ',e.nom,'. Tiene ',e.edad,' anios. Su DNI es', e.dni);
end; 

//b i.:Listar en pantalla los datos de empleados que tengan un nombre o apellido determinado.
procedure buscarApellido (var a :archivoEmpleados); 
var 
  apellido : string; 
  e : empleados;
begin
  writeln ('2. Buscar un empleade por nombre o apellido.');
  write ('Introducir el apellido o nombre del empleado: '); readln (apellido); 

  reset (a);
  writeln ('Lista de empleades con ese apellido o nombre: ');
  while (not eof(a)) do begin 
    read (a, e);
    if ((e.ape = apellido) or (e.nom = apellido)) then
      listarEmpleado (e);
    end; 
  close (a);
  writeln (); 
end; 

// b ii.:Listar en pantalla los empleados de a uno por línea.
procedure listarTodes (var a : archivoEmpleados); 
var 
  e : empleados;
begin
  writeln ('3. Todes les empleades');
  reset (a);
  while (not eof (a)) do begin 
    read (a,e);
    listarEmpleado(e);
  end; 
  close (a);
  writeln ();
end; 

// b iii. : Listar en pantalla empleados mayores de 70 años, próximos a jubilarse.
procedure mayores70 (var a : archivoEmpleados); 
var 
  e : empleados;
begin 
  writeln ('4. Empleados cercanos a jubilarse');
  reset (a);
  while (not eof (a)) do begin 
    read (a,e);
    if (e.edad > 70) then 
      listarEmpleado(e);
  end; 

  close (a);
  writeln();
end; 


// a : crear el archivo de empleados 
procedure leerEmpleade (var e : empleados);
begin
  write ('Apellido del empleado: '); readln(e.ape); 
  if (e.ape <> fin) then begin 
    write ('Nombre del empleado: '); readln (e.nom);
    write ('Numero de empleado: '); readln (e.nro);
    write ('Edad del empleado: '); readln (e.edad);
    write ('DNI del empleado: '); readln (e.dni);
  end; 
end; 

procedure crearArchivo (var a : archivoEmpleados); 
var 
  e : empleados; 
  nombre : string;
begin 
  writeln ('1. Crear Archivo'); 
  write ('Nombre del archivo: '); readln (nombre);
  assign (a , nombre +'.txt');

  rewrite (a);
  leerEmpleade(e);
  while (e.ape <> fin) do begin 
    write (a , e);
    leerEmpleade(e);
  end; 
  close(a);
  writeln();
end; 

procedure menu (var a : archivoEmpleados); 
var 
  opcion : string; 
begin 
  writeln('================== MENU ==================');
  writeln ('1. Crear un archivo');
  writeln ('2. Buscar empleades por apellido o nombre'); 
  writeln ('3. Listar a todes les empleades');
  writeln ('4. Listar a les empleades cercanos a jubilarse');
  writeln ('0. Para salir');
  write ('Igrese una opción: '); readln (opcion);
  case opcion of 
    '1': crearArchivo (a);
    '2': buscarApellido(a);
    '3': listarTodes(a);
    '4': mayores70(a);
    '0': halt; 
    else begin 
      writeln ('Es usted bolude? Ingreso una opcion invalida.');
    end; 
  end;
  menu (a);
end; 
// programa principal 
VAR 
  archivo : archivoEmpleados; 
BEGIN 
  menu (archivo);
END. 
