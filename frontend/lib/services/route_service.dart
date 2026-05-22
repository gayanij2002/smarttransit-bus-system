import 'dart:convert';

import 'package:http/http.dart' as http;

import 'api_service.dart';
import '../models/route_model.dart';

class RouteService {
  // ================= GET ALL ROUTES =================
  static Future<List<RouteModel>> getRoutes() async {
    try {
      final response = await http.get(
        ApiService.buildUri("/api/routes/"),
        headers: {"Content-Type": "application/json"},
      );

      print("ROUTES STATUS: ${response.statusCode}");
      print("ROUTES BODY: ${response.body}");

      if (response.statusCode == 200) {
        final List data = jsonDecode(response.body);

        return data.map((route) => RouteModel.fromJson(route)).toList();
      }

      return [];
    } catch (e) {
      print("GET ROUTES ERROR: $e");
      return [];
    }
  }
}
