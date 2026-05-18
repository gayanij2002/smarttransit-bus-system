package main

import (
	"smarttransit-backend/config"
	"smarttransit-backend/database"
	"smarttransit-backend/internal/auth"
	"smarttransit-backend/internal/buses"
	"smarttransit-backend/internal/routes"
	"smarttransit-backend/internal/schedules"

	"github.com/gin-contrib/cors"
	"github.com/gin-gonic/gin"
)

func main() {

	config.LoadEnv()

	database.ConnectDB()

	router := gin.Default()

	router.Use(cors.Default())

	auth.AuthRoutes(router)

	buses.BusRoutes(router)

	routes.RouteRoutes(router)

	schedules.ScheduleRoutes(router)

	router.GET("/", func(c *gin.Context) {
		c.JSON(200, gin.H{
			"message": "SmartTransit Backend Running",
		})
	})

	router.Run(":8080")
}
