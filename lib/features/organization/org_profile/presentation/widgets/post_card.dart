import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mosahem/core/constants/app_assets.dart';
import 'package:mosahem/core/constants/app_colors.dart';
import 'package:mosahem/core/helpers/date_helper.dart';
import 'package:mosahem/features/organization/org_profile/presentation/widgets/likes_bottom_sheet.dart';
import 'share_bottom_sheet.dart';
import 'comments_bottom_sheet.dart';

class PostCard extends StatelessWidget {
  final String orgName;
  final String orgPhoto;
  final String timeAgo;
  final String postImage;
  final String title;
  final String description;
  final String location;
  final String date;
  final String time;
  final String comments;
  final String likes;

  final bool wantOrgPhoto;
  final bool applyButton;

  final String workType;
  final String timeType;
  final String status;
  final String? orgLogo;

  const PostCard({
    super.key,
    required this.orgName,

    this.wantOrgPhoto = false,
    this.applyButton = true,

    required this.timeAgo,
    required this.postImage,
    required this.title,
    required this.description,
    required this.location,
    required this.date,
    required this.time,
    required this.comments,
    required this.likes,
    this.orgPhoto = "",
    this.workType = "On-Site",
    this.timeType = "Part Time",
    this.status = "Open",
    this.orgLogo,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              wantOrgPhoto && orgPhoto.isNotEmpty
                  ? Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.mustardYellow,
                          width: 2,
                        ),
                      ),
                      child: CircleAvatar(
                        radius: 16,
                        backgroundColor: Colors.transparent,
                        backgroundImage: AssetImage(orgPhoto),
                      ),
                    )
                  : const CircleAvatar(
                      radius: 16,
                      backgroundColor: Colors.grey,
                    ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        orgName,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        DateHelper.format(timeAgo),
                        style: const TextStyle(
                          fontSize: 11,
                          color: Colors.blueGrey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),

                  Row(
                    children: [
                      _buildTag(workType, AppColors.primary),

                      const SizedBox(width: 4),

                      _buildTag(timeType, AppColors.lightGreen),

                      const SizedBox(width: 4),

                      _buildTag(
                        status,
                        AppColors.lightGreen,
                        icon: status == "Open" ? Icons.lock_open : Icons.lock,
                      ),
                    ],
                  ),
                ],
              ),
              const Spacer(),
              SvgPicture.asset(AppAssets.sendIcon),
            ],
          ),

          const SizedBox(height: 10),

          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            // child: Image.asset(
            //   postImage,
            //   height: 170,
            //   width: double.infinity,
            //   fit: BoxFit.cover,
            // ),
            child: postImage.startsWith('http')
                ? Image.network(
                    postImage,
                    height: 170,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) =>
                        Image.asset(AppAssets.postImage),
                  )
                : Image.asset(
                    postImage,
                    height: 170,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
          ),

          const SizedBox(height: 12),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "$title 🌱",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      description,
                      style: const TextStyle(
                        fontSize: 11,
                        color: Color(0xFF53717D),
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Text(
                          "Time: ${DateHelper.format(time)}",
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1B5E78),
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Icon(
                          Icons.access_time,
                          size: 14,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 8),

              Container(
                padding: const EdgeInsets.only(
                  right: 32,
                  left: 32,
                  top: 8,
                  bottom: 8,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFF4F7F8),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSmallInfo(
                      Icons.location_on_rounded,
                      location,
                      Colors.orangeAccent,
                    ),
                    const SizedBox(height: 6),
                    _buildSmallInfo(
                      Icons.calendar_today_rounded,
                      DateHelper.format(date),
                      Colors.green,
                    ),
                    const SizedBox(height: 6),
                    _buildSmallInfo(
                      Icons.access_time,
                      DateHelper.format(time),
                      Colors.redAccent,
                    ),
                    const SizedBox(height: 10),

                    applyButton
                        ? SizedBox(
                            height: 30,
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF1B5E78),
                                shape: const StadiumBorder(),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                ),
                                elevation: 0,
                              ),
                              child: const Row(
                                children: [
                                  Text(
                                    "Apply",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                    ),
                                  ),
                                  SizedBox(width: 4),
                                  Icon(
                                    Icons.arrow_outward,
                                    size: 12,
                                    color: Colors.yellow,
                                  ),
                                ],
                              ),
                            ),
                          )
                        : const SizedBox(),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),
          const Divider(height: 1, thickness: 0.5),
          const SizedBox(height: 8),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    backgroundColor: Colors.transparent,
                    builder: (context) => const ShareBottomSheet(),
                  );
                },
                icon: SvgPicture.asset(
                  AppAssets.shareIcon,
                  height: 18,
                  width: 18,
                ),
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        builder: (context) => const CommentsBottomSheet(),
                      );
                    },
                    icon: SvgPicture.asset(AppAssets.commentIcon),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    comments,
                    style: const TextStyle(
                      color: Colors.orangeAccent,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (context) => LikesBottomSheet(),
                  );
                },
                child: _buildActionItem(Icons.favorite_border, likes),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTag(String text, Color color, {IconData? icon}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withOpacity(1),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color, width: 0.5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 10, color: Colors.white),
            const SizedBox(width: 2),
          ],
          Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 8,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSmallInfo(IconData icon, String text, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 12, color: color),
        const SizedBox(width: 4),
        Text(
          text,
          style: const TextStyle(
            fontSize: 9,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1B5E78),
          ),
        ),
      ],
    );
  }

  Widget _buildActionItem(IconData icon, String count) {
    return Row(
      children: [
        Icon(icon, color: AppColors.primary, size: 20),
        const SizedBox(width: 6),
        Text(
          count,
          style: const TextStyle(
            color: Colors.orangeAccent,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
