package buses

func CreateBusService(request CreateBusRequest) error {

	return CreateBus(request)
}

func GetBusesService() ([]Bus, error) {

	return GetAllBuses()
}

func GetBusByIDService(id string) (*Bus, error) {

	return GetBusByID(id)
}

func UpdateBusService(id string, request CreateBusRequest) error {

	return UpdateBus(id, request)
}

func DeleteBusService(id string) error {

	return DeleteBus(id)
}
