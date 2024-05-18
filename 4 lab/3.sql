--3
DROP VIEW AVAILABLEROOMS;
CREATE VIEW AVAILABLEROOMS AS
SELECT booking.room_number,
       booking.client_id,
       booking.check_out_date
from booking
where booking.check_out_date >= '2024-05-01'::date
  and booking.check_out_date is not null
WITH CHECK OPTION;

--4--
INSERT INTO AvailableRooms (room_number, client_id, check_out_date)
VALUES (100, 1, '2024-04-04'::date);

--5
--•	Хранимую процедуру, выполняющую несколько инструкций;
CREATE OR REPLACE PROCEDURE insert_and_update_booking(
    p_client_id integer,
    p_room_number integer,
    p_booking_date date,
    p_check_in_date date,
    p_check_out_date date
)
     LANGUAGE 'plpgsql'
AS
$$
BEGIN
    INSERT INTO booking (client_id, room_number, booking_date, check_in_date, check_out_date)
    VALUES (p_client_id, p_room_number, p_booking_date, p_check_in_date, p_check_out_date);

    UPDATE booking
    SET check_out_date = p_check_out_date + INTERVAL '2 day'
    WHERE booking_id = (SELECT MAX(booking_id) FROM booking);
END;
$$;

CALL insert_and_update_booking(1, 311, '2024-04-01'::date, '2024-04-03'::date, '2025-01-01'::date);

--Хранимую процедуру с вводимым параметром (дата, идентификатор, значение столбца и т.д.)

CREATE OR REPLACE PROCEDURE select_all_booking_user(p_client integer)
    LANGUAGE 'plpgsql'
AS
$$
DECLARE
    rec RECORD;
BEGIN
    FOR rec IN SELECT * FROM booking WHERE client_id = p_client
        LOOP
            RAISE NOTICE 'booking room: %, client: %, check_out: %', rec.room_number, rec.client_id, rec.check_out_date;
        END LOOP;
END;
$$;

CALL select_all_booking_user(1);

--6

-- CREATE EXTENSION IF NOT EXISTS pg_cron;
--
-- SELECT cron.schedule('30 9 * * 6', $$CALL select_all_booking(1)$$);

--7

CREATE OR REPLACE FUNCTION count_userinbooking()
    RETURNS INTEGER AS
$$
DECLARE
    count_rec INTEGER;
BEGIN
    SELECT COUNT(*) INTO count_rec FROM users WHERE client_id IN (Select client_id from booking);
    RETURN count_rec;
END;
$$ LANGUAGE 'plpgsql';

SELECT count_userinbooking();

--8

--вставка
CREATE OR REPLACE FUNCTION trigger_insert()
    RETURNS TRIGGER AS
$$
BEGIN
    NEW.booking_date = CURRENT_DATE;
    RETURN NEW;
END;
$$ LANGUAGE 'plpgsql';

CREATE TRIGGER booking_date_trigger
    BEFORE INSERT
    ON booking
    FOR EACH ROW
EXECUTE FUNCTION trigger_insert();


INSERT INTO booking (client_id, room_number, check_out_date)
VALUES (1, 101, '2024-05-20');

--обновление
CREATE OR REPLACE FUNCTION trigger_update()
    RETURNS TRIGGER AS
$$
BEGIN
    NEW.booking_date = CURRENT_DATE + INTERVAL '1 day';
    RETURN NEW;
END;
$$ LANGUAGE 'plpgsql';

CREATE TRIGGER booking_date_update_trigger
    BEFORE UPDATE
    ON booking
    FOR EACH ROW
EXECUTE FUNCTION trigger_update();


UPDATE booking
SET check_out_date = '2024-05-21'
WHERE booking_id = (SELECT MAX(booking_id) FROM booking);

--удаление
CREATE OR REPLACE FUNCTION trigger_delete()
    RETURNS TRIGGER AS
$$
BEGIN
    RAISE NOTICE  'Запись % удалена', OLD.booking_id;
    RETURN OLD;
END;
$$ LANGUAGE 'plpgsql';

CREATE TRIGGER booking_date_delete_trigger
    BEFORE DELETE
    ON booking
    FOR EACH ROW
EXECUTE FUNCTION trigger_delete();

DELETE
FROM booking
WHERE booking_id = (SELECT MAX(booking_id) FROM booking);