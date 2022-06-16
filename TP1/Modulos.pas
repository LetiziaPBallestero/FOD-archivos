// Modulos que he visto repetidos 

{ - - - - - - - - - Crear un archivo - - - - - - - - - - - - }
{ Crear un archivo siempre consta de 2 metodos: leer el registro y crear el archivo }
procedure leerRegistro ( var r : registro ); 
begin 
  write ('Clave univoca: '); readln (r.clave);
  if (r.clave <> corte ) then begin 
    // leo el resto 
  end;
end; 

procedure crearArchivo (var archivo : archivoRegitro); 
var 
	r : registro;
	name : string; 
begin	
	write ('Nombre del archivo: '); readln (name); 
	assign (archivo , name);
	rewrite(archivo);
	
  leerRegistro (r);
  while (r.clave <> corte) do begin
    write (archivo , r);
    leerRegistro;
  end;
  close(archivo);
end; 

{ - - - - - -  Crear un archivo desde un txt - - - - - - }
// como se lee desde un archivo diferente 
// no tengo que leer el registro para esto
procedure crearArchivo (var archivo : archivoRegistro); 
var 
	registro : registro; 
	name : string; 
	texto : Text; 
begin
	
	write ('Nombre del archivo: '); readln (name); 
	assign (archivo , name);
	rewrite(archivo);
	
	assign (texto , 'Registro.txt');
	reset (texto); 
	
	while (not eof (texto)) do begin
		with r do begin 
			readln(texto, // campos del registro);
		end; 
		write (archivo , registro; 
	end; 
	close(texto);
	close(archivo);
end; 

{ - - - - - - - - - - - - listar en panalla - - - - - - - - - - }
procedure listarRegistro (r : registro);
begin 
  writeln ('Campos :' r.campo);
end;

procedure listarArchivo (var archivo : archivoDeRegistro); 
var 
  r : registro;
begin 
  reset (archivo);
  while (not eof (archivo)) do begin 
    read (archivo , r);
    if ( ) then // condicion 
      listarRegistro(r);
    end;
  end;
  close (archivo);
end; 

{ - - - -  - - - - - -  - -buscar en un archivo - - - - - -  - - - }
{ - - - - - - - - - - - -  modificar en un archivo - - - - - - - - }
{ - - -  - - - - - - - - - - -  aniadir registros al final - - - - }
{ - - - - - - - - - - - - - - - - exportar archivos - - - - - - - -}
// de binmario a texto 
// de texto a binario 
{ = = = = = = = = menus = = = = = = = = = }
