-- Представление с вложенным запросом
CREATE VIEW TotalBookings AS
SELECT first_name, last_name,
       (SELECT COUNT(*) FROM booking WHERE users.client_id = booking.client_id) AS total_bookings
FROM users;


-- Представление с группировкой
CREATE VIEW RoomTypeCount AS
SELECT type, COUNT(*) AS room_count
FROM numbers
GROUP BY type;


-- Представление с соединением
CREATE VIEW ClientBookings AS
SELECT users.first_name, users.last_name, numbers.room_number, type, booking.booking_date
FROM users
JOIN booking ON users.client_id = booking.client_id
JOIN numbers ON booking.room_number = numbers.room_number;


-- Изменяемое представление с условием WHERE
CREATE VIEW AvailableRooms AS
SELECT room_number, type, price
FROM numbers
WHERE room_number IN (SELECT booking.room_number from booking where booking.check_out_date > CURRENT_DATE);


