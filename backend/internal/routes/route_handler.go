package routes

import (
	"net/http"

	"github.com/gin-gonic/gin"
)

func CreateRouteHandler(c *gin.Context) {

	var request CreateRouteRequest

	if err := c.ShouldBindJSON(&request); err != nil {

		c.JSON(http.StatusBadRequest, gin.H{
			"error": err.Error(),
		})

		return
	}

	err := CreateRouteService(request)

	if err != nil {

		c.JSON(http.StatusInternalServerError, gin.H{
			"error": err.Error(),
		})

		return
	}

	c.JSON(http.StatusOK, gin.H{
		"message": "Route created successfully",
	})
}

func GetRoutesHandler(c *gin.Context) {

	routes, err := GetRoutesService()

	if err != nil {

		c.JSON(http.StatusInternalServerError, gin.H{
			"error": err.Error(),
		})

		return
	}

	c.JSON(http.StatusOK, routes)
}
