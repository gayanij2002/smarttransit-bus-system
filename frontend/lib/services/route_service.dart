import 'dart:convert';

import 'package:http/http.dart' as http;

import 'api_service.dart';

import '../models/route_model.dart';

class RouteService {
  static Future<List<RouteModel>> getRoutes() async {
    try {
      final response = await http.get(
        Uri.parse("${ApiService.baseUrl}/api/routes/"),
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
