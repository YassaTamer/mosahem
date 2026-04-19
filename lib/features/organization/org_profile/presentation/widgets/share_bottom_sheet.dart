import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mosahem/core/constants/app_assets.dart';

class ShareBottomSheet extends StatelessWidget {
  const ShareBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: const BoxDecoration(
        color: Color(0xFFF8FAFB),
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(width: 40),
              const Text(
                "Share",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close),
              ),
            ],
          ),

          const SizedBox(height: 20),

          Wrap(
            spacing: 20,
            runSpacing: 20,
            children: [
              // شيلنا الـ const من هنا
              ShareItem(
                label: "Copy Link",
                icon: AppAssets.copyLink, // مفيش const هنا
              ),
              ShareItem(label: "WhatsApp", icon: AppAssets.whatsApp),
              ShareItem(label: "Telegram", icon: AppAssets.telegram),
              ShareItem(label: "Messenger", icon: AppAssets.massenger),
              ShareItem(label: "Facebook", icon: AppAssets.facebook),
            ],
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}

class ShareItem extends StatelessWidget {
  final String label;
  final dynamic icon;

  const ShareItem({super.key, required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 75, // زودنا العرض شوية عشان النص لو طويل
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: const Color(0xFFF5F5F5), // لون خلفية خفيف زي فيجما
            child: _buildIcon(),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIcon() {
    if (icon is String) {
      return SvgPicture.asset(icon, width: 24, height: 24);
    } else if (icon is IconData) {
      return Icon(icon, color: Colors.blue, size: 24);
    }
    return const SizedBox();
  }
}
