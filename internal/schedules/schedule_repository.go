package schedules

import (
	"context"
	"smarttransit-backend/database"

	"github.com/google/uuid"
)

func CreateSchedule(schedule CreateScheduleRequest) error {

	query := `
	INSERT INTO schedules (
		id,
		bus_id,
		departure_time,
		arrival_time
	)
	VALUES ($1, $2, $3, $4)
	`

	_, err := database.DB.Exec(
		context.Background(),
		query,
		uuid.New().String(),
		schedule.BusID,
		schedule.DepartureTime,
		schedule.ArrivalTime,
	)

	return err
}

func GetAllSchedules() ([]Schedule, error) {

	query := `
	SELECT id, bus_id, departure_time, arrival_time, created_at
	FROM schedules
	ORDER BY created_at DESC
	`

	rows, err := database.DB.Query(context.Background(), query)

	if err != nil {
		return nil, err
	}

	defer rows.Close()

	var schedules []Schedule

	for rows.Next() {

		var schedule Schedule

		err := rows.Scan(
			&schedule.ID,
			&schedule.BusID,
			&schedule.DepartureTime,
			&schedule.ArrivalTime,
			&schedule.CreatedAt,
		)

		if err != nil {
			return nil, err
		}

		schedules = append(schedules, schedule)
	}

	return schedules, nil
}

func GetScheduleByID(id string) (Schedule, error) {

	var schedule Schedule

	query := `
	SELECT
		id,
		bus_id,
		departure_time,
		arrival_time,
		created_at
	FROM schedules
	WHERE id=$1
	`

	err := database.DB.QueryRow(
		context.Background(),
		query,
		id,
	).Scan(
		&schedule.ID,
		&schedule.BusID,
		&schedule.DepartureTime,
		&schedule.ArrivalTime,
		&schedule.CreatedAt,
	)

	return schedule, err
}

func UpdateSchedule(
	id string,
	schedule Schedule,
) error {

	query := `
	UPDATE schedules
	SET
		bus_id=$1,
		departure_time=$2,
		arrival_time=$3
	WHERE id=$4
	`

	_, err := database.DB.Exec(
		context.Background(),
		query,
		schedule.BusID,
		schedule.DepartureTime,
		schedule.ArrivalTime,
		id,
	)

	return err
}

func DeleteSchedule(id string) error {

	query := `
	DELETE FROM schedules
	WHERE id=$1
	`

	_, err := database.DB.Exec(
		context.Background(),
		query,
		id,
	)

	return err
}
