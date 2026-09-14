# Vehicle Sharing Platform

A backend-focused vehicle and ride sharing platform built with **Java 17, Spring Boot, Spring Data JPA/Hibernate, REST APIs, MySQL/H2, Maven and Spring Security**.

[![Java](https://img.shields.io/badge/Java-17-orange)](https://www.oracle.com/java/)
[![Spring Boot](https://img.shields.io/badge/Spring%20Boot-3.3-brightgreen)](https://spring.io/projects/spring-boot)
[![Build](https://img.shields.io/badge/build-Maven-blue)](https://maven.apache.org/)

## Why this project

The platform models a practical ride-sharing workflow: vehicle owners publish rides, passengers search by route/date, and bookings are validated against journey order, date and seat availability. The current default branch is the Java/Spring Boot implementation. The original Ruby on Rails version is preserved in the `legacy-rails` branch for history.

## Highlights

- RESTful APIs for **vehicles, rides and bookings**
- Layered design: **Controller -> Service -> Repository -> Database**
- Persistence with **Spring Data JPA / Hibernate**
- MySQL-ready configuration with **H2** for zero-setup local development
- Bean Validation for request/domain validation
- Transactional booking flow with seat inventory updates
- Route validation that prevents invalid origin/destination ordering
- Centralized API exception handling
- Spring Security configuration foundation
- Maven build and GitHub Actions CI

## Architecture

```text
Client / Postman
      |
      v
REST Controllers
      |
      v
Service Layer
      |
      v
Spring Data JPA Repositories
      |
      v
Hibernate / JPA
      |
      +------> H2 (local)
      |
      +------> MySQL (environment configured)
```

## Tech stack

| Area | Technology |
|---|---|
| Language | Java 17 |
| Framework | Spring Boot 3 |
| API | Spring Web / REST |
| Persistence | Spring Data JPA, Hibernate |
| Database | MySQL, H2 |
| Validation | Jakarta Bean Validation |
| Security | Spring Security |
| Build | Maven |
| Testing | JUnit 5, Mockito |
| CI | GitHub Actions |

## Core domain

**Vehicle** stores vehicle number, available seats, route endpoints, cost and discount.

**Ride** represents a published journey with an owner, vehicle, seats, origin, intermediate stops, destination, price and travel date.

**Booking** represents a passenger reservation for a specific ride, route segment, date and number of seats.

## API endpoints

| Method | Endpoint | Purpose |
|---|---|---|
| GET | `/api/vehicles` | List vehicles |
| POST | `/api/vehicles` | Create a vehicle |
| GET | `/api/rides` | List rides |
| GET | `/api/rides/{id}` | Get ride by id |
| GET | `/api/rides/search?from=...&to=...&date=YYYY-MM-DD` | Search rides |
| POST | `/api/rides` | Publish a ride |
| DELETE | `/api/rides/{id}` | Delete a ride |
| POST | `/api/bookings` | Book seats |
| GET | `/api/bookings?passengerEmail=...` | View passenger bookings |

## Example: publish a ride

```bash
curl -X POST http://localhost:8080/api/rides \
  -H "Content-Type: application/json" \
  -d '{
    "ownerEmail":"owner@example.com",
    "vehicleNo":"WB01AB1234",
    "seats":4,
    "startPoint":"Kolkata",
    "stop1":"Burdwan",
    "finalStop":"Durgapur",
    "cost":800,
    "discount":50,
    "date":"2026-09-20"
  }'
```

## Example: book seats

```bash
curl -X POST http://localhost:8080/api/bookings \
  -H "Content-Type: application/json" \
  -d '{
    "rideId":1,
    "passengerEmail":"passenger@example.com",
    "startLocation":"Kolkata",
    "destination":"Durgapur",
    "seats":2,
    "date":"2026-09-20"
  }'
```

## Run locally

### Prerequisites

- Java 17+
- Maven 3.8+

```bash
git clone https://github.com/souravbanerjee23/Vehcile-Sharing-Final.git
cd Vehcile-Sharing-Final
mvn clean test
mvn spring-boot:run
```

The application starts on `http://localhost:8080` and uses an in-memory H2 database by default.

### Run with MySQL

Create a database named `vehicle_sharing`, then set:

```bash
export DB_URL='jdbc:mysql://localhost:3306/vehicle_sharing'
export DB_USERNAME='root'
export DB_PASSWORD='your-password'
mvn spring-boot:run
```

## Key design decisions

### Route-order validation
A booking is accepted only when the selected destination appears after the selected start location in the ride's ordered route. This moves route consistency into the service layer instead of trusting client input.

### Transactional seat update
Booking creation and seat decrement execute within a transaction so the two database operations are treated as one unit of work.

### Database portability
Local development uses H2 in MySQL compatibility mode, while environment variables allow the same application to connect to MySQL without changing source code.

## Project structure

```text
src/main/java/com/sourav/vehiclesharing
├── config/        # Spring Security configuration
├── controller/    # REST controllers
├── exception/     # Centralized exception handling
├── model/         # JPA entities
├── repository/    # Spring Data repositories
└── service/       # Business logic / booking validation
```

## Future improvements

- JWT-based authentication and role authorization
- Optimistic/pessimistic locking for highly concurrent seat booking
- Pagination and richer ride search
- OpenAPI/Swagger documentation
- Dockerized production profile and observability

## Resume-ready summary

**Vehicle Sharing Platform | Java, Spring Boot, Spring Data JPA, Hibernate, MySQL, REST APIs**  
Built a layered REST backend for publishing rides and booking seats, implementing route/date validation, transactional seat inventory updates, centralized exception handling and database portability between H2 and MySQL.

---

Created and maintained by [Sourav Bandyopadhyay](https://www.linkedin.com/in/sourav-bandyopadhyay-78497715a/).
