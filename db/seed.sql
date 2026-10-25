INSERT INTO clients (name, phone)
VALUES ('Ana', '5550000001');

INSERT INTO services (name, duration_minutes, current_price)
VALUES ('Corte', 30, 250.00);

INSERT INTO stylists (name)
VALUES ('Lupe');

INSERT INTO stylists (name)
VALUES ('Rosa');

INSERT INTO stylist_services (service_id, stylist_id)
VALUES (1, 1);

INSERT INTO appointments (
    client_id, stylist_id, service_id,
    starts_at, ends_at, price, status
)
VALUES (
    1, 1, 1,
    '2026-11-02 10:00:00-06',
    '2026-11-02 10:30:00-06',
    250.00, 'scheduled'
);