import 'package:flutter/material.dart';

class PendingCard extends StatelessWidget {
  const PendingCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 20),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(25),
        margin: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: const Color(0xffFFF8E1), // أصفر فاتح
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.orange),
        ),
        child: Column(
          children: [
            const Icon(
              Icons.hourglass_top_rounded,
              color: Colors.orange,
              size: 30,
            ),

            const SizedBox(height: 10),

            const Text(
              "Pending",
              style: TextStyle(
                color: Colors.orange,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 12),

            const Text(
              "We're currently reviewing your organization. This may take a short time.",
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
