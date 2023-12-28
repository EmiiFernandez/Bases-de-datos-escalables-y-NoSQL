USE website;

## TRANSACCIONES
	
    /* El concepto de transacción se basa en la idea de que una serie de acciones de la base 
		de datos deben ser tratadas como una entidad única, y estas acciones deben completarse 
		en su totalidad o deshacerse por completo si ocurre algún error.
		Las propiedades clave de las transacciones son conocidas como las propiedades ACID:
			- Atomicidad (Atomicity): Una transacción es atómica, lo que significa que todas 
            las operaciones dentro de la transacción se realizan como una única unidad. 
            Si alguna parte de la transacción falla, todas las operaciones se deshacen 
            (rollback) para mantener la coherencia de la base de datos.
            - Consistencia (Consistency): La ejecución de una transacción lleva la base 
            de datos de un estado consistente a otro. Si la transacción se completa con éxito, 
            la base de datos queda en un estado consistente. Si la transacción falla, 
            la base de datos se devuelve al estado que tenía antes de la transacción. 
            - Aislamiento (Isolation): Cada transacción se ejecuta en un entorno aislado, 
            lo que significa que sus efectos no son visibles para otras transacciones hasta 
            que se complete. Esto ayuda a prevenir interferencias entre transacciones 
            concurrentes.
            - Durabilidad (Durability): Una vez que una transacción se ha completado con éxito, 
            sus efectos son permanentes y se mantienen incluso en caso de un fallo del sistema. 
            Los cambios realizados por la transacción persisten en la base de datos
		Es solo para manipular datos
        No es recomendable utilizar DROP*/
    
	-- Puede ser START o BEGIN TRANSACTION 
    -- Ejecuto y comienzo a realizar la transacción. Si algo llega a pasar se autocommitea
START TRANSACTION;
	-- Inserto un producto en la base de datos
INSERT INTO products VALUES (default, 'product with trans', 100, 1, '', '', 1, NOW(), NOW());

	-- Al ejecutar el commit se persiste la transacción en la BDD y puede ser visto
		-- en todas las sesiones
COMMIT;

SELECT * FROM products ORDER BY id DESC;

	/* Si inicio una transacción y modifico desde el resultado de grillas y utilizo
		el apply se autocommiteará*/