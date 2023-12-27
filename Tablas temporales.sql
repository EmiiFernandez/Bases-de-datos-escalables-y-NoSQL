USE website;

## TABLAS TEMPORALES

	--  Almacenar datos de manera temporal, es decir, durante un período específico de tiempo 
		-- o hasta que se complete una tarea particular.
	-- La creo para cuando necesito manipular una tabla temporalmente
    -- No se ven en el listado de tablas
    -- La tabla temporal solo existe en la sesión que tenemos abierta

# Creación tabla temporal
CREATE TEMPORARY TABLE ejemplo (
	name VARCHAR(100)
);

INSERT INTO ejemplo VALUES('test1');

SELECT * FROM ejemplo;

# Creación de tabla temporal con query
CREATE TEMPORARY TABLE report
SELECT
	c.name, COUNT(p.id) AS product_quantity
FROM products AS p
INNER JOIN categories AS c ON c.id = p.category_id
GROUP BY c.name;

SELECT * FROM report;

SELECT * FROM report ORDER BY product_quantity DESC;