package bookings

import "time"

type Booking struct {
	ID string `json:"id"`

	BusID string `json:"bus_id"`

	Seats []int `json:"seats"`

	CreatedAt time.Time `json:"created_at"`
}

type CreateBookingRequest struct {
	BusID string `json:"bus_id"`

	Seats []int `json:"seats"`
}
