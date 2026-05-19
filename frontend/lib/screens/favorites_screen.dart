import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundGray,

      appBar: AppBar(
        backgroundColor: primaryBlue,

        title: const Text("Favorites", style: TextStyle(color: Colors.white)),

        centerTitle: true,
      ),

      body: const Center(
        child: Text(
          "No Favorite Buses Yet",

          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: textGray,
          ),
        ),
      ),
    );
  }
}
