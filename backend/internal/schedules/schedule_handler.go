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

func GetScheduleByIDHandler(c *gin.Context) {

	id := c.Param("id")

	schedule, err := GetScheduleByID(id)

	if err != nil {
		c.JSON(404, gin.H{
			"error": "Schedule not found",
		})
		return
	}

	c.JSON(200, schedule)
}

func UpdateScheduleHandler(c *gin.Context) {

	id := c.Param("id")

	var schedule Schedule

	if err := c.ShouldBindJSON(&schedule); err != nil {
		c.JSON(400, gin.H{
			"error": err.Error(),
		})
		return
	}

	err := UpdateSchedule(id, schedule)

	if err != nil {
		c.JSON(500, gin.H{
			"error": "Failed to update schedule",
		})
		return
	}

	c.JSON(200, gin.H{
		"message": "Schedule updated successfully",
	})
}

func DeleteScheduleHandler(c *gin.Context) {

	id := c.Param("id")

	err := DeleteSchedule(id)

	if err != nil {
		c.JSON(500, gin.H{
			"error": "Failed to delete schedule",
		})
		return
	}

	c.JSON(200, gin.H{
		"message": "Schedule deleted successfully",
	})
}
