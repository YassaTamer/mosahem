import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:mosahem/core/constants/app_assets.dart';
import 'package:mosahem/core/constants/app_colors.dart';
import 'package:mosahem/core/widgets/custom_button.dart';
import 'package:mosahem/core/widgets/custom_text.dart';
import 'package:mosahem/features/auth/data/models/track_model.dart';

class SelectTracksView extends StatefulWidget {
  const SelectTracksView({super.key});

  @override
  State<SelectTracksView> createState() => _SelectTracksViewState();
}

class _SelectTracksViewState extends State<SelectTracksView> {
  List<TrackModel> tracks = [];

  List<String> selectedTrackIds = [];

  Future<void> getTracks() async {
    try {
      final response = await Dio().get(
        'https://mosahemapi.runasp.net/api/v1/fields/get-all-fields',
      );
      if (response.statusCode == 200 && response.data['Succeeded'] == true) {
        final List data = response.data['Data'];
        setState(() {
          tracks = data.map((e) => TrackModel.fromJson(e)).toList();
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getTracks();
  }

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
              Expanded(
                child: SingleChildScrollView(
                  child: Wrap(
                    spacing: 10,
                    runSpacing: 7,
                    children: List.generate(tracks.length, (index) {
                      final bool isSelected = selectedTrackIds.contains(
                        tracks[index].id,
                      );

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            if (selectedTrackIds.contains(tracks[index].id)) {
                              selectedTrackIds.remove(tracks[index].id);
                            } else {
                              selectedTrackIds.add(tracks[index].id);
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
                              tracks[index].name,
                              color: isSelected
                                  ? AppColors.white
                                  : AppColors.primaryDark,
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
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
