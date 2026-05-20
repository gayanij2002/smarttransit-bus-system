class RouteModel {
  final String id;

  final String startLocation;

  final String endLocation;

  final String distance;

  final String createdAt;

  RouteModel({
    required this.id,

    required this.startLocation,

    required this.endLocation,

    required this.distance,

    required this.createdAt,
  });

  factory RouteModel.fromJson(Map<String, dynamic> json) {
    return RouteModel(
      id: json["id"],

      startLocation: json["start_location"],

      endLocation: json["end_location"],

      distance: json["distance"],

      createdAt: json["created_at"],
    );
  }
}
