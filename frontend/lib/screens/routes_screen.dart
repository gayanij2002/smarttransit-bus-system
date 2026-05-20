import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

import '../models/route_model.dart';

import '../services/route_service.dart';

class RoutesScreen extends StatefulWidget {
  const RoutesScreen({super.key});

  @override
  State<RoutesScreen> createState() => _RoutesScreenState();
}

class _RoutesScreenState extends State<RoutesScreen> {
  List<RouteModel> routes = [];

  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    loadRoutes();
  }

  Future<void> loadRoutes() async {
    final data = await RouteService.getRoutes();

    setState(() {
      routes = data;

      isLoading = false;
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
                      Icons.route,
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
                      "Available Routes",

                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: textGray,
                      ),
                    ),

                    const SizedBox(height: 10),

                    const Text(
                      "Live routes from backend",

                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),

                    const SizedBox(height: 24),

                    Expanded(
                      child: isLoading
                          ? const Center(child: CircularProgressIndicator())
                          : ListView.builder(
                              itemCount: routes.length,

                              itemBuilder: (context, index) {
                                final route = routes[index];

                                return Container(
                                  margin: const EdgeInsets.only(bottom: 18),

                                  padding: const EdgeInsets.all(20),

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
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(14),

                                            decoration: BoxDecoration(
                                              color: accentPurple.withOpacity(
                                                0.15,
                                              ),

                                              borderRadius:
                                                  BorderRadius.circular(18),
                                            ),

                                            child: const Icon(
                                              Icons.route,

                                              color: buttonViolet,

                                              size: 34,
                                            ),
                                          ),

                                          const SizedBox(width: 16),

                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,

                                              children: [
                                                Text(
                                                  "${route.startLocation} → ${route.endLocation}",

                                                  style: const TextStyle(
                                                    fontSize: 22,
                                                    fontWeight: FontWeight.bold,
                                                    color: primaryBlue,
                                                  ),
                                                ),

                                                const SizedBox(height: 8),

                                                Text(
                                                  "Distance: ${route.distance}",

                                                  style: const TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),

                                      const SizedBox(height: 18),

                                      SizedBox(
                                        width: double.infinity,

                                        height: 52,

                                        child: ElevatedButton(
                                          onPressed: () {
                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              SnackBar(
                                                backgroundColor: buttonViolet,

                                                content: Text(
                                                  "${route.startLocation} → ${route.endLocation}",
                                                ),
                                              ),
                                            );
                                          },

                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: buttonViolet,

                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                            ),
                                          ),

                                          child: const Text(
                                            "View Route",

                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
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
