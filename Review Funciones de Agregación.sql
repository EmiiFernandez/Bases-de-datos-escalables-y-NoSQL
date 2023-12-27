# FUNCIONES DE AGREGACIÓN

-- Cantidad total de products
#Si hago SELECT * FROM me muestra solo 1000 registros
#COUNT cuenta los registros de la tabla y evalua si hay valores nulos o no
#Utilizando COUNT(*) suma todos los registros
#COUNT(id) todo según los registros

SELECT COUNT(id)
	FROM products ;

-- Precio máximo según una category
#En este caso primero busca la categoria y luego el percio máximo, sin clarar el resto 
#de los campos. No sabemos a cual corresponde

SELECT MAX(price)
	FROM products
		WHERE category_id = 4;

-- Precio mínimo de todos los products

SELECT MIN(price)
	FROM products;

-- Stock según una category
#Busca en la tabla producto la columna stock y suma todos los stocks de la categoria 4
SELECT SUM(stock)
	FROM products
		WHERE category_id = 4;