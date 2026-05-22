package schedules

import "time"

type Schedule struct {
	ID            string    `json:"id"`
	BusID         string    `json:"bus_id"`
	DepartureTime string    `json:"departure_time"`
	ArrivalTime   string    `json:"arrival_time"`
	CreatedAt     time.Time `json:"created_at"`
}

type CreateScheduleRequest struct {
	BusID         string `json:"bus_id"`
	DepartureTime string `json:"departure_time"`
	ArrivalTime   string `json:"arrival_time"`
}
