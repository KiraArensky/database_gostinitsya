-- Представление с вложенным запросом
CREATE VIEW TotalBookings AS
SELECT first_name,
       last_name,
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
-- CREATE VIEW AvailableRooms AS
-- SELECT numbers.room_number, type, price, (SELECT booking.check_out_date from booking where numbers.room_number = booking.room_number)
-- FROM numbers
-- WHERE numbers.room_number NOT IN (SELECT booking.room_number from booking where (booking.check_out_date < '2024-05-01'::date) AND booking.check_out_date is not NULL)
--

CREATE VIEW AVAILABLEROOMS AS
SELECT booking.room_number,
       booking.client_id,
       booking.check_out_date
from booking
where booking.check_out_date >= '2024-05-01'::date
  and booking.check_out_date is not null
