USE NETFLIX;

 /* Crea una función que a partir de dos números, calcule y muestre el resultado de la multiplicación entre ambos. */
 
 DELIMITER //
 CREATE FUNCTION MULTIPLICAR(NUM1 INT,NUM2 INT) RETURNS INT NO SQL
 BEGIN
 DECLARE RESULTADO INT;
 SET RESULTADO = (NUM1*NUM2);
 RETURN RESULTADO;
 END//
 SELECT MULTIPLICAR(3,4);

/*Crea una función que a partir de un número y una palabra, calcule y muestre el resultado de la suma del número y el número de caracteres de la palabra.*/

DELIMITER //
CREATE FUNCTION SUMAPALABRA(PALABRA VARCHAR(50), NUMERO INT) RETURNS INT NO SQL
BEGIN
DECLARE RESULTADOTOTAL INT;
DECLARE NUMEROPALABRA INT;
SET NUMEROPALABRA=length(PALABRA);
SET RESULTADOTOTAL=(NUMEROPALABRA+NUMERO);
RETURN RESULTADOTOTAL;

END//

SELECT SUMAPALABRA("HOLA",5);

/*Crea una función que a partir de dos palabras muestre como resultado las dos palabras separadas por el conector “y”. Ejemplo) Palabra1: hola;  Palabra2: adios;  Resultado: hola y adios*/

DELIMITER //
CREATE FUNCTION CONCATENADOR(PALABRA1 VARCHAR(100),PALABRA2 VARCHAR(100))RETURNS VARCHAR (200) NO SQL
BEGIN
DECLARE RESULTADO VARCHAR (200);
SET RESULTADO=CONCAT(PALABRA1 , " Y " , PALABRA2);
RETURN RESULTADO;
END//

SELECT CONCATENADOR("QUE PASA","IAAA");


/*Crea una función que calcule la división entre dos números insertados por el usuario a través de la función Select.  Ejemplo)  select division(21, 3);   Resultado: 7*/

DELIMITER //
CREATE FUNCTION DIVIDIR(NUMERO1 INT,NUMERO2 INT)RETURNS INT NO SQL
BEGIN
DECLARE RESULTADO INT;
SET RESULTADO=(NUMERO1/NUMERO2);
RETURN RESULTADO;
END//

SELECT DIVIDIR(10,2);


/*Crea una función dados dos números, uno insertado por el usuario, y otro dentro de la función, muestre una frase indicando si el número insertado por el usuario es mayor, menor o igual al otro.*/

DELIMITER //
CREATE FUNCTION NUMEROMAYOR(NUMERO1 INT) RETURNS VARCHAR(50)NO SQL
BEGIN
DECLARE RESULTADO VARCHAR(50);
DECLARE NUMERO2 INT;
SET NUMERO2=30;
IF (NUMERO1>NUMERO2) THEN
SET RESULTADO="EL NUMERO INTRODUCIDO ES MAYOR";
ELSE 
SET RESULTADO="EL NUMERO DEL SISTEMA ES MAYOR";
END IF;
RETURN RESULTADO;
END//

SELECT NUMEROMAYOR(33);


/*Corrige las siguientes funciones implementadas en MySQL y explica brevemente la función que realiza cada una de ellas.*/

DROP FUNCTION EJERCICIO7;
delimiter //
create function ejercicio7(nom varchar(15), apellido varchar(15)) returns varchar(50) DETERMINISTIC
begin
declare resultado varchar(50);

set resultado=concat("Bienvenido ", nom, " ", apellido,"!!");

return resultado;
end//

select ejercicio7("jon", "zamora");

/*Ejercicio 2.*/ 

delimiter //
create funCtion ejercicio1(num1 int,num2 int,operacion varchar(15)) returns VARCHAR(20) NO SQL
begin

declare resultado int;
if (operacion="suma") then
	set resultado=num1+num2;
elseif (operacion="resta") then
	set resultado=num1-num2;
elseif (operacion="division") then
	set resultado=num1 div num2;
elseif (operacion="multiplicacion") then
	set resultado=num1*num2;
end if;
return resultado;
end //

