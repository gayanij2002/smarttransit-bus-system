import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

import 'home_screen.dart';
import 'favorites_screen.dart';
import 'profile_screen.dart';
import 'routes_screen.dart';
import 'live_tracking_screen.dart';
import 'login_screen.dart' hide buttonViolet;

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int currentIndex = 0;

  final List screens = [
    const HomeScreen(),

    const FavoritesScreen(),

    const RoutesScreen(),

    const LiveTrackingScreen(),

    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,

        selectedItemColor: buttonViolet,

        unselectedItemColor: Colors.grey,

        backgroundColor: Colors.white,

        type: BottomNavigationBarType.fixed,

        onTap: (index) {
          if (index == 5) {
            Navigator.pushReplacement(
              context,

              MaterialPageRoute(builder: (_) => const LoginScreen()),
            );

            return;
          }

          setState(() {
            currentIndex = index;
          });
        },

        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),

          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: "Favorites",
          ),

          BottomNavigationBarItem(icon: Icon(Icons.route), label: "Routes"),

          BottomNavigationBarItem(
            icon: Icon(Icons.location_on),
            label: "Tracking",
          ),

          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),

          BottomNavigationBarItem(icon: Icon(Icons.logout), label: "Logout"),
        ],
      ),
    );
  }
}
