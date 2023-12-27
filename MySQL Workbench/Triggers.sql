USE website;

## TRIGGERS

	-- Son programas almacenados que se ejecutan automáticamente en respuesta a ciertos eventos 
		-- en una tabla o vista
    -- Estos eventos pueden incluir acciones como INSERT, UPDATE, DELETE u otras operaciones 
		-- específicas de la base de datos.
	-- Ejemplo: actualizar registros, enviar notificaciones dado algo que suceda
    -- Esqueleto
	/*	DELIMITER $$
		CREATE TRIGGER trigger_name trigger_time trigger_event(INSERT, UPDATE, DELETE) 
			ON table_name
			-- FOR EACH ROW: Indica que el trigger se ejecutará una vez por cada fila 
				-- afectada por la operación del evento.
		FOR EACH ROW
		BEGIN
			-- SI TIENE CUERPO
		END 
		END $$
		DELIMITER ;
		*/
    
# TRIGGERS DESENCADENADORES

-- TRIGGER POR INSERT

	--  Trigger que si no se asigna password se agregue como pass el email
    
-- En la tabla usuarios, ANTES de hacer una inserción
DELIMITER $$
	-- crea un nuevo trigger llamado setUserPass que se ejecutará antes de realizar una 
		-- inserción (BEFORE INSERT) en la tabla users, ya que pass no puede estar vacío
CREATE TRIGGER setUserPass BEFORE INSERT ON users
FOR EACH ROW
BEGIN
	-- Si el campo password esta vacío setear o sea null agregar el email
	-- NEW se refiere a la fila que está siendo manipulada por el trigger
    IF NEW.password = '' OR NEW.password IS NULL THEN
    -- NEW será el valor de la inserción del registo, seteando el email por defecto
    	SET NEW.password = NEW.email;
	END IF;
END $$
DELIMITER ;

-- Prueba 
INSERT INTO users (username, email) VALUES ('test12', 'test12@test.com');

INSERT INTO users (username, email, password) VALUES ('test13', 'test13@test.com', 'test13');

SELECT * FROM users ORDER BY created_at DESC LIMIT 3;

DROP TRIGGER setUserPass;

-- TRIGGER POR UPDATE

	-- Setear los carritos en 0 en cantidad del producto, siempre y cuando de 
		-- productos tenga con stock  0

DELIMITER $$
		-- En este caso puese ser AFTER o BEFORE
        -- Se ejecutará después de realizar una actualización en la tabla productos
CREATE TRIGGER setStockProductCarts AFTER UPDATE ON products
FOR EACH ROW
BEGIN
	-- IF ondición que verifica si el nuevo valor de la columna stock 
		-- (después de la actualización) es igual a cero.
	IF NEW.stock = 0 THEN
			/*Si la condición del paso anterior es verdadera, ejecuta una sentencia de 
			actualización en la tabla carts. Establece la cantidad (quantity) en cero para 
			todas las filas en la tabla carts donde el product_id coincide con el nuevo id 
			de la fila en la tabla products que fue actualizada*/
		UPDATE carts SET quantity = 0 WHERE product_id = NEW.id;
	END IF;
END $$
DELIMITER ;

-- Prueba 
SELECT * FROM products WHERE id = 54;
SELECT * FROM carts WHERE product_id = 54;
UPDATE products SET stock = 0 WHERE id = 54;
DROP TRIGGER setStockProductCarts;

-- TRIGGER POR DELETE

	-- Cada vez que eliminemos un producto, se revise la BDD y 
		-- eliminar los registros correspondientes a los carritos que tengan ese producto
	-- Este trigger se utiliza para mantener la integridad referencial entre las 
		-- tablas products y carts. Antes de que se elimine un producto de la tabla 
        -- products, el trigger elimina todas las filas en la tabla carts que contienen 
        -- ese producto, asegurando que no queden registros de ese producto en los carritos 
        -- de compra después de su eliminación.

DELIMITER $$
	-- Este trigger se activará antes de realizar una eliminación (BEFORE DELETE) 
		-- en la tabla products (FK)
CREATE TRIGGER deleteProductCart BEFORE DELETE ON products
FOR EACH ROW
BEGIN
		/*Elimina todas las filas de la tabla carts donde el product_id coincide con el valor 
        antiguo (OLD) de la columna id en la fila que se está eliminando de la tabla products*/
	DELETE FROM carts WHERE product_id = OLD.id; #id viene de producs
END $$
DELIMITER ;

-- Prueba 
SELECT * FROM products WHERE id = 82;
SELECT * FROM carts WHERE product_id = 82;
DELETE FROM products WHERE id = 82;

DROP TRIGGER deleteProductCart;