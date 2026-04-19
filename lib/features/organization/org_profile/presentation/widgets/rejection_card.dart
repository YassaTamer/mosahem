import 'package:flutter/material.dart';

class RejectionCard extends StatelessWidget {
  final String statusMessage;
  final String statusText;

  const RejectionCard({
    super.key,
    required this.statusMessage,
    required this.statusText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 20),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(25),
        margin: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: const Color(0xffFDEDED),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.red),
        ),

        child: Column(
          children: [
            Text(
              statusMessage, //"Reason for rejection"
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 12),

            Text(
              statusText,
              // "Thank you for submitting your organization for verification.\n\n"
              // "After reviewing the provided information and documents, "
              // "we regret to inform you that the verification request has been "
              // "rejected at this time due to unmet requirements.\n\n"
              // "Please ensure that all details are accurate and complete, "
              // "and feel free to reapply after making the necessary updates.\n\n"
              // "Best regards,\nAdmin Team"
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 16),

            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () {},
              child: const Text(
                "Submit again",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
