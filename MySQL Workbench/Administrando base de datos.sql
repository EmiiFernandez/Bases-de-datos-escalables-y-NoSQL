USE website;

## ADMINISTRANDO BDD RELACIONALES

# IMPORTAR Y EXPORTAR DATOS

-- Exportar
	 -- Guardar archivo con export/import en .csv
SELECT * FROM products;

-- Importar
	-- Puedo crear una tabla nueva o usar una existente
SELECT * FROM products_imported;

# RESPALDAR BDD CON WORKBENCH

-- Backup BDD

	/*
    1. Server
    2. Data export
    3. Selecciono la BDD y configuro lo que quiero exportar
		-- selecciono si quiero que se exporte en un archivo o varios
	5. 	Defino si quiero importar estructuras y/o datos
		-- Selecciono que objects to export quiero exportar
	6. Selecciono la ruta 
    7. Exporto en formato .sql
    */
    
-- Restaurar BDD

	/*
	1. Server
    2. Data import
    3. Seleccionamos el archivo
    4. Aclaro en que schquema se retaurará
		-- Puedo utilizar una que ya este o crear un schema nuevo
		-- Puede eliminar todo lo que contenga el schema existente
	5. Defino si quiero importar estructuras y/o datos
	6. Import
    */

# RESPALDAR BDD CON LÍNEA DE COMANDOS

-- Backup

	/*
-- Comando
    mysqldump --host=127.0.0.1 --port=3306 --default-character-set=utf8 --user=root
		--protocol=tcp --routines --events "website" -p > /website-backup-consola.sql 
        --verbose
        
		#Backup con PowerShell
    mysqldump.exe --host=127.0.0.1 --port=3306 --user=root -p --routines --events website 
	--result-file=website-backup-consola.sql --verbose
        
	**mysqldump: Es el comando principal que invoca el respaldo de MySQL.
	**--host=127.0.0.1: Especifica la dirección IP del host del servidor de la bdd. 
		En este caso, 127.0.0.1 es la dirección IP para el localhost.
        Si no lo agregamos toma localhost por defecto
	**--port=3306: Especifica el puerto en el que el servidor de la bdd está escuchando.
		El valor predeterminado para MySQL es 3306.
	**--default-character-set=utf8: Establece el conjunto de caracteres predeterminado 
		para la codificación del volcado a UTF-8.
	**--user=root: Especifica el nombre de usuario con el que se conectará a la bdd. 
		En este caso, el usuario es "root".
	**--protocol=tcp: Indica el protocolo de conexión a utilizar. 
		En este caso, se utiliza TCP.
	**--routines: Incluye las rutinas almacenadas (stored procedures y funciones) 
		en el volcado.
	**--events: Incluye los eventos del calendario en el volcado.
    **"website": Especifica el nombre de la base de datos que se va a volcar. 
		En este caso, la base de datos es "website".
	**-p: Solicita una contraseña al usuario. Al agregar -p, mysqldump solicitará 
		la contraseña antes de realizar el volcado.
	**> /website-backup-consola.sql: Redirige la salida del volcado a un archivo 
		llamado "website-backup-consola.sql". 
        Este archivo contendrá el script SQL generado por mysqldump.
        Si no agrego la salida lo vuelca en la pantalla
	**--verbose: Imprime información detallada sobre el proceso de volcado.
    */

-- Restaurar

	-- Creo BDD si no la tengo creada
	/*
    -- Conexión a BDD
	mysql -h 127.0.0.1 --port=3306 -u root -p
    
    **mysql: Es el comando para iniciar la interfaz de línea de comandos de MySQL.
	**-h 127.0.0.1: Especifica la dirección IP del host del servidor de la bdd. 
		En este caso, 127.0.0.1 es la dirección IP para el localhost.
	**--port=3306: Especifica el puerto en el que el servidor de la bdd está escuchando.
		El valor predeterminado para MySQL es 3306.
	**-u root: Especifica el nombre de usuario con el que se conectará a la bdd. 
		En este caso, el usuario es "root".
	**-p: Solicita una contraseña al usuario. Al agregar -p, el sistema solicitará 
		la contraseña antes de conectar.

	-- Creo BDD
    CREATE DATABASE test;
    
    **CREATE DATABASE test;: Sentencia SQL que crea una nueva bdd llamada "test". 
		Esta sentencia se debe ejecutar en la interfaz de línea de comandos de MySQL 
        después de haberse conectado.
        Puedo omitirlo si ya esta creada la BDD
    
    -- Restaurar BDD
	mysql -h 127.0.0.1 --port=3306 -u root -p test > website-backup-consola.sql" --verbose

	# Con PowerShell
		-- Conecto con mysql
			- mysql -h 127.0.0.1 --port=3306 -u root -p
		-- Selecciono la tabla
			- USE test;
		-- Restauro BDD
			- Comando: source "ruta completa donde está el archivo .sql"

	**mysql: Es el comando para iniciar la interfaz de línea de comandos de MySQL.
	**-h 127.0.0.1: Especifica la dirección IP del host del servidor de la bdd.
	**--port=3306: Especifica el puerto en el que el servidor de la bdd está escuchando.
    **-u root: Especifica el nombre de usuario con el que se conectará a la bdd.
	**-p: Solicita una contraseña al usuario.
    **test: Especifica el nombre de la base de datos a la que se conectará.
	** > website-backup-consola.sql: Redirige la entrada del archivo 
		"website-backup-consola.sql" al comando mysql, lo que restaurará la bdd 
	**--verbose: Muestra información detallada sobre el proceso de restauración.
    */
    
	