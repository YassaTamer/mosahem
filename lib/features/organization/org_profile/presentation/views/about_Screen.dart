import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mosahem/core/constants/app_assets.dart';
import 'package:mosahem/core/constants/app_colors.dart';
import 'package:mosahem/features/organization/org_profile/presentation/widgets/location_section_about.dart';
import 'package:mosahem/features/organization/org_profile/presentation/widgets/save_bottom.dart';
import 'package:mosahem/features/organization/org_profile/presentation/widgets/tracks_section_about.dart';

class AboutScreen extends StatefulWidget {
  final PreferredSizeWidget? appBar;

  const AboutScreen({super.key, required this.appBar});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  final TextEditingController _descController = TextEditingController(
    text: "Mosahem is a volunteering platform...",
  );
  final TextEditingController _visionController = TextEditingController(
    text: "We believe that everyone has the ability...",
  );

  bool _isEditingDesc = false;
  bool _isEditingVision = false;

  @override
  void dispose() {
    _descController.dispose();
    _visionController.dispose();
    super.dispose();
  }

  Widget _buildEditableSection({
    required String title,
    required TextEditingController controller,
    required bool isEditing,
    required VoidCallback onEditTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 🔹 Header
        Row(
          children: [
            Icon(
              title == "Our Vision" ? Icons.visibility : Icons.info,
              size: 18,
              color: AppColors.lightGreen,
            ),
            const SizedBox(width: 6),
            Text(
              title,
              style: const TextStyle(
                color: AppColors.lightGreen,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const Spacer(),
            IconButton(
              onPressed: onEditTap,
              icon: Icon(
                isEditing ? Icons.check_circle : Icons.edit,
                color: isEditing ? AppColors.lightGreen : AppColors.primary,
                size: 22,
              ),
            ),
          ],
        ),

        const SizedBox(height: 8),

        // 🔹 Content
        isEditing
            ? TextField(
                controller: controller,
                maxLines: 4,
                style: const TextStyle(fontSize: 14, height: 1.5),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: AppColors.primaryLightBlue,
                  contentPadding: const EdgeInsets.all(14),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide(
                      color: AppColors.primary.withOpacity(0.2),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(
                      color: AppColors.primary,
                      width: 1.5,
                    ),
                  ),
                ),
              )
            : GestureDetector(
                onTap: onEditTap,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: AppColors.primary.withOpacity(0.08),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 12,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.08),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          title == "Our Vision"
                              ? Icons.visibility_outlined
                              : Icons.info_outline,
                          size: 18,
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          controller.text.isEmpty
                              ? "Tap to add $title..."
                              : controller.text,
                          style: TextStyle(
                            fontSize: 14,
                            height: 1.6,
                            color: controller.text.isEmpty
                                ? Colors.grey
                                : Colors.black87,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, size: 32),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: SvgPicture.asset(AppAssets.splashLogo, width: 36),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // About Section
            _buildEditableSection(
              title: "About Organization",
              controller: _descController,
              isEditing: _isEditingDesc,
              onEditTap: () => setState(() => _isEditingDesc = !_isEditingDesc),
            ),
            const SizedBox(height: 20),

            // Vision Section
            _buildEditableSection(
              title: "Our Vision",
              controller: _visionController,
              isEditing: _isEditingVision,
              onEditTap: () =>
                  setState(() => _isEditingVision = !_isEditingVision),
            ),
            const Divider(height: 40),

            // Locations
            const LocationsSection(),
            const Divider(height: 40),

            // Tracks
            const TracksSection(),
            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: SaveButton(
          onTap: () => Navigator.pop(context),
          bottomText: 'Save Edit',
        ),
      ),
    );
  }
}
