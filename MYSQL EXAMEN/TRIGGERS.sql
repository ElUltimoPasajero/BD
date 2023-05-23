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

CREATE TABLE IF NOT EXISTS nueva_peliculas(
	id_peli int,
    	nombre_peli VARCHAR(30),
    	duracion INT,
    	director_peli VARCHAR(20),
    	género_peli ENUM ('acción', 'drama', 'comedia'),
   	nota_peli FLOAT,
	calidad enum ("buena", "regular", "mala"),
	estado enum ("activo", "eliminado") default "activo",
    	primary key (id_peli)
);

	CREATE TABLE IF NOT EXISTS informe_modificaciones(
		id int,
  	 	usuario varchar(30),
		fecha date,
 	  	hora time
	);
    
    
   /* Ejercicio 1.- Crea un trigger Backup_peliculas que se encargue de guardar en una segunda tabla nueva_peliculas todos los datos que se inserten en la tabla original, cada vez que se realicen inserciones en la base de datos.*/
   
   DROP TRIGGER BACKUP
   DELIMITER //
   CREATE TRIGGER BACKUP
   AFTER INSERT ON PELICULAS
   FOR EACH ROW
   BEGIN
   INSERT INTO NUEVA_PELICULAS(NOMBRE_PELI,DURACION,DIRECTOR_PELI,GÉNERO_PELI,NOTA_PELI,ID_PELI)VALUES
   (NEW.NOMBRE_PELI,NEW.DURACION,NEW.DIRECTOR_PELI,NEW.GÉNERO_PELI,NEW.NOTA_PELI,NEW.ID_PELI);
   
   
   END//
   
   INSERT INTO PELICULAS(NOMBRE_PELI,DURACION,DIRECTOR_PELI,GÉNERO_PELI,NOTA_PELI,ID_PELI)VALUES("CACA",10,"YO","ACCIÓN",10,30);
   
  /* Ejercicio 2.- Crea un trigger eliminadas que se encargue de asignar un valor de Estado “eliminado” en la tabla nueva_peliculas a las películas que se eliminen de la tabla Peliculas. */
  
  DELIMITER // 
  CREATE TRIGGER ELIMINADA
  AFTER DELETE ON PELICULAS
  FOR EACH ROW
  BEGIN
  
  UPDATE NUEVA_PELICULAS SET ESTADO="ELIMINADO" WHERE ID_PELI=OLD.ID_PELI;
  

  END//
  
  
  /*Ejercicio 3.- Crea un trigger calidad_peliculas que se encargue de asignar un valor de Calidad en la tabla nueva_peliculas en base a la nota de las películas, cada vez que se realicen inserciones en la tabla Peliculas. 

	- Si la nota de las películas es mayor que 5, se les asignará calidad “buena”
	- Si la nota de las películas es menor que 5, se les asignará calidad “mala”
	- Si la nota de las películas es igual que 5, se les asignará calidad “regular”*/
    
  DELIMITER //
CREATE TRIGGER calidad_peliculas
AFTER INSERT ON peliculas
FOR EACH ROW
BEGIN
	declare cal varchar(20);
    
		if NEW.nota_peli > 5 then
			set cal="buena";
		elseif NEW.nota_peli < 5 then
			set cal="mala";
		else 
			set cal="regular";
		end if;

    insert into nueva_peliculas (nombre_peli, duracion, director_peli, género_peli, nota_peli, id_peli, calidad) 	VALUES (NEW.nombre_peli, NEW.duracion, NEW.director_peli, NEW.género_peli, NEW.nota_peli, 	NEW.id_peli, cal);
END//


delimiter //

CREATE TRIGGER calidad_peliculas
AFTER INSERT ON Peliculas
FOR EACH ROW
BEGIN
    IF NEW.nota_peli > 5 THEN
        INSERT INTO nueva_peliculas(id_peli, nombre_peli, duracion, director_peli, género_peli, nota_peli, calidad, estado)
        VALUES (NEW.id_peli, NEW.nombre_peli, NEW.duracion, NEW.director_peli, NEW.género_peli, NEW.nota_peli, 'buena', 'activo');
    ELSEIF NEW.nota_peli < 5 THEN
        INSERT INTO nueva_peliculas(id_peli, nombre_peli, duracion, director_peli, género_peli, nota_peli, calidad, estado)
        VALUES (NEW.id_peli, NEW.nombre_peli, NEW.duracion, NEW.director_peli, NEW.género_peli, NEW.nota_peli, 'mala', 'activo');
    ELSE
        INSERT INTO nueva_peliculas(id_peli, nombre_peli, duracion, director_peli, género_peli, nota_peli, calidad, estado)
        VALUES (NEW.id_peli, NEW.nombre_peli, NEW.duracion, NEW.director_peli, NEW.género_peli, NEW.nota_peli, 'regular', 'activo');
    END IF;
    
 
END //

  
/*  Crea un trigger modificaciones que se encargue de almacenar en la tabla Informe_modificaciones los siguientes datos cada vez que se modifique algún dato de la tabla Peliculas.

- ID: identificador de la película modificada
- Usuario_conectado: usuario que ha realizado la modificación (usuario conectado en MySQL)
- Fecha: fecha de la modificación
- Hora: hora de la modificación */

DROP TRIGGER MODIFICACIONES
DELIMITER //
CREATE TRIGGER modificaciones
AFTER UPDATE ON peliculas
FOR EACH ROW
BEGIN
declare usuario_conectado varchar(30);
set usuario_conectado=(select user());

INSERT INTO informe_modificaciones (id, usuario, fecha, hora) values (NEW.id_peli, usuario_conectado, curdate(), now());
END//

SELECT*FROM PELICULAS;
UPDATE PELICULAS SET DURACION=200 WHERE ID_PELI = 30;
SELECT*FROM INFORME_MODIFICACIONES;
   
   
