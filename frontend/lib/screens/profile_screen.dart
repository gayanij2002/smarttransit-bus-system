import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundGray,

      appBar: AppBar(
        backgroundColor: primaryBlue,

        title: const Text("Profile", style: TextStyle(color: Colors.white)),

        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [
            const SizedBox(height: 30),

            CircleAvatar(
              radius: 55,

              // ignore: deprecated_member_use
              backgroundColor: accentPurple.withOpacity(0.3),

              child: const Icon(Icons.person, size: 60, color: buttonViolet),
            ),

            const SizedBox(height: 20),

            const Text(
              "SmartTransit User",

              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: textGray,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              "user@gmail.com",

              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),

            const SizedBox(height: 40),

            profileTile(Icons.settings, "Settings"),

            profileTile(Icons.history, "Booking History"),

            profileTile(Icons.info, "About App"),
          ],
        ),
      ),
    );
  }

  Widget profileTile(IconData icon, String title) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.circular(18),

        boxShadow: [
          // ignore: deprecated_member_use
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8),
        ],
      ),

      child: ListTile(
        leading: Icon(icon, color: buttonViolet),

        title: Text(title),

        trailing: const Icon(Icons.arrow_forward_ios, size: 18),
      ),
    );
  }
}
