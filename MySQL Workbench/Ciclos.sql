USE website;

## CICLOS

	-- Nos permiten ejecutar un proceso n cantidad de veces
    
# LOOP

	-- Proceso que nos dira hola la cantidad de veces que le pasemos
DELIMITER $$
								-- cant de veces a ejecutar
CREATE PROCEDURE sayHelloNTimes2(times INT)
BEGIN
		# counter: tendra por defecto que lo haga una vez
	DECLARE counter INT DEFAULT 1;
		# Loop nos permite etiquetarla. 
        # Nos permite etiquetarla y volver a utilizarla en otra parte del código
    my_loop: LOOP
		SELECT 'hello';
			-- Cambio de estado del counter
        SET counter = counter + 1;
			-- Salgo del ciclo cuando el counter sea la cantidad de veces que se paso por parámetro
        IF counter > times THEN
        -- Salir del loop
        -- Debo agregar el leave para que frene el proceso
        LEAVE my_loop;
        END IF;
	END LOOP;
END $$
DELIMITER ;

CALL sayHelloNTimes2(5);

DROP PROCEDURE sayHelloNTimes2;

# WHILE

	-- Saludo n cantidad de veces con While, mientras se cumpla la condición
DELIMITER $$
CREATE PROCEDURE sayHelloNTimes3(times INT)
BEGIN
	DECLARE counter INT DEFAULT 1;
		-- Mientras contador sea menos o igual al times se cumple la condición
    WHILE counter <= times DO
		SELECT 'hello';
		-- cambio de estado
        SET counter = counter + 1;
	END WHILE;
END $$
DELIMITER ;

CALL sayHelloNTimes3(5);

# REPEAT

	-- Saludo n cantidad de veces, pero queriendo que siempre se ejecuta aunque sea
    -- una vez
DELIMITER $$
CREATE PROCEDURE sayHelloNTimes4(times INT)
BEGIN
	DECLARE counter INT DEFAULT 1;
    
    REPEAT
		-- Código a ejecutar
		SELECT 'hello';
        SET counter = counter + 1;
			-- cambio de estado
		-- Hasta que una condición se cumpla
		UNTIL counter > times END REPEAT;
	END $$
DELIMITER ;

CALL sayHelloNTimes4(3);

DROP PROCEDURE sayHelloNTimes4;


