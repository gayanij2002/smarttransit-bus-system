package bookings

import "github.com/gin-gonic/gin"

func BookingRoutes(
	routes *gin.RouterGroup,
) {

	booking := routes.Group(
		"/bookings",
	)

	{
		booking.POST(
			"/",
			CreateBookingHandler,
		)

		booking.GET(
			"/",
			GetBookingsHandler,
		)

		booking.GET(
			"/seats/:bus_id",
			GetBookedSeatsHandler,
		)
	}
}
