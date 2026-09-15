export type Ride = {
  id?: number;
  ownerEmail: string;
  vehicleNo: string;
  seats: number;
  startPoint: string;
  stop1?: string;
  stop2?: string;
  stop3?: string;
  stop4?: string;
  finalStop: string;
  cost: number;
  discount?: number;
  date: string;
};

export type Booking = {
  id?: number;
  rideId: number;
  passengerEmail: string;
  startLocation: string;
  destination: string;
  seats: number;
  date: string;
  status?: 'CONFIRMED' | 'CANCELLED';
};

export type Vehicle = {
  id?: number;
  vehicleNo: string;
  seats: number;
  startPoint?: string;
  finalStop?: string;
  cost?: number;
  discount?: number;
};

export type UserRole = 'PASSENGER' | 'DRIVER';

type OtpRequestResponse = {
  message: string;
  contact: string;
  role: UserRole;
  expiresInMinutes: number;
  developmentOtp?: string;
};

type OtpVerifyResponse = {
  authenticated: boolean;
  message?: string;
  contact: string;
  role: UserRole;
};

const API_BASE = process.env.NEXT_PUBLIC_API_BASE_URL ?? 'http://localhost:8080';

async function request<T>(path: string, init?: RequestInit): Promise<T> {
  const response = await fetch(`${API_BASE}${path}`, {
    ...init,
    headers: {
      'Content-Type': 'application/json',
      ...(init?.headers ?? {})
    },
    cache: 'no-store'
  });

  if (!response.ok) {
    const message = await response.text();
    throw new Error(message || `Request failed with status ${response.status}`);
  }

  if (response.status === 204) return undefined as T;
  return response.json() as Promise<T>;
}

export const api = {
  listRides: () => request<Ride[]>('/api/rides'),
  searchRides: (from: string, to: string, date: string) =>
    request<Ride[]>(`/api/rides/search?from=${encodeURIComponent(from)}&to=${encodeURIComponent(to)}&date=${encodeURIComponent(date)}`),
  createRide: (ride: Ride) => request<Ride>('/api/rides', { method: 'POST', body: JSON.stringify(ride) }),
  deleteRide: (id: number) => request<void>(`/api/rides/${id}`, { method: 'DELETE' }),
  listVehicles: () => request<Vehicle[]>('/api/vehicles'),
  createVehicle: (vehicle: Vehicle) => request<Vehicle>('/api/vehicles', { method: 'POST', body: JSON.stringify(vehicle) }),
  createBooking: (booking: Booking) => request<Booking>('/api/bookings', { method: 'POST', body: JSON.stringify(booking) }),
  listBookings: (passengerEmail?: string) =>
    request<Booking[]>(passengerEmail ? `/api/bookings?passengerEmail=${encodeURIComponent(passengerEmail)}` : '/api/bookings'),
  requestOtp: (contact: string, role: UserRole) =>
    request<OtpRequestResponse>('/api/auth/request-otp', { method: 'POST', body: JSON.stringify({ contact, role }) }),
  verifyOtp: (contact: string, role: UserRole, code: string) =>
    request<OtpVerifyResponse>('/api/auth/verify-otp', { method: 'POST', body: JSON.stringify({ contact, role, code }) })
};
