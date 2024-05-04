SELECT A.*, B.*
FROM "booking" A, "booking" B
WHERE A.booking_id = B.booking_id;