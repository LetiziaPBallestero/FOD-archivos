program punto1; 
TYPE 
    empleado = record
        cod : integer; 
        nombre: string; 
        monto : double;
    end;

    archivo_comisiones = file of empleado; 
    archivo_maestro = file of empleado; 
                                      {zona de modulos} 
// modulos para crear el archivo 
procedure leerRegistro (var e : empleado);
begin 
    write ('Codigo de empleado: '); readln (e.cod);
    if (e.cod <> -1) then begin
        write ('Nombre del empleado: '); readln (e.nombre);
        write ('Monto de empleado: '); readln (e.monto);
    end;
end; 

procedure crearArchivo (var archivo : archivo_comisiones); 
var 
    e : empleado;
begin 
    assign (archivo , 'ArchivoDeEmpleado.txt');
    rewrite (archivo);

    leerRegistro (e);
    while (e.cod <> -1) do begin 
        write (archivo , e); 
        leerRegistro (e);
    end; 
    close (archivo);
    writeln ('');
end; 

// modulos relacionados con el ejercicio 
    // 2. imprimir archivo 
        // 2.1 imprimir registro 
procedure imprimirRegistro (e : empleado); 
begin 
	writeln ('Codigo de empleado: ',e.cod,' - Nombre: ',e.nombre,' - Comision: ',e.monto:5:2);
end;

procedure imprimirArchivoMaestro (var m : archivo_maestro); 
var 
    e : empleado; 
begin 
    reset (m); 
    while (not eof (m)) do begin 
        read (m , e ); 
        imprimirRegistro (e); 
    end; 
    close (m); 
end; 
procedure imprimirArchivoDetalle (var d : archivo_comisiones); 
var 
    e : empleado; 
begin 
	assign (d , 'ArchivoDeEmpleado.txt');
    reset (d); 
    while (not eof (d)) do begin 
        read (d,e); 
        imprimirRegistro (e);
    end; 
    close (d);
    writeln ('');
end; 

// 1. merge de archivo, el empleado puede aparecer más de una vez y esta ordenaod por codigo
// 1.1 recorrer el archivo con un corte de control por empleado 
// 1.2 generar un archivo juntando estos 

// ¡¡¡!!! importante esto para no saltearse el ultimo registro con el tema de los punteros 
procedure leer( var detalle: archivo_comisiones; var dato: empleado);
begin
	if (not eof(detalle)) then 
		read (detalle, dato)
	else 
		dato.cod := -1;
end;

procedure merge (var m : archivo_maestro ; var d : archivo_comisiones); 
 var 
    nuevoEmpleado : empleado;
    corteEmpleado : empleado;  
    montoAuxiliar : real; 
begin 
    // abrir el archivo detalle y generar el archivo maestro 
    assign (d , 'ArchivoDeEmpleado.txt');
    reset (d); 

    assign (m , 'Maestro.txt');
    rewrite (m);

		leer (d , corteEmpleado);
        while (corteEmpleado.cod <> -1)do begin 
			montoAuxiliar := 0; 
            nuevoEmpleado := corteEmpleado; 
            while ((nuevoEmpleado.cod = corteEmpleado.cod) and (corteEmpleado.cod <> -1)) do begin 
                montoAuxiliar := montoAuxiliar + corteEmpleado.monto; 
                leer (d , corteEmpleado); 
            end; 
            // este bucle termino porque llegue, como minimo, a otro empleado
            nuevoEmpleado.monto := montoAuxiliar; 
            write(m , nuevoEmpleado);
        end; 
    close (d); 
    close (m); 
end; 
                                    {programa principal }
VAR
    maestro : archivo_maestro; 
    detalle : archivo_comisiones; 
BEGIN 
    // crearArchivo (detalle); 
    imprimirArchivoDetalle(detalle);
    merge(maestro,detalle); 
    imprimirArchivoMaestro(maestro); 
END. 
