import 'package:flutter/material.dart';
import 'package:frontend/screens/favorite_service.dart';

import '../theme/app_theme.dart';
import '../models/bus_model.dart';
import '../services/bus_service.dart';
import 'bus_details_screen.dart';
// ignore: unused_import
import '../services/favorite_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<BusModel> buses = [];

  List<BusModel> filteredBuses = [];

  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    loadBuses();
  }

  Future<void> loadBuses() async {
    final data = await BusService.getBuses();

    setState(() {
      buses = data;

      filteredBuses = data;

      isLoading = false;
    });
  }

  void searchBus(String query) {
    final results = buses.where((bus) {
      final name = bus.busName.toLowerCase();

      final number = bus.busNumber.toLowerCase();

      final input = query.toLowerCase();

      return name.contains(input) || number.contains(input);
    }).toList();

    setState(() {
      filteredBuses = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundGray,

      body: SafeArea(
        child: Column(
          children: [
            // ================= HEADER =================
            Container(
              width: double.infinity,

              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 24),

              decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [primaryBlue, buttonViolet]),

                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(28),
                  bottomRight: Radius.circular(28),
                ),
              ),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  Row(
                    children: const [
                      Icon(Icons.directions_bus, color: Colors.white, size: 40),

                      SizedBox(width: 10),

                      Text(
                        "SMART",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      Text(
                        "TRANSIT",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 26,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),

                  Container(
                    padding: const EdgeInsets.all(8),

                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),

                    child: const Icon(
                      Icons.notifications_none,
                      color: buttonViolet,
                      size: 28,
                    ),
                  ),
                ],
              ),
            ),

            // ================= BODY =================
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(18),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children: const [
                        Text(
                          "Available Buses",

                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: textGray,
                          ),
                        ),

                        Text(
                          "FILTER",

                          style: TextStyle(
                            color: buttonViolet,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 18),

                    // ================= SEARCH BAR =================
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,

                        borderRadius: BorderRadius.circular(16),

                        boxShadow: [
                          BoxShadow(
                            // ignore: deprecated_member_use
                            color: Colors.black.withOpacity(0.04),
                            blurRadius: 10,
                          ),
                        ],
                      ),

                      child: TextField(
                        onChanged: searchBus,

                        decoration: InputDecoration(
                          hintText: "Search buses...",

                          hintStyle: const TextStyle(fontSize: 18),

                          prefixIcon: const Icon(
                            Icons.search,
                            size: 34,
                            color: Colors.grey,
                          ),

                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),

                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // ================= BUS LIST =================
                    Expanded(
                      child: isLoading
                          ? const Center(child: CircularProgressIndicator())
                          : filteredBuses.isEmpty
                          ? const Center(
                              child: Text(
                                "No Buses Found",

                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                ),
                              ),
                            )
                          : ListView.builder(
                              physics: const BouncingScrollPhysics(),

                              itemCount: filteredBuses.length,

                              itemBuilder: (context, index) {
                                final bus = filteredBuses[index];

                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 18),

                                  child: BusCard(bus: bus),
                                );
                              },
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ================= BUS CARD =================

class BusCard extends StatefulWidget {
  final BusModel bus;

  const BusCard({super.key, required this.bus});

  @override
  State<BusCard> createState() => _BusCardState();
}

class _BusCardState extends State<BusCard> {
  @override
  Widget build(BuildContext context) {
    final bus = widget.bus;

    final isFavorite = FavoriteService.isFavorite(bus);
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,

          MaterialPageRoute(builder: (context) => BusDetailsScreen(bus: bus)),
        );
      },

      child: Container(
        padding: const EdgeInsets.all(18),

        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Colors.white, Color(0xFFF3EEFF)],
          ),

          borderRadius: BorderRadius.circular(24),

          boxShadow: [
            // ignore: deprecated_member_use
            BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
          ],
        ),

        child: Row(
          children: [
            // ================= ICON =================
            Container(
              padding: const EdgeInsets.all(16),

              decoration: BoxDecoration(
                // ignore: deprecated_member_use
                color: accentPurple.withOpacity(0.20),

                borderRadius: BorderRadius.circular(18),
              ),

              child: const Icon(
                Icons.directions_bus,
                size: 46,
                color: buttonViolet,
              ),
            ),

            const SizedBox(width: 18),

            // ================= INFO =================
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Text(
                    bus.busName,

                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: primaryBlue,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    "Bus Number: ${bus.busNumber}",

                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    "${bus.totalSeats} Seats Available",

                    style: const TextStyle(
                      fontSize: 15,
                      color: buttonViolet,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

            // ================= ARROW =================
            Column(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      FavoriteService.toggleFavorite(bus);
                    });
                  },

                  child: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,

                    color: Colors.red,
                    size: 30,
                  ),
                ),

                const SizedBox(height: 14),

                const Icon(Icons.arrow_forward_ios, color: buttonViolet),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
