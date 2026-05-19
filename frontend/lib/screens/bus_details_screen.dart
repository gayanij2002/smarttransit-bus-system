import 'package:flutter/material.dart';

import '../models/bus_model.dart';
import '../theme/app_theme.dart';

class BusDetailsScreen extends StatelessWidget {
  final BusModel bus;

  const BusDetailsScreen({super.key, required this.bus});

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

              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),

              decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [primaryBlue, buttonViolet]),

                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(32),
                  bottomRight: Radius.circular(32),
                ),
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },

                    child: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(height: 30),

                  Center(
                    child: Container(
                      padding: const EdgeInsets.all(24),

                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.15),

                        borderRadius: BorderRadius.circular(24),
                      ),

                      child: const Icon(
                        Icons.directions_bus,
                        color: Colors.white,
                        size: 90,
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  Center(
                    child: Text(
                      bus.busName,

                      textAlign: TextAlign.center,

                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  Center(
                    child: Text(
                      bus.busNumber,

                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // ================= BODY =================
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),

                child: Column(
                  children: [
                    // ================= INFO CARDS =================
                    Row(
                      children: [
                        Expanded(
                          child: InfoCard(
                            icon: Icons.event_seat,
                            title: "${bus.totalSeats}",
                            subtitle: "Total Seats",
                          ),
                        ),

                        const SizedBox(width: 16),

                        Expanded(
                          child: InfoCard(
                            icon: Icons.confirmation_num,
                            title: bus.busNumber,
                            subtitle: "Bus Number",
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 22),

                    // ================= DETAILS SECTION =================
                    Container(
                      width: double.infinity,

                      padding: const EdgeInsets.all(22),

                      decoration: BoxDecoration(
                        color: Colors.white,

                        borderRadius: BorderRadius.circular(24),

                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                          ),
                        ],
                      ),

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          const Text(
                            "Bus Information",

                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: primaryBlue,
                            ),
                          ),

                          const SizedBox(height: 24),

                          detailRow(
                            Icons.directions_bus,
                            "Bus Name",
                            bus.busName,
                          ),

                          const SizedBox(height: 18),

                          detailRow(Icons.pin, "Bus Number", bus.busNumber),

                          const SizedBox(height: 18),

                          detailRow(
                            Icons.event_seat,
                            "Seat Capacity",
                            "${bus.totalSeats} Seats",
                          ),

                          const SizedBox(height: 18),

                          detailRow(Icons.verified, "Status", "Available"),
                        ],
                      ),
                    ),

                    const SizedBox(height: 28),

                    // ================= BUTTON =================
                    SizedBox(
                      width: double.infinity,
                      height: 58,

                      child: ElevatedButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Bus Selected Successfully"),
                            ),
                          );
                        },

                        style: ElevatedButton.styleFrom(
                          backgroundColor: buttonViolet,

                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),

                        child: const Text(
                          "Book Now",

                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget detailRow(IconData icon, String title, String value) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(12),

          decoration: BoxDecoration(
            color: accentPurple.withOpacity(0.15),

            borderRadius: BorderRadius.circular(14),
          ),

          child: Icon(icon, color: buttonViolet),
        ),

        const SizedBox(width: 16),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Text(
                title,

                style: const TextStyle(color: Colors.grey, fontSize: 15),
              ),

              const SizedBox(height: 4),

              Text(
                value,

                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: textGray,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ================= INFO CARD =================

class InfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const InfoCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 22),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.circular(24),

        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
        ],
      ),

      child: Column(
        children: [
          Icon(icon, color: buttonViolet, size: 34),

          const SizedBox(height: 12),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),

            child: Text(
              title,

              textAlign: TextAlign.center,

              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: primaryBlue,
              ),
            ),
          ),

          const SizedBox(height: 6),

          Text(
            subtitle,

            style: const TextStyle(color: Colors.grey, fontSize: 15),
          ),
        ],
      ),
    );
  }
}
