import 'package:flutter/material.dart';
import 'package:mosahem/core/constants/app_colors.dart';

class FollowerCard extends StatelessWidget {
  final String name;
  final String bio;
  final String imageUrl;
  final VoidCallback onDelete;

  const FollowerCard({
    super.key,
    required this.name,
    required this.bio,
    required this.imageUrl,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      child: Row(
        children: [
          CircleAvatar(radius: 30, backgroundImage: NetworkImage(imageUrl)),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(bio, style: const TextStyle(fontSize: 14)),
              ],
            ),
          ),
          SizedBox(
            height: 30,
            child: ElevatedButton(
              onPressed: onDelete,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 15),
                elevation: 0,
              ),
              child: const Text(
                "Delete",
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
