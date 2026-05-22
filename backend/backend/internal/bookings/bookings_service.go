package bookings

func CreateBookingService(
	request CreateBookingRequest,
) error {

	return CreateBooking(request)

}

func GetBookingsService() (
	[]Booking,
	error,
) {

	return GetAllBookings()

}

func GetBookedSeatsService(
	busID string,
) ([]int, error) {

	return GetBookedSeatsByBusID(
		busID,
	)

}
