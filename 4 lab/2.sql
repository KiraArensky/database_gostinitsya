SELECT * FROM TotalBookings;
SELECT * FROM RoomTypeCount;
SELECT * FROM ClientBookings;
SELECT * FROM AvailableRooms;

-- Вставка нового доступного номера
INSERT INTO AvailableRooms (room_number, type, price)
VALUES (9999, 3, 999);

-- Обновление стоимости проживания за ночь для доступного номера
UPDATE AvailableRooms
SET price = 1200
WHERE room_number = 8989;

-- Попытка вставить новый занятый номер
INSERT INTO AvailableRooms (room_number, type, price)
VALUES (909, 2, 2000);

-- Попытка обновить стоимость проживания за ночь для занятого номера
UPDATE AvailableRooms
SET price = 890980
WHERE room_number = 100;
