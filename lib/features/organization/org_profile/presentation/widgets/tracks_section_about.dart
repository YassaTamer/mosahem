import 'package:flutter/material.dart';
import 'package:mosahem/core/constants/app_assets.dart';
import 'package:mosahem/core/constants/app_colors.dart';
import 'package:mosahem/features/organization/org_profile/presentation/views/add_tracks_screen.dart';

class TracksSection extends StatelessWidget {
  final bool showAddIcon;
  final bool showRemoveIcon;

  const TracksSection({
    super.key,
    this.showAddIcon = true,
    this.showRemoveIcon = true,
  });

  @override
  Widget build(BuildContext context) {
    List<String> selectedTracks = [
      "Education",
      "Arts & Culture",
      "Digital Marketing",
      "Community Service",
      "Special Needs Support",
    ];

    return Column(
      children: [
        Row(
          children: [
            if (showAddIcon) const SizedBox(width: 48),

            const Spacer(),
            const Text(
              "Tracks",
              style: TextStyle(
                fontSize: 18,
                color: AppColors.lightGreen,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),

            if (showAddIcon)
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddTracksScreen(),
                    ),
                  );
                },
                icon: const Icon(Icons.add, color: AppColors.lightGreen),
              )
            else
              const SizedBox(width: 48),
          ],
        ),
        const SizedBox(height: 15),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          alignment: WrapAlignment.center,
          children: selectedTracks
              .map((track) => _buildTrackItem(track))
              .toList(),
        ),
      ],
    );
  }

  Widget _buildTrackItem(String title) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Text(
            title,
            style: const TextStyle(color: Colors.white, fontSize: 13),
          ),
        ),

        if (showRemoveIcon) ...[
          const SizedBox(width: 4),
          GestureDetector(
            onTap: () {},
            child: Image.asset(AppAssets.removeTrashIcon, width: 20),
          ),
        ],
      ],
    );
  }
}
