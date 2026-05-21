import 'package:flutter/material.dart';
import 'package:frontend/screens/favorite_service.dart';

import '../theme/app_theme.dart';

// ignore: unused_import
import '../services/favorite_service.dart';

import '../models/bus_model.dart';

import 'bus_details_screen.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    List<BusModel> favorites = FavoriteService.getFavorites();

    return Scaffold(
      backgroundColor: backgroundGray,

      appBar: AppBar(
        backgroundColor: primaryBlue,

        title: const Text(
          "Favorite Buses",

          style: TextStyle(color: Colors.white),
        ),

        centerTitle: true,
      ),

      body: favorites.isEmpty
          ? const Center(
              child: Text(
                "No Favorite Buses Yet",

                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: textGray,
                ),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(18),

              itemCount: favorites.length,

              itemBuilder: (context, index) {
                final bus = favorites[index];

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,

                      MaterialPageRoute(
                        builder: (context) => BusDetailsScreen(bus: bus),
                      ),
                    );
                  },

                  child: Container(
                    margin: const EdgeInsets.only(bottom: 18),

                    padding: const EdgeInsets.all(18),

                    decoration: BoxDecoration(
                      color: Colors.white,

                      borderRadius: BorderRadius.circular(22),

                      boxShadow: [
                        BoxShadow(
                          // ignore: deprecated_member_use
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                        ),
                      ],
                    ),

                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(14),

                          decoration: BoxDecoration(
                            // ignore: deprecated_member_use
                            color: accentPurple.withOpacity(0.2),

                            borderRadius: BorderRadius.circular(16),
                          ),

                          child: const Icon(
                            Icons.directions_bus,
                            size: 40,
                            color: buttonViolet,
                          ),
                        ),

                        const SizedBox(width: 16),

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

                              Text(bus.busNumber),
                            ],
                          ),
                        ),

                        const Icon(Icons.favorite, color: Colors.red),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
