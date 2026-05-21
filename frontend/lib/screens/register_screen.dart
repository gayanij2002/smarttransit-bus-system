import 'package:flutter/material.dart';

import '../services/api_service.dart';
import 'login_screen.dart';

const Color primaryBlue = Color(0xFF2E3192);
const Color accentPurple = Color(0xFFB39DDB);
const Color backgroundGray = Color(0xFFF5F5F5);
const Color buttonViolet = Color(0xFF7E57C2);

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final nameController = TextEditingController();

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  bool obscurePassword = true;

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFEAEAEA),

      body: SafeArea(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height,
            ),

            child: Center(
              child: Container(
                width: screenWidth * 0.88,

                margin: const EdgeInsets.symmetric(vertical: 20),

                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(35),

                  gradient: const LinearGradient(
                    colors: [Color(0xFF2E3192), Color(0xFF3A36A8)],

                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),

                  boxShadow: [
                    BoxShadow(
                      color: Colors.black
                          // ignore: deprecated_member_use
                          .withOpacity(0.15),

                      blurRadius: 20,

                      offset: const Offset(0, 10),
                    ),
                  ],
                ),

                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 32,
                  ),

                  child: Column(
                    mainAxisSize: MainAxisSize.min,

                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,

                        children: [
                          Icon(
                            Icons.directions_bus,
                            color: Colors.white,
                            size: 50,
                          ),

                          SizedBox(width: 8),

                          Text(
                            "SMART",

                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          Text(
                            "TRANSIT",

                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 28,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 45),

                      const Text(
                        "Create Account",

                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 35),

                      Container(
                        padding: const EdgeInsets.all(20),

                        decoration: BoxDecoration(
                          color: const Color(0xFFF1F1F5),

                          borderRadius: BorderRadius.circular(10),
                        ),

                        child: Column(
                          children: [
                            // NAME
                            TextField(
                              controller: nameController,

                              decoration: InputDecoration(
                                hintText: "Enter your name",

                                filled: true,
                                fillColor: Colors.white,

                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),

                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),

                            const SizedBox(height: 18),

                            // EMAIL
                            TextField(
                              controller: emailController,

                              decoration: InputDecoration(
                                hintText: "Enter your email",

                                filled: true,
                                fillColor: Colors.white,

                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),

                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),

                            const SizedBox(height: 18),

                            // PASSWORD
                            TextField(
                              controller: passwordController,

                              obscureText: obscurePassword,

                              decoration: InputDecoration(
                                hintText: "Enter password",

                                filled: true,
                                fillColor: Colors.white,

                                suffixIcon: IconButton(
                                  icon: Icon(
                                    obscurePassword
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                  ),

                                  onPressed: () {
                                    setState(() {
                                      obscurePassword = !obscurePassword;
                                    });
                                  },
                                ),

                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),

                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 28),

                      SizedBox(
                        width: double.infinity,
                        height: 58,

                        child: ElevatedButton(
                          onPressed: () async {
                            if (nameController.text.trim().isEmpty ||
                                emailController.text.trim().isEmpty ||
                                passwordController.text.trim().isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Please fill all fields"),
                                ),
                              );

                              return;
                            }

                            setState(() {
                              isLoading = true;
                            });

                            bool success = await ApiService.register(
                              nameController.text.trim(),

                              emailController.text.trim(),

                              passwordController.text.trim(),
                            );

                            setState(() {
                              isLoading = false;
                            });

                            if (success) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Registration Successful"),

                                  backgroundColor: Colors.green,
                                ),
                              );

                              Navigator.pushReplacement(
                                context,

                                MaterialPageRoute(
                                  builder: (context) => const LoginScreen(),
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Registration Failed"),

                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          },

                          style: ElevatedButton.styleFrom(
                            backgroundColor: buttonViolet,

                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                          ),

                          child: isLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : const Text(
                                  "Create Account",

                                  style: TextStyle(
                                    color: Colors.white,

                                    fontSize: 22,

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
            ),
          ),
        ),
      ),
    );
  }
}
