import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:mosahem/core/constants/app_assets.dart';
import 'package:mosahem/core/constants/app_colors.dart';
import 'package:mosahem/core/widgets/custom_button.dart';
import 'package:mosahem/core/widgets/custom_text.dart';

class SelectTracksView extends StatefulWidget {
  const SelectTracksView({super.key});

  @override
  State<SelectTracksView> createState() => _SelectTracksViewState();
}

class _SelectTracksViewState extends State<SelectTracksView> {
  final List<String> tracks = [
    'Education',
    'Healthcare',
    'Sports',
    'Environment',
    'Technology',
    'Child Care',
    'Community Service',
    'Arts & Culture',
    'Women Empowerment',
    'Youth Development',
    'IT Support',
    'Human Rights',
    'Special Needs Support',
    'Animal Welfare',
    'Career Development',
    'Digital Marketing',
    'Graphic Design',
    'Social Media Management',
    'Content Creation',
    'Data Entry',
  ];

  final List<String> selectedTracks = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, size: 32),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: SvgPicture.asset(AppAssets.splashLogo, width: 36),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                'Select Tracks',
                color: AppColors.primary,
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
              Gap(6),
              CustomText(
                'Please select the volunteer tracks your orgnization.',
                color: Color(0xff072132),
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
              Gap(12),
              Divider(color: AppColors.greyLight, thickness: 1.2),
              Wrap(
                spacing: 10,
                runSpacing: 7,
                children: List.generate(tracks.length, (index) {
                  final bool isSelected = selectedTracks.contains(
                    tracks[index],
                  );
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        if (selectedTracks.contains(tracks[index])) {
                          selectedTracks.remove(tracks[index]);
                        } else {
                          selectedTracks.add(tracks[index]);
                        }
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.primaryDark
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.primaryDark),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8.0,
                          vertical: 2,
                        ),
                        child: CustomText(
                          tracks[index],
                          color: isSelected
                              ? AppColors.white
                              : AppColors.primaryDark,
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
        child: Row(
          children: [
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => SelectTracksView()),
                );
              },
              child: const CustomText(
                'Skip',
                color: Color(0xffD8B50C),
                fontSize: 18,
              ),
            ),
            const Gap(12),
            Expanded(
              child: CustomButton(
                text: 'Continue',
                color: AppColors.primaryDark,

                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => SelectTracksView()),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
