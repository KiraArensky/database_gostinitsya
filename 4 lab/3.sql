CREATE OR REPLACE VIEW AvailableRooms AS
SELECT room_number, type, price
FROM numbers
WHERE room_number IN (SELECT booking.room_number from booking where booking.check_out_date > CURRENT_DATE);

CREATE OR REPLACE FUNCTION prevent_insert_update_on_view() RETURNS TRIGGER AS $$
BEGIN
  IF NEW.room_number IN (SELECT booking.room_number from booking where booking.check_out_date < CURRENT_DATE) THEN
    RAISE EXCEPTION 'Номер должен быть свободен';
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER AvailableRoomsInsertUpdateTrigger
INSTEAD OF INSERT OR UPDATE ON AvailableRooms
FOR EACH ROW EXECUTE FUNCTION prevent_insert_update_on_view();
