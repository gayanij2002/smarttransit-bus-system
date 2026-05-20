package buses

import (
	"context"
	"smarttransit-backend/database"

	"github.com/google/uuid"
)

func CreateBus(bus CreateBusRequest) error {

	query := `
	INSERT INTO buses (
		id,
		bus_name,
		bus_number,
		route_id,
		total_seats
	)
	VALUES ($1, $2, $3, $4, $5)
	`

	_, err := database.DB.Exec(
		context.Background(),
		query,
		uuid.New().String(),
		bus.BusName,
		bus.BusNumber,
		bus.RouteID,
		bus.TotalSeats,
	)

	return err
}

func GetAllBuses() ([]Bus, error) {

	query := `
	SELECT id, bus_name, bus_number, route_id, total_seats, created_at
	FROM buses
	ORDER BY created_at DESC
	`

	rows, err := database.DB.Query(context.Background(), query)

	if err != nil {
		return nil, err
	}

	defer rows.Close()

	var buses []Bus

	for rows.Next() {

		var bus Bus

		err := rows.Scan(
			&bus.ID,
			&bus.BusName,
			&bus.BusNumber,
			&bus.RouteID,
			&bus.TotalSeats,
			&bus.CreatedAt,
		)

		if err != nil {
			return nil, err
		}

		buses = append(buses, bus)
	}

	return buses, nil
}

func GetBusByID(id string) (*Bus, error) {

	query := `
	SELECT id, bus_name, bus_number, route_id, total_seats, created_at
	FROM buses
	WHERE id=$1
	`

	row := database.DB.QueryRow(
		context.Background(),
		query,
		id,
	)

	var bus Bus

	err := row.Scan(
		&bus.ID,
		&bus.BusName,
		&bus.BusNumber,
		&bus.RouteID,
		&bus.TotalSeats,
		&bus.CreatedAt,
	)

	if err != nil {
		return nil, err
	}

	return &bus, nil
}

func UpdateBus(id string, bus CreateBusRequest) error {

	query := `
	UPDATE buses
	SET
		bus_name=$1,
		bus_number=$2,
		route_id=$3,
		total_seats=$4
	WHERE id=$5
	`

	_, err := database.DB.Exec(
		context.Background(),
		query,
		bus.BusName,
		bus.BusNumber,
		bus.RouteID,
		bus.TotalSeats,
		id,
	)

	return err
}

func DeleteBus(id string) error {

	query := `
	DELETE FROM buses
	WHERE id=$1
	`

	_, err := database.DB.Exec(
		context.Background(),
		query,
		id,
	)

	return err
}
