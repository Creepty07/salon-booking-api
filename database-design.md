# BASE DE DATOS SALON

## CLIENTS
- id (PK)
- name
- phone (UNIQUE)
- mail

## SERVICES 
- id (PK)
- name
- duration
- current_price

## STYLIST_SERVICES
- id (PK)
- service_id (FK)
- stylist_id (FK)

## STYLISTS:
- id (PK)
- name
- is_active

## APPOINTMENTS - UNIQUE(stylist_id, date, start_time)
- id (PK)
- client_id (FK)
- stylist_id (FK)
- service_id (FK)
- date
- start_time
- price
- status

## RELACIONES:
- CLIENTS 1:N APPOINTMENTS
- STYLISTS 1:N APPOINTMENTS
- SERVICE 1:N APPOINTMENTS
- SERVICES N:M STYLIST
