package buses

import (
	"smarttransit-backend/internal/middleware"

	"github.com/gin-gonic/gin"
)

func BusRoutes(router *gin.Engine) {

	bus := router.Group("/api/buses")
	{
		bus.GET("/", GetBusesHandler)

		bus.GET("/:id", GetBusByIDHandler)

		bus.POST(
			"/",
			middleware.JWTAuthMiddleware(),
			CreateBusHandler,
		)

		bus.PUT(
			"/:id",
			middleware.JWTAuthMiddleware(),
			UpdateBusHandler,
		)

		bus.DELETE(
			"/:id",
			middleware.JWTAuthMiddleware(),
			DeleteBusHandler,
		)
	}
}
