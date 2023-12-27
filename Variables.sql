USE website;

## VARIABLES

	-- Si quisieramos guardar información 

-- Declaración

	# Crear una variable
		# SET --> defino la variable
        # @ --> nombre de la variable
        # La variable stock tendrá el valor 10
SET @stock = 10;

SELECT @stock;

	# Reemplazo la variable. Cambiará el valor de memoria
SET @stock = 12;

SELECT @stock;

-- Uso de una variable dentro de una query

SELECT * FROM products WHERE stock > @stock;

# VARIABLES EN STORED PROCEDURES

	-- Tendrá un valor de salid (OUT)
    -- Seteará un valor de 2 + 1

	# Creo una variable para guardar el resultado del SP
DELIMITER $$
CREATE PROCEDURE plusOneV3(OUT val INT)
BEGIN 
	SET val = 2 + 1;
END $$
DELIMITER ;

	-- Cómo es de salida no devolverá información, por lo que seteo en una variable
    -- guardo la información en la memoria y lo llamo con el SELECT
    -- Me permite trabajar con una variable de salida que está dentro de un SP
CALL plusOneV3(@val1);

SELECT @val1;

	# Creo una variable para guardar el resultado del SP con dato de entrada y salida
	-- INOUT --> parámetro de entrada y salida
DELIMITER $$
CREATE PROCEDURE plusOneV4(INOUT value INT)
BEGIN 
	SET value = value + 1;
END $$
DELIMITER ;

	# Debemos setear el valor por que sino comenzaría con undefined
SET @value2 = 10;
CALL plusOneV4(@value2);
SELECT @value2;
CALL plusOneV4(@value2);
SELECT @value2;

	# Declaro y seteo variables
    
DELIMITER $$
CREATE PROCEDURE addThingsV2()
BEGIN 
	# Declare --> declaro la variable pero no le asigno valor
    # Cuando declaro solo uso el nombre y cuando seteo agrego el @
    # Con default le agrego un valor por defecto - Puedo modificarlo luego
	DECLARE val1 INT DEFAULT 1;
    SET @val2 = 2;
    SELECT @val2 + val1;
END $$
DELIMITER ;

CALL addThingsV2();

# VARIABLES EN FUNCIONES

	-- Calcular el promedio entre dos números enteros y debe retornar un flotante
    
DELIMITER $$
CREATE FUNCTION avgOfTwoNumbers2(num1 INT, num2 INT)
	# Debe retornar un resultado flotante y siempre es lo mismo (deterministic)
RETURNS FLOAT DETERMINISTIC
BEGIN 
		# Declaro la variable para el resultado, sin valor por defecto
        # Declarar las variables debajo del begin
	DECLARE calc FLOAT;
    SET calc=(num1 + num2) / 2;
		# Retorna el valor de calc
    RETURN calc;
END $$
DELIMITER ;

SELECT avgOfTwoNumbers2(11,2);
