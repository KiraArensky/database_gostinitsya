-- Запрос на подсчет количества строк в таблице, удовлетворяющих заданному условию (COUNT)
SELECT COUNT(*) FROM numbers WHERE price > 1001;

-- Запрос на подсчет среднего значения в каком-либо столбце таблицы (функция AVG)
SELECT AVG(price) FROM numbers;

-- Запрос на подсчет суммы значений какого-либо столбца в таблице (функция SUM)
SELECT SUM(seats) FROM room_type;

-- Запрос на нахождение максимального значения в столбце таблицы (функция MAX)
SELECT MAX(price) FROM numbers;

-- Запрос на нахождение минимального значения в столбце таблицы (функция MIN)
SELECT MIN(seats) FROM room_type;

-- Запрос на нахождение минимального значения в столбце таблицы без использования функции MIN, применяя ORDER BY и LIMIT
SELECT seats FROM room_type ORDER BY seats ASC LIMIT 1;

-- Запрос на нахождение максимального значения в столбце таблицы без использования функции MAX, применяя ORDER BY DESC и LIMIT
SELECT price FROM numbers ORDER BY price DESC LIMIT 1;

-- Запрос с группировкой строк и подсчетом значения любой агрегатной функции по каждой группе (GROUP BY)
SELECT client_id, COUNT(client_id) FROM booking GROUP BY client_id; /* количества бронирование */

-- Запрос с соединением не менее, чем 2-х таблиц, группировкой строк и подсчетом значения любой агрегатной функции по каждой группе (GROUP BY)
SELECT t1.first_name, t2.booking_date, COUNT(*) FROM users t1 JOIN booking t2 ON t1.client_id = t2.client_id GROUP BY t1.first_name, t2.booking_date;

-- Запрос SELECT с использованием вложенного подзапроса SELECT
SELECT booking_id FROM booking WHERE client_id IN (SELECT client_id FROM users WHERE first_name LIKE 'Кирилл'); /* по имени польхзователя все его бронированиия*/

-- Запрос INSERT с использованием вложенного подзапроса SELECT
INSERT INTO booking (client_id, room_number, booking_date, check_in_date, check_out_date)  SELECT client_id, numbers.room_number, booking_date, check_in_date, check_out_date FROM booking, numbers WHERE numbers.type = 3; /* номера определенной категории и добавить в бронирование */

-- Запрос на объединение результатов запросов с использованием UNION
SELECT room_number FROM numbers UNION SELECT id FROM room_type;

-- Запрос на соединение таблиц с использованием JOIN (все виды)
-- INNER JOIN
SELECT * FROM users INNER JOIN booking ON users.client_id = booking.client_id; /* добавить пользователя который не совершал бронирование */
-- LEFT JOIN
SELECT * FROM users LEFT JOIN booking ON users.client_id = booking.client_id;
-- RIGHT JOIN
SELECT * FROM users RIGHT JOIN booking ON users.client_id = booking.client_id;
-- FULL JOIN
SELECT * FROM users full JOIN booking ON users.client_id = booking.client_id;
