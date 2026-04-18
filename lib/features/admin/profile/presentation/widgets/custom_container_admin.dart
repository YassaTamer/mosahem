import 'package:flutter/material.dart';
import 'package:mosahem/core/constants/app_colors.dart';
import 'package:mosahem/core/widgets/custom_button.dart';
import 'package:mosahem/core/widgets/custom_text.dart';

class CustomContainerAdmin extends StatelessWidget {
  const CustomContainerAdmin({
    super.key,
    required this.adminName,
    required this.onDelete,
  });
  final String adminName;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 15),
      child: Container(
        decoration: BoxDecoration(color: AppColors.white),
        child: Row(
          children: [
            // *** Profile photo of Admin ***
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.mustardYellow, width: 3),
              ),
              child: CircleAvatar(
                backgroundColor: AppColors.white,
                radius: 34,
                child: ClipOval(
                  child: Image.asset(
                    "assets/images/splash_logo.png",
                    width: 100,
                    height: 100,
                  ),
                ),
              ),
            ),
            SizedBox(width: 10),

            //*** Name of the Admin account ***
            CustomText(adminName, fontSize: 18, fontWeight: FontWeight.bold),

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
