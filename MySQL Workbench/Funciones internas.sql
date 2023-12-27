USE website;

## FUNCIONES INTERNAS
	-- Funciones que trae MySQL
    -- https://dev.mysql.com/doc/refman/8.0/en/functions.html
    
-- Para textos

	#Tener todos los emails en mayúscula
SELECT UPPER(email)
FROM users;

	#Tener todos los emails en minúscula
SELECT LOWER(email)
FROM users;

	#Reemlazar en el email la palabra user por test
SELECT REPLACE(email, 'user', 'test')
FROM users;

	#Mostrar todas las letras que están delante del '@'
SELECT SUBSTRING_INDEX(email, '@', 1)
FROM users;

	#Mostrar el username al revés
SELECT username, REVERSE(username), CONCAT('Hola ', username)
FROM users;

	#CONCAT_WS nos permite definir (al principio) como separar lo concatenado
SELECT CONCAT_WS(' ', 'hola', username, 'cómo estás?')
FROM users;

	#Cantidad de letras que tiene el usuario
SELECT username, LENGTH(username)
FROM users;

	#Cortar email comenzando en el 1 y solo quiero 4 letras del mismo
SELECT SUBSTRING(email, 1, 4)
FROM users;

-- Para fechas

	# Mostrar el año actual
		-- Now() es fecha de hoy
SELECT YEAR(NOW());

	# Día de la semana
SELECT WEEKDAY(NOW());

	# Semana del año
SELECT WEEK(NOW());

	# Extraigo el año de la fecha ingresada
SELECT EXTRACT(YEAR FROM '2022-01-10');

	# Formeteo fecha 
		# Puedo formatearlo como quiera
SELECT DATE_FORMAT('2022-01-10',  '%d de %M de %y');
SELECT DATE_FORMAT(NOW(), '%d-%m-%Y');

	# Calcular la edad de una persona
		#YEAR --> aclaro lo que quiero restar
        # 2do y 3er parametro --> fechas a restar
SELECT TIMESTAMPDIFF(YEAR, '1989-03-21', NOW());
		# Meses de diferencia
SELECT TIMESTAMPDIFF(MONTH, '1989-03-21', NOW());

-- Para números

	# Valor numérico aleatorio
		# RAND(): números entre 0 y 1
SELECT RAND();

	# CEIL(): devuelve el número superior siguiente
SELECT CEIL(1.2);
SELECT CEIL(1.00000001);

	# FLOOR(): Redondea hacia abajo
SELECT FLOOR(1.9999);

	# ROUND(): Redondea el número
		# <1.4999 --> redondea hacia abajo
        # <= 1.5 --> redondea hacia arriba
SELECT ROUND(1.4999999);
SELECT ROUND(1.5);

	# Número aleatorio entre 0 y 10
		# Debo multiplicar el número aleatorio por el número máximo que quiero obtener
SELECT ROUND(RAND() * 10);

	# Número aleatorio entre 4 y 10
		# 4 --> Se suma 4 al aleatorio que es donde comienza nuestro mínimo
        # 6 --> Diferencia entre el rango 4 y 10
SELECT ROUND(4 + RAND() * 6);

