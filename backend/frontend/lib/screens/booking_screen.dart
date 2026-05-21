import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  List<int> selectedSeats = [];

  final int ticketPrice = 1500;

  void toggleSeat(int seatNumber) {
    setState(() {
      if (selectedSeats.contains(seatNumber)) {
        selectedSeats.remove(seatNumber);
      } else {
        selectedSeats.add(seatNumber);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    int totalPrice = selectedSeats.length * ticketPrice;

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
                      Icons.event_seat,
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
                      "Select Your Seats",

                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: textGray,
                      ),
                    ),

                    const SizedBox(height: 10),

                    const Text(
                      "Choose available seats for your journey",

                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),

                    const SizedBox(height: 25),

                    // ================= DRIVER =================
                    Align(
                      alignment: Alignment.centerRight,

                      child: Container(
                        padding: const EdgeInsets.all(12),

                        decoration: BoxDecoration(
                          color: buttonViolet.withOpacity(0.15),

                          borderRadius: BorderRadius.circular(14),
                        ),

                        child: const Text(
                          "DRIVER",

                          style: TextStyle(
                            color: buttonViolet,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    // ================= SEATS =================
                    Expanded(
                      child: GridView.builder(
                        itemCount: 32,

                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4,

                              mainAxisSpacing: 18,

                              crossAxisSpacing: 18,

                              childAspectRatio: 1,
                            ),

                        itemBuilder: (context, index) {
                          int seatNumber = index + 1;

                          bool isSelected = selectedSeats.contains(seatNumber);

                          return GestureDetector(
                            onTap: () {
                              toggleSeat(seatNumber);
                            },

                            child: Container(
                              decoration: BoxDecoration(
                                color: isSelected ? buttonViolet : Colors.white,

                                borderRadius: BorderRadius.circular(18),

                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.05),
                                    blurRadius: 8,
                                  ),
                                ],
                              ),

                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,

                                children: [
                                  Icon(
                                    Icons.event_seat,

                                    color: isSelected
                                        ? Colors.white
                                        : buttonViolet,

                                    size: 34,
                                  ),

                                  const SizedBox(height: 6),

                                  Text(
                                    seatNumber.toString(),

                                    style: TextStyle(
                                      color: isSelected
                                          ? Colors.white
                                          : textGray,

                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 20),

                    // ================= SUMMARY =================
                    Container(
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
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,

                            children: [
                              const Text(
                                "Selected Seats",

                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              Text(
                                selectedSeats.isEmpty
                                    ? "None"
                                    : selectedSeats.join(", "),

                                style: const TextStyle(
                                  color: buttonViolet,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 14),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,

                            children: [
                              const Text(
                                "Total Price",

                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              Text(
                                "Rs. $totalPrice",

                                style: const TextStyle(
                                  fontSize: 24,
                                  color: buttonViolet,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 22),

                          SizedBox(
                            width: double.infinity,
                            height: 58,

                            child: ElevatedButton(
                              onPressed: selectedSeats.isEmpty
                                  ? null
                                  : () {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        const SnackBar(
                                          content: Text("Booking Successful"),

                                          backgroundColor: Colors.green,
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
                                "Confirm Booking",

                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
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
