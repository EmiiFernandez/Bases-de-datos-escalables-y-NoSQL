USE website;

## ESTRUCTURAS CONDICIONALES

# CONDICIONAL IF EN CONSULTAS

	-- Nos permite usar una sola condición
    -- No todo IF tiene un ELSEIF
    -- Siempre tendrá un ELSE
    
SELECT
	IF(Conditioning, TrueValue, FalseValue);

	# Si stock es menos a 10 ingresa a warning y si es mayor ingresa a good
SELECT id, name, stock,
	IF(stock < 10, 'warning', 'good') AS flag
FROM products;

SELECT id, name, stock,
	IF(stock < 10, 'warning', '') AS warning
FROM products;

# CONDICIONAL CASE EN CONSULTAS

	-- Nos permite utilizar más de una condición
    
SELECT id, name, stock,
    CASE 
		WHEN Condition1 THEN TrueValue1
        WHEN Condition2 THEN TrueValue2
        ELSE FalseValue END
FROM products;

SELECT id, name, stock,
		# dejamos el if para chequear que flag2 funcione
	IF(stock < 10, 'warning', 'good') AS ifFlag,
    CASE 
		WHEN stock < 10 THEN 'warning' 
   		WHEN stock < 30 THEN 'good' 
        ELSE 'on-sale' END AS caseFlag
FROM products;

# CONDICIONAL IF EN STORED PROCEDURES O FUNCIONES

SELECT
	IF Condition1 THEN TrueValue1
		[ELSEIF Condition1 THEN TrueValue2] ...
		[ELSE TrueValue3]
	END IF;
    
    # Dividir dos números enteros, aclarándole que no se puede dividir por 0
DELIMITER $$
CREATE FUNCTION divTwoNumbers2(num1 INT, num2 INT)
RETURNS FLOAT DETERMINISTIC
BEGIN
	DECLARE calc FLOAT DEFAULT 0;
    IF num2 <> 0 THEN SET calc = num1 / num2;
	ELSE RETURN 0;
	END IF;
	RETURN calc;
END $$
DELIMITER ;

SELECT divTwoNumbers(2,10);

# CASE EN STORED PROCEDURES O FUNCIONES

-- Puede trabajar de dos formas distintas 

	# Evaluando un valor con diferentes condiciones
		# Los valores deben ser exactos
SELECT
	CASE case_value
		WHEN when_value THEN statment_list
		[WHEN when_value THEN statment_list] ...
		[ELSE statment_list]
	END CASE;
    
    # Evaluando múltiples condiciones
SELECT
	CASE 
		WHEN search_condition THEN statment_list
		[WHEN search_condition THEN statment_list] ...
		[ELSE statment_list]
	END CASE;
    
    # Recibiremos un valor de talla (entero) y nos devolvera el tamaño de talle en texto
DELIMITER $$
CREATE FUNCTION sizeThan2(size INT)
RETURNS VARCHAR(20) DETERMINISTIC
BEGIN
	DECLARE val VARCHAR(20);
    CASE size
		WHEN 1 THEN SET val = 'small';
		WHEN 2 THEN SET val = 'medium';
		ELSE SET val = 'large';
	END CASE;
    
    RETURN val;
END $$
DELIMITER ;

SELECT sizeThan2(1);

	# Utilizando case cuando se necesite cumplir una condición
DELIMITER $$
CREATE FUNCTION sizeThan3(size INT)
RETURNS VARCHAR(20) DETERMINISTIC
BEGIN
	DECLARE val VARCHAR(20);
    CASE
		WHEN size <= 5 THEN SET val = 'small';
		WHEN size <= 10  THEN SET val = 'medium';
		ELSE SET val = 'large';
	END CASE;
    
    RETURN val;
END $$
DELIMITER ;

SELECT sizeThan3(11);