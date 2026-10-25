INSERT INTO clients (
    name,
    phone,
    email
)
VALUES
    (
        'Ana',
        '5550000001',
        NULL
    ),
    (
        'Mariana',
        '5550000002',
        'mariana@gmail.com'
    ),
    (
        'Luciana',
        '5550000003',
        'luciana@gmail.com'
    ),
    (
        'Bruno',
        '5550000004',
        NULL
    ),
    (
        'Carla',
        '5550000005',
        'carla@gmail.com'
    );


INSERT INTO services (
    name,
    duration_minutes,
    current_price
)
VALUES
    (
        'Corte',
        30,
        250.00
    ),
    (
        'Tinte',
        90,
        800.00
    ),
    (
        'Peinado',
        45,
        350.00
    ),
    (
        'Manicure',
        60,
        300.00
    );


INSERT INTO stylists (
    name,
    is_active
)
VALUES
    (
        'Lupe',
        DEFAULT
    ),
    (
        'Rosa',
        DEFAULT
    ),
    (
        'Sofia',
        FALSE
    );


INSERT INTO stylist_services (
    service_id,
    stylist_id
)
VALUES
    (
        1,
        1
    ),
    (
        3,
        1
    ),
    (
        2,
        2
    ),
    (
        4,
        2
    ),
    (
        1,
        3
    );


INSERT INTO appointments (
    client_id,
    stylist_id,
    service_id,
    starts_at,
    ends_at,
    price,
    status
)
VALUES
    (
        1,
        1,
        1,
        '2026-11-02 10:00:00-06',
        '2026-11-02 10:30:00-06',
        250.00,
        'scheduled'
    ),
    (
        2,
        2,
        2,
        '2026-11-02 11:00:00-06',
        '2026-11-02 12:30:00-06',
        800.00,
        'scheduled'
    ),
    (
        3,
        1,
        3,
        '2026-10-21 12:00:00-06',
        '2026-10-21 12:45:00-06',
        350.00,
        'completed'
    ),
    (
        1,
        2,
        4,
        '2026-10-22 16:00:00-06',
        '2026-10-22 17:00:00-06',
        300.00,
        'completed'
    ),
    (
        2,
        2,
        2,
        '2026-10-20 10:00:00-06',
        '2026-10-20 11:30:00-06',
        800.00,
        'completed'
    ),
    (
        4,
        1,
        1,
        '2026-10-23 09:00:00-06',
        '2026-10-23 09:30:00-06',
        250.00,
        'cancelled'
    ),
    (
        1,
        1,
        3,
        '2026-11-04 15:00:00-06',
        '2026-11-04 15:45:00-06',
        300.00,
        'scheduled'
    ),
    (
        3,
        2,
        2,
        '2026-11-05 11:00:00-06',
        '2026-11-05 12:30:00-06',
        800.00,
        'scheduled'
    );