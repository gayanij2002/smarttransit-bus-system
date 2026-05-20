import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/route_model.dart';

class RouteService {
  static Future<List<RouteModel>> getRoutes() async {
    try {
      final response = await http.get(
        Uri.parse("http://192.168.1.3:8080/api/routes/"),
      );

      if (response.statusCode == 200) {
        List data = jsonDecode(response.body);

        return data.map((route) => RouteModel.fromJson(route)).toList();
      }

      return [];
    } catch (e) {
      return [];
    }
  }
}
