package routes

func CreateRouteService(request CreateRouteRequest) error {

	return CreateRoute(request)
}

func GetRoutesService() ([]Route, error) {

	return GetAllRoutes()
}
