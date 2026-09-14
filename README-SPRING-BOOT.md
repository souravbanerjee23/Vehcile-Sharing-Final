# Vehicle Sharing Platform - Spring Boot Rewrite

A Java 17 / Spring Boot REST rewrite of the original Ruby on Rails vehicle-sharing application.

## Stack
Java 17, Spring Boot 3, Spring Web, Spring Data JPA/Hibernate, Bean Validation, Spring Security, MySQL, H2, Maven, JUnit.

## Architecture
`Controller -> Service -> Repository -> JPA/Hibernate -> Database`

## Features
- Create and list vehicles
- Publish rides with origin, intermediate stops, destination, date, seats and pricing
- Search rides by route/date
- Book seats on a ride
- Validate journey date and route ordering
- Atomically decrement available seats during booking
- Centralized validation/error responses
- MySQL-ready configuration; H2 is the zero-setup local default

## Run
Requires Java 17+ and Maven.

```bash
mvn spring-boot:run
```

For MySQL:
```bash
export DB_URL='jdbc:mysql://localhost:3306/vehicle_sharing'
export DB_USERNAME='root'
export DB_PASSWORD='your-password'
mvn spring-boot:run
```

## REST endpoints
- `GET /api/vehicles`
- `POST /api/vehicles`
- `GET /api/rides`
- `GET /api/rides/{id}`
- `GET /api/rides/search?from=Kolkata&to=Durgapur&date=2026-09-20`
- `POST /api/rides`
- `DELETE /api/rides/{id}`
- `POST /api/bookings`
- `GET /api/bookings?passengerEmail=user@example.com`

## Migration note
The original Rails source remains on `main` while this rewrite is reviewed on `spring-boot-rewrite`. The domain behavior is based on the original Vehicle, Ride and Rent models, including route/date validation.
