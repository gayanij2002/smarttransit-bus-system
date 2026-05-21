import 'package:flutter/material.dart';

import '../services/api_service.dart';
import '../theme/app_theme.dart';

import 'login_screen.dart'
    hide backgroundGray, primaryBlue, buttonViolet, accentPurple, textGray;

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String name = "Loading...";
  String email = "Loading...";

  @override
  void initState() {
    super.initState();

    loadProfile();
  }

  Future<void> loadProfile() async {
    final profile = await ApiService.getProfile();

    if (profile != null) {
      setState(() {
        name = profile["name"] ?? "No Name";
        email = profile["email"] ?? "No Email";
      });
    }
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
                      Icons.person,
                      color: buttonViolet,
                      size: 28,
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
                    // ================= PROFILE CARD =================
                    Container(
                      width: double.infinity,

                      padding: const EdgeInsets.all(24),

                      decoration: BoxDecoration(
                        color: Colors.white,

                        borderRadius: BorderRadius.circular(28),

                        boxShadow: [
                          BoxShadow(
                            color: Colors.black
                                // ignore: deprecated_member_use
                                .withOpacity(0.05),

                            blurRadius: 12,
                          ),
                        ],
                      ),

                      child: Column(
                        children: [
                          Container(
                            width: 110,
                            height: 110,

                            decoration: BoxDecoration(
                              color:
                                  // ignore: deprecated_member_use
                                  accentPurple.withOpacity(0.2),

                              shape: BoxShape.circle,
                            ),

                            child: const Icon(
                              Icons.person,
                              size: 70,
                              color: buttonViolet,
                            ),
                          ),

                          const SizedBox(height: 18),

                          Text(
                            name,

                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: primaryBlue,
                            ),
                          ),

                          const SizedBox(height: 8),

                          Text(
                            email,

                            style: const TextStyle(
                              fontSize: 17,
                              color: Colors.grey,
                            ),
                          ),

                          const SizedBox(height: 18),

                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 18,
                              vertical: 10,
                            ),

                            decoration: BoxDecoration(
                              color:
                                  // ignore: deprecated_member_use
                                  buttonViolet.withOpacity(0.1),

                              borderRadius: BorderRadius.circular(20),
                            ),

                            child: const Text(
                              "Premium Traveller",

                              style: TextStyle(
                                color: buttonViolet,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 28),

                    // ================= OPTIONS =================
                    ProfileTile(icon: Icons.favorite, title: "Favorite Buses"),

                    ProfileTile(
                      icon: Icons.notifications,
                      title: "Notifications",
                    ),

                    ProfileTile(icon: Icons.settings, title: "Settings"),

                    ProfileTile(
                      icon: Icons.help_outline,
                      title: "Help & Support",
                    ),

                    const SizedBox(height: 30),

                    // ================= LOGOUT BUTTON =================
                    SizedBox(
                      width: double.infinity,
                      height: 60,

                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                            context,

                            MaterialPageRoute(
                              builder: (context) => const LoginScreen(),
                            ),

                            (route) => false,
                          );
                        },

                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,

                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),

                        icon: const Icon(Icons.logout, color: Colors.white),

                        label: const Text(
                          "Logout",

                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
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
}

// ================= PROFILE TILE =================

class ProfileTile extends StatelessWidget {
  final IconData icon;

  final String title;

  const ProfileTile({super.key, required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),

      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.circular(20),

        boxShadow: [
          BoxShadow(
            color: Colors.black
                // ignore: deprecated_member_use
                .withOpacity(0.04),

            blurRadius: 8,
          ),
        ],
      ),

      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),

            decoration: BoxDecoration(
              color:
                  // ignore: deprecated_member_use
                  accentPurple.withOpacity(0.15),

              borderRadius: BorderRadius.circular(14),
            ),

            child: Icon(icon, color: buttonViolet, size: 28),
          ),

          const SizedBox(width: 18),

          Expanded(
            child: Text(
              title,

              style: const TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w600,
                color: textGray,
              ),
            ),
          ),

          const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 18),
        ],
      ),
    );
  }
}
