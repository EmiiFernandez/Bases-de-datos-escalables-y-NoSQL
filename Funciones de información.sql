USE website;

## FUNCIONES DE INFORMACIÓN

-- Se utilizan para obtener detalles y características específicas sobre la base de datos, las 
-- tablas, las columnas y otros objetos. Estas funciones proporcionan información sobre el 
-- esquema y la estructura de la BDD
-- Por ej: saber el usuario actual, último id insertado en la tabla

	# Versión de MySQL
SELECT VERSION();

	# Saber con que usuario estoy conectado
SELECT CURRENT_USER();

	# Saber el rol del usuario
SELECT CURRENT_ROLE();

	# Último ID insertado
    
		#Este da 0 por que no había agregado ningún usuario
SELECT LAST_INSERT_ID();

INSERT INTO users VALUES(default, 'usuario999', 'amil@amil.com', 'pass', NOW());

SELECT LAST_INSERT_ID();

	# ID máximo
SELECT MAX(id) FROM users;

	# Chequear a que BDD se está conectado
SELECT DATABASE();
SELECT SCHEMA();

	# Cual es la conexión actual
SELECT CONNECTION_ID();