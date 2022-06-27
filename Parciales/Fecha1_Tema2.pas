program Fecha1_Tema2; 
// Fecha: 07/06/2022
// Tema 2 
// Primera fecha 

{
    Un supermercado recibe, por mes, un archivo 
    de datos con la informacion de ventas realizas 
    en sus sucursales. 

    El archivo recibido tiene un formato
    El archivo ESTA ordenado por:
        -sucursal, 
        -tipo de producto, y 
        -por nombre. 

    Hacer un programa que dado el archivo este, 
    realice un informe por pantalla con el formato dado
}
TYPE 
    ventas = record 
        sucursal : integer; 
        tipo: String; 
        nombre: String; 
        precio : real; 
        vendido : integer; 
    end; 
    archivo = file of ventas; 
// modulos 
// para probar: 
procedure leerRegistro ( var r : ventas ); 
begin 
  write ('Sucursal: '); readln (r.sucursal);
  if (r.sucursal <> -1 ) then begin 
    write ('Tipo de producto: '); readln (r.tipo);
    write ('Nombre del producto: '); readln (r.nombre);
    write ('Precio del producto: '); readln (r.precio);
    write ('Cantidad vendida: '); readln (r.vendido);
  end;
end; 

procedure crearArchivo (var a : archivo);
var 
	r : ventas; 
begin
	
	assign (a , 'sucursales.txt');
	rewrite(a);
	
	leerRegistro (r);
    while (r.sucursal <> -1) do begin
    write (a , r);
    leerRegistro(r);
  end;
  close(a);
end; 
// del parcial: 
procedure listarSucursal(var a : archivo);
var 
    v : ventas;
    corteSucursal : integer; 
    corteProducto : String; 
    corteNombre : string;

    montoProducto: real;
    montoSucursal : real;

    contadorP: integer;
    
    cantVendida : integer;
begin 
    assign (a , 'sucursales.txt');
	reset(a);
    
    contadorP := 1;
    
     read(a,v);
    while (not eof(a)) do begin
        // arranca el corte de sucursal 
        montoSucursal :=0;
        corteSucursal := v.sucursal;
        while ((not eof(a)) and (v.sucursal = corteSucursal)) do begin 
            writeln ('SUCURSAL : ',v.sucursal); 
            
            // arranca el corte de tipo de producto 
            montoProducto := 0; 
            corteProducto := v.tipo;
            
            while ((not eof(a)) and (v.tipo = corteProducto) and (v.sucursal = corteSucursal)) do begin 
                writeln (#9 ,'Tipo de producto ', contadorP,': ', v.tipo);
                
                // arranca el corte del nombre de producto 
                corteNombre := v.nombre; 
                cantVendida := 0;

                while ((not eof(a)) and (v.tipo = corteProducto) and (v.nombre = corteNombre) and (v.sucursal = corteSucursal) ) do begin 
                    cantVendida := cantVendida + v.vendido; 
                    read (a,v);
                end;

                writeln (#9, #9,  'Nombre del producto: ',v.nombre);
                writeln (#9, #9, #9, 'Monto total vendido del producto: ', cantVendida*v.precio,'Cantidad vendida: ',cantVendida); 

                montoProducto := montoProducto + (cantVendida*v.precio);   
                // termina las operaciones sobre el producto             
            end; 

            writeln ('Monto vendido del tipo de producto ',contadorP,': ',v.tipo,' - ',montoProducto);
            writeln ('');
            montoSucursal := montoSucursal + montoProducto;
            contadorP := contadorP+1;
        end; 
        writeln ('Monto TOTAL de la Sucursal: ',v.sucursal,' - ',montoSucursal)
     end;
    close (a);
end; 
// programa principal 
VAR 
    a : archivo; 
BEGIN
    crearArchivo (a);
    listarSucursal (a);
END. 
