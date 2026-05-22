package schedules

import (
	"net/http"

	"github.com/gin-gonic/gin"
)

// CreateSchedule godoc
// @Summary Create schedule
// @Description Create new schedule
// @Tags Schedules
// @Security BearerAuth
// @Accept json
// @Produce json
// @Param schedule body CreateScheduleRequest true "Create Schedule"
// @Success 200 {object} map[string]interface{}
// @Router /api/schedules/ [post]
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

// GetSchedules godoc
// @Summary Get all schedules
// @Description Retrieve all schedules
// @Tags Schedules
// @Produce json
// @Success 200 {array} Schedule
// @Router /api/schedules/ [get]
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

// GetScheduleByID godoc
// @Summary Get schedule by ID
// @Description Retrieve single schedule
// @Tags Schedules
// @Produce json
// @Param id path string true "Schedule ID"
// @Success 200 {object} Schedule
// @Router /api/schedules/{id} [get]
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

// UpdateSchedule godoc
// @Summary Update schedule
// @Description Update existing schedule
// @Tags Schedules
// @Security BearerAuth
// @Accept json
// @Produce json
// @Param id path string true "Schedule ID"
// @Param schedule body Schedule true "Update Schedule"
// @Success 200 {object} map[string]interface{}
// @Router /api/schedules/{id} [put]
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

// DeleteSchedule godoc
// @Summary Delete schedule
// @Description Delete schedule
// @Tags Schedules
// @Security BearerAuth
// @Produce json
// @Param id path string true "Schedule ID"
// @Success 200 {object} map[string]interface{}
// @Router /api/schedules/{id} [delete]
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