/*Ejercicio 3.- */

delimiter //
create function ejercicio2(num1 int) returns int NO SQL
begin
declare resultado int;

set resultado=power(num1, 2);
return resultado;
end //


/*Ejercicio 4.*/ 

delimiter //
create function ejercicio3(num1 int, operacion varchar(10)) returns int NO SQL
begin
declare resultado int;

if (operacion="potencia") then
	set resultado=power(num1, 2);
elseif (operacion="raiz")then
	set resultado=sqrt(num1);
end if;
return resultado;

end//

/*Ejercicio 5*/ 

drop function ejercicio6;
delimiter //
create function ejercicio6(num1 int) returns varchar(15) NO SQL
begin
declare resultado varchar(15);
declare aleatorio int;

set aleatorio=rand()*(10-1)+1;

if (aleatorio=num1) then
	set resultado="Has acertado";
elseif (aleatorio != num1)  then
	set resultado="Has fallado";
end if;

return resultado;
end //

select ejercicio6(5);


/*Ejercicio 6.-*/ 
drop function ejercicio5;
delimiter //
create function ejercicio5(num1 int) returns varchar(50) DETERMINISTIC
begin
declare resultado varchar(50);
declare numero int;
declare Resto int;

set numero=30;

set resto=mod(numero, num1);

if (resto=0) then
	set resultado=concat("el numero es divisible por ", num1);
elseif (resto<>0) then
	set resultado=concat("el numero no es divisible por ", num1);
end if;
return resultado;
end //

select ejercicio5(7);

DELIMITER //
CREATE FUNCTION PIEDRAPAPELTIJERA(ELECCION VARCHAR(20))RETURNS VARCHAR(50) DETERMINISTIC
BEGIN
DECLARE RESULTADO VARCHAR(50);
DECLARE JUGADOR VARCHAR(50);
DECLARE MAQUINA VARCHAR(50);
DECLARE NUMMAQUINA INT;
SET NUMMAQUINA=RAND()*(3-1)+1;

IF (NUMMAQUINA = 1) THEN
SET MAQUINA="PIEDRA";
ELSEIF (NUMMAQUINA = 2) THEN
SET MAQUINA="PAPEL";
ELSEIF (NUMMAQUINA = 3 ) THEN
SET MAQUINA="TIJERAS";
END IF;

IF (ELECCION = 1) THEN
SET JUGADOR="PIEDRA";
ELSEIF (ELECCION = 2) THEN
SET JUGADOR="PAPEL";
ELSEIF (ELECCION = 3 ) THEN
SET JUGADOR="TIJERAS";
END IF;

IF (JUGADOR = "PIEDRA" AND MAQUINA ="PIEDRA") THEN
SET RESULTADO="HABEIS EMPATADO";
ELSEIF (JUGADOR = "PIEDRA" AND MAQUINA ="TIJERAS") THEN
SET RESULTADO="HAS PERDIDO";
ELSEIF (JUGADOR = "PIEDRA" AND MAQUINA ="PAPEL") THEN
SET RESULTADO="HAS PERDIDO";
END IF;

IF (JUGADOR = "PAPEL" AND MAQUINA ="PAPEL") THEN
SET RESULTADO="HABEIS EMPATADO";
ELSEIF (JUGADOR = "PAPEL" AND MAQUINA ="TIJERAS") THEN
SET RESULTADO="HAS PERDIDO";
ELSEIF (JUGADOR = "PAPEL" AND MAQUINA ="PIEDRA") THEN
SET RESULTADO="HAS GANADO";
END IF;

IF (JUGADOR = "TIJERAS" AND MAQUINA ="TIJERAS") THEN
SET RESULTADO="HABEIS EMPATADO";
ELSEIF (JUGADOR = "TIJERAS" AND MAQUINA ="PIEDRA") THEN
SET RESULTADO="HAS PERDIDO";
ELSEIF (JUGADOR = "TIJERAS" AND MAQUINA ="PAPEL") THEN
SET RESULTADO="HAS GANADO";
END IF;

RETURN RESULTADO;



END //


SELECT PIEDRAPAPELTIJERA(1);























