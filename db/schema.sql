CREATE TABLE clients (
    id  INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR(100) NOT NULL CHECK(name <> ''),
    phone VARCHAR(20) UNIQUE NOT NULL,
    email VARCHAR(50),
    CONSTRAINT client_phone_not_empty CHECK (phone <> '')
);

CREATE TABLE services (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR(100) NOT NULL CHECK(name <> ''),
    duration_minutes INTEGER NOT NULL,
    current_price NUMERIC(7,2) NOT NULL,
    CONSTRAINT service_duration_minutes_positive CHECK(duration_minutes > 0),
    CONSTRAINT service_current_price_positive CHECK(current_price > 0)
);

CREATE TABLE stylists (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR(100) NOT NULL CHECK(name <> ''),
    is_active BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE stylist_services (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    service_id INTEGER NOT NULL REFERENCES services(id),
    stylist_id INTEGER NOT NULL REFERENCES stylists(id),
    CONSTRAINT stylist_service_unique UNIQUE(service_id, stylist_id)
);

CREATE TABLE appointments (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    client_id INTEGER NOT NULL REFERENCES clients(id),
    stylist_id INTEGER NOT NULL REFERENCES stylists(id),
    service_id INTEGER NOT NULL REFERENCES services(id),
    starts_at TIMESTAMPTZ NOT NULL,
    ends_at TIMESTAMPTZ NOT NULL,
    price NUMERIC(7,2) NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'scheduled',
    CONSTRAINT appointment_price_nonnegative CHECK (price >= 0),
    CONSTRAINT appointment_status_check CHECK (status IN ('scheduled', 'cancelled', 'completed')),
    CONSTRAINT appointment_stylist_start_unique UNIQUE(stylist_id, starts_at),
    CONSTRAINT appointment_ends_after_starts CHECK (ends_at > starts_at),
    CONSTRAINT appointment_stylist_service_fk FOREIGN KEY (stylist_id, service_id) REFERENCES stylist_services (stylist_id, service_id)
);