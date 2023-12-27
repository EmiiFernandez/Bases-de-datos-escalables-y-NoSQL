#REVIEW UPDATE

#Necesito saber la estructura de la tabla
#Mencionar cual es la tabla a hacer actualizar
#SET es donde hacemos los cambios
#Importante usar filtros!

UPDATE users
	SET email = 'emailmodificado@cosa.com'
		WHERE id = 1;
        
SELECT * FROM users
	WHERE id = 1;
    
UPDATE users
	SET email = "luis@cosa.com", username = 'luis'
		WHERE id = 1;

SELECT * FROM users
	WHERE id = 1;
    
UPDATE users
	SET email = "luis@luis.com", username = 'luis'
		WHERE id = 1;

SELECT * FROM users
	WHERE id = 1;