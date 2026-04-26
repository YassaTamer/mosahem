import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mosahem/core/constants/user_role.dart';
import 'package:mosahem/features/admin/home/presentation/views/admin_home_view.dart';
import 'package:mosahem/features/admin/profile/presentation/views/profile_view.dart';
import 'package:mosahem/features/layout/logic/cubit/layout_cubit.dart';
import 'package:mosahem/features/organization/createOpp/presentation/views/create_opp_view.dart';
import 'package:mosahem/features/organization/home/presentation/views/org_home_view.dart';
import 'package:mosahem/features/organization/org_profile/presentation/views/home_screen.dart';
import 'package:mosahem/features/organization/org_profile/presentation/views/org_profile_screen.dart';
import 'package:mosahem/features/volunteer/home/presentation/views/volunteer_home_view.dart';
import 'package:mosahem/features/volunteer/volunteer_profile/presentation/views/profile_screen.dart';

class MainLayoutView extends StatelessWidget {
  final UserRole role;

  const MainLayoutView({super.key, required this.role});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LayoutCubit(),
      child: BlocBuilder<LayoutCubit, LayoutState>(
        builder: (context, state) {
          return Scaffold(
            body: _getScreens()[state.currentIndex],
            bottomNavigationBar: _buildCustomBottomBar(
              context,
              state.currentIndex,
            ),
          );
        },
      ),
    );
  }

  Widget _buildCustomBottomBar(BuildContext context, int currentIndex) {
    // final items = _getNavItems();
    return Container(
      height: 75,
      decoration: const BoxDecoration(
        color: Color(0xFF072132),
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(context, 0, currentIndex),

          if (role == UserRole.organization) _buildAddButton(context),

          _buildNavItem(context, 1, currentIndex),
        ],
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, int index, int currentIndex) {
    final item = _getNavItems()[index];
    final isSelected = index == currentIndex;

    return GestureDetector(
      onTap: () {
        context.read<LayoutCubit>().changeTab(index);
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: isSelected
            ? BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFFFFC107), width: 2),
              )
            : null,
        child: Icon(
          (item.icon as Icon).icon,
          size: 26,
          color: isSelected ? const Color(0xFF072132) : Colors.white,
        ),
      ),
    );
  }

  Widget _buildAddButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => CreateOppView()),
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          shape: BoxShape.rectangle,
          //border: Border.all(color: const Color(0xFFFFC107), width: 2),
        ),
        child: const Icon(Icons.add, size: 32, color: Color(0xFF072132)),
      ),
    );
  }

  List<Widget> _getScreens() {
    if (role == UserRole.admin) {
      return const [AdminProfileView(), AdminHomeView()];
    } else if (role == UserRole.organization) {
      return const [
        HomeScreen(),
        OrgHomeView(),
        //  OrgProfileScreen(), => puplic
        //  PrivateOrgProfileScreen(data: '',),
        //  Center(child: Text("Organization Chat")),
        // Center(child: Text("Organization Notifications")),
        // Center(child: Text("Organization Profile")),
      ];
    } else {
      return const [
        ProfileScreen(),
        VolunteerHomeView(),
        //Center(child: Text("Volunteer Home")),
        // Center(child: Text("Volunteer Activities")),
      ];
    }
  }

  List<BottomNavigationBarItem> _getNavItems() {
    if (role == UserRole.admin) {
      return const [
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle),
          label: "Profile",
        ),
        BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: "Home"),
        //  BottomNavigationBarItem(icon: Icon(Icons.people), label: "Users"),
      ];
    } else if (role == UserRole.organization) {
      return const [
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          label: "Profile",
        ),
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
      ];
    } else {
      return const [
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle),
          label: "Profile",
        ),
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
      ];
    }
  }
}
