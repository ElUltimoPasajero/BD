CREATE DATABASE IF NOT EXISTS Netflix;
USE Netflix;

CREATE TABLE IF NOT EXISTS Peliculas(
	id_peli int,
    nombre_peli VARCHAR(30),
    duracion INT,
    director_peli VARCHAR(20),
    género_peli ENUM ('acción', 'drama', 'comedia'),
    nota_peli FLOAT,
    primary key (id_peli)
);

INSERT INTO Peliculas (nombre_peli, duracion, director_peli, género_peli, nota_peli, id_peli) VALUES
('Bright', 120, 'Fernando', 'acción', 3.1, 1),
('Frida', 100, 'Daniel', 'drama', 7.6, 10),
('Los dos papas', 160, 'Adrián', 'comedia', 8.3, 11),
('Animales nocturnos', 185, 'Tomás', 'drama', 9.5, 100),
('Oceans Eleven', 150, 'Nuria', 'acción', 3.5, 21),
('Buscando a Nemo', 120, 'Jon', 'acción', 2.1, 17),
('El Hoyo', 110, 'Ivan', 'acción', 9.9, 41),
('Diamante en bruto', 140, 'Paola', 'acción', 7, 101);

/*aquí tienes un procedimiento que actualiza la columna notas, dado un ID, una elección y dos números*/

delimiter //
create procedure hola(eleccion varchar(15), num1 int, num2 int, identificador int)
begin
declare nueva decimal(2,1);
if eleccion = "elevado" then
set nueva=(select elevado(num1, num2));
elseif eleccion = "raiz" then
set nueva=(select raiz(num1));
end if;

update peliculas set nota=nueva where id=identificador;
select * from peliculas;
end//

 

delimiter //
create function elevado (num1 int, num2 int) returns int no sql
begin
declare resultado int;
set resultado=power(num1, num2);
return resultado;
end //

 

delimiter //
create function raiz (num1 int) returns decimal(2,1) no sql
begin
declare resultado decimal(2,1);
set resultado=sqrt(num1);
return resultado;
end //


call hola("elevado", 3, 2, 6);


/*procedimiento para cambiar orden de las letras de una palabra*/

DROP PROCEDURE ADIOS;

delimiter //

create procedure adios(identificador int)
begin
declare nom varchar(20);
declare nuevo varchar(20);
declare num int;
declare cont int;
declare letra varchar(2);


set nuevo="";
set cont=0;
set nom=(select nombre_peli from peliculas where id_peli=identificador);
set num=(select char_length(nombre_peli) from peliculas where id_peli=identificador);


while cont <= num do
set letra=SUBSTRING(nom, num, 1);
set nuevo=concat(nuevo, letra);
set num=num-1;
end while;

update peliculas set nombre_peli=nuevo where id_peli=identificador;
select * from peliculas;
end//



call adios(17);





DELIMITER //

CREATE PROCEDURE cambiar_orden_nombre_pelicula(IN pelicula_id INT)
BEGIN
    DECLARE nombre_pelicula VARCHAR(30);
    DECLARE nuevo_nombre_pelicula VARCHAR(30);
    
    
    SELECT nombre_peli INTO nombre_pelicula FROM Peliculas WHERE id_peli = pelicula_id;
    
    SET nuevo_nombre_pelicula = REVERSE(nombre_pelicula);
    
 
    UPDATE Peliculas SET nombre_peli = nuevo_nombre_pelicula WHERE id_peli = pelicula_id;
    
   
    SELECT nuevo_nombre_pelicula AS 'Nuevo nombre de la película';
END//



