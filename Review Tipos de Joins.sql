# TIPOS DE JOINS

#Son la forma de conectar dos tablas que se relacionan
#INNER JOIN: Devuelve todas las filas cuando hay al menos una coincidencia en ambas tablas.
#LEFT JOIN: Devuelve todas las filas de la tabla de la izquierda, y las filas coincidentes 
	#de la tabla de la derecha.
#RIGHT JOIN: Devuelve todas las filas de la tabla de la derecha, y las filas coincidentes de 
	#la tabla de la izquierda.
#OUTER JOIN: Devuelve todas las filas de las dos tablas, la izquierda y la derecha. También 
	#se llama FULL OUTER JOIN.
#Ejemplo: SELECT <select list> FROM Table "tipo" JOIN Table B ON A.Key = B.Key

# INNER JOIN

# Inner join deben coincidir los registros de ambas tablas

-- Obtener products y su category
#Category name necesito crearlo por que no existe. Con ON establezco la relación de tablas
#name existe en las dos tablas, por lo que tengo que aclarar cual quiero
# AS escribo alias para la query que estoy haciendo

SELECT p.name AS product_name, stock, c.name AS category_name
	FROM products AS p
		JOIN categories AS c ON p.category_id = c.id;
		
-- Todos los users y sus carts

SELECT * 
	FROM users AS u
		JOIN carts;

-- Users sin cart

SELECT *
	FROM users
		JOIN carts
			WHERE carts.id = NULL;
