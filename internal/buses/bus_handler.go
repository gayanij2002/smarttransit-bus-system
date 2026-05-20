package buses

import (
	"net/http"

	"github.com/gin-gonic/gin"
)

// CreateBus godoc
// @Summary Create bus
// @Description Create new bus
// @Tags Buses
// @Security BearerAuth
// @Accept json
// @Produce json
// @Param bus body CreateBusRequest true "Create Bus"
// @Success 200 {object} map[string]interface{}
// @Router /api/buses/ [post]
func CreateBusHandler(c *gin.Context) {

	var request CreateBusRequest

	if err := c.ShouldBindJSON(&request); err != nil {

		c.JSON(http.StatusBadRequest, gin.H{
			"error": err.Error(),
		})

		return
	}

	err := CreateBusService(request)

	if err != nil {

		c.JSON(http.StatusInternalServerError, gin.H{
			"error": err.Error(),
		})

		return
	}

	c.JSON(http.StatusOK, gin.H{
		"message": "Bus created successfully",
	})
}

// GetBuses godoc
// @Summary Get all buses
// @Description Retrieve all buses
// @Tags Buses
// @Produce json
// @Success 200 {array} Bus
// @Router /api/buses/ [get]
func GetBusesHandler(c *gin.Context) {

	buses, err := GetBusesService()

	if err != nil {

		c.JSON(http.StatusInternalServerError, gin.H{
			"error": err.Error(),
		})

		return
	}

	c.JSON(http.StatusOK, buses)
}

// GetBusByID godoc
// @Summary Get bus by ID
// @Description Retrieve single bus
// @Tags Buses
// @Produce json
// @Param id path string true "Bus ID"
// @Success 200 {object} Bus
// @Router /api/buses/{id} [get]
func GetBusByIDHandler(c *gin.Context) {

	id := c.Param("id")

	bus, err := GetBusByIDService(id)

	if err != nil {

		c.JSON(http.StatusNotFound, gin.H{
			"error": "Bus not found",
		})

		return
	}

	c.JSON(http.StatusOK, bus)
}

// UpdateBus godoc
// @Summary Update bus
// @Description Update existing bus
// @Tags Buses
// @Security BearerAuth
// @Accept json
// @Produce json
// @Param id path string true "Bus ID"
// @Param bus body Bus true "Update Bus"
// @Success 200 {object} map[string]interface{}
// @Router /api/buses/{id} [put]
func UpdateBusHandler(c *gin.Context) {

	id := c.Param("id")

	var request CreateBusRequest

	if err := c.ShouldBindJSON(&request); err != nil {

		c.JSON(http.StatusBadRequest, gin.H{
			"error": err.Error(),
		})

		return
	}

	err := UpdateBusService(id, request)

	if err != nil {

		c.JSON(http.StatusInternalServerError, gin.H{
			"error": err.Error(),
		})

		return
	}

	c.JSON(http.StatusOK, gin.H{
		"message": "Bus updated successfully",
	})
}

// DeleteBus godoc
// @Summary Delete bus
// @Description Delete bus
// @Tags Buses
// @Security BearerAuth
// @Produce json
// @Param id path string true "Bus ID"
// @Success 200 {object} map[string]interface{}
// @Router /api/buses/{id} [delete]
func DeleteBusHandler(c *gin.Context) {

	id := c.Param("id")

	err := DeleteBusService(id)

	if err != nil {

		c.JSON(http.StatusInternalServerError, gin.H{
			"error": err.Error(),
		})

		return
	}

	c.JSON(http.StatusOK, gin.H{
		"message": "Bus deleted successfully",
	})
}
