import 'package:flutter/material.dart';
import 'package:mosahem/core/constants/app_assets.dart';
import 'package:mosahem/core/constants/app_colors.dart';
import 'package:mosahem/core/widgets/app_snackbar.dart';
import 'package:mosahem/features/organization/org_profile/presentation/views/add_tracks_screen.dart';

class TracksSection extends StatefulWidget {
  final bool showAddIcon;
  final bool showRemoveIcon;

  const TracksSection({
    super.key,
    this.showAddIcon = true,
    this.showRemoveIcon = true,
  });

  @override
  State<TracksSection> createState() => _TracksSectionState();
}

class _TracksSectionState extends State<TracksSection> {
  // اللستة بتاعت التراكس
  List<String> selectedTracks = [
    "Education",
    "Arts & Culture",
    "Digital Marketing",
    "Community Service",
    "Special Needs Support",
  ];

  void _confirmDelete(String trackTitle) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: const Text(
            "Confirm Delete",
            style: TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text("Are you sure you want to delete '$trackTitle'?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text("Cancel", style: TextStyle(color: Colors.grey)),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);

                setState(() {
                  selectedTracks.remove(trackTitle);
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
                      message: "Track '$trackTitle' deleted successfully",
                    ),
                  ),
                );
              },
              child: const Text("Delete", style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            if (widget.showAddIcon) const SizedBox(width: 48),
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

            // ---- التعديل هنا ----
            // خلينا الزرار ده يستنى النتيجة اللي راجعة من الـ AddTracksScreen
            if (widget.showAddIcon)
              IconButton(
                onPressed: () async {
                  final newTrack = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddTracksScreen(),
                    ),
                  );

                  // لو رجعنا بـ Track جديد ومكنش موجود قبل كدا، هنضيفه
                  if (newTrack != null &&
                      newTrack is String &&
                      newTrack.isNotEmpty) {
                    if (!selectedTracks.contains(newTrack)) {
                      setState(() {
                        selectedTracks.add(newTrack);
                      });
                    }
                  }
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
        if (widget.showRemoveIcon) ...[
          const SizedBox(width: 4),
          GestureDetector(
            onTap: () {
              _confirmDelete(title);
            },
            child: Image.asset(AppAssets.removeTrashIcon, width: 20),
          ),
        ],
      ],
    );
  }
}
