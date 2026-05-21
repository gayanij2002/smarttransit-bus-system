import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  static const String baseUrl = "http://192.168.1.2:8080";
  // CHOREO SECURITY TOKEN

  // ================= LOGIN =================
  static Future<bool> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/api/auth/login"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": email, "password": password}),
      );

      print("LOGIN STATUS: ${response.statusCode}");
      print("LOGIN BODY: ${response.body}");

      print(response.statusCode);
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
        Uri.parse("$baseUrl/api/auth/register"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"name": name, "email": email, "password": password}),
      );

      print("REGISTER STATUS: ${response.statusCode}");
      print("REGISTER BODY: ${response.body}");

      if (response.statusCode == 200) {
        return true;
      }

      return false;
    } catch (e) {
      print("REGISTER ERROR: $e");
      return false;
    }
  }

  // ================= PROFILE =================
  static Future<Map<String, dynamic>?> getProfile() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      String? token = prefs.getString("token");

      if (token == null) {
        print("NO JWT TOKEN FOUND");
        return null;
      }

      final response = await http.get(
        Uri.parse("$baseUrl/api/auth/profile"),
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
}
