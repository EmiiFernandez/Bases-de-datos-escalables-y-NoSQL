USE website;

## FUNCIONES DE VENTANA 

	-- También conocidas como funciones analíticas, son una característica en BDD relacionales que 
	-- permiten realizar cálculos sobre un "conjunto de ventanas" de filas relacionadas con 
	-- la fila actual en una consulta.

# Sin Cláusula de Ventana:
	-- Los cálculos se aplican al conjunto de datos completo o a grupos definidos por 
    -- la cláusula GROUP BY, sin considerar el orden de las filas.
    
# Con Cláusula de Ventana:
	-- Los cálculos se aplican a "ventanas" de filas basadas en condiciones de partición y 
    -- orden definidas por la cláusula OVER, permitiendo análisis más detallados y 
    -- específicos.

# FUNCIONES DE VENTANA SIN CLÁUSULA WINDOW

-- Obtener listado de productos y adicionar en cada fila la posición según la categoría

	#Select traigo la información
SELECT name, category_id, stock,
	# ROW_NUMBER() --> se utiliza para devolver el número secuencial de cada fila dentro de 
		#su partición. Es una especie de función de ventana. 
	# El número de fila comienza desde 1 hasta el número de filas presentes en la partición.
	# ORDER BY --> se utiliza para especificar el orden en el que deseas numerar las filas.
    # OVER -->  define la ventana sobre la cual se realizarán los cálculos
    # PARTITION BY --> divide el conjunto de resultados en particiones basadas en los 
		# valores únicos
    ROW_NUMBER() OVER(PARTITION BY category_id ORDER BY category_id, name) AS orderByCategory,
    SUM(stock) OVER(PARTITION BY category_id) AS categoryStock
FROM products
	# Ordenar de modo ascendete según el id de la categoría y el nombre
ORDER BY category_id, name;

# FUNCIONES DE VENTANA CON CLÁUSULA WINDOW

SELECT 
	p.name, 
    p.stock,
    p.category_id,
    ROW_NUMBER() OVER(w ORDER BY p.category_id, p.name) AS positionByCategory,
    SUM(p.stock) OVER(w) AS totalByCategory,
		#Registro anterior del nombre
    LAG(p.name) OVER(w ORDER BY p.category_id, p.name) AS previousRecord,
		#Registro posterior del nombre
    LEAD(p.name) OVER(w ORDER BY p.category_id, p.name) AS nextRecord
FROM products AS p
	# Englobar partición
WINDOW w AS (PARTITION BY p.category_id)
ORDER BY p.category_id, p.name ASC;
	