import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  static const String baseUrl = "http://192.168.1.2:8080";

  // LOGIN
  static Future<bool> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/api/auth/login"),

        headers: {"Content-Type": "application/json"},

        body: jsonEncode({"email": email, "password": password}),
      );

      // ignore: avoid_print
      print(response.body);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        String token = data["token"];

        final prefs = await SharedPreferences.getInstance();

        await prefs.setString("token", token);

        return true;
      }

      return false;
    } catch (e) {
      // ignore: avoid_print
      print("LOGIN ERROR: $e");

      return false;
    }
  }

  // REGISTER
  static Future<bool> register(
    String name,
    String email,
    String password,
  ) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/api/auth/register"),

        headers: {"Content-Type": "application/json"},

        body: jsonEncode({"name": name, "email": email, "password": password}),
      );

      // ignore: avoid_print
      print(response.body);

      if (response.statusCode == 200) {
        return true;
      }

      return false;
    } catch (e) {
      // ignore: avoid_print
      print("REGISTER ERROR: $e");

      return false;
    }
  }

  // GET PROFILE
  static Future<Map<String, dynamic>?> getProfile() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      String? token = prefs.getString("token");

      if (token == null) {
        return null;
      }

      final response = await http.get(
        Uri.parse("$baseUrl/api/auth/profile"),

        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      // ignore: avoid_print
      print(response.body);

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }

      return null;
    } catch (e) {
      // ignore: avoid_print
      print("PROFILE ERROR: $e");

      return null;
    }
  }
}
