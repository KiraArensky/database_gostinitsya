SELECT * FROM AvailableRooms;

-- Вставка нового доступного номера
INSERT INTO AvailableRooms (room_number, type, price)
VALUES (311, 2, 3000);

-- Обновление стоимости проживания за ночь для доступного номера
UPDATE AvailableRooms
SET price = 1200
WHERE room_number = 311;

-- Попытка вставить новый занятый номер
INSERT INTO AvailableRooms (room_number, type, price)
VALUES (105, 2, 10000);

-- Попытка обновить стоимость проживания за ночь для занятого номера
UPDATE AvailableRooms
SET price = 890980
WHERE room_number = 101;
