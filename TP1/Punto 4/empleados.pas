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

// punto 4 
// voy a usar el archivo ya generador en el punto anterior 
// que es el "empleados.txt";

// añadir 1 o mas empleados 
procedure agregarEmpleades ( var a : archivoEmpleados); 
var 
  e : empleados; 
begin 
  writeln ('5. Agregar empleades.');
  assign (a , 'empleados.txt'); 

  reset (a); 
  leerEmpleade (e); 
  // me muevo al final de archivo con seek 
  // seek (archivo , pos) -> 
  // uso FileSize(a), el tamanio del archivo justamente para ir al ultimo elemento
  seek(a , FileSize(a)); 
  while (e.ape <> fin) do begin 
    write (a,e);
    leerEmpleade(e); 
  end; 
  close (a);
  writeln ('');
end;

// b. Modificar edad a una o más empleados.
procedure modificarEdad (var a : archivoEmpleados); 
var 
  e : empleados; 
  next : boolean; 
  numero : integer; 
  encontre : boolean; 
  respuesta : string; 
begin 
  next := true;
  encontre := false; 

  writeln ('6. Modificar edad de une o mas empleades.');
  assign (a , 'empleados.txt');

  reset (a);
  while (next) do begin 
    write ('Numero del empleade: '); readln (numero);
    while ((not eof (a)) and (not encontre)) do begin 
      read (a , e); 
      if (e.nro = numero) then begin 
        encontre := true; 
        write ('Nueva edad: '); readln (e.edad);
        // voy uno atrás para escribir
        seek (a , FilePos(a)-1);
        write (a,e);
      end; 
    end;
    writeln ('');
    // pongo el puntero del archivo al inicio
    seek (a , 0);
    write ('Desea editar mas edades: ');  readln (respuesta);
    if ((respuesta = 'No') or (respuesta = 'no')) then 
      next := false;
  end; 
  close (a);
  writeln (''); 
end; 

// c. Exportar el contenido del archivo a un archivo de texto llamado “todos_empleados.txt
procedure exportar ( var a : archivoEmpleados); 
var 
	txt : Text;
	e : empleados; 
	name : string; 
begin 
	writeln ('7. Exportar a un archivo de texto');
	assign (a , 'empleados.txt');
	reset (a);
	write ('Ingrese el nombre del archivo a exportar: '); readln(name);
	assign (txt , name);
	rewrite (txt); 
	while (not eof (a)) do begin 
		read (a,e);
		writeln(txt, 'Apellido: '+ e.ape + ' Nombre: '+ e.nom+ '. Numero de empleado: ', e.nro ,'. Edad: ',e.edad,'. Dni: '+ e.dni);
	end; 
	close (a);
	close (txt);
	writeln ('');
end; 

// :) no agregue empleados con DNI 00
// d. Exportar a un archivo de texto llamado: “faltaDNIEmpleado.txt”, los empleados
// que no tengan cargado el DNI (DNI en 00).
procedure exportarSinDNI (var a : archivoEmpleados); 
var 
	txt : Text; 
	e: empleados;
	name : string; 
begin 
	writeln ('8. Exportar a un archivo de texto sin los empleados del DNI 00'); 
	assign (a , 'empleados.txt');
	reset (a); 
	write ('Ingrese el nombre del archivo a exportar: '); readln(name);
	assign (txt , name);
	rewrite (txt); 
	while (not eof (a)) do begin 
		read (a,e);
		if (e.dni = '00') then 
			writeln(txt, 'Apellido: '+ e.ape + ' Nombre: '+ e.nom+ '. Numero de empleado: ', e.nro ,'. Edad: ',e.edad,'. Dni: '+ e.dni);
	end; 
	close (a);
	close (txt);
	writeln ('');
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
  writeln ('5. Agregar empleades');
  writeln ('6. Modificar la edad de un empleade');
  writeln ('7. Exportar a un archivo de texto');
  writeln ('8. Exportar sin los DNI terminados en 00');
  writeln ('0. Para salir');
  write ('Igrese una opción: '); readln (opcion);
  case opcion of 
    '1': crearArchivo (a);
    '2': buscarApellido(a);
    '3': listarTodes(a);
    '4': mayores70(a);
    '5': agregarEmpleades(a);
    '6': modificarEdad(a);
    '7': exportar (a);
    '8': exportarSinDNI(a);
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
