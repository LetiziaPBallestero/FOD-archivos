{Realizar un algoritmo que cree un archivo de números enteros no ordenados y permita
incorporar datos al archivo. Los números son ingresados desde teclado. El nombre del
archivo debe ser proporcionado por el usuario desde teclado. La carga finaliza cuando
se ingrese el número 30000, que no debe incorporarse al archivo}

program punto1; 
const
  fin = 30000;
TYPE 
  archivoEnteros = file of integer; 
// modulos
procedure crearArchivo (var a : archivoEnteros);
var 
  num : integer;
begin 
  reset (a);
  write('Ingrese un numero o 30000 para terminar: ');
  readln (num);
  while (num <> fin) do begin
      write (a , num);
      write('Ingrese un numero o 30000 para terminar: ');
      readln (num);
  end;
  close(a)
end;

// main 
VAR 
  archivo : archivoEnteros;
  nombreArchivo : string;
BEGIN 
  write ('Nombre del archivo: '); 
  readln (nombreArchivo);
  assign (archivo , 'nombreArchivo.txt');
  rewrite(archivo);
  close(archivo);
  crearArchivo(archivo);
END. 
