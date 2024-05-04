SELECT * FROM users;

SELECT first_name FROM users;

SELECT price FROM numbers where type = 1;

SELECT booking_date FROM booking where room_number BETWEEN 500 AND 990;

SELECT description FROM room_type where name LIKE 'V_P';

SELECT first_name FROM users where email IN ('kshi.txt@yandex.ru', 'durnayapsinka@mail.ru');

SELECT first_name FROM users ORDER BY last_name DESC;

SELECT first_name FROM users ORDER BY last_name DESC LIMIT 2;

SELECT * FROM booking CROSS JOIN numbers;

SELECT * FROM booking JOIN numbers ON booking.room_number = numbers.room_number;

SELECT A.*, B.* FROM "booking" A, "booking" B WHERE A.booking_id = B.booking_id;