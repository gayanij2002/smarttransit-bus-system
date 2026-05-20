package bookings

import (
	"net/http"

	"github.com/gin-gonic/gin"
)

// CreateBooking godoc
// @Summary Create booking
// @Description Create new booking
// @Tags Bookings
// @Accept json
// @Produce json
// @Param booking body CreateBookingRequest true "Booking"
// @Success 200 {object} map[string]interface{}
// @Router /api/bookings/ [post]
func CreateBookingHandler(
	c *gin.Context,
) {

	var request CreateBookingRequest

	if err := c.ShouldBindJSON(
		&request,
	); err != nil {

		c.JSON(
			http.StatusBadRequest,
			gin.H{
				"error": err.Error(),
			},
		)

		return
	}

	err := CreateBookingService(
		request,
	)

	if err != nil {

		c.JSON(
			http.StatusInternalServerError,
			gin.H{
				"error": err.Error(),
			},
		)

		return
	}

	c.JSON(
		http.StatusOK,
		gin.H{
			"message": "Booking created successfully",
		},
	)
}

// GetBookings godoc
// @Summary Get bookings
// @Description Retrieve all bookings
// @Tags Bookings
// @Produce json
// @Success 200 {array} Booking
// @Router /api/bookings/ [get]
func GetBookingsHandler(
	c *gin.Context,
) {

	bookings, err :=
		GetBookingsService()

	if err != nil {

		c.JSON(
			http.StatusInternalServerError,
			gin.H{
				"error": err.Error(),
			},
		)

		return
	}

	c.JSON(
		http.StatusOK,
		bookings,
	)
}
