# DATABASE BEAUTY SALON

### Appointment Client Index

The `appointment_client_id_idx` index improves queries that search
appointments by client. It also helps PostgreSQL check for related
appointments when deleting a client.

The index requires additional storage and adds some overhead to
INSERT, UPDATE, and DELETE operations on appointments.

## clients
- id (PK)
- name — CHECK (btrim(name) <> '')
- phone (UNIQUE) — CHECK (btrim(phone) <> '')
- email

## services
- id (PK)
- name — CHECK (btrim(name) <> '')
- duration_minutes
- current_price

## stylist_services — UNIQUE(service_id, stylist_id)
- id (PK)
- service_id (FK)
- stylist_id (FK)

## stylists
- id (PK)
- name — CHECK (btrim(name) <> '')
- is_active

## appointments — UNIQUE(stylist_id, starts_at)
- id (PK)
- client_id (FK)
- stylist_id (FK)
- service_id (FK)
- starts_at
- ends_at
- price
- status
- FOREIGN KEY (stylist_id, service_id) REFERENCES stylist_services (stylist_id, service_id) — composite FK

## RELATIONS
- **CLIENTS 1:N APPOINTMENTS:** A client can have many appointments; each appointment belongs to one client.
- **STYLISTS 1:N APPOINTMENTS:** A stylist can have many appointments; each appointment belongs to one stylist.
- **SERVICES 1:N APPOINTMENTS:** A service can appear in many appointments; each appointment is for one service.
- **SERVICES N:M STYLISTS:** A stylist can perform many services, and each service can be performed by many stylists. The `stylist_services` table implements this relationship.
- **APPOINTMENTS → STYLIST_SERVICES:** Each appointment must use a stylist-service combination that exists in `stylist_services`.

## DATABASE ROLE AND PERMISSIONS

### salon_api

The `salon_api` role is a restricted database user intended for the API.
It follows the principle of least privilege by receiving only the permissions required by the API.

| Table | SELECT | INSERT | UPDATE | DELETE | Justification |
|---|:---:|:---:|:---:|:---:|---|
| `services` | X | | | | The API retrieves available services through `GET /services`. |
| `clients` | X | X | | | The API retrieves clients and creates new ones. |
| `appointments` | X | X | X | | The API retrieves, creates, and updates appointments. |
| `stylists` | X | | | | The API retrieves stylists to assign them to appointments. |
| `stylist_services` | | | | | The composite foreign key validates stylist-service combinations automatically. |

The role also receives:

- `CONNECT` on the `salon_dev` database.
- `USAGE` on the `public` schema.

The role does not receive `DELETE` permissions on any table.
Appointments are cancelled instead of deleted, preserving their history.

### Script execution order

Run the database scripts in the following order:

1. `db/schema.sql` — Creates the database tables, constraints, and indexes.
2. `db/seed.sql` — Inserts the initial data.
3. `db/user_salon_api.sql` — Creates the `salon_api` role and grants its permissions.

The schema and initial data must exist before configuring the API role's table permissions.

