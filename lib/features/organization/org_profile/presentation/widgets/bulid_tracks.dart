import 'package:flutter/material.dart';

Widget bulidTracks(String label) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    decoration: BoxDecoration(
      border: Border.all(color: const Color(0xFF1B4D7E), width: 1),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Text(
      label,
      style: const TextStyle(color: Color(0xFF1B4D7E), fontSize: 12),
    ),
  );
}
