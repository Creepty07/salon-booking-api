# DATABASE BEAUTY SALON

## clients
- id (PK)
- name
- phone (UNIQUE)
- email

## services
- id (PK)
- name
- duration_minutes
- current_price

## stylist_services — UNIQUE(service_id, stylist_id)
- id (PK)
- service_id (FK)
- stylist_id (FK)

## stylists
- id (PK)
- name
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
- FOREIGN KEY (stylist_id, service_id) REFERENCES stylist_services (stylist_id, service_id)

## RELATIONS
- **CLIENTS 1:N APPOINTMENTS:** A client can have many appointments; each appointment belongs to one client.
- **STYLISTS 1:N APPOINTMENTS:** A stylist can have many appointments; each appointment belongs to one stylist.
- **SERVICES 1:N APPOINTMENTS:** A service can appear in many appointments; each appointment is for one service.
- **SERVICES N:M STYLISTS:** A stylist can perform many services, and each service can be performed by many stylists. The `stylist_services` table implements this relationship.
- **APPOINTMENTS → STYLIST_SERVICES:** Each appointment must use a stylist-service combination that exists in `stylist_services`.
