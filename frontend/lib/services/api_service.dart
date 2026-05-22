// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  // ================= CHOREO BASE URL =================
  static const String baseUrl =
      "https://8c0a7554-4281-4356-8b7f-522782a0f64a-dev.e1-us-east-azure.choreoapis.dev/default/backend/v1.1";
  // ================= BUILD URI =================
  static Uri buildUri(String path) {
    return Uri.parse(baseUrl + path);
  }

  // ================= LOGIN =================
  static Future<bool> login(String email, String password) async {
    try {
      final response = await http.post(
        buildUri("/api/auth/login"),

        headers: {"Content-Type": "application/json"},

        body: jsonEncode({"email": email, "password": password}),
      );

      print("LOGIN STATUS: ${response.statusCode}");
      print("LOGIN BODY: ${response.body}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        String token = data["token"];

        final prefs = await SharedPreferences.getInstance();

        await prefs.setString("token", token);

        return true;
      }

      return false;
    } catch (e) {
      print("LOGIN ERROR: $e");
      return false;
    }
  }

  // ================= REGISTER =================
  static Future<bool> register(
    String name,
    String email,
    String password,
  ) async {
    try {
      final response = await http.post(
        buildUri("/api/auth/register"),

        headers: {"Content-Type": "application/json"},

        body: jsonEncode({"name": name, "email": email, "password": password}),
      );

      print("REGISTER STATUS: ${response.statusCode}");
      print("REGISTER BODY: ${response.body}");

      return response.statusCode == 200 || response.statusCode == 201;
    } catch (e) {
      print("REGISTER ERROR: $e");
      return false;
    }
  }

  // ================= GET PROFILE =================
  static Future<Map<String, dynamic>?> getProfile() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      String? token = prefs.getString("token");

      if (token == null) {
        print("NO JWT TOKEN FOUND");
        return null;
      }

      final response = await http.get(
        buildUri("/api/auth/profile"),

        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      print("PROFILE STATUS: ${response.statusCode}");
      print("PROFILE BODY: ${response.body}");

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }

      return null;
    } catch (e) {
      print("PROFILE ERROR: $e");
      return null;
    }
  }

  // ================= LOGOUT =================
  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove("token");
  }
}
