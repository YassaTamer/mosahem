import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mosahem/core/constants/app_assets.dart';
import 'package:mosahem/core/constants/app_colors.dart';
// تأكد من مسار الـ AppSnackBar
import 'package:mosahem/core/widgets/app_snackbar.dart';
import 'package:mosahem/features/organization/org_profile/presentation/views/add_new_location_screen.dart';
import 'package:mosahem/features/organization/org_profile/presentation/views/edit_location_screen.dart';

class LocationsSection extends StatefulWidget {
  final bool showAddIcon;
  final bool showEditIcon;
  final bool showDeleteIcon;

  const LocationsSection({
    super.key,
    this.showAddIcon = true,
    this.showEditIcon = true,
    this.showDeleteIcon = true,
  });

  @override
  State<LocationsSection> createState() => _LocationsSectionState();
}

class _LocationsSectionState extends State<LocationsSection> {
  // اللستة اللي هيتضاف فيها العناوين
  List<Map<String, String>> locations = [
    {"title": "Cairo, Nasr City", "subtitle": "Abbas El Akkad Street"},
    {"title": "Sohag, Sohag city", "subtitle": "Elzhra Street"},
  ];

  void _showDeleteDialog(BuildContext context, Map<String, String> location) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
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
            Text("Are you sure you want to delete '${location['title']}'?"),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text("Cancel", style: TextStyle(color: Colors.grey)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);

              setState(() {
                locations.remove(location);
              });

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  behavior: SnackBarBehavior.floating,
                  padding: const EdgeInsets.only(
                    bottom: 20,
                    left: 20,
                    right: 20,
                  ),
                  content: AppSnackBar(
                    message:
                        "Location '${location['title']}' deleted successfully",
                  ),
                ),
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
            if (widget.showAddIcon) const SizedBox(width: 48),

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

            // ---- التعديل الأساسي هنا ----
            // زرار الإضافة اللي فوق هو اللي بيستنى الداتا
            if (widget.showAddIcon)
              IconButton(
                onPressed: () async {
                  // استدعاء شاشة الإضافة أو التعديل (على حسب المسمى عندك)
                  final newLocation = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const EditLocationScreen(),
                    ),
                  );

                  // لو الداتا رجعت، نضيفها في اللستة
                  if (newLocation != null &&
                      newLocation is Map<String, String>) {
                    setState(() {
                      locations.add(newLocation);
                    });
                  }
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

        // عرض العناوين من اللستة
        ...locations.map((loc) => _buildLocationCard(context, loc)).toList(),
      ],
    );
  }

  Widget _buildLocationCard(
    BuildContext context,
    Map<String, String> location,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            spreadRadius: 1,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(color: AppColors.primary.withOpacity(0.1)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  location['title']!,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  location['subtitle']!,
                  style: const TextStyle(color: Colors.black87, fontSize: 13),
                ),
              ],
            ),
          ),

          // ---- إرجاع زراير الحذف والتعديل مكانهم الصحيح ----
          if (widget.showDeleteIcon)
            IconButton(
              onPressed: () => _showDeleteDialog(context, location),
              icon: Image.asset(AppAssets.removeTrashIcon, width: 22),
            ),

          if (widget.showEditIcon)
            IconButton(
              onPressed: () {
                // هنا بتفتح شاشة التعديل للوكيشن موجود بالفعل
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const EditLocationScreen(),
                  ),
                );
              },
              icon: SvgPicture.asset(AppAssets.editPen, width: 20, height: 20),
            ),
        ],
      ),
    );
  }
}
