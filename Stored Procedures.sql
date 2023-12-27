# Storedd Procedures

USE website;

-- Para modificar un SP debo primero eliminarlo y volver a crear

-- Creación

	# Delimiter nos permitirá delimitar donde comienza y termina la ejecución y creación SP
	# Puede ser: $$, &&, ;;, || u otros
DELIMITER $$
	# CREATE PROCEDURE: Palabras reservadas para crear en MySQL
	# nameProcedure() --> nombre del procedimiento. Dentro de los () podrían ir los parámetros de entrada y salida
CREATE PROCEDURE nameProcedure()
	# BEGIN: Donde inicia el cuerpo del procedimiento
BEGIN
	-- instrucciones SQL
	# END debe finalizar con el dilimitador que le coloque ($$)
END $$
	# El delimiter final debe terminar con un ";" 
DELIMITER ;

-- Ejecución

	# Llamar a un SP
CALL nameProcedure();

-- Eliminación

	# No colocar los () al eliminar
DROP PROCEDURE nameProcedure;

-- Consultar mis SP
SHOW PROCEDURE status WHERE Db = DATABASE() AND Type = "PROCEDURE";

# Storedd Procedures con argumentos de entrada

	-- Argumentos con tipos de datos

	# Crear procedimiento almacenado que reciba un número y muestre en pantalla

-- Crear
DELIMITER $$
	# primero va el nombre del dato y luego el tipo de dato
CREATE PROCEDURE showNumber(num INT)
BEGIN
	SELECT num;
END $$
DELIMITER ;

-- Ejecutar
CALL showNumber(99);

-- Eliminar
DROP PROCEDURE showNumber;

-- Bloque de sentencias SQL

-- Crear
DELIMITER $$
CREATE PROCEDURE sumNumber(num1 INT, num2 INT)
BEGIN
	SELECT num1 + num2;
END $$
DELIMITER ;

-- Ejecución
CALL sumNumber(99, 11);

-- Eliminar
DROP PROCEDURE sumNumber;

# Stored Procedures con argumentos de salida

	-- Crear función donde reciba por parámetro tipo salida

-- Crear
DELIMITER $$
	# OUT informa que es de salida
CREATE PROCEDURE setOne(OUT value INT)
BEGIN
	# Le doy el valor del número de salida
	SET value = 1;
END $$
DELIMITER ;

-- Ejecutar
CALL setOne(@value);
# para mostrar la información utilizo un select
SELECT @value;

-- Eliminar
DROP PROCEDURE setOne;
