package routes

import (
	"smarttransit-backend/internal/middleware"

	"github.com/gin-gonic/gin"
)

func RouteRoutes(router *gin.Engine) {

	route := router.Group("/api/routes")
	{
		route.GET("/", GetRoutesHandler)

		route.GET("/:id", GetRouteByIDHandler)

		route.POST(
			"/",
			middleware.JWTAuthMiddleware(),
			CreateRouteHandler,
		)

		route.PUT(
			"/:id",
			middleware.JWTAuthMiddleware(),
			UpdateRouteHandler,
		)

		route.DELETE(
			"/:id",
			middleware.JWTAuthMiddleware(),
			DeleteRouteHandler,
		)
	}
}
