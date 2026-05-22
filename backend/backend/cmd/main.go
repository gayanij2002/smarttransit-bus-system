// @title SmartTransit Bus API
// @version 1.0
// @description SmartTransit Backend APIs
// @host localhost:8080
// @BasePath /

// @securityDefinitions.apikey BearerAuth
// @in header
// @name Authorization

package main

import (
	"os"

	"smarttransit-backend/config"
	"smarttransit-backend/database"
	"smarttransit-backend/internal/auth"
	"smarttransit-backend/internal/bookings"
	"smarttransit-backend/internal/buses"
	"smarttransit-backend/internal/routes"
	"smarttransit-backend/internal/schedules"

	_ "smarttransit-backend/docs"

	swaggerFiles "github.com/swaggo/files"
	ginSwagger "github.com/swaggo/gin-swagger"

	"github.com/gin-contrib/cors"
	"github.com/gin-gonic/gin"
)

func main() {

	// Load environment variables
	config.LoadEnv()

	// Connect database
	database.ConnectDB()

	// Create Gin router
	router := gin.Default()

	// Enable CORS
	router.Use(cors.Default())

	// Swagger
	router.GET(
		"/swagger/*any",
		ginSwagger.WrapHandler(swaggerFiles.Handler),
	)

	// Routes
	auth.AuthRoutes(router)

	buses.BusRoutes(router)

	routes.RouteRoutes(router)

	schedules.ScheduleRoutes(router)

	bookings.BookingRoutes(
		router.Group("/api"),
	)

	// Test route
	router.GET("/", func(c *gin.Context) {
		c.JSON(200, gin.H{
			"message": "SmartTransit Backend Running",
		})
	})

	// Choreo/Docker PORT support
	port := os.Getenv("PORT")

	if port == "" {
		port = "8080"
	}

	router.Run(":" + port)
}
