package schedules

import (
	"smarttransit-backend/internal/middleware"

	"github.com/gin-gonic/gin"
)

func ScheduleRoutes(router *gin.Engine) {

	schedule := router.Group("/api/schedules")
	{
		schedule.GET("/", GetSchedulesHandler)

		schedule.GET("/:id", GetScheduleByIDHandler)

		schedule.POST(
			"/",
			middleware.JWTAuthMiddleware(),
			CreateScheduleHandler,
		)

		schedule.PUT(
			"/:id",
			middleware.JWTAuthMiddleware(),
			UpdateScheduleHandler,
		)

		schedule.DELETE(
			"/:id",
			middleware.JWTAuthMiddleware(),
			DeleteScheduleHandler,
		)
	}
}
