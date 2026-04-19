import 'package:flutter/material.dart';
import 'package:mosahem/core/constants/app_assets.dart';
import 'package:mosahem/core/constants/app_colors.dart';
import 'package:mosahem/core/widgets/custom_text.dart';
import 'package:mosahem/core/widgets/custom_text_field.dart';
import 'package:mosahem/features/admin/home/presentation/views/filter_view.dart';

class AdminHomeView extends StatefulWidget {
  const AdminHomeView({super.key, this.adminUserName = "Mosahem"});
  final String adminUserName;

  @override
  State<AdminHomeView> createState() => _AdminHomeViewState();
}

class _AdminHomeViewState extends State<AdminHomeView> {
  bool isSearching = false;
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        toolbarHeight: 100,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.mustardYellow, width: 3),
              ),
              child: CircleAvatar(
                backgroundColor: AppColors.white,
                radius: 38,
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

            CustomText(
              "Hi, ${widget.adminUserName}...",
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ],
        ),
      ),

      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isSearching = true;
                    });
                  },
                  child: isSearching
                      ? Container(
                          width: 300,
                          height: 50,
                          decoration: BoxDecoration(
                            color: AppColors.primaryLightBlue,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: TextField(
                            controller: searchController,
                            autofocus: true,
                            onSubmitted: (_) {
                              setState(() {
                                isSearching = false;
                              });
                            },
                            decoration: InputDecoration(
                              hintText: "Search",
                              hintStyle: TextStyle(
                                color: AppColors.primary.withAlpha(
                                  (255 * 0.5).toInt(),
                                ),
                              ),
                              border: InputBorder.none,
                              prefixIcon: Image.asset(AppAssets.searchIcon),
                              suffixIcon: IconButton(
                                icon: Icon(Icons.close),
                                onPressed: () {
                                  setState(() {
                                    isSearching = false;
                                    searchController.clear();
                                  });
                                },
                              ),
                            ),
                          ),
                        )
                      : Container(
                          width: 300,
                          height: 50,
                          decoration: BoxDecoration(
                            color: AppColors.primaryLightBlue,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: CustomText(
                                  "Search",
                                  fontSize: 20,
                                  color: AppColors.primary.withAlpha(
                                    (255 * 0.5).toInt(),
                                  ),
                                ),
                              ),
                              SizedBox(width: 190),
                              Image.asset(AppAssets.searchIcon),
                            ],
                          ),
                        ),
                ),

                SizedBox(width: 10),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FilterView()),
                    );
                  },
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: AppColors.primaryLightBlue,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Image.asset(AppAssets.filterIcon),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
