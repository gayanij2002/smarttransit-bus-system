package bookings

import (
	"context"
	"encoding/json"
	"errors"

	"smarttransit-backend/database"

	"github.com/google/uuid"
)

func CreateBooking(
	booking CreateBookingRequest,
) error {

	// ================= GET EXISTING BOOKED SEATS =================

	query := `
SELECT seats
FROM bookings
WHERE bus_id=$1
`

	rows, err := database.DB.Query(
		context.Background(),
		query,
		booking.BusID,
	)

	if err != nil {
		return err
	}

	defer rows.Close()

	bookedSeatsMap := make(map[int]bool)

	for rows.Next() {

		var seatsData []byte

		err := rows.Scan(&seatsData)

		if err != nil {
			return err
		}

		var seats []int

		err = json.Unmarshal(
			seatsData,
			&seats,
		)

		if err != nil {
			return err
		}

		for _, seat := range seats {
			bookedSeatsMap[seat] = true
		}
	}

	// ================= CHECK DUPLICATES =================

	for _, seat := range booking.Seats {

		if bookedSeatsMap[seat] {

			return errors.New(
				"one or more seats already booked",
			)
		}
	}

	// ================= SAVE BOOKING =================

	insertQuery := `
INSERT INTO bookings (
	id,
	bus_id,
	seats
)
VALUES ($1, $2, $3)
`

	seatsJSON, err := json.Marshal(
		booking.Seats,
	)

	if err != nil {
		return err
	}

	_, err = database.DB.Exec(
		context.Background(),
		insertQuery,
		uuid.New().String(),
		booking.BusID,
		seatsJSON,
	)

	return err
}

func GetAllBookings() (
	[]Booking,
	error,
) {

	query := `
SELECT
	id,
	bus_id,
	seats,
	created_at
FROM bookings
ORDER BY created_at DESC
`

	rows, err := database.DB.Query(
		context.Background(),
		query,
	)

	if err != nil {
		return nil, err
	}

	defer rows.Close()

	var bookings []Booking

	for rows.Next() {

		var booking Booking

		var seatsData []byte

		err := rows.Scan(
			&booking.ID,
			&booking.BusID,
			&seatsData,
			&booking.CreatedAt,
		)

		if err != nil {
			return nil, err
		}

		err = json.Unmarshal(
			seatsData,
			&booking.Seats,
		)

		if err != nil {
			return nil, err
		}

		bookings = append(
			bookings,
			booking,
		)
	}

	return bookings, nil
}

func GetBookedSeatsByBusID(
	busID string,
) ([]int, error) {

	query := `
SELECT seats
FROM bookings
WHERE bus_id=$1
`

	rows, err := database.DB.Query(
		context.Background(),
		query,
		busID,
	)

	if err != nil {
		return nil, err
	}

	defer rows.Close()

	bookedSeatsMap := make(map[int]bool)

	for rows.Next() {

		var seatsData []byte

		err := rows.Scan(&seatsData)

		if err != nil {
			return nil, err
		}

		var seats []int

		err = json.Unmarshal(
			seatsData,
			&seats,
		)

		if err != nil {
			return nil, err
		}

		for _, seat := range seats {
			bookedSeatsMap[seat] = true
		}
	}

	var bookedSeats []int

	for seat := range bookedSeatsMap {
		bookedSeats = append(
			bookedSeats,
			seat,
		)
	}

	return bookedSeats, nil
}
