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


/* Ejercicio 1.- Realiza un procedimiento donde se inserte una nueva película a la tabla “Peliculas” con los datos expuestos. Una vez hecho esto, haz que en el propio procedimiento se muestre la tabla resultante.
- Nombre película: La historia interminable
- Duración: 110
- Director: Barbara
- Género: acción
- Nota: 8
- Identificador: 3 */

DROP PROCEDURE INSERTAR;
DELIMITER //
CREATE PROCEDURE INSERTAR(NOMBRE VARCHAR(50),DURACION INT,DIRECTOR VARCHAR(50),GENERO VARCHAR(50),NOTA INT, ID INT)
BEGIN

INSERT INTO PELICULAS(NOMBRE_PELI, DURACION,DIRECTOR_PELI,GÉNERO_PELI,NOTA_PELI,ID_PELI)VALUES
(NOMBRE,DURACION,DIRECTOR,GENERO,NOTA,ID);

SELECT * FROM PELICULAS;


END//

CALL INSERTAR("LA HISTORIA INTERMINABLE",110,"BARBARA","ACCION",8,3);

/*Ejercicio 2.- Realiza un procedimiento que modifique la nota de una película. El nombre de la película y la nota se insertarán a través del Select. Una vez hecho esto, haz que en el propio procedimiento se muestre la tabla resultante.*/

DELIMITER //
CREATE PROCEDURE MODIFICAR(NOMBRE VARCHAR(50), NOTA INT)
BEGIN

UPDATE PELICULAS SET NOTA_PELI=NOTA WHERE NOMBRE_PELI=NOMBRE;

SELECT * FROM PELICULAS;

END//

CALL MODIFICAR("EL HOYO",10);

/*Ejercicio 3.- Realiza un procedimiento que añada valores de forma automática a nueva columna llamada “Valoraciones” en la tabla películas. La columna Valoraciones podrá tener 3 valores (buena, mala o regular).
- Si la nota de la película es menor que 3.5, la valoración será “mala”
- Si la nota de la película es mayor que 7, la valoración será “buena”
- Si la nota de la película está entre 3.5 y 7 (ambos incluidos), la valoración será “regular”*/

DROP PROCEDURE VALORACIONES;
DELIMITER //
CREATE PROCEDURE VALORACIONES()
BEGIN

ALTER TABLE PELICULAS ADD VALORACION ENUM("BUENA","MALA","REGULAR");

UPDATE PELICULAS SET VALORACION="MALA" WHERE NOTA_PELI < 3.5;
UPDATE PELICULAS SET VALORACION="BUENA" WHERE NOTA_PELI > 7;
UPDATE PELICULAS SET VALORACION="REGULAR" WHERE NOTA_PELI >= 3.5 AND NOTA_PELI <= 7;

SELECT*FROM PELICULAS;

END//

CALL VALORACIONES();


/*Ejercicio 4.- Realiza un procedimiento que modifique el director/directora de una película seleccionada por el usuario de la tabla Películas. Una vez hecho esto, haz que en el propio procedimiento se muestre la tabla resultante.
- El usuario insertará el identificador de la pelícila que desea modificar a través del Select
- El usuario insertará el nombre del director a través del select*/

DROP PROCEDURE MODIFICARDIRECTOR;
DELIMITER //
CREATE PROCEDURE MODIFICARDIRECTOR(NOMBREDIRECTOR VARCHAR(50),ID INT)

BEGIN

UPDATE PELICULAS SET DIRECTOR_PELI=NOMBREDIRECTOR WHERE ID=ID_PELI;

SELECT*FROM PELICULAS;

END//

CALL MODIFICARDIRECTOR("MIGUELILLO",17);
