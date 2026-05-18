-- 1. Obtén los clientes de Brasil
SELECT * FROM customer 
WHERE country = 'Brazil';

-- 2. Obtén los empleados que son agentes de ventas
SELECT * FROM employee 
WHERE title = 'Sales Support Agent';

-- 3. Obtén las canciones de ‘AC/DC’
-- Unimos track -> album -> artist
SELECT t.* FROM track t
JOIN album al ON t.album_id = al.album_id
JOIN artist ar ON al.artist_id = ar.artist_id
WHERE ar.name = 'AC/DC';

-- 4. Obtén los campos de los clientes que no sean de USA: Nombre completo, ID, País
SELECT first_name || ' ' || last_name AS nombre_completo, 
       customer_id, 
       country 
FROM customer 
WHERE country != 'USA';

-- 5. Obtén los empleados que son agentes de ventas: Nombre completo, Dirección y email
-- Usamos CONCAT_WS para evitar que un campo NULL (como state) anule toda la cadena
SELECT first_name || ' ' || last_name AS nombre_completo, 
       CONCAT_WS(', ', city, state, country) AS direccion, 
       email 
FROM employee 
WHERE title = 'Sales Support Agent';

-- 6. Obtén una lista con los países no repetidos a los que se han emitido facturas
SELECT DISTINCT billing_country 
FROM invoice;

-- 7. Obtén una lista con los estados de USA no repetidos de donde son los clientes y cuántos clientes en cada uno
SELECT state, COUNT(customer_id) AS total_clientes 
FROM customer 
WHERE country = 'USA' AND state IS NOT NULL
GROUP BY state;

-- 8. Cuántos artículos tiene la factura 37
SELECT COUNT(invoice_line_id) AS total_articulos
FROM invoice_line 
WHERE invoice_id = 37;

-- 9. Cuántas canciones tiene ‘AC/DC’
SELECT COUNT(t.track_id) AS total_canciones
FROM track t
JOIN album al ON t.album_id = al.album_id
JOIN artist ar ON al.artist_id = ar.artist_id
WHERE ar.name = 'AC/DC';

-- 10. Cuántos artículos tiene cada factura
SELECT invoice_id, COUNT(invoice_line_id) AS total_articulos 
FROM invoice_line 
GROUP BY invoice_id;

-- 11. Cuántas facturas hay de cada país
SELECT billing_country, COUNT(invoice_id) AS total_facturas 
FROM invoice 
GROUP BY billing_country;

-- 12. Cuántas facturas ha habido en 2009 y 2011
SELECT EXTRACT(YEAR FROM invoice_date) AS anio, COUNT(invoice_id) AS total_facturas
FROM invoice 
WHERE EXTRACT(YEAR FROM invoice_date) IN (2009, 2011)
GROUP BY EXTRACT(YEAR FROM invoice_date);

-- 13. Cuántas facturas ha habido entre 2009 y 2011
SELECT COUNT(invoice_id) AS total_facturas
FROM invoice 
WHERE EXTRACT(YEAR FROM invoice_date) BETWEEN 2009 AND 2011;

-- 14. Cuántas clientes hay de España y de Brasil
SELECT country, COUNT(customer_id) AS total_clientes
FROM customer 
WHERE country IN ('Spain', 'Brazil')
GROUP BY country;

-- 15. Obtén las canciones que su título empieza por ‘You’
SELECT * FROM track 
WHERE name LIKE 'You%';