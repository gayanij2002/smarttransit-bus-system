package schedules

func CreateScheduleService(request CreateScheduleRequest) error {

	return CreateSchedule(request)
}

func GetSchedulesService() ([]Schedule, error) {

	return GetAllSchedules()
}
