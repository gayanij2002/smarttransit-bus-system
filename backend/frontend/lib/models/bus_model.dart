class BusModel {
  final String id;
  final String busName;
  final String busNumber;
  final int totalSeats;

  BusModel({
    required this.id,
    required this.busName,
    required this.busNumber,
    required this.totalSeats,
  });

  factory BusModel.fromJson(Map<String, dynamic> json) {
    return BusModel(
      id: json['id'] ?? "",

      busName: json['bus_name'] ?? "",

      busNumber: json['bus_number'] ?? "",

      totalSeats: json['total_seats'] ?? 0,
    );
  }
}
