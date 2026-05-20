import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/bus_model.dart';

class BusService {
  // CHANGE IP IF YOUR WIFI IP CHANGES

  static const String baseUrl = "http://192.168.1.3:8080";

  static Future<List<BusModel>> getBuses() async {
    try {
      final response = await http.get(Uri.parse("$baseUrl/api/buses/"));

      if (response.statusCode == 200) {
        final List data = jsonDecode(response.body);

        return data.map((bus) => BusModel.fromJson(bus)).toList();
      }

      return [];
    } catch (e) {
      // ignore: avoid_print
      print(e);

      return [];
    }
  }
}
