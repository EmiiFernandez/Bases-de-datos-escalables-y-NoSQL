#Selecciono schema a trabajar
USE website;

#Selecciono todas (*) las columnas de la tabla users
SELECT *
FROM users;

#Personalizo la busqueda de la tabla usuarios
SELECT email, username, id
FROM users;

#Selecciono las columnas a mostrar (id, email) de la tabla users donde el ID sea mayor a 50
SELECT id, email
FROM users
WHERE id > 50;

#Selecciono las columnas a mostrar (id, email) de la tabla users donde el email sea ...
SELECT id, email
FROM users
WHERE email = 'user57@example.com';
#REVIEW SELECT

#Selecciono las columnas a mostrar (id, email) de la tabla users donde el email contenga 
#dentro la palabra juancarlos (sin importar la posición)
SELECT id, email
FROM users
WHERE email LIKE '%juancarlos%';

#Filtro entre fechas. 
#La tabla created_at contiene fecha y hora, por lo que se debe especificar ambos
SELECT id, email, password, created_at
FROM users
WHERE created_at BETWEEN '2023-08-23' AND '2023-08-23 23:59:59';

#Utilizo dos condiciones para filtrar los datos
#Trae todos los usuarios que se encruentren entre las fechas y el id sea mayor a 80
SELECT id, email, password, created_at
FROM users
WHERE created_at BETWEEN '2023-03-23 20:44:00' AND '2023-06-23 23:59:59'
AND id > 80;

#Trae todos los usuarios que se encruentren entre las fechas y el id sea mayor a 80 o menor a 20
#ID los agrego en () por que sino no se cumple la condición correctamente
SELECT id, email, password, created_at
FROM users
WHERE created_at BETWEEN '2023-03-23 20:44:00' AND '2023-06-23 23:59:59'
AND (id > 80 OR id < 20);