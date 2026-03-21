import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mosahem/core/constants/user_role.dart';
import 'package:mosahem/features/layout/logic/cubit/layout_cubit.dart';
import 'package:mosahem/features/organization/createOpp/presentation/views/create_opp_view.dart';

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
    final items = _getNavItems();

    return Container(
      height: 75,
      decoration: const BoxDecoration(
        color: Color(0xFF072132),
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          for (int i = 0; i < items.length; i++) ...[
            if (role == UserRole.organization && i == 2)
              _buildAddButton(context),

            _buildNavItem(context, i, currentIndex),
          ],
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
      return const [
        Center(child: Text("Admin Home")),
        Center(child: Text("Admin Users")),
      ];
    } else if (role == UserRole.organization) {
      return const [
        Center(child: Text("Organization Home")),
        Center(child: Text("Organization Chat")),

        Center(child: Text("Organization Notifications")),
        Center(child: Text("Organization Profile")),
      ];
    } else {
      return const [
        Center(child: Text("Volunteer Home")),
        Center(child: Text("Volunteer Activities")),
      ];
    }
  }

  List<BottomNavigationBarItem> _getNavItems() {
    if (role == UserRole.admin) {
      return const [
        BottomNavigationBarItem(
          icon: Icon(Icons.dashboard),
          label: "Dashboard",
        ),
        BottomNavigationBarItem(icon: Icon(Icons.people), label: "Users"),
      ];
    } else if (role == UserRole.organization) {
      return const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(
          icon: Icon(Icons.chat_bubble_outline),
          label: "Chat",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.notifications_none),
          label: "Notifications",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          label: "Profile",
        ),
      ];
    } else {
      return const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(
          icon: Icon(Icons.volunteer_activism),
          label: "Activities",
        ),
      ];
    }
  }
}
