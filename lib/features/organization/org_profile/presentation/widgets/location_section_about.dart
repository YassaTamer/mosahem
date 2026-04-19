import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mosahem/core/constants/app_assets.dart';
import 'package:mosahem/core/constants/app_colors.dart';
import 'package:mosahem/features/organization/org_profile/presentation/views/add_new_location_screen.dart';
import 'package:mosahem/features/organization/org_profile/presentation/views/edit_location_screen.dart';

class LocationsSection extends StatelessWidget {
  final bool showAddIcon; // أيقونة الزائد (Add)
  final bool showEditIcon; // أيقونة القلم (Edit)
  final bool showDeleteIcon; // أيقونة السلة (Delete)

  const LocationsSection({
    super.key,
    this.showAddIcon = true,
    this.showEditIcon = true,
    this.showDeleteIcon = true,
  });

  void _showDeleteDialog(BuildContext context, String locationName) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          "Delete Location",
          style: TextStyle(
            color: AppColors.primary,
            fontWeight: FontWeight.w600,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(AppAssets.waring),
            const SizedBox(height: 10),
            Text("Are you sure you want to delete '$locationName'?"),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel", style: TextStyle(color: Colors.grey)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Deleted Successfully")),
              );
            },
            child: const Text("Confirm", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            if (showAddIcon) const SizedBox(width: 48),

            Expanded(
              child: Center(
                child: const Text(
                  "Locations",
                  style: TextStyle(
                    fontSize: 18,
                    color: AppColors.lightGreen,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            if (showAddIcon)
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddNewLocationScreen(),
                    ),
                  );
                },
                icon: SvgPicture.asset(
                  AppAssets.addNewLocation,
                  width: 22,
                  height: 22,
                ),
              )
            else
              const SizedBox(width: 48),
          ],
        ),
        const SizedBox(height: 15),
        _buildLocationCard(
          context,
          "Cairo, Nasr City",
          "Abbas El Akkad Street",
        ),
        _buildLocationCard(context, "Sohag, Sohag city", "Elzhra Street"),
      ],
    );
  }

  Widget _buildLocationCard(
    BuildContext context,
    String title,
    String subtitle,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.primary, width: 1.5),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(color: Colors.black87, fontSize: 12),
                ),
              ],
            ),
          ),

          if (showDeleteIcon)
            IconButton(
              onPressed: () => _showDeleteDialog(context, title),
              icon: Image.asset(AppAssets.removeTrashIcon),
            ),
          if (showEditIcon)
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const EditLocationScreen(),
                  ),
                );
              },
              icon: SvgPicture.asset(AppAssets.editPen, width: 18, height: 18),
            ),
        ],
      ),
    );
  }
}
