package buses

import "time"

type Bus struct {
	ID         string    `json:"id"`
	BusName    string    `json:"bus_name"`
	BusNumber  string    `json:"bus_number"`
	RouteID    string    `json:"route_id"`
	TotalSeats int       `json:"total_seats"`
	CreatedAt  time.Time `json:"created_at"`
}

type CreateBusRequest struct {
	BusName    string `json:"bus_name"`
	BusNumber  string `json:"bus_number"`
	RouteID    string `json:"route_id"`
	TotalSeats int    `json:"total_seats"`
}
