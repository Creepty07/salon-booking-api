CREATE ROLE salon_api LOGIN PASSWORD 'set_password';
GRANT CONNECT ON DATABASE salon_dev TO salon_api;
GRANT USAGE ON SCHEMA public TO salon_api;
GRANT SELECT ON services TO salon_api;
GRANT SELECT, INSERT ON clients TO salon_api;
GRANT SELECT, INSERT, UPDATE ON appointments TO salon_api;
GRANT SELECT ON stylists TO salon_api;

