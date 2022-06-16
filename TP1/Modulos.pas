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

{ - - - - - -  Crear un archivo desde un texto - - - - - - }
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
	
	assign (texto , 'Registro.texto');
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
procedure buscarValor (var archivo : archivoDeRegistro);
var
	r : registro;
	id : integer;
	encontre : boolean;
begin 
	encontre:= false;
	reset (archivo);

	write ('Pido ID: '); readln (id); 

	while ((not eof (a)) and not encontre) do begin 
		read (archivo,r);
		if (r.clave = id) then begin 
			encontre := true;
			// voy uno para atras para poder usarlo 
			seek (archivo,FilePos(archivo)-1 );
			// hago lo que tenga que hacer
		end;
	end;

	close(archivo);
end;
{ - - - - - - - - - - - -  modificar en un archivo - - - - - - - - }
// solo un elemento 
procedure modificarValor (var archivo : archivoDeRegistro);
var
	r : registro;
	id : integer;
	encontre : boolean;
begin 
	encontre:= false;
	reset (archivo);

	write ('Pido ID: '); readln (id); 

	while ((not eof (a)) and not encontre) do begin 
		read (archivo,r);
		if (r.clave = id) then begin 
			encontre := true;
			write ('Dato a modificar: '); readln (r.modificar); 
			// voy uno para atras para escribir 
			seek (archivo,FilePos(archivo)-1 );
			write(arvhico,r);
		end;
	end;

	close(archivo);
end;
// mas de un elemento 
procedure modificarMasDeUnElemento (var archivo : archivoDeRegistro); 
var 
  r : registro;
  continuar : boolean; 
  encontre : boolean; 
  respuesta : string; 
  ID : tipoNecesario;
begin 
  continuar := true;
  encontre := false; 

  reset (archivo);

  while (continuar) do begin 
    write ('ID para buscar: '); readln (ID);
    while ((not eof (archivo)) and (not encontre)) do begin 
      read (archivo , registro); 
      if (registro.clave = ID) then begin 
        encontre := true; 
        write ('Dato a modificar: '); readln (registro.dateAModificar);
        // voy uno atrás para escribir
        seek (archivo , FilePos(archivo)-1);
        write (archivo , registro);
      end; 
    end;
    // pongo el puntero del archivo al inicio 
    seek (a , 0);
    write ('Desea editar más conjuntos: ');  readln (respuesta);
    if ((respuesta = 'No') or (respuesta = 'no')) then 
      continuar := false;
  end; 
  close (archivo);
end; 

{ - - -  - - - - - - - - - - -  aniadir registros al final - - - - }
procedure agregarRegistroAlFinal (var archivo : archivoRegistro);
var
	registro : registro; 
begin
	reset (archivo);
	leerRegistro (registro);
	// me tengo que mover al final del archivo y lo hago con seek 
	// seek (archivo , pos )
	// uso FIlesize(a) el tamanño del archivo justamente para ir al ultimo elemento 
	seek (archivo , FileSize(archivo));
	while (registro.claveUnivoca <> corte ) do begin 
		write (archivo,registro)
		leerRegistro(registro)
	end; 
	close (archivo);
end; 
{ - - - - - - - - - - - - - - - - exportar archivos - - - - - - - -}
// de binmario a texto 
// ¡! si tengo que exportar empleados con alguna condición se me hace imposible 
// reutilizar el modulo exportar, tengo que hacerlo 
// de 0, ya que es UN empleado en particular
procedure exportar ( var archivo : archivoDeAlgo); 
var 
	texto : Text;
	registro : registro; 
	nombre : string; 
begin 
	assign (archivo , 'archivo.txt');
	reset (archivo);
	write ('Ingrese el nombre del archivo a exportar: '); readln(nnombre);
	assign (texto , nombre);
	rewrite (texto); 

	while (not eof (archivo)) do begin 
		read (archivo , registro);
		writeln(texto, // las cosas del registro );
	end; 
	close (archivo);
	close (texto);
end; 
{ = = = = = = = = menus = = = = = = = = = }
// el menu tiene que ser en un procedure para poder ser recursivo 
procedure menu (var archivo : archivoRegistro); 
var 
  opcion : string; 
begin 
  writeln('================== MENU ==================');
  writeln ('1. Opcion 1');
  writeln ('2. Opcion 2'); 
  writeln ('3. ...');
  writeln ('0. Para salir');
  write ('Igrese una opción: '); readln (opcion);
  case opcion of 
    '1': metodo1 (archivo);
    '2': metodo2 (archivo);
    '3': // ...
    '0': halt; 
    else begin 
      writeln ('Ingrese una opción correcta');
    end; 
  end;
  menu (archivo);
end; 
