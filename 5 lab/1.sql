--1

SELECT rolname
FROM pg_roles;

--2

CREATE ROLE read_role;
CREATE ROLE insert_role;
CREATE ROLE update_role;
CREATE ROLE delete_role;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO read_role;
GRANT INSERT ON ALL TABLES IN SCHEMA public TO insert_role;
GRANT UPDATE ON ALL TABLES IN SCHEMA public TO update_role;
GRANT DELETE ON ALL TABLES IN SCHEMA public TO delete_role;

--3

CREATE USER connected_role WITH PASSWORD 'connected_role';
GRANT CONNECT ON DATABASE postgres TO connected_role;
ALTER USER connected_role CREATEDB;
GRANT ALL PRIVILEGES ON DATABASE postgres TO connected_role;

SET ROLE connected_role;
CREATE DATABASE test_db;
RESET ROLE;

SET ROLE connected_role;
drop database test_db;
RESET ROLE;

--4
ALTER USER connected_role WITH PASSWORD 'change_password';
ALTER USER connected_role VALID UNTIL '2025-12-12';

--5
create role Admin superuser;

--6,7
SET ROLE Admin;
CREATE USER "user";
GRANT read_role TO "user";
REVOKE "read_role" FROM "user";
GRANT SELECT (first_name, email) ON "users" TO "user";
REVOKE SELECT (client_id, phone_number) ON public."users" FROM "user";

SET ROLE "user";
SELECT first_name
FROM "users";
RESET ROLE;

--8

CREATE USER Manager;
GRANT SELECT, UPDATE ON ALL TABLES IN SCHEMA public TO Manager;

SET ROLE manager;
SELECT * FROM "users";
DELETE FROM booking where booking_id = (SELECT MAX(booking_id) FROM booking);
RESET ROLE;



--9
REVOKE ALL PRIVILEGES ON ALL TABLES IN SCHEMA public FROM manager;
DROP USER manager;

--10
CREATE GROUP managers;
GRANT SELECT, INSERT, UPDATE ON ALL TABLES IN SCHEMA public TO managers;

--11
CREATE USER manager;
GRANT managers TO manager;

--12
CREATE USER test_user;
GRANT SELECT, INSERT, UPDATE ON ALL TABLES IN SCHEMA public TO test_user;


