import 'package:flutter/material.dart';
import 'package:mosahem/core/constants/app_colors.dart';
// تم الاستغناء عن الـ import بتاع bulid_tracks لأننا عملنا واحد تفاعلي داخل الشاشة
// import 'package:mosahem/features/organization/org_profile/presentation/widgets/bulid_tracks.dart';

class AddTracksScreen extends StatefulWidget {
  const AddTracksScreen({super.key});

  @override
  State<AddTracksScreen> createState() => _AddTracksScreenState();
}

class _AddTracksScreenState extends State<AddTracksScreen> {
  // متغير لحفظ التراك اللي اليوزر اختاره
  String? selectedTrack;

  final List<String> allTracks = [
    "Environment",
    "Youth Development",
    "Animal Welfare",
    "Healthcare",
    "Career Development",
    "Graphic Design",
    "Human Rights",
    "Content Creation",
    "Women Empowerment",
    "Technology",
    "Data Entry",
    "Child Care",
    "ُEducation",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Add New Track",
          style: TextStyle(
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  alignment: WrapAlignment.start,
                  // استخدام الويدجت التفاعلي الجديد
                  children: allTracks
                      .map((track) => _buildTrackChip(track))
                      .toList(),
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF34D399),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                onPressed: () {
                  // ---- التعديل هنا ----
                  // بنعمل Pop ونرجع التراك اللي اليوزر اختاره
                  if (selectedTrack != null) {
                    Navigator.pop(context, selectedTrack);
                  } else {
                    // لو داس حفظ من غير ما يختار حاجة، نرجع عادي من غير داتا
                    Navigator.pop(context);
                  }
                },
                child: const Text(
                  "Save",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ويدجت تفاعلي للـ Track
  Widget _buildTrackChip(String title) {
    bool isSelected =
        selectedTrack == title; // بنشوف هل ده التراك المختار ولا لأ

    return GestureDetector(
      onTap: () {
        setState(() {
          // لو داس على تراك مختاره بالفعل، بيلغي اختياره.. ولو تراك جديد بيختاره
          selectedTrack = isSelected ? null : title;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.grey.shade50,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? AppColors.primary : Colors.grey.shade300,
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black87,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
