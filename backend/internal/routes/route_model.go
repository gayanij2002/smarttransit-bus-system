package routes

import "time"

type Route struct {
	ID            string    `json:"id"`
	StartLocation string    `json:"start_location"`
	EndLocation   string    `json:"end_location"`
	Distance      string    `json:"distance"`
	CreatedAt     time.Time `json:"created_at"`
}

type CreateRouteRequest struct {
	StartLocation string `json:"start_location"`
	EndLocation   string `json:"end_location"`
	Distance      string `json:"distance"`
}
