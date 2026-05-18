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
