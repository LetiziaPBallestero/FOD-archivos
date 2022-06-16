program Pcelulares; 
TYPE 
  celulares = record 
    cod : integer; 
    nom : string; 
    des: string; 
    marca : string; 
    precio : real; 
    stockM : integer; 
    stockD : integer; 
  end; 

  archivoCelulares = file of celulares; 
  
// modulos 
procedure listarTelefono (c : celulares); 
begin 
	writeln ('- Datos básicos -');
	writeln('Codigo: ',c.cod,'. Nombre: ',c.nom,'. Marca: ',c.marca);
	writeln('Descripcion: ',c.des);
	writeln('Stock disponible: ',c.stockD,' - Stock minimo: ',c.stockM);
end;

// a. crear un archivo 
procedure leerCelular (var c : celulares); 
begin
	write ('Codigo de telefono: ');readln(c.cod);
	if (c.cod <> -1) then begin 
		write ('Nombre del telefono: '); readln (c.nom);
		write ('Descripcion del telefono: '); readln (c.des);
		write ('Marca del telefono: '); readln (c.marca);
		write ('Precio del telefono: '); readln (c.precio);
		write ('Stock minimo: '); readln (c.stockM);
		write ('Stock Disponible: '); readln (c.stockD);
	end;
end; 

procedure crearArchivo (var a : archivoCelulares); 
var 
	c : celulares; 
	name : string; 
	texto : Text; 
begin
	writeln ('---- 1 : Crear el archivo binario mediante uno existente'); 
	
	write ('Nombre del archivo: '); readln (name); 
	assign (a , name);
	rewrite(a);
	
	assign (texto , 'Celulares.txt');
	reset (texto); 
	
	while (not eof (texto)) do begin
		with c do begin 
			readln(texto, cod, nom, des, marca, precio, stockM, stockD);
		end; 
		write (a , c); 
	end; 
	close(texto);
	close(a);
end; 

// b. Listar en pantalla los celulares que tengan un stock menor al stock minimo 
procedure listarStockFaltante(var a : archivoCelulares); 
var 
	 c : celulares; 
begin 
	writeln ('---- 2: Se van a listar los telefonos con un stock disponible MENOR al minomo');
	
	reset (a); 
	while (not eof (a)) do begin 
		read (a,c); 
		if (c.stockD < c.stockM) then 
			listarTelefono(c);
	end;
	close (a);		
end; 

// c. Listar en pantalla los celulares del archivo cuya descripción contenga una
// cadena de caracteres proporcionada por el usuario.
procedure listarDescripcion (var a : archivoCelulares); 
var 
	c : celulares; 
	descripcion : string;
begin 
	writeln ('---- 3: Dada la descripcion, listar los telefonos.'); 
	reset (a);
	
	write ('Descripcion a buscar: ');readln(descripcion);
	while (not eof (a)) do begin 
		read(a,c); 
		if Pos(descripcion, c.des) <> 0 then
			listarTelefono(c);
	end;
end; 

// d.  Exportar el archivo creado en el inciso a) a un archivo de texto denominado
// “celulares.txt” con todos los celulares del mismo.
procedure exportarATexto (var a : archivoCelulares);
var 
	c : celulares; 
	texto: text; 
begin 
	writeln ('---- 4: Exportar a texto');

	reset (a); 
	
	assign (texto , 'celular.txt'); 
	rewrite (texto);
	
	while (not eof(a)) do begin 
		read (a,c);
		writeln(texto, c.cod, c.precio, c.marca);
		writeln(texto,c.stockD , c.stockM, c.des);
		writeln(texto,c.nom);
	end;
	close (texto); 
	close (a);
end; 


/// punto 6, 
// aniadir uno o más celulares al final del archivo con sus datos
// ingresados por teclado
procedure agregarCelulares (var a : archivoCelulares);
var
	c : celulares;
begin
	writeln ('---- 5: Agregar telefonos.')
	reset (a);
	leerCelular(c);
	// me tengo que mover al final del archivo y lo hago con seek 
	// seek (archivo , pos )
	// uso FIlesize(a) el tamanño del archivo justamente para ir al ultimo elemento 
	seek (a , FileSize(a));
	while (c.cod <> -1 ) do begin 
		write (a,c)
		leerCelular(c);
	end; 
	close (a);
	wirteln(''); 
end; 

// modificar el stock de un telefono dado 
procedure modificarStock (var a : archivoCelulares);
var
	c : celulares;
	id : integer;
	encontre : boolean;
begin 
	writeln ('---- 6: Modificar el stock de un telefono dado');
	encontre:= false;
	reset (a);

	write ('Cual es el ID del telefono que desea editar: '); readln (id); 

	while ((not eof (a)) and not encontre) do begin 
		read (a,c);
		if (c.cod = id) then begin 
			encontre := true;
			write ('Nuevo stock: '); readln (c.stockD); 
			// voy uno para atras para escribir 
			seek (a,FilePos(a)-1 );
			write(a,c);
		end;
	end;

	close(a);
	writeln('');
end;

// Exportar el contenido del archivo binario a un archivo de texto denominado:
// ”SinStock.txt”, con aquellos celulares que tengan stock 0 

procedure exportarATextoSinStock (var a : archivoCelulares);
var 
	c : celulares;
	texto : Text;
begin 
	writeln ('---- 7. Expotar a un archivo de texto los telefonos sin stock');
	reset (a);

	assign (texto , 'CelularesSinStock.txt');
	rewrite (texto);
	while (not eof (a)) do begin 
			read (a,c);
			if (c.stockD == 0) then begin 
					writeln(texto,c.cod, c.precio, c.marca);
					writeln(texto,c.stockD , c.stockM, c.des);
					writeln(texto,c.nom);
			end;
	end;
	close (a);
	close (texto); 
end;

// ------------------- menu 
procedure menu (var a : archivoCelulares); 
var 
	opcion: string;
begin 
writeln('================== MENU ==================');
  writeln ('1. Crear un archivo');
  writeln ('2. Listar celulares con stock faltante');
  writeln ('3. Buscar por descripcion');
  writeln ('4. Exportar a texto');
	writeln ('5. Agregar celulares');
	writeln ('6. Modificar el stock de un telefono');
	writeln ('7. Expotar a un archivo de texto los telefonos sin stock');
  writeln ('0. Para salir');
  write ('Igrese una opcion: '); readln (opcion);
  writeln ('');
  case opcion of 
    '1': crearArchivo (a);
    '2': listarStockFaltante(a);
		'3': listarDescripcion(a);
		'4': exportarATexto(a);
		'5': agregarCelulares(a);
		'6': modificarStock(a);
		'7': exportarATextoSinStock(a);
    '0': halt; 
    else begin 
      writeln ('Es usted bolude? Ingreso una opcion invalida.');
    end; 
  end;
  menu (a);
end; 

// programa principal 
VAR
	archivo : archivoCelulares; 
BEGIN 
	menu (archivo);
END. 
