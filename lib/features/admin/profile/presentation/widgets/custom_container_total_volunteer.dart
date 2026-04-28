import 'package:flutter/material.dart';
import 'package:mosahem/core/constants/app_assets.dart';
import 'package:mosahem/core/constants/app_colors.dart';
import 'package:mosahem/core/widgets/custom_button.dart';
import 'package:mosahem/core/widgets/custom_text.dart';

class CustomContainerTotalVolunteer extends StatelessWidget {
  const CustomContainerTotalVolunteer({
    super.key,
    required this.onDelete,
    required this.volunteerName,
    required this.bio,
    required this.profilePhoto,
  });

  final String volunteerName;
  final VoidCallback onDelete;
  final String bio;
  final String profilePhoto;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 15),
      child: Container(
        decoration: BoxDecoration(color: AppColors.white),
        child: Row(
          children: [
            // *** Profile photo of Admin ***
            CircleAvatar(
              backgroundColor: AppColors.white,
              radius: 34,
              child: ClipOval(
                child: profilePhoto.startsWith('http')
                    ? Image.network(
                        profilePhoto,
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                        errorBuilder: (_, _, _) => Image.asset(
                          AppAssets.profilePhotoIcon,
                          width: 60,
                          height: 60,
                        ),
                      )
                    : Image.asset(
                        profilePhoto,
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
              ),
            ),
            SizedBox(width: 10),

            //*** Name of the Admin account ***
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  volunteerName,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                CustomText(bio, fontSize: 12),
              ],
            ),

            const Spacer(),

            //*** Delete Button ***
            CustomButton(
              text: "Delete",
              fontSize: 15,
              fontColor: AppColors.white,
              width: 80,
              height: 40,
              color: AppColors.red,
              onTap: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}
