package database

import (
	"context"
	"log"
	"os"

	"github.com/jackc/pgx/v5/pgxpool"
)

var DB *pgxpool.Pool

func ConnectDB() {

	dbURL := os.Getenv("DATABASE_URL")

	pool, err := pgxpool.New(context.Background(), dbURL)

	if err != nil {
		log.Fatal("Database connection failed")
	}

	DB = pool

	log.Println("Database connected successfully")
}
