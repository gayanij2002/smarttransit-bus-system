package routes

import (
	"net/http"

	"github.com/gin-gonic/gin"
)

// CreateRoute godoc
// @Summary Create route
// @Description Create new route
// @Tags Routes
// @Security BearerAuth
// @Accept json
// @Produce json
// @Param route body CreateRouteRequest true "Create Route"
// @Success 200 {object} map[string]interface{}
// @Router /api/routes/ [post]
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

// GetRoutes godoc
// @Summary Get all routes
// @Description Retrieve all routes
// @Tags Routes
// @Produce json
// @Success 200 {array} Route
// @Router /api/routes/ [get]
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

// GetRouteByID godoc
// @Summary Get route by ID
// @Description Retrieve single route
// @Tags Routes
// @Produce json
// @Param id path string true "Route ID"
// @Success 200 {object} Route
// @Router /api/routes/{id} [get]
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

// UpdateRoute godoc
// @Summary Update route
// @Description Update existing route
// @Tags Routes
// @Security BearerAuth
// @Accept json
// @Produce json
// @Param id path string true "Route ID"
// @Param route body Route true "Update Route"
// @Success 200 {object} map[string]interface{}
// @Router /api/routes/{id} [put]
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

// DeleteRoute godoc
// @Summary Delete route
// @Description Delete route
// @Tags Routes
// @Security BearerAuth
// @Produce json
// @Param id path string true "Route ID"
// @Success 200 {object} map[string]interface{}
// @Router /api/routes/{id} [delete]
func DeleteRouteHandler(c *gin.Context) {

	id := c.Param("id")

	err := DeleteRoute(id)

	if err != nil {
		c.JSON(500, gin.H{
			"error": "Failed to delete route",
		})
		return
	}

	c.JSON(200, gin.H{
		"message": "Route deleted successfully",
	})
}
