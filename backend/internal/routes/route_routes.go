package routes

import (
	"smarttransit-backend/internal/middleware"

	"github.com/gin-gonic/gin"
)

func RouteRoutes(router *gin.Engine) {

	route := router.Group("/api/routes")
	{
		route.GET("/", GetRoutesHandler)

		route.POST(
			"/",
			middleware.JWTAuthMiddleware(),
			CreateRouteHandler,
		)
	}
}
