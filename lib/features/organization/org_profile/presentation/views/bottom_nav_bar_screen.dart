
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mosahem/core/constants/app_assets.dart';
import 'package:mosahem/core/constants/app_colors.dart';
import 'package:mosahem/features/organization/org_profile/presentation/views/home_screen.dart';

class BottomNavBarScreen extends StatefulWidget {
  const BottomNavBarScreen({super.key});

  @override
  State<BottomNavBarScreen> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<BottomNavBarScreen> {
  int currentIndex = 0;

  final screens = [
    HomeScreen(),
    HomeScreen(),
    HomeScreen(),
    HomeScreen(),
    HomeScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],

      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppColors.textDark,

        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },

        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(AppAssets.profileOrg),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(AppAssets.messegasIcon),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(AppAssets.addPostIcon),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(AppAssets.notificationIcon),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(AppAssets.homeIcon),
            label: "",
          ),
        ],
      ),
    );
  }
}
