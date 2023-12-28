USE website;

## OPTIMIZACIÓN

	/* La optimización se refiere a mejorar el rendimiento y la eficiencia de las consultas 
    y operaciones en la base de datos. 
    Uno de los aspectos clave de la optimización en bases de datos es el uso de índices.
	Un índice es una estructura de datos que mejora la velocidad de las operaciones de 
    búsqueda en una tabla. Funciona de manera similar a un índice en un libro, 
    permitiendo ubicar rápidamente las páginas que contienen la información deseada. 
    Los índices facilitan la búsqueda y recuperación de datos, especialmente en tablas grandes, 
    al reducir la cantidad de registros que deben ser examinados
    
		Al ejecutar una sentencia con índica el tiempo de ejecución
        Ocupa recursos en memoria, pero puede mejorar nuestro rendimiento
	Tipo de índices:
		- Índice B-Tree (Árbol B): Son ampliamente utilizados en bdd relacionales. 
        Son eficientes para igualar, comparar rangos y realizar búsquedas. 
        Permiten una rápida búsqueda de datos mediante recorridos de nodos, manteniendo 
        el árbol balanceado.
        Se utilizan para mejorar la velocidad de las operaciones SELECT, JOIN y WHERE, 
        donde se busca igualdad o se necesita ordenación.
        - Índice Full-Text (Texto Completo): Están diseñados específicamente para realizar 
        búsquedas de texto avanzadas. Permiten buscar palabras clave en grandes bloques 
        de texto y pueden manejar aspectos semánticos, como la relevancia de las palabras. 
        No son tan eficientes para igualar o comparar rangos como los índices B-Tree.
        Útiles para búsquedas de texto en campos extensos, como descripciones, comentarios 
        o contenido de texto.
        - Índice Hash: Se utilizan funciones hash para asignar claves de búsqueda a 
        direcciones en la tabla. Son eficientes para búsquedas exactas, pero no son 
        útiles para búsquedas de rangos. Los índices hash no mantienen un orden específico.
		Útiles para mejorar la velocidad de búsquedas exactas en columnas, pero no son 
        adecuados para operaciones de rango.*/

# ÍNDICE SIMPLE

	-- Cantidad de veces que existe un mail en la tabla users
		-- Al ejecutar esta sentencia sin índice tarda 8.406 sec
		-- Al ejecutar la sentencia con índice tarda 0.016 sec
SELECT email, COUNT(email)
FROM users
	-- Agrupo los resultados según los emails
GROUP BY email
	-- Selecciono solo los emails que aparezcan más de una vez
HAVING COUNT(email)>1;

	-- Crearemos un índice para optimizar la consulta de tipo select
    -- Creamos el índice en la tabla users. Luego del ON le diremos en que campos se creará
CREATE INDEX users_index_email ON users(email);

	-- Eliminar índice
ALTER TABLE users DROP INDEX users_index_email;

SHOW INDEX FROM users;

	-- Cantidad de registros en la tabla users
SELECT COUNT(id) FROM users;

# ÍNDICE UNIQUE
	/*Cuando defines un índice único en una columna, la bdd requiere que todos los valores en 
    esa columna sean únicos. 
    En caso de intentar crear un índice único con datos duplicados dará un error
    debido a la restricción de índice único, no puedes tener duplicados en esa columna.
    */
    
    -- Creo el índice unique
CREATE UNIQUE INDEX products_index_unique_name ON products(name);

	-- Eliminar el índice
ALTER TABLE products DROP INDEX products_index_unique_name;

	-- Ver todas los índices de la tabla
SHOW INDEX FROM products;

	-- Cantidad de registros de la tabla products
SELECT COUNT(id) FROM products;

	-- Chequeo que no pueda ingresar un dato duplicado
		-- Error 1062: Ingreso duplicado
INSERT INTO products(name, category_id) VALUES("smartphone", 6);

	-- Elimino los nombres duplicados y solo dejo el del id más bajo
DELETE p1
FROM products p1
JOIN products p2 ON p1.name = p2.name AND p1.id > p2.id;
	
# ÍNDICE FULLTEXT

	-- Están diseñados específicamente para realizar búsquedas de texto en campos de
		-- texto grandes
	-- Omite palabras menores a 4 letras

        
	-- Creo un índice que se encargue de mapear las palabras que tenga el campo
CREATE FULLTEXT INDEX products_index_fulltext_name ON products(name);

	-- Elimino indice
ALTER TABLE products DROP INDEX products_index_fulltext_name;

	-- Muestro todos los índices de la tabla
SHOW INDEX FROM products;

	# Busco todos los productos que contengan la palabra exacta smart
SELECT *
FROM products
	-- MATCH --> Utilzo la columna main para la búsqueda del texto
    -- AGAINST --> Especifica la cadena de búsqueda
WHERE MATCH(`name`) AGAINST('smart'); 

	# Busco todos los productos que contengan la palabra smart
SELECT *
FROM products
	-- MATCH --> Utilzo la columna main para la búsqueda del texto
    -- AGAINST --> Especifica la cadena de búsqueda
WHERE MATCH(`name`) AGAINST('smart*'  IN BOOLEAN MODE); 

/* La cláusula IN BOOLEAN MODE se utiliza junto con la expresión MATCH...AGAINST 
cuando se desea realizar una búsqueda de texto completo en modo booleano. 
Este modo permite utilizar operadores booleanos como AND, OR y NOT para controlar y 
personalizar la lógica de la búsqueda.

Cuando se utiliza IN BOOLEAN MODE, puedes especificar términos de búsqueda más complejos y 
realizar búsquedas booleanas. 

	** Operador + (AND): El operador + se utiliza para indicar que todos los términos que lo 
	preceden deben estar presentes en el resultado.

		MATCH(column) AGAINST('+term1 +term2' IN BOOLEAN MODE);
	
	** Operador - (NOT): El operador "-" se utiliza para indicar que un término no debe 
    estar presente en el resultado.

		MATCH(column) AGAINST('+term1 -term2' IN BOOLEAN MODE);

	** Operador * (comodín): El asterisco * se utiliza para representar cualquier conjunto 
    de caracteres al final de una cadena.

		MATCH(column) AGAINST('term*' IN BOOLEAN MODE);

	** Operador " (comillas dobles): Se utilizan para buscar una frase exacta.
    
		MATCH(column) AGAINST('"exact phrase"' IN BOOLEAN MODE);

	** Operador | (OR): El operador | se utiliza para indicar que al menos uno de los 
    términos debe estar presente en el resultado.

		MATCH(column) AGAINST('term1 | term2' IN BOOLEAN MODE);*/

# ÍNDICE COMPUESTOS

	# Un usuario no pueda agregar un producto dos veces en un carrito
														-- los dos campos que quiero únicos
ALTER TABLE carts ADD UNIQUE INDEX carts_unique_user_product(user_id, product_id);

	-- Elimino indice
ALTER TABLE carts DROP INDEX carts_unique_user_product;

	-- Muestro todos los índices de la tabla
SHOW INDEX FROM carts;