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


/* Crea una función en MySQL que se encargue de mostrar información de la tabla películas.

- Número de películas que contiene la tabla

- Media de duración de las películas

- Puntuación máxima de las notas de las películas

- Puntuación mínima de las notas de las películas*/

DROP FUNCTION MOSTRAR;
DELIMITER //
CREATE FUNCTION MOSTRAR() RETURNS VARCHAR (200) NO SQL
BEGIN
DECLARE TOTALPELIS INT;
DECLARE MEDIADURACION INT;
DECLARE MAXIMA DECIMAL(2,1);
DECLARE MINIMA DECIMAL(2,1);
DECLARE RESULTADO VARCHAR(200);


SET TOTALPELIS=(SELECT COUNT(*)FROM PELICULAS);
SET MEDIADURACION=(SELECT AVG(DURACION)FROM PELICULAS);
SET MAXIMA=(SELECT MAX(NOTA_PELI)FROM PELICULAS);
SET MINIMA=(SELECT MIN(NOTA_PELI)FROM PELICULAS);
SET RESULTADO=CONCAT(" TOTAL ", TOTALPELIS," DURACION MEDIA ", MEDIADURACION," MAXIMA NOTA ", MAXIMA ," MINIMA NOTA ", MINIMA);


RETURN RESULTADO;


END //

SELECT MOSTRAR();

/*Crea una función en MySQL que a partir de dos IDs insertados por el usuario, devuelva el nombre de la película con menor puntuación de las dos.*/

DROP FUNCTION NOMBREID;
DELIMITER //
CREATE FUNCTION NOMBREID(ID1 INT, ID2 INT)RETURNS VARCHAR(200) NO SQL
BEGIN
DECLARE PUNTUACION1 DECIMAL(2.1);
DECLARE PUNTUACION2 DECIMAL(2,1);
DECLARE NOMBREPELI VARCHAR(200);

SET PUNTUACION1=(SELECT NOTA_PELI FROM PELICULAS WHERE ID_PELI=ID1);
SET PUNTUACION2=(SELECT NOTA_PELI FROM PELICULAS WHERE ID_PELI=ID2);

IF (PUNTUACION1<PUNTUACION2) THEN
 SET NOMBREPELI=(SELECT NOMBRE_PELI FROM PELICULAS WHERE ID_PELI=ID1);
 ELSEIF (PUNTUACION1>PUNTUACION2) THEN
 SET NOMBREPELI=(SELECT NOMBRE_PELI FROM PELICULAS WHERE ID_PELI=ID2);

END IF;

RETURN NOMBREPELI;


END //

SELECT NOMBREID(1,10);


/*Crea un procedimiento que modifique la puntuación de la película “Buscando a Nemo” sumándole un punto a su puntuación establecida. Muestra la tabla resultante al finalizar el procedimiento.

- Realiza la suma del punto mediante la función “Sumapunto” e intégrala en el procedimiento

- En el procedimiento deberás insertar solo el nombre de la película*/


DELIMITER //

CREATE FUNCTION SUMARPUNTO(ID INT) RETURNS DECIMAL(2,1) NO SQL
BEGIN

DECLARE NUEVAPUNTUACION DECIMAL(2.1);
DECLARE PUNTUACIONACTUAL DECIMAL(2,1);

SET PUNTUACIONACTUAL=(SELECT NOTA_PELI FROM PELICULAS WHERE ID_PELI=ID);
SET NUEVAPUNTUACION=PUNTUACIONACTUAL+1;

RETURN NUEVAPUNTUACION;

END//

DROP PROCEDURE MODIFICARPUNTUACION;
DELIMITER //
CREATE PROCEDURE MODIFICARPUNTUACION(NOMBRE VARCHAR(50))
BEGIN
DECLARE ID INT;
DECLARE RESULTADO DECIMAL(2,1);

SET ID=(SELECT ID_PELI FROM PELICULAS WHERE NOMBRE_PELI=NOMBRE);
SET RESULTADO=(SELECT SUMARPUNTO(ID));

UPDATE PELICULAS SET NOTA_PELI=RESULTADO WHERE ID=ID_PELI;

SELECT*FROM PELICULAS;

END //

CALL MODIFICARPUNTUACION("BUSCANDO A NEMO");




