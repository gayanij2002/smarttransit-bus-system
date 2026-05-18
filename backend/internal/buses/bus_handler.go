package buses

import (
	"net/http"

	"github.com/gin-gonic/gin"
)

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
