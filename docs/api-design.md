# OVERVIEW AND CONVENTIONS

This API is designed for use by receptionists at our clients' salons. Authentication and login are not required in this version.

The API follows these conventions:

- **JSON:** All JSON fields use `snake_case`.
- **Dates:** All dates and timestamps use ISO 8601 format.
- **Phone numbers:** Phone numbers use the E.164 international format.
- **Time zone:** All dates and times use the salon's local time zone (UTC-06).

# ENDPOINTS

| ID | Method | Route | Description |
|---|---|---|---|
| R1 | GET | `/services` | Get the list of available services. |
| R2 | POST | `/clients` | Create a new client. |
| R3 | GET | `/clients/:id` | Get a client by ID. |
| R4 | POST | `/appointments` | Create a new appointment. |
| R5 | GET | `/appointments?client_id=…` | Get all appointments for a specific client. |
| R6 | GET | `/appointments?from=YYYY-MM-DD[&to=YYYY-MM-DD]` | Get appointments within a date range. |
| R7–R8 | PATCH | `/appointments/:id` | Update an existing appointment. |

# ENDPOINT DETAILS

# ENDPOINT DETAILS

### R1. GET /services

**Request body:** None.

**Success response:** `200 OK`

**Response body:** Array of services with all their fields.

```json
[
  {
    "id": 1,
    "name": "Haircut",
    "duration_minutes": 30,
    "current_price": 250
  },
  {
    "id": 2,
    "name": "Manicure",
    "duration_minutes": 60,
    "current_price": 350
  }
]
```

### R2. POST /clients

**Request body:**

```json
{
  "name": "Luisa",
  "phone": "+524422582568",
  "email": "luisa@gmail.com"
}
```

**Success response:** `201 Created`

**Response body:** The created client object, including the server-generated ID.

```json
{
  "id": 1,
  "name": "Luisa",
  "phone": "+524422582568",
  "email": "luisa@gmail.com"
}
```

### R3. GET /clients/:id

**Request body:** None.

**Success response:** `200 OK`

**Response body:** A single client object with all its fields.

### R4. POST /appointments

**Request body:**

```json
{
  "client_id": 1,
  "stylist_id": 1,
  "service_id": 1,
  "starts_at": "2026-11-02T14:00:00-06:00"
}
```

**Success response:** `201 Created`

**Response body:** The created appointment object. The server generates the ID, calculates `ends_at`, copies the current service price into `price`, and sets the initial status to `scheduled`.

```json
{
  "id": 1,
  "client_id": 1,
  "stylist_id": 1,
  "service_id": 1,
  "starts_at": "2026-11-02T14:00:00-06:00",
  "ends_at": "2026-11-02T14:30:00-06:00",
  "price": 250,
  "status": "scheduled"
}
```

### R5. GET /appointments?client_id=12

**Request body:** None.

**Success response:** `200 OK`

**Response body:** Array of all appointments belonging to the specified client, including all appointment fields.

### R6. GET /appointments?from=YYYY-MM-DD[&to=YYYY-MM-DD]

**Request body:** None.

**Success response:** `200 OK`

**Response body:** Array of appointments within the specified date range.

### R7. PATCH /appointments/:id (Cancel appointment)

**Request body:**

```json
{
  "status": "cancelled"
}
```

**Success response:** `200 OK`

**Response body:** The complete updated appointment object, including all its fields.

### R8. PATCH /appointments/:id (Edit appointment)

**Request body:** Only the fields that need to be updated, such as:

```json
{
  "service_id": 2
}
```

**Success response:** `200 OK`

**Response body:** The complete updated appointment object. If the service changes, the server recalculates `ends_at` and updates `price` using the new service information.

# BUSINESS RULES

### 4.1 Appointment status transitions

Appointments have three possible statuses: `scheduled`, `completed`, and `cancelled`.

The following transitions are allowed:

| From | To | Allowed | Reason |
|---|---|---|---|
| `scheduled` | `cancelled` | Yes | A scheduled appointment can be cancelled. |
| `scheduled` | `completed` | Yes | A scheduled appointment can be completed. |
| `completed` | `cancelled` | No | A completed appointment cannot be cancelled. |
| `cancelled` | `scheduled` | No | A cancelled appointment cannot be reactivated. |
| `completed` | `scheduled` | No | A completed appointment cannot return to a pending state. |

The `completed` and `cancelled` statuses are terminal states. No further status changes are allowed from these states.

### 4.2 Appointment editing

An appointment can only be edited when its current status is `scheduled`.

The following fields can be updated:

- `client_id`
- `stylist_id`
- `service_id`
- `starts_at`

The `price` cannot be edited manually.

If the appointment status is `completed` or `cancelled`, no appointment fields can be edited.

### 4.3 Price rules

The client does not send the appointment price.

The server gets the current price from `services.current_price` and saves it in `appointments.price` when creating an appointment.

If the service changes, the server updates the appointment price using the new service price.

The original price is stored in the appointment, so future service price changes do not affect existing appointments.

### 4.4 Appointment end time

The client only sends `starts_at`.

The server calculates `ends_at` using:

`ends_at = starts_at + duration_minutes`

The duration comes from `services.duration_minutes`.

The client cannot send or modify `ends_at` manually.

If the service changes, the server recalculates `ends_at` using the new service duration.

### 4.5 Appointment date filters

The `from` and `to` parameters are used to filter appointments by date.

Both dates are inclusive and use the salon's time zone (UTC-06).

Rules:

- `from` is required.
- `to` is optional.
- If `to` is not provided, it has the same value as `from`.
- If both are provided, the API includes appointments from the `from` date through the `to` date.
- The `to` date cannot be earlier than the `from` date.

Examples:

**Appointments for November 2, 2026:**

`GET /appointments?from=2026-11-02`

**Appointments from November 1 to November 2, 2026:**

`GET /appointments?from=2026-11-01&to=2026-11-02`

Internally, the server uses a half-open date interval for PostgreSQL:

- Start: `starts_at >= from`
- End: `starts_at < (to + 1 day)`

This includes the entire final day without depending on a specific time value.

# OUT OF SCOPE

The following features are not included in this API version:

### 5.1 Discounts

Discounts and special prices for clients are not included.

The API only uses the current service price when creating an appointment. Discount rules may be added in a future version.

### 5.2 Appointment overlap validation

The API does not currently prevent appointments from overlapping in time.

The database only prevents two appointments for the same stylist from having the exact same start time.

Full overlap validation will be considered in a future version.

### 5.3 Error responses

Detailed error responses are not defined in this version.

Error codes, messages, and response formats will be documented in a separate section (3.4).

### 5.4 Authentication and login

Authentication and login are not included.

The API is currently designed for receptionists, without user accounts or login requirements.

Authentication and access control may be added in a future version.


