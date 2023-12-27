USE website;

## CURSORES

	-- Un cursor se utiliza para recorrer un conjunto de resultados y acceder a 
    -- las filas de datos una por una.

# Creación cursor

	-- SP que ejecute el carrito según el usuario
    -- muestra lo que tenga el usuario en el carrito
DELIMITER $$
CREATE PROCEDURE executeCartByUser2(pUserId INT)
BEGIN
	DECLARE userId, pID, quan INT;
		-- done: Lo utilizaremos para definir si finalizo la cantidad de registros
			-- que hay en la consulta cart
	DECLARE done INT DEFAULT FALSE;
		-- Declaramos la variable de tipo cursor que será el derivado de una consulta de BDD
    DECLARE cart CURSOR FOR SELECT user_id, product_id, quantity 
		FROM carts 
			WHERE user_id = pUserId;
		-- Declaro que continue trabajando hasta que se cumpla el loop
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
		-- Después de la declaración de variables abro el cursor
        -- Consumo recursos del servidor
	OPEN cart;
    my_loop: LOOP
			-- FETCH --> apunta al primer registro de la sentencia del select y comenzaremos
				-- a guardar en las variables definidas 
		FETCH cart INTO userId, pID, quan;
			-- Si done cambia true finalizo el loop
        IF done THEN LEAVE my_loop;
		END IF;
		SELECT CONCAT_WS(' ', 'user:', userId, 'prod:', pID);
	END LOOP;
	CLOSE cart;
END $$
DELIMITER ;

CALL executeCartByUser2(20);

	-- Prueba para evaluar cuantos registros trae
SELECT user_id, product_id, quantity FROM carts WHERE user_id = 1;

DROP PROCEDURE executeCartByUser2;

# STORED PROCEDURES CON CURSORES

	-- Ingresará al carrito de un usuario y eliminará del stock la cantidad del 
		-- producto seleccionado 
DELIMITER $$
CREATE PROCEDURE executeCartByUser3(pUserId INT)
BEGIN
	DECLARE cartId, pID, quan INT;
		-- Booleano que va a definir cuando va a terminar el cursor 
	DECLARE done INT DEFAULT FALSE;
		-- Declaro el cursor que selecciona el product_id y la cantidad pertenecientes
			-- al usuario
    DECLARE cart CURSOR FOR SELECT id, product_id, quantity 
		FROM carts 
			WHERE user_id = pUserId;
		-- El handler continuará hasta que done sea true
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
	OPEN cart;
		my_loop: LOOP
				-- Agrego la información de cada registro a nuestras variables
			FETCH cart INTO cartId, pID, quan;
				-- Si done cambia true finalizo el loop
			IF done THEN LEAVE my_loop;
            END IF;
				-- Actualizo la tabla de productos
			UPDATE products SET stock = stock - quan WHERE id = pId;
				-- Elimino el registro de la tabla de carritos
			DELETE FROM carts WHERE id = cartId;
		END LOOP;
	CLOSE cart;
    -- Dirá success al cumplirse
    SELECT 'success';
END $$
DELIMITER ;

CALL executeCartByUser3(1);

	-- Prueba para evaluar cuantos registros trae
SELECT user_id, product_id, quantity FROM carts WHERE user_id = 1;
SELECT id, name, stock FROM products WHERE id = 57;

DROP PROCEDURE executeCartByUser3;

# STORED PROCEDURES CON CURSORES Y TRANSACCIONES

	-- Cuando tengamos más de una transacción es importante chequear que todas las 
		-- transacciones se ejecuten correctamente

DELIMITER $$
CREATE PROCEDURE executeCartByUser4(pUserId INT)
BEGIN
	DECLARE cartId, pID, quan INT;
	DECLARE done INT DEFAULT FALSE;
    DECLARE cart CURSOR FOR SELECT id, product_id, quantity 
		FROM carts 
			WHERE user_id = pUserId;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
		-- Aclaro el comienzo de la transacción luego se ejecutan las secuencias
        -- Si alguna secuencia falla se frenará la transacción
    START TRANSACTION;
	OPEN cart;
		my_loop: LOOP
			FETCH cart INTO cartId, pID, quan;
			IF done THEN LEAVE my_loop;
            END IF;
			UPDATE products SET stock = stock - quan WHERE id = pId;
			DELETE FROM carts WHERE id = cartId;
		END LOOP;
	CLOSE cart;
	COMMIT;
    SELECT 'success';
END $$
DELIMITER ;

CALL executeCartByUser4(7);

	-- Prueba para evaluar cuantos registros trae
SELECT user_id, product_id, quantity FROM carts WHERE user_id = 7;
SELECT id, name, stock FROM products WHERE id = 95;

DROP PROCEDURE executeCartByUser4;