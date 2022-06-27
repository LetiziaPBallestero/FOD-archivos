{ Para leer correctamente sin que tengas que poner while (eof) y perder las cosas 
le mandas uno antes del bucle de corte y después otro en el corazon del codigo}
procedure leer( var detalle: archivo_detalle; var dato: registro);
begin
	if (not eof(detalle)) then 
		read (detalle, dato)
	else 
		dato.CONDICION_DE_FIN := CONDICION;
end;

{ Merge con un detalle del mismo tipo }
procedure merge (var maestro : archivo_maestro ; var detalle : archivo_detalle); 
 var 
    nuevoRegistro : registro;
    corteRegistro : registro;  
    variableAcumulable : tipo_necesario; 
begin 
    // abrir el archivo detalle y generar el archivo maestro 
    assign (detalle , 'Detalle.txt');
    reset (detalle); 

    assign (maestro , 'Maestro.txt');
    rewrite (maestro);

		leer (detalle , corteRegistro);
        while (corteRegistro.CONDICION_DE_FIN <> -1)do begin 
			variableAcumulable := 0; 
            nuevoRegistro := corteRegistro; 
            while ((nuevoRegistro.CONDICION = corteRegistro.CONDICION) and (corteRegistro.CONDICION_DE_FIN <> -1)) do begin 
                variableAcumulable := variableAcumulable + corteRegistro.ACUMULABLE; 
                leer (detalle , corteRegistro); 
            end; 
            // este bucle termino porque llegue, como minimo, a otro empleado
            nuevoRegistro.ACUMULABLE := variableAcumulable; 
            write(maestro , nuevoRegistro);
        end; 
    close (detalle); 
    close (maestro); 
end; 