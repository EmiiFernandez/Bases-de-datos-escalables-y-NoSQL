USE website;

## MANEJO DE ERRORES & HANDLERS

# ERROR HANDLING
	-- Manejar algún tipo de error cuando suceda alto en el SP
    -- Ejemplo que la tabla no existe

/*DELIMITER $$
CREATE PROCEDURE pname(params...)
BEGIN
		-- Declaro una acción, la cual nos dirá si continua el código (CONTINUE)
			-- o se sale (UNDO)
						-- En el for agregamos condición o conjunto de condiciones
	DECLARE handler_action HANDLER FOR condition_value [, condition_value]...
    -- statement
    BEGIN
		-- body of handler
    END;
END $$
DELIMITER ;

handler_action: {
	CONTINUE
    EXIT
    UNDO
}

condition_value: {
	mysql_error_code
    SQLSTATE [VALUE] sqlstate_value
    condition_name
    SQLWARNING
    NOT FOUND
    SQLEXCEPTION
}

CALL pname();

DROP PROCEDURE pname; */

	-- Manejo de error si la tabla no existe
DELIMITER $$
CREATE PROCEDURE insertCategori2(pname VARCHAR(50))
BEGIN
		-- Exit: no quiero que continue el código
	DECLARE EXIT HANDLER FOR 1146
		-- Si encuentra el error, mostrar en pantalla que no existe
    BEGIN
		SELECT 'no such table';
    END;
		-- Si la tabla existe se agrega a la tabla categoria y retorna un success
    INSERT INTO categori VALUES (pname);
    SELECT 'success';
END $$
DELIMITER ;

	-- Select para saber el código de tabla que no existe (1146)
SELECT * FROM no_exist;

CALL insertCategori2('value');

DROP PROCEDURE insertCategori2;

## Manejo de errores con nombre

	-- Errores asociados a una condición y ponerle un nombre a nuestra condición

/* DELIMITER $$
CREATE PROCEDURE pname()
BEGIN
	DECLARE pname CONDITION FOR condition_sql_error;
    DECLARE ptype HANDLER FOR pname
END;
DELIMITER ;
CALL pname(7);
DROP PROCEDURE pname;
*/

	-- En caso que la categoria ya exista no duplicarla
DELIMITER $$
CREATE PROCEDURE insertCategory2(pname VARCHAR(50))
BEGIN
		-- defino la condición de error
	DECLARE error_duplicated CONDITION FOR 1062;
		-- Se detiene al encontrar el error
    DECLARE EXIT HANDLER FOR error_duplicated
		-- Lo que sucede si aparece el error
        BEGIN 
			SELECT 'Category already exists';
        END;
        -- En caso de no encontrar error agrega la categoria y envia un mensaje de success
	INSERT INTO categories (name) VALUES (pname);
    SELECT 'success';
END $$
DELIMITER ;

CALL insertCategory2('webcam');

DROP PROCEDURE insertCategory2;

-- Chequeo el error de duplicación
INSERT INTO categories(name) VALUES ('electronics');