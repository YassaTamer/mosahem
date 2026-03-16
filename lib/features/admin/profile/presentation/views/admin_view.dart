import 'package:flutter/material.dart';
import 'package:mosahem/core/constants/app_assets.dart';
import 'package:mosahem/core/constants/app_colors.dart';
import 'package:mosahem/core/widgets/custom_text.dart';
import 'package:mosahem/features/admin/profile/presentation/views/add_new_admin_view.dart';
import 'package:mosahem/features/admin/profile/presentation/widgets/custom_container_admin_widget.dart';

class AdminView extends StatefulWidget {
  const AdminView({super.key});

  @override
  State<AdminView> createState() => _AdminViewState();
}

class _AdminViewState extends State<AdminView> {
  List<String> admins = [
    "Betty Bassem",
    "Yassa Shahat",
    "Mario Nabil",
    "Margret Mikhael",
    "Steven Nabil",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.primaryLightBlue,
        title: CustomText(
          'Admin',
          fontWeight: FontWeight.bold,
          color: AppColors.primary,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddNewAdminView()),
                );
              },
              icon: Image.asset(
                AppAssets.addNewAdminIcon,
                width: 40,
                height: 40,
              ),
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: admins.length,
        itemBuilder: (context, index) {
          return CustomContainerAdmin(
            adminName: admins[index],
            onDelete: () {
              setState(() {
                admins.removeAt(index);
              });
            },
          );
        },
      ),
    );
  }
}
