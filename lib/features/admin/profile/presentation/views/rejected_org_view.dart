import 'package:flutter/material.dart';
import 'package:mosahem/core/constants/app_colors.dart';
import 'package:mosahem/core/widgets/custom_text.dart';
import 'package:mosahem/features/admin/profile/presentation/views/reason_of_rejection_view.dart';

class RejectedOrgView extends StatelessWidget {
  const RejectedOrgView({
    super.key,
    required this.orgLogo,
    required this.orgName,
  });
  final String orgLogo;
  final String orgName;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.red, width: 1),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppColors.googleButton.withAlpha((255 * 0.5).toInt()),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: AppColors.white,
                    radius: 34,
                    child: ClipOval(
                      child: orgLogo.startsWith('http')
                          ? Image.network(
                              orgLogo,
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Image.asset(
                                  'assets/images/org_logo.png', // fallback
                                  width: 80,
                                  height: 80,
                                );
                              },
                            )
                          : Image.asset(
                              orgLogo,
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          orgName,
                          fontSize: 18,
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ReasonOfRejectionView(),
                    ),
                  );
                },
                child: CustomText(
                  "Reason of Rejection",
                  color: AppColors.red,
                  underline: true,
                  decorationColor: AppColors.red,
                  decorationThickness: 2,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
