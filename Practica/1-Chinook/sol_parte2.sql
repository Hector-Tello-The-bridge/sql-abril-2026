-- 1. Facturas de Clientes de Brasil: Nombre del cliente, Id de factura, fecha y país
SELECT c.first_name || ' ' || c.last_name AS nombre_cliente, 
       i.invoice_id, 
       i.invoice_date, 
       i.billing_country 
FROM invoice i
JOIN customer c ON i.customer_id = c.customer_id
WHERE c.country = 'Brazil';

-- 2. Obtén cada factura asociada a cada agente de ventas con su nombre completo
SELECT i.invoice_id, 
       e.first_name || ' ' || e.last_name AS nombre_agente
FROM invoice i
JOIN customer c ON i.customer_id = c.customer_id
JOIN employee e ON c.support_rep_id = e.employee_id;

-- 3. Obtén el nombre del cliente, el país, el nombre del agente y el total
SELECT c.first_name || ' ' || c.last_name AS nombre_cliente, 
       c.country AS pais_cliente, 
       e.first_name || ' ' || e.last_name AS nombre_agente, 
       i.total 
FROM invoice i
JOIN customer c ON i.customer_id = c.customer_id
JOIN employee e ON c.support_rep_id = e.employee_id;

-- 4. Obtén cada artículo de la factura con el nombre de la canción
SELECT il.invoice_line_id, 
       il.invoice_id, 
       t.name AS nombre_cancion, 
       il.unit_price, 
       il.quantity 
FROM invoice_line il
JOIN track t ON il.track_id = t.track_id;

-- 5. Muestra todas las canciones con su nombre, formato, álbum y género
SELECT t.name AS nombre_cancion, 
       mt.name AS formato, 
       al.title AS album, 
       g.name AS genero 
FROM track t
JOIN media_type mt ON t.media_type_id = mt.media_type_id
JOIN album al ON t.album_id = al.album_id
JOIN genre g ON t.genre_id = g.genre_id;

-- 6. Cuántas canciones hay en cada playlist
SELECT p.name AS nombre_playlist, 
       COUNT(pt.track_id) AS total_canciones 
FROM playlist p
LEFT JOIN playlist_track pt ON p.playlist_id = pt.playlist_id
GROUP BY p.playlist_id, p.name;

-- 7. Cuánto ha vendido cada empleado
SELECT e.first_name || ' ' || e.last_name AS nombre_agente, 
       SUM(i.total) AS total_vendido 
FROM employee e
JOIN customer c ON e.employee_id = c.support_rep_id
JOIN invoice i ON c.customer_id = i.customer_id
GROUP BY e.employee_id, nombre_agente;

-- 8. ¿Quién ha sido el agente de ventas que más ha vendido en 2009?
SELECT e.first_name || ' ' || e.last_name AS nombre_agente, 
       SUM(i.total) AS total_vendido_2009 
FROM employee e
JOIN customer c ON e.employee_id = c.support_rep_id
JOIN invoice i ON c.customer_id = i.customer_id
WHERE EXTRACT(YEAR FROM i.invoice_date) = 2009
GROUP BY e.employee_id, nombre_agente
ORDER BY total_vendido_2009 DESC
LIMIT 1;

-- 9. ¿Cuáles son los 3 grupos que más han vendido?
SELECT ar.name AS nombre_grupo, 
       SUM(il.unit_price * il.quantity) AS total_vendido 
FROM artist ar
JOIN album al ON ar.artist_id = al.artist_id
JOIN track t ON al.album_id = t.album_id
JOIN invoice_line il ON t.track_id = il.track_id
GROUP BY ar.artist_id, nombre_grupo
ORDER BY total_vendido DESC
LIMIT 3;