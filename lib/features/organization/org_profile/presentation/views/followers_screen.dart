import 'package:flutter/material.dart';
import 'package:mosahem/core/constants/app_colors.dart';
import 'package:mosahem/features/organization/org_profile/presentation/views/search_screen.dart';
import 'package:mosahem/features/organization/org_profile/presentation/widgets/follower_card.dart';

class FollowersScreen extends StatelessWidget {
  final String screenTitle = "Followers";
  final String countText = "1,5K";

  const FollowersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              screenTitle,
              style: const TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              countText,
              style: const TextStyle(color: Color(0xFFD4AF37), fontSize: 14),
            ),
          ],
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.grey),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SearchScreen()),
              );
            },
          ),
        ],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.only(top: 10),
        itemCount: 10,
        separatorBuilder: (context, index) =>
            const Divider(height: 1, color: Color(0xFFEEEEEE)),
        itemBuilder: (context, index) {
          return FollowerCard(
            name: "Wade Warren",
            bio: "Environmental Volunteer",
            imageUrl:
                "https://images.pexels.com/photos/36444645/pexels-photo-36444645.jpeg",
            onDelete: () {
              print("Delete follower $index");
            },
          );
        },
      ),
    );
  }
}
