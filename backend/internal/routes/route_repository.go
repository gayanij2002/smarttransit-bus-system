package routes

import (
	"context"
	"smarttransit-backend/database"

	"github.com/google/uuid"
)

func CreateRoute(route CreateRouteRequest) error {

	query := `
	INSERT INTO routes (
		id,
		start_location,
		end_location,
		distance
	)
	VALUES ($1, $2, $3, $4)
	`

	_, err := database.DB.Exec(
		context.Background(),
		query,
		uuid.New().String(),
		route.StartLocation,
		route.EndLocation,
		route.Distance,
	)

	return err
}

func GetAllRoutes() ([]Route, error) {

	query := `
	SELECT id, start_location, end_location, distance, created_at
	FROM routes
	ORDER BY created_at DESC
	`

	rows, err := database.DB.Query(context.Background(), query)

	if err != nil {
		return nil, err
	}

	defer rows.Close()

	var routes []Route

	for rows.Next() {

		var route Route

		err := rows.Scan(
			&route.ID,
			&route.StartLocation,
			&route.EndLocation,
			&route.Distance,
			&route.CreatedAt,
		)

		if err != nil {
			return nil, err
		}

		routes = append(routes, route)
	}

	return routes, nil
}

func GetRouteByID(id string) (Route, error) {

	var route Route

	query := `
	SELECT id, start_location, end_location, distance, created_at
	FROM routes
	WHERE id=$1
	`

	err := database.DB.QueryRow(
		context.Background(),
		query,
		id,
	).Scan(
		&route.ID,
		&route.StartLocation,
		&route.EndLocation,
		&route.Distance,
		&route.CreatedAt,
	)

	return route, err
}

func UpdateRoute(
	id string,
	route Route,
) error {

	query := `
	UPDATE routes
	SET
		start_location=$1,
		end_location=$2,
		distance=$3
	WHERE id=$4
	`

	_, err := database.DB.Exec(
		context.Background(),
		query,
		route.StartLocation,
		route.EndLocation,
		route.Distance,
		id,
	)

	return err
}
