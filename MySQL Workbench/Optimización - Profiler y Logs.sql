USE website;

## PROFILER Y LOGS

	-- Mostrar si los logs generales están habilitados (ON u OFF)
SHOW VARIABLES LIKE '%general_log%';

	-- Habilitar el registro general
SET GLOBAL general_log = ON;
	
    -- Mostrar si el registro de consultas lentas está habilitado
SHOW VARIABLES LIKE '%slow_query_log%';

	-- Habilitar el registro de consultas lentas
SET GLOBAL slow_query_log = ON;

    -- Mostrar la configuración del tiempo para considerar una consulta lenta
SHOW VARIABLES LIKE '%long_query_time%';

	-- Configurar el tiempo para considerar una consulta lenta (2 seg en este caso)
SET GLOBAL long_query_time = 2; -- seconds

	-- Mostrar la cantidad de consultas lentas registradas
SHOW GLOBAL STATUS LIKE '%slow_queries%';

	-- Mostrar la configuración actual de la salida de logs
		-- Por defecto se guarda en modo FILE
SHOW VARIABLES LIKE '%log_output%';

	-- Configurar la salida de logs para que sea una tabla (estaba en file)
SET GLOBAL log_output = 'table';

	-- Mosrtar todas las columnas del registro general
SELECT * FROM mysql.general_log;

	-- Mostrar la fecha y hora de eventos y los argumentos del registro general
SELECT event_time, CAST(argument AS CHAR) FROM mysql.general_log;

	-- Mostrar el texto de las consultas lentas del registro de consultas lentas
SELECT CAST(sql_text AS CHAR) FROM mysql.slow_log;

	-- Eliminar registros
TRUNCATE TABLE mysql.general_log;
TRUNCATE TABLE mysql.slow_log;