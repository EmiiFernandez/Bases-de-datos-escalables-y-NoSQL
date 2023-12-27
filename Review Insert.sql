#REVIEW INSERT 

USE website;

#Inserto una nueva columna en users, sin aclarar los parámetros. 
#Agregar los datos según orden de la tabla. Tienen que cumplirse todos los campos
#id es autoincremental por ello agrego el "default"
#CURRENT_TIMESTAMP --> agrega el valor actual de fecha y hora
INSERT INTO users 
VALUES (default, 'juancarlos', 'juancarlos@juancarlos.com', '123456', current_timestamp());

#Especificando los campos
INSERT INTO users (username, email, password)
VALUES ('ana', 'ana@ana.com', '12345');

SELECT * FROM users where username = 'ana';



