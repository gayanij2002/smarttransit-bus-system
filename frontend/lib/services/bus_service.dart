import 'dart:convert';

import 'package:http/http.dart' as http;

import 'api_service.dart';
import '../models/bus_model.dart';

class BusService {
  // ================= GET ALL BUSES =================
  static Future<List<BusModel>> getBuses() async {
    try {
      final response = await http.get(
        ApiService.buildUri("/api/buses/"),

        headers: {"Content-Type": "application/json"},
      );

      print("BUSES STATUS: ${response.statusCode}");
      print("BUSES BODY: ${response.body}");

      if (response.statusCode == 200) {
        final List data = jsonDecode(response.body);

        return data.map((bus) => BusModel.fromJson(bus)).toList();
      }

      return [];
    } catch (e) {
      print("GET BUSES ERROR: $e");
      return [];
    }
  }
}
