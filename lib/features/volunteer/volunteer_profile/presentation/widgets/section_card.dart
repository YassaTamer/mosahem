import 'package:flutter/material.dart';
import 'package:mosahem/core/constants/app_colors.dart';

class SectionCard extends StatelessWidget {
  final String title;
  final Widget child;
  final bool isVolunteer;

  const SectionCard({
    super.key,
    required this.title,
    required this.child,
    required this.isVolunteer,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
              // IconButton(
              //   onPressed: () {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //         builder: (context) => ProfileEditScreen(),
              //       ),
              //     );
              //   },
              //   icon: Icon(Icons.edit, size: 18, color: AppColors.primary),
              // ),
            ],
          ),
          const SizedBox(height: 2),
          child,
        ],
      ),
    );
  }
}
