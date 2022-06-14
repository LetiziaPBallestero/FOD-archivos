program punto2;
{Realizar un algoritmo, que utilizando el archivo de números enteros no ordenados
creados en el ejercicio 1, informe por pantalla cantidad de números menores a 1500 y
el promedio de los números ingresados. El nombre del archivo a procesar debe ser
proporcionado por el usuario una única vez. Además, el algoritmo deberá listar el
contenido del archivo en pantalla.}
CONST 
  tope=1500;
TYPE 
  archivoEnteros = file of integer; 
// modulos 
function promedio (suma : integer ; cant : integer) : real; 
begin 
  promedio:= (suma/cant);
end; 

procedure procesar (var a : archivoEnteros); 
var 
  suma : integer;
  numMenores : integer; 
  num : integer; 
begin 
  reset (a);
  suma := 0; 
  numMenores := 0;
  while (not eof (a)) do begin
    read (a , num); 
    suma := suma + num; 
    if (num < tope) then 
      numMenores:= numMenores+1;
  end; 

  writeln ('Hay ',numMenores,' menores a 1500');
  writeln ('La suma es de: ',suma);
  writeln ('Hay estos elementos: ',FileSize(a));
  writeln ('El promedio de los numeros del archivo es ',promedio(suma, FileSize(a)):2:2);
  writeln ('Esta bien, pero en el archivo original meti un numero asquerosamente grande tipo 2145458762 pero no era 30000 asi que pasi igual y claramente se me chanfleo algo por eso');
  close (a);
end; 
	
// programa principal
VAR
  nombre : string; 
  archivo: archivoEnteros;
BEGIN 
  writeln ('El archivo se llama nombreArchivo, porque soy tonta');

  write ('Archivo a leer: ');
  read (nombre); 

  Assign (archivo , nombre+'.txt'); 
  procesar (archivo);
END. 
