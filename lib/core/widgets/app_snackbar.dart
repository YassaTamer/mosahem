import 'dart:ui';
import 'package:flutter/material.dart';

class AppSnackBar extends StatelessWidget {
  final String message;
  final Color color;
  final IconData icon;

  const AppSnackBar({
    super.key,
    required this.message,
    this.color = const Color(0xffE53935),
    this.icon = Icons.error_rounded,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(22),

      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),

        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),

          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [color.withOpacity(.9), color],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),

            borderRadius: BorderRadius.circular(22),

            border: Border.all(color: Colors.white.withOpacity(.25)),

            boxShadow: [
              BoxShadow(
                color: color.withOpacity(.4),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),

          child: Row(
            children: [
              /// ICON CONTAINER
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.white.withOpacity(.35),
                      Colors.white.withOpacity(.15),
                    ],
                  ),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: Colors.white, size: 22),
              ),

              const SizedBox(width: 14),

              /// MESSAGE
              Expanded(
                child: Text(
                  message,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    height: 1,
                  ),
                ),
              ),

              const SizedBox(width: 8),

              /// CLOSE BUTTON
              GestureDetector(
                onTap: () {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                },
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(.2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.close, size: 16, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
