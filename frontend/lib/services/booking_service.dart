import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/booking_model.dart';

class BookingService {
  static const String baseUrl = "http://192.168.1.2:8080";

  static Future<bool> createBooking(BookingModel booking) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/api/bookings/"),

        headers: {"Content-Type": "application/json"},

        body: jsonEncode(booking.toJson()),
      );

      return response.statusCode == 200 || response.statusCode == 201;
    } catch (e) {
      return false;
    }
  }

  static Future<List<int>> getBookedSeats(String busId) async {
    try {
      final response = await http.get(
        Uri.parse("$baseUrl/api/bookings/seats/$busId"),
      );

      if (response.statusCode == 200) {
        List data = jsonDecode(response.body);

        return data.map((e) => e as int).toList();
      }

      return [];
    } catch (e) {
      return [];
    }
  }
}
