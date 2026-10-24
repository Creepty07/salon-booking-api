# DATABASE BEAUTY SALON

## clients
- id (PK)
- name
- phone (UNIQUE)
- mail

## services 
- id (PK)
- name
- duration
- current_price

## stylist_services - UNIQUE(stylist_id, service_id)
- id (PK)
- service_id (FK)
- stylist_id (FK)

## stylists:
- id (PK)
- name
- is_active

## appointments - UNIQUE(stylist_id, date, start_time)
- id (PK)
- client_id (FK)
- stylist_id (FK)
- service_id (FK)
- date
- start_time
- price
- status

## RELATIONS:
- CLIENTS 1:N APPOINTMENTS: A client can have many appointments; each appointment belongs to one client.
- STYLISTS 1:N APPOINTMENTS: A stylist can have many appointments; each appointment belongs to one stylist.
- SERVICES 1:N APPOINTMENTS: A service can appear in many appointments; each appointment is for one service.
- SERVICES N:M STYLISTS: A stylist can perform many services, and each service can be performed by many stylists.
