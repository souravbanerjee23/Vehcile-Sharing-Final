'use client';

import { FormEvent, useEffect, useMemo, useState } from 'react';
import RoleLogin from '@/components/RoleLogin';
import { api, Booking, Ride, UserRole } from '@/lib/api';

const emptyRide: Ride = {
  ownerEmail: '',
  vehicleNo: '',
  seats: 1,
  startPoint: '',
  finalStop: '',
  cost: 0,
  discount: 0,
  date: ''
};

const emptyBooking: Booking = {
  rideId: 0,
  passengerEmail: '',
  startLocation: '',
  destination: '',
  seats: 1,
  date: ''
};

export default function HomePage() {
  const [rides, setRides] = useState<Ride[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState('');
  const [message, setMessage] = useState('');
  const [search, setSearch] = useState({ from: '', to: '', date: '' });
  const [rideForm, setRideForm] = useState<Ride>(emptyRide);
  const [bookingForm, setBookingForm] = useState<Booking>(emptyBooking);
  const [bookingEmail, setBookingEmail] = useState('');
  const [bookings, setBookings] = useState<Booking[]>([]);
  const [session, setSession] = useState<{ contact: string; role: UserRole } | null>(null);

  async function loadRides() {
    try {
      setLoading(true);
      setError('');
      setRides(await api.listRides());
    } catch (e) {
      setError(e instanceof Error ? e.message : 'Unable to load rides.');
    } finally {
      setLoading(false);
    }
  }

  useEffect(() => {
    loadRides();
  }, []);

  const availableSeats = useMemo(
    () => rides.reduce((total, ride) => total + ride.seats, 0),
    [rides]
  );

  async function handleSearch(event: FormEvent) {
    event.preventDefault();
    try {
      setError('');
      setMessage('');
      const result = await api.searchRides(search.from, search.to, search.date);
      setRides(result);
      setMessage(`${result.length} ride${result.length === 1 ? '' : 's'} found.`);
    } catch (e) {
      setError(e instanceof Error ? e.message : 'Search failed.');
    }
  }

  async function handlePublish(event: FormEvent) {
    event.preventDefault();
    if (session?.role !== 'DRIVER') {
      setError('Please sign in as a ride owner before publishing a ride.');
      return;
    }
    try {
      setError('');
      await api.createRide({ ...rideForm, ownerEmail: rideForm.ownerEmail || session.contact, seats: Number(rideForm.seats), cost: Number(rideForm.cost), discount: Number(rideForm.discount ?? 0) });
      setRideForm(emptyRide);
      setMessage('Ride published successfully.');
      await loadRides();
    } catch (e) {
      setError(e instanceof Error ? e.message : 'Unable to publish ride.');
    }
  }

  async function handleBook(event: FormEvent) {
    event.preventDefault();
    if (session?.role !== 'PASSENGER') {
      setError('Please sign in as a passenger before booking a ride.');
      return;
    }
    try {
      setError('');
      await api.createBooking({ ...bookingForm, passengerEmail: bookingForm.passengerEmail || session.contact, rideId: Number(bookingForm.rideId), seats: Number(bookingForm.seats) });
      setBookingForm(emptyBooking);
      setMessage('Booking confirmed.');
      await loadRides();
    } catch (e) {
      setError(e instanceof Error ? e.message : 'Unable to create booking.');
    }
  }

  async function handleBookingLookup(event: FormEvent) {
    event.preventDefault();
    try {
      setError('');
      setBookings(await api.listBookings(bookingEmail || session?.contact));
    } catch (e) {
      setError(e instanceof Error ? e.message : 'Unable to load bookings.');
    }
  }

  function handleAuthenticated(contact: string, role: UserRole) {
    setSession({ contact, role });
    setError('');
    setMessage(`${role === 'DRIVER' ? 'Ride owner' : 'Passenger'} login successful.`);
    if (role === 'DRIVER') {
      setRideForm(current => ({ ...current, ownerEmail: contact }));
    } else {
      setBookingForm(current => ({ ...current, passengerEmail: contact }));
      setBookingEmail(contact);
    }
  }

  return (
    <main>
      <section className="hero shell">
        <div>
          <span className="eyebrow">Vehicle Sharing Platform</span>
          <h1>Share rides. Fill seats. Travel smarter.</h1>
          <p className="hero-copy">
            Find people travelling your route, reserve an available seat, or offer your own ride and split travel costs. Search, book and manage trips from one simple platform.
          </p>
          <div className="hero-actions">
            <a className="button primary" href="#search">Find a ride</a>
            <a className="button secondary" href="#login">Sign in</a>
          </div>
        </div>
        <div className="stats-card">
          <div><strong>{rides.length}</strong><span>rides available</span></div>
          <div><strong>{availableSeats}</strong><span>open seats</span></div>
          <div><strong>OTP</strong><span>secure role-based sign in</span></div>
        </div>
      </section>

      {(error || message) && (
        <div className={`shell notice ${error ? 'error' : 'success'}`}>{error || message}</div>
      )}

      <section id="login" className="shell panel auth-panel">
        <div className="section-heading auth-heading">
          <div>
            <span className="eyebrow">Secure access</span>
            <h2>Choose how you want to travel</h2>
          </div>
          {session ? (
            <div className="session-pill">
              Signed in as {session.role === 'DRIVER' ? 'Ride owner' : 'Passenger'} · {session.contact}
              <button className="text-button" type="button" onClick={() => setSession(null)}>Sign out</button>
            </div>
          ) : null}
        </div>
        <div className="login-grid">
          <RoleLogin
            role="PASSENGER"
            title="Passenger login"
            description="Verify your email or phone with an OTP to book seats and view your trips."
            onAuthenticated={handleAuthenticated}
          />
          <RoleLogin
            role="DRIVER"
            title="Ride owner login"
            description="Verify your email or phone with an OTP to publish rides and manage available seats."
            onAuthenticated={handleAuthenticated}
          />
        </div>
      </section>

      <section id="search" className="shell panel">
        <div className="section-heading">
          <div><span className="eyebrow">Discover</span><h2>Search rides</h2></div>
          <button className="text-button" onClick={loadRides}>Show all</button>
        </div>
        <form className="grid-form search-form" onSubmit={handleSearch}>
          <label>From<input required value={search.from} onChange={e => setSearch({ ...search, from: e.target.value })} placeholder="Kolkata" /></label>
          <label>To<input required value={search.to} onChange={e => setSearch({ ...search, to: e.target.value })} placeholder="Digha" /></label>
          <label>Date<input required type="date" value={search.date} onChange={e => setSearch({ ...search, date: e.target.value })} /></label>
          <button className="button primary" type="submit">Search</button>
        </form>

        <div className="ride-grid">
          {loading ? <p>Loading rides…</p> : rides.map(ride => (
            <article className="ride-card" key={ride.id ?? `${ride.vehicleNo}-${ride.date}`}>
              <div className="ride-card-top"><span>{ride.vehicleNo}</span><strong>₹{ride.cost}</strong></div>
              <h3>{ride.startPoint} <span>→</span> {ride.finalStop}</h3>
              <p>{ride.date} · {ride.seats} seat{ride.seats === 1 ? '' : 's'} available</p>
              {ride.discount ? <span className="chip">₹{ride.discount} discount</span> : null}
              <button className="button secondary full" onClick={() => setBookingForm({
                ...bookingForm,
                passengerEmail: session?.role === 'PASSENGER' ? session.contact : bookingForm.passengerEmail,
                rideId: ride.id ?? 0,
                startLocation: ride.startPoint,
                destination: ride.finalStop,
                date: ride.date
              })}>Book this ride</button>
            </article>
          ))}
        </div>
      </section>

      <section className="shell two-column">
        <div id="publish" className="panel">
          <span className="eyebrow">For ride owners</span><h2>Publish a ride</h2>
          {session?.role !== 'DRIVER' ? <p className="access-note">Sign in as a ride owner above to publish a journey.</p> : null}
          <form className="grid-form" onSubmit={handlePublish}>
            <label>Owner email<input required type="email" value={rideForm.ownerEmail} onChange={e => setRideForm({ ...rideForm, ownerEmail: e.target.value })} /></label>
            <label>Vehicle number<input required value={rideForm.vehicleNo} onChange={e => setRideForm({ ...rideForm, vehicleNo: e.target.value })} /></label>
            <label>From<input required value={rideForm.startPoint} onChange={e => setRideForm({ ...rideForm, startPoint: e.target.value })} /></label>
            <label>To<input required value={rideForm.finalStop} onChange={e => setRideForm({ ...rideForm, finalStop: e.target.value })} /></label>
            <label>Date<input required type="date" value={rideForm.date} onChange={e => setRideForm({ ...rideForm, date: e.target.value })} /></label>
            <label>Seats<input required min="1" type="number" value={rideForm.seats} onChange={e => setRideForm({ ...rideForm, seats: Number(e.target.value) })} /></label>
            <label>Fare<input required min="0" type="number" value={rideForm.cost} onChange={e => setRideForm({ ...rideForm, cost: Number(e.target.value) })} /></label>
            <label>Discount<input min="0" type="number" value={rideForm.discount ?? 0} onChange={e => setRideForm({ ...rideForm, discount: Number(e.target.value) })} /></label>
            <button className="button primary span-2" type="submit">Publish ride</button>
          </form>
        </div>

        <div className="panel">
          <span className="eyebrow">For passengers</span><h2>Book seats</h2>
          {session?.role !== 'PASSENGER' ? <p className="access-note">Sign in as a passenger above to confirm a booking.</p> : null}
          <form className="grid-form" onSubmit={handleBook}>
            <label>Ride ID<input required min="1" type="number" value={bookingForm.rideId || ''} onChange={e => setBookingForm({ ...bookingForm, rideId: Number(e.target.value) })} /></label>
            <label>Email<input required type="email" value={bookingForm.passengerEmail} onChange={e => setBookingForm({ ...bookingForm, passengerEmail: e.target.value })} /></label>
            <label>From<input required value={bookingForm.startLocation} onChange={e => setBookingForm({ ...bookingForm, startLocation: e.target.value })} /></label>
            <label>To<input required value={bookingForm.destination} onChange={e => setBookingForm({ ...bookingForm, destination: e.target.value })} /></label>
            <label>Date<input required type="date" value={bookingForm.date} onChange={e => setBookingForm({ ...bookingForm, date: e.target.value })} /></label>
            <label>Seats<input required min="1" type="number" value={bookingForm.seats} onChange={e => setBookingForm({ ...bookingForm, seats: Number(e.target.value) })} /></label>
            <button className="button primary span-2" type="submit">Confirm booking</button>
          </form>
        </div>
      </section>

      <section className="shell panel">
        <span className="eyebrow">My trips</span><h2>Passenger bookings</h2>
        <form className="lookup" onSubmit={handleBookingLookup}>
          <input required type="email" value={bookingEmail} onChange={e => setBookingEmail(e.target.value)} placeholder="passenger@example.com" />
          <button className="button secondary" type="submit">Load bookings</button>
        </form>
        <div className="booking-list">
          {bookings.map(booking => (
            <div key={booking.id ?? `${booking.rideId}-${booking.date}`}>
              <strong>{booking.startLocation} → {booking.destination}</strong>
              <span>Ride #{booking.rideId} · {booking.seats} seats · {booking.date} · {booking.status ?? 'CONFIRMED'}</span>
            </div>
          ))}
        </div>
      </section>
    </main>
  );
}
