import 'package:flutter/material.dart';
import 'package:mosahem/core/constants/app_colors.dart';

class ApplicantCard extends StatelessWidget {
  // المتغيرات الـ final اللي طلبتها
  final String applicantName;
  final String jobTitle;
  final String dateText;
  final String userImageUrl;
  final String rejectedBtnText;
  final String acceptedBtnText;
  final VoidCallback onReject;
  final VoidCallback onAccept;

  const ApplicantCard({
    super.key,
    this.applicantName = "Wade Warren",
    this.jobTitle = "Beach Cleanup",
    this.dateText = "12/12/2025",
    this.userImageUrl = 'https://via.placeholder.com/150',
    this.rejectedBtnText = "Rejected",
    this.acceptedBtnText = "Accepted",
    required this.onReject,
    required this.onAccept,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(radius: 30, backgroundImage: NetworkImage(userImageUrl)),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  applicantName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(jobTitle, style: const TextStyle(fontSize: 14)),
                Text(dateText, style: const TextStyle(fontSize: 12)),
                const SizedBox(height: 12),
                Row(
                  children: [
                    _buildActionBtn(rejectedBtnText, AppColors.red, onReject),
                    const SizedBox(width: 10),
                    _buildActionBtn(
                      acceptedBtnText,
                      AppColors.lightGreen,
                      onAccept,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionBtn(String text, Color color, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 30,
        width: 135,
        padding: const EdgeInsets.symmetric(horizontal: 37, vertical: 4),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}
