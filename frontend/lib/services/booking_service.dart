// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'api_service.dart';
import '../models/booking_model.dart';

class BookingService {
  static const String baseUrl = ApiService.baseUrl;

  // ================= CREATE BOOKING =================
  static Future<bool> createBooking(BookingModel booking) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      String? token = prefs.getString("token");

      if (token == null) {
        print("NO JWT TOKEN FOUND");
        return false;
      }

      final response = await http.post(
        ApiService.buildUri("/api/bookings/"),

        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },

        body: jsonEncode(booking.toJson()),
      );

      print("BOOKING STATUS: ${response.statusCode}");
      print("BOOKING BODY: ${response.body}");

      return response.statusCode == 200 || response.statusCode == 201;
    } catch (e) {
      print("BOOKING ERROR: $e");
      return false;
    }
  }

  // ================= GET BOOKED SEATS =================
  static Future<List<int>> getBookedSeats(String busId) async {
    try {
      final response = await http.get(
        ApiService.buildUri("/api/bookings/seats/$busId"),
      );

      print("SEATS STATUS: ${response.statusCode}");
      print("SEATS BODY: ${response.body}");

      if (response.statusCode == 200) {
        List data = jsonDecode(response.body);

        return data.map((e) => e as int).toList();
      }

      return [];
    } catch (e) {
      print("GET SEATS ERROR: $e");
      return [];
    }
  }
}
