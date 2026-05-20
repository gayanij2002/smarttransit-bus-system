import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class LiveTrackingScreen extends StatefulWidget {
  const LiveTrackingScreen({super.key});

  @override
  State<LiveTrackingScreen> createState() => _LiveTrackingScreenState();
}

class _LiveTrackingScreenState extends State<LiveTrackingScreen> {
  double busPosition = 0.35;

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
                      Icons.location_on,
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
                padding: const EdgeInsets.all(20),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    const Text(
                      "Live Bus Tracking",

                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: textGray,
                      ),
                    ),

                    const SizedBox(height: 8),

                    const Text(
                      "Track your bus in real-time",

                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),

                    const SizedBox(height: 24),

                    // ================= MAP UI =================
                    Expanded(
                      child: Container(
                        width: double.infinity,

                        decoration: BoxDecoration(
                          color: Colors.white,

                          borderRadius: BorderRadius.circular(28),

                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 10,
                            ),
                          ],
                        ),

                        child: Stack(
                          children: [
                            // ================= MAP BG =================
                            Positioned.fill(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(28),

                                child: Image.network(
                                  "https://i.imgur.com/QCNbOAo.png",

                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),

                            // ================= ROUTE LINE =================
                            Positioned(
                              left: 70,
                              top: 220,

                              child: Container(
                                width: 240,
                                height: 6,
                                color: buttonViolet,
                              ),
                            ),

                            // ================= START POINT =================
                            const Positioned(
                              left: 50,
                              top: 205,

                              child: Column(
                                children: [
                                  Icon(
                                    Icons.location_pin,
                                    color: Colors.green,
                                    size: 40,
                                  ),

                                  Text("Colombo"),
                                ],
                              ),
                            ),

                            // ================= END POINT =================
                            const Positioned(
                              right: 35,
                              top: 205,

                              child: Column(
                                children: [
                                  Icon(
                                    Icons.location_pin,
                                    color: Colors.red,
                                    size: 40,
                                  ),

                                  Text("Kandy"),
                                ],
                              ),
                            ),

                            // ================= BUS =================
                            Positioned(
                              left: 70 + (240 * busPosition),

                              top: 180,

                              child: Column(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(12),

                                    decoration: BoxDecoration(
                                      color: buttonViolet,

                                      borderRadius: BorderRadius.circular(18),
                                    ),

                                    child: const Icon(
                                      Icons.directions_bus,
                                      color: Colors.white,
                                      size: 34,
                                    ),
                                  ),

                                  const SizedBox(height: 6),

                                  const Text(
                                    "Highway Express",

                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // ================= INFO CARDS =================
                    Row(
                      children: [
                        Expanded(
                          child: TrackingInfoCard(
                            title: "Estimated Arrival",

                            value: "25 mins",

                            icon: Icons.access_time,
                          ),
                        ),

                        const SizedBox(width: 16),

                        Expanded(
                          child: TrackingInfoCard(
                            title: "Current Speed",

                            value: "72 km/h",

                            icon: Icons.speed,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    Row(
                      children: [
                        Expanded(
                          child: TrackingInfoCard(
                            title: "Next Stop",

                            value: "Peradeniya",

                            icon: Icons.location_city,
                          ),
                        ),

                        const SizedBox(width: 16),

                        Expanded(
                          child: TrackingInfoCard(
                            title: "Passengers",

                            value: "34",

                            icon: Icons.people,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // ================= REFRESH BUTTON =================
                    SizedBox(
                      width: double.infinity,
                      height: 58,

                      child: ElevatedButton.icon(
                        onPressed: () {
                          setState(() {
                            busPosition += 0.08;

                            if (busPosition > 1) {
                              busPosition = 0.1;
                            }
                          });
                        },

                        style: ElevatedButton.styleFrom(
                          backgroundColor: buttonViolet,

                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),

                        icon: const Icon(Icons.refresh, color: Colors.white),

                        label: const Text(
                          "Refresh Live Location",

                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
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

// ================= INFO CARD =================

class TrackingInfoCard extends StatelessWidget {
  final String title;

  final String value;

  final IconData icon;

  const TrackingInfoCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.circular(22),

        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
        ],
      ),

      child: Column(
        children: [
          Icon(icon, color: buttonViolet, size: 34),

          const SizedBox(height: 10),

          Text(
            value,

            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: primaryBlue,
            ),
          ),

          const SizedBox(height: 6),

          Text(
            title,

            textAlign: TextAlign.center,

            style: const TextStyle(color: Colors.grey, fontSize: 14),
          ),
        ],
      ),
    );
  }
}
