# REVIEW DELETE

#Ser claro con el registro que se quiere eliminar
#Usualmente se eliminan registros por FK o, en este caso, username
#FILTRAR!!!! Por que se pueden eliminar todos los registros de una tabla por error

DELETE FROM users
	WHERE id = 88884;
    
SELECT * FROM users
	WHERE id = 88884;
    
DELETE FROM users
	WHERE email = "juancarlos@juancarlos.com";

SELECT * FROM users
	WHERE email = "juancarlos@juancarlos.com";
