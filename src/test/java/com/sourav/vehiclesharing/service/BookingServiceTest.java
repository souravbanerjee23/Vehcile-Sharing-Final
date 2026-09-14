package com.sourav.vehiclesharing.service;

import com.sourav.vehiclesharing.model.Booking;
import com.sourav.vehiclesharing.model.Ride;
import com.sourav.vehiclesharing.repository.BookingRepository;
import com.sourav.vehiclesharing.repository.RideRepository;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import java.time.LocalDate;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

class BookingServiceTest {

    private RideRepository rideRepository;
    private BookingRepository bookingRepository;
    private BookingService bookingService;

    @BeforeEach
    void setUp() {
        rideRepository = mock(RideRepository.class);
        bookingRepository = mock(BookingRepository.class);
        bookingService = new BookingService(rideRepository, bookingRepository);
    }

    @Test
    void booksValidRouteAndDecrementsAvailableSeats() {
        LocalDate travelDate = LocalDate.now().plusDays(2);
        Ride ride = ride(travelDate, 4);
        Booking booking = booking(travelDate, "Kolkata", "Durgapur", 2);

        when(rideRepository.findById(1L)).thenReturn(Optional.of(ride));
        when(bookingRepository.save(any(Booking.class))).thenAnswer(invocation -> invocation.getArgument(0));

        Booking result = bookingService.book(booking);

        assertSame(booking, result);
        assertEquals(2, ride.getSeats());
        verify(rideRepository).save(ride);
        verify(bookingRepository).save(booking);
    }

    @Test
    void rejectsDestinationBeforeStartingPoint() {
        LocalDate travelDate = LocalDate.now().plusDays(2);
        Ride ride = ride(travelDate, 4);
        Booking booking = booking(travelDate, "Durgapur", "Kolkata", 1);

        when(rideRepository.findById(1L)).thenReturn(Optional.of(ride));

        IllegalArgumentException error = assertThrows(IllegalArgumentException.class,
                () -> bookingService.book(booking));

        assertTrue(error.getMessage().contains("Destination"));
        verify(bookingRepository, never()).save(any());
    }

    @Test
    void rejectsBookingWhenRequestedSeatsExceedAvailability() {
        LocalDate travelDate = LocalDate.now().plusDays(2);
        Ride ride = ride(travelDate, 1);
        Booking booking = booking(travelDate, "Kolkata", "Durgapur", 2);

        when(rideRepository.findById(1L)).thenReturn(Optional.of(ride));

        assertThrows(IllegalArgumentException.class, () -> bookingService.book(booking));
        verify(bookingRepository, never()).save(any());
    }

    private Ride ride(LocalDate date, int seats) {
        Ride ride = new Ride();
        ride.setStartPoint("Kolkata");
        ride.setStop1("Burdwan");
        ride.setFinalStop("Durgapur");
        ride.setDate(date);
        ride.setSeats(seats);
        return ride;
    }

    private Booking booking(LocalDate date, String start, String destination, int seats) {
        Booking booking = new Booking();
        booking.setRideId(1L);
        booking.setPassengerEmail("passenger@example.com");
        booking.setStartLocation(start);
        booking.setDestination(destination);
        booking.setSeats(seats);
        booking.setDate(date);
        return booking;
    }
}
