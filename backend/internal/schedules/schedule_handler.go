package schedules

import (
	"net/http"

	"github.com/gin-gonic/gin"
)

func CreateScheduleHandler(c *gin.Context) {

	var request CreateScheduleRequest

	if err := c.ShouldBindJSON(&request); err != nil {

		c.JSON(http.StatusBadRequest, gin.H{
			"error": err.Error(),
		})

		return
	}

	err := CreateScheduleService(request)

	if err != nil {

		c.JSON(http.StatusInternalServerError, gin.H{
			"error": err.Error(),
		})

		return
	}

	c.JSON(http.StatusOK, gin.H{
		"message": "Schedule created successfully",
	})
}

func GetSchedulesHandler(c *gin.Context) {

	schedules, err := GetSchedulesService()

	if err != nil {

		c.JSON(http.StatusInternalServerError, gin.H{
			"error": err.Error(),
		})

		return
	}

	c.JSON(http.StatusOK, schedules)
}
