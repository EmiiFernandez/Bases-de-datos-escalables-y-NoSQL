USE website;

# FUNCIONES
	-- Son creados para ejecutar procesos en particular
	-- No se pueden actualizar las funciones. Se debe eliminar y crear nuevamente

-- Estructura

	# Creación
		# Buena práctica utilizar los delimitadores
DELIMITER $$
CREATE FUNCTION functionName()
	# DataType: Tipo de dato
    # [characteristic]: Debemos definir si es deterministica o no deterministica
    # Deterministica: Funciones que siempre devolverán lo mismo, por ejemplo suma de 2 números
    # No determinista: Número aleatorio, formateo fechas
RETURNS dataType [characteristic (DETERMINISTIC, NO DETERMINISTIC)] 
BEGIN
	-- bloque de instrucciones
	RETURN
END $$
DELIMITER ;

## FUNCIÓN SIN ARGUMENTOS
	
    -- Creación
DELIMITER $$
CREATE FUNCTION sayHello()
RETURNS VARCHAR(100) DETERMINISTIC
BEGIN
	RETURN "Hello World";
END $$
DELIMITER ;

	-- Ejecución
SELECT sayHello();

	-- Eliminar
DROP FUNCTION sayHello;

## FUNCIÓN CON ARGUMENTOS

    -- Creación
DELIMITER $$
CREATE FUNCTION sayHelloHuman(humanName VARCHAR(100), humanLastName VARCHAR(100))
RETURNS VARCHAR(100) DETERMINISTIC
BEGIN
	RETURN CONCAT("Hello ", humanName, ' ', humanLastName);
END $$
DELIMITER ;

	-- Ejecución
SELECT sayHelloHuman("Emilia", "Fernández");

	-- Eliminar
DROP FUNCTION sayHelloHuman;