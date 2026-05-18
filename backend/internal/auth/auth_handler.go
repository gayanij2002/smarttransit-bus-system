package auth

import (
	"net/http"

	"github.com/gin-gonic/gin"
)

// Register godoc
// @Summary Register user
// @Description Create new user account
// @Tags Auth
// @Accept json
// @Produce json
// @Param user body RegisterRequest true "User Register"
// @Success 200 {object} map[string]interface{}
// @Router /api/auth/register [post]
func Register(c *gin.Context) {

	var request RegisterRequest

	if err := c.ShouldBindJSON(&request); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{
			"error": err.Error(),
		})
		return
	}

	err := RegisterUser(request)

	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{
			"error": err.Error(),
		})
		return
	}

	c.JSON(http.StatusOK, gin.H{
		"message": "User registered successfully",
	})
}

// Login godoc
// @Summary Login user
// @Description Login and receive JWT token
// @Tags Auth
// @Accept json
// @Produce json
// @Param user body LoginRequest true "User Login"
// @Success 200 {object} map[string]interface{}
// @Router /api/auth/login [post]
func Login(c *gin.Context) {

	var request LoginRequest

	if err := c.ShouldBindJSON(&request); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{
			"error": err.Error(),
		})
		return
	}

	token, err := LoginUser(request)

	if err != nil {
		c.JSON(http.StatusUnauthorized, gin.H{
			"error": err.Error(),
		})
		return
	}

	c.JSON(http.StatusOK, gin.H{
		"token": token,
	})
}

// Profile godoc
// @Summary User profile
// @Description Protected profile route
// @Tags Auth
// @Security BearerAuth
// @Produce json
// @Success 200 {object} map[string]interface{}
// @Router /api/auth/profile [get]
func Profile(c *gin.Context) {

	userID, _ := c.Get("user_id")

	c.JSON(http.StatusOK, gin.H{
		"message": "Protected profile route",
		"user_id": userID,
	})
}
