package config

import (
	"log"
	"os"

	"github.com/joho/godotenv"
)

func LoadEnv() {

	// Skip .env loading in Choreo
	if os.Getenv("CHOREO") != "" {
		log.Println("Running on Choreo")
		return
	}

	err := godotenv.Load()

	if err != nil {
		log.Println("No .env file found")
	}
}
