class BookingModel {
  final String busId;

  final List<int> seats;

  BookingModel({required this.busId, required this.seats});

  Map<String, dynamic> toJson() {
    return {"bus_id": busId, "seats": seats};
  }
}
