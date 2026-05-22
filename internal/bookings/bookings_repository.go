package bookings

import (
	"context"
	"encoding/json"

	"smarttransit-backend/database"

	"github.com/google/uuid"
)

func CreateBooking(
	booking CreateBookingRequest,
) error {

	query := `
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
		query,
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
