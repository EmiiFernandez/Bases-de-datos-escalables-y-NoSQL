USE website;

## SUBCONSULTAS
	-- Consulta que se encuentra dentro de otra consulta principal
	-- Tener en cuenta que la subconsulta traiga un valor y una columna
    -- Es importante notar que las subconsultas pueden ser anidadas, es decir, una 
		-- subconsulta puede contener a su vez otra subconsulta. Sin embargo, es necesario 
        -- asegurarse de que la subconsulta devuelva un solo valor o conjunto de valores, 
        -- ya que una subconsulta no puede devolver directamente un conjunto de resultados a
        -- menos que se utilice en una cláusula que permita eso (por ejemplo, IN o EXISTS).


-- Realizar un reporte que tenga el nombre del producto y la cantidad para 
	-- un mes determinado

SELECT
p.id, p.name,
	#	Subconsulta --> Cantidad de personas de la tabla carts
	#				--> WHERE uno la subconsulta con la tabla products
    #				--> AND  para filtrar por fechas
(SELECT COUNT(id) FROM carts AS c WHERE p.id = c.product_id
	AND c.created_at BETWEEN'2023-07-01' AND  '2023-07-31') AS q_jul_23
FROM products  AS p;

	-- Chequeo la subconsulta
SELECT COUNT(id) FROM carts AS c WHERE c.product_id = 54
	AND c.created_at BETWEEN'2023-07-01' AND  '2023-07-31';
    
SELECT
p.id, p.name,
	#	Subconsulta --> Cantidad de personas de la tabla carts
	#				--> WHERE uno la subconsulta con la tabla products
    #				--> AND  para filtrar por fechas
    # Subconsulta entre meses
(SELECT COUNT(id) FROM carts AS c WHERE p.id = c.product_id
	AND c.created_at BETWEEN'2023-07-01' AND  '2023-07-31') AS q_jul_23,
    #Subconsulta en un año
(SELECT COUNT(id) FROM carts AS c WHERE p.id = c.product_id
	AND c.created_at BETWEEN'2023-01-01' AND  '2023-12-31') AS q_23
FROM products  AS p;

# SUBCONSULTAS USANDO EXISTS

	-- Se utiliza para verificar si una subconsulta devuelve algún resultado 
    /* Sintaxis:
		SELECT columnas
		FROM tabla1
		WHERE EXISTS (subconsulta);*/
	
	-- Productos que tengan carritos
SELECT
p.name
FROM products AS p
WHERE EXISTS (SELECT id FROM carts AS c WHERE c.product_id = p.id);

# SUBCONSULTAS CON MÁS DE UNA COLUMNA

	-- Traer productos con las ventas de ciertos meses en particular en modo columna
SELECT 
p.id, p.name,
	-- suma de la venta del mes y uno la tabla de ventas con la tabla productos
	-- tiene que devolver una sola columna, por eso traigo solo la suma
(
SELECT SUM(quantity) FROM carts AS s WHERE s.product_id = p.id
		-- Extraigo del mes 8
	AND EXTRACT(MONTH FROM s.created_at) = 8
		-- Extraigo según el año|
    AND EXTRACT(YEAR FROM s.created_at) = 2022
) AS month8,
(
SELECT SUM(quantity) FROM carts AS s WHERE s.product_id = p.id
	AND EXTRACT(MONTH FROM s.created_at) = 9
    AND EXTRACT(YEAR FROM s.created_at) = 2022
) AS month9,
(
SELECT SUM(quantity) FROM carts AS s WHERE s.product_id = p.id
	AND EXTRACT(MONTH FROM s.created_at) = 10
    AND EXTRACT(YEAR FROM s.created_at) = 2022
) AS month10,
(
SELECT SUM(quantity) FROM carts AS s WHERE s.product_id = p.id
	AND EXTRACT(MONTH FROM s.created_at) = 11
    AND EXTRACT(YEAR FROM s.created_at) = 2022
) AS month11
FROM products AS p;