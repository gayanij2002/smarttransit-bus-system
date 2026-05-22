package database

import (
	"context"
	"log"
	"os"
	"time"

	"github.com/jackc/pgx/v5/pgxpool"
)

var DB *pgxpool.Pool

func ConnectDB() {

	dbURL := os.Getenv("DATABASE_URL")

	if dbURL == "" {
		log.Fatal("DATABASE_URL is empty")
	}

	ctx, cancel := context.WithTimeout(
		context.Background(),
		10*time.Second,
	)
	defer cancel()

	pool, err := pgxpool.New(ctx, dbURL)

	if err != nil {
		log.Fatal("Database pool creation failed: ", err)
	}

	err = pool.Ping(ctx)

	if err != nil {
		log.Fatal("Database ping failed: ", err)
	}

	DB = pool

	log.Println("Database connected successfully")
}
