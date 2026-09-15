# Vehicle Sharing Next.js UI

Modern React/Next.js frontend for the existing Spring Boot Vehicle Sharing REST APIs.

## Stack
- Next.js 14
- React 18
- TypeScript
- Java 17 / Spring Boot backend
- REST API integration

## Run
```bash
cd frontend
cp .env.example .env.local
npm install
npm run dev
```

The UI runs on `http://localhost:3000` and expects the backend at `http://localhost:8080` by default.

## Implemented flows
- List all rides
- Search rides by source, destination and travel date
- Publish a ride
- Book seats on an existing ride
- Lookup bookings by passenger email
- Responsive UI for desktop and mobile

The API client is centralized under `lib/api.ts` and maps directly to the existing Spring Boot endpoints.
