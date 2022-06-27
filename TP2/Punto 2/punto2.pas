program punto2; 
TYPE 
    alumno = record 
        cod : integer; 
        apellido : string; 
        nombre : string; 
        cursadas: integer; 
        // sin final = cursadas , con final  = finalizadas 
        finalizadas : integer;
    end; 

    materia = record
        codigoAlumno : integer; 
        // 'finalizada' o 'cursada'
        estado : String; 
    end; 

    alumnosMaestro = file of alumno; 
    archivoMaterias = file of materias; 

                                              { Zona de modulos }
// crear archivos 
procedure leerMateria (var m : materia);
begin 
    write ('Codigo de alumno: '); readln (m.codigoAlumno); 
    if (m.codigoAlumno <> -1 ) then begin 
        write('Estado de la materia ("finalizada" si es con final o "cursada" si no tiene final: '); 
        readln (m.estado);
    end; 
end;

procedure crearArchivos ( var d : archivoMaterias)
var 
    m : materia;
begin 
    assgin (d , 'Detalle.txt');
    rewrite (d);
    leerMateria(m); 
    if (m.codigoAlumno <> -1 ) then begin 
        write(d,m);
        leerMateria(m);
    end;
end;

procedure leerAlumno (var a : alumno);
begin 
    write ('Codigo de alumno: '); readln (a.cod); 
    if (a.cod <> -1 ) then begin 
        write ('Apellido del alumno: '); readln (a.apellido);
        write ('Nombre del alumno: '); readln (a.nombre);
        write ('Materias aprobadas SIN final: '); readln (a.cursadas);
        write ('Materias CON final aprobado: '); readln (a.finalizadas);
    end; 
end;

procedure crearArchivoMaestro ( var m : alumnosMaestro);
var 
    a : alumno;
begin 
    assgin (m , 'Maestro.txt');
    rewrite (m);
    leerAlumno(a); 
    if (a.cod <> -1 ) then begin 
        write(m,a);
        leerAlumno(a);
    end;
end;
// merge 
procedure leerMateria ( var detalle : archivoMaterias ; var dato : materia); 
begin
	if (not eof(detalle)) then 
		read (detalle, dato)
	else 
		dato.codigoAlumno := -1;
end;

procedure leerAlumno ( var maestro : alumnosMaestro ; var dato : alumno); 
begin 
    if (not eof (maestro)) then 
        read (maestro,dato)
    else 
        dato.cod := -1; 
end; 

procedure merge (var maestro : alumnosMaestro ; var detalle : archivoMaterias); 
var
    corteMateria : materia;
    corteAlumno : alumno; 
    alumnoNuevo : alumno; 
begin 
{ 
Actualizar el archivo maestro de la siguiente manera:
i.Si aprobó el final se incrementa en uno la 
cantidad de materias con final aprobado.

ii.Si aprobó la cursada se incrementa en uno la cantidad 
de materias aprobadas sin final.
}

    assign (maestro , 'Maestro.txt'); 
    reset (maestro); 

    assign (detalle , 'Detalle.txt');
    reset (detalle); 

    leerMateria (detalle ,  corteMateria); 
    while (corteMateria.codigoAlumno <> -1 ) do begin 
        leerAlumno (maestro , corteAlumno);
        while (corteAlumno.cod <> alumnoNuevo.cod)  do
            // la primera vez lo voy a saltear, pero lo necesito para 
            // buscar una segunda vez
            leerAlumno (maestro , corteAlumno); 
        while (corteMateria.cod = corteAlumno.cod) do begin 
            if (corteMateria.estado = 'cursada') then 
                    corteAlumno.cursadas := corteAlumno.cursadas + 1; 
            if (corteMateria.estado = 'finalizada') then 
                    corteAlumno.finalizadas := corteAlumno.finalizadas + 1;
            leerMateria(detalle , corteMateria);
        end; 
        // -1 y actualizo:  
        seek (maestro , filepos (maestro)-1); 
        write (maestro , corteAlumno);
    end; 
    close (maestro); 
    close (detalle);
end; 
// listar archivos 
procedure imprimirTextoAlumno( var listado : text ;  a : alumnos); 
begin
    with a do begin 
        writeln(listado,' ',cod,' ',apellido,' ',nombre);
        writeln(listado,' ',cursadas,' ',finalizadas);
    end;
end; 

procedure listarCuatroMaterias (var maestro : alumnosMaestro);
var
	a : alumno; 
	listado : text; 
begin 
	assign (maestro , 'Maestro.txt');
	assign (listado , 'Alumnos_Sin_Final.txt');
	
	reset (maestro);
    rewrite (listado);
    
    leerAlumno(maestro , a);
    while (a.cod <> -1) do begin 
		if (a.cursadas > 4) and (a.finalizadas < a.finalizadas) then 
			imprimirTextoAlumno (listado , a); 
		leerAlumno (maestro , a); 
	end; 
	
	close (maestro); 
	close(listado);
end;
                                                   { Menu }
procedure menu ( var maestro : alumnosDetalle ; var detalle : archivoMaterias); 
var 
    opcion : string;
begin 
    writeln ('======================= MENU =========================='); 
    wirteln ('1. Actualizar archivo de alumnos');
    writeln ('2. Listar alumnos');
    writeln ('0. Para salir');
    write ('Ingrese una opcion: '); readln (opcion);
    case opcion of 
        '1': merge (maestro,detalle);
        '2': imprimirArchivo (maestro);
        '0': halt; 
        else begin 
            writeln ('Ingrese una opcion correcta'); 
        end; 
    end; 
    menu (maestro,detalle);
end;
                                            { Programa principal }
VAR
    maestro = alumnosMaestro; 
    detalle = archivoMaterias; 
BEGIN
    crearArchivos(detalle);
    crearArchivoMaestro (maestro);
    menu (maestro,detalle);
END. 