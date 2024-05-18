SELECT * FROM AvailableRooms;

-- Вставка нового доступного номера
INSERT INTO AvailableRooms (room_number, client_id, check_out_date)
VALUES (311, 1, '2024-05-03'::date);

-- Обновление стоимости проживания за ночь для доступного номера
UPDATE AvailableRooms
SET check_out_date = '2024-06-06'
WHERE room_number = 311;

-- Попытка вставить новый занятый номер
INSERT INTO AvailableRooms (room_number, client_id, check_out_date)
VALUES (100, 1, '2024-04-04'::date);

-- Попытка обновить стоимость проживания за ночь для занятого номера
UPDATE AvailableRooms
SET check_out_date = '2024-06-06'
WHERE room_number = 100;
