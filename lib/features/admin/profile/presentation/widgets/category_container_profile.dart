import 'package:flutter/material.dart';
import 'package:mosahem/core/constants/app_colors.dart';
import 'package:mosahem/core/widgets/custom_button.dart';
import 'package:mosahem/core/widgets/custom_text.dart';

class CategoryContainerProfile extends StatelessWidget {
  const CategoryContainerProfile({
    super.key,
    this.recentButtonName,
    this.navigationRecentPage,
    this.recentButton = true,
    this.recentPage = true,
    this.leftPaddingImage = 0,
    required this.containerName,
    required this.containerNumber,
    required this.totalButtonName,
    required this.containerImage,
    required this.navigationTotalPage,
  });
  final String containerName;
  final int containerNumber;
  final String totalButtonName;
  final bool recentButton;
  final bool recentPage;
  final String? recentButtonName;
  final String containerImage;
  final double leftPaddingImage;
  final Widget navigationTotalPage;
  final Widget? navigationRecentPage;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(7),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.primaryDark, width: 1),
          color: AppColors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                //*** container name & number ***
                Row(
                  children: [
                    CustomText(
                      containerName,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(width: 10),
                    CustomText(
                      containerNumber.toString(),
                      color: AppColors.lightGreen,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),

                SizedBox(height: 60),

                //*** total and recent buttons ***
                Row(
                  children: [
                    CustomButton(
                      text: totalButtonName,
                      fontColor: AppColors.primary,
                      width: 130,
                      height: 40,
                      color: AppColors.yellowButton,
                      fontSize: 12,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => navigationTotalPage,
                          ),
                        );
                      },
                    ),
                    SizedBox(width: 5),
                    if (recentPage == true &&
                        recentButton == true &&
                        recentButtonName != null &&
                        navigationRecentPage != null)
                      CustomButton(
                        text: recentButtonName!,
                        fontColor: AppColors.primary,
                        width: 135,
                        height: 40,
                        fontSize: 12,
                        color: AppColors.yellowButton,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => navigationRecentPage!,
                            ),
                          );
                        },
                      ),
                  ],
                ),
              ],
            ),

            //*** image ***
            Spacer(),
            Padding(
              padding: EdgeInsets.only(bottom: 30, left: leftPaddingImage),
              child: SizedBox(
                child: Image.asset(containerImage, width: 60, height: 60),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
