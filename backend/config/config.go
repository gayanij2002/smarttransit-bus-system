package config

import (
	"log"
	"os"

	"github.com/joho/godotenv"
)

func LoadEnv() {
	// Only try loading .env locally
	if os.Getenv("CHOREO") == "" {
		err := godotenv.Load()

		if err != nil {
			log.Println("No .env file found")
		}
	}
}
