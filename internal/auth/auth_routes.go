package auth

import (
	"smarttransit-backend/internal/middleware"

	"github.com/gin-gonic/gin"
)

func AuthRoutes(router *gin.Engine) {

	auth := router.Group("/api/auth")
	{
		auth.POST("/register", Register)
		auth.POST("/login", Login)

		auth.GET(
			"/profile",
			middleware.JWTAuthMiddleware(),
			Profile,
		)
	}
}
