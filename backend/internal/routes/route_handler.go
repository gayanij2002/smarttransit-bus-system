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

func GetRouteByIDHandler(c *gin.Context) {

	id := c.Param("id")

	route, err := GetRouteByID(id)

	if err != nil {
		c.JSON(404, gin.H{
			"error": "Route not found",
		})
		return
	}

	c.JSON(200, route)
}

func UpdateRouteHandler(c *gin.Context) {

	id := c.Param("id")

	var route Route

	if err := c.ShouldBindJSON(&route); err != nil {
		c.JSON(400, gin.H{
			"error": err.Error(),
		})
		return
	}

	err := UpdateRoute(id, route)

	if err != nil {
		c.JSON(500, gin.H{
			"error": "Failed to update route",
		})
		return
	}

	c.JSON(200, gin.H{
		"message": "Route updated successfully",
	})
}
