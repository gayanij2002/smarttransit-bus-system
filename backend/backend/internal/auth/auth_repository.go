package auth

import (
	"context"
	"smarttransit-backend/database"

	"github.com/google/uuid"
)

func CreateUser(user RegisterRequest, hashedPassword string) error {

	query := `
	INSERT INTO users (id, name, email, password)
	VALUES ($1, $2, $3, $4)
	`

	_, err := database.DB.Exec(
		context.Background(),
		query,
		uuid.New().String(),
		user.Name,
		user.Email,
		hashedPassword,
	)

	return err
}

func GetUserByEmail(email string) (*User, error) {

	query := `
	SELECT id, name, email, password, created_at
	FROM users
	WHERE LOWER(email)=LOWER($1)
	`

	row := database.DB.QueryRow(context.Background(), query, email)

	var user User

	err := row.Scan(
		&user.ID,
		&user.Name,
		&user.Email,
		&user.Password,
		&user.CreatedAt,
	)

	if err != nil {
		return nil, err
	}

	return &user, nil
}
