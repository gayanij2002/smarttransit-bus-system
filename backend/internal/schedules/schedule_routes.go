package schedules

import (
	"smarttransit-backend/internal/middleware"

	"github.com/gin-gonic/gin"
)

func ScheduleRoutes(router *gin.Engine) {

	schedule := router.Group("/api/schedules")
	{
		schedule.GET("/", GetSchedulesHandler)

		schedule.POST(
			"/",
			middleware.JWTAuthMiddleware(),
			CreateScheduleHandler,
		)
	}
}
