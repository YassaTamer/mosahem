import 'package:flutter/material.dart';
import 'package:mosahem/core/constants/app_colors.dart';
// تأكد من مسار الـ AppSnackBar
import 'package:mosahem/core/widgets/app_snackbar.dart';

class ProfileForm extends StatefulWidget {
  const ProfileForm({super.key});

  @override
  State<ProfileForm> createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm> {
  final formKey = GlobalKey<FormState>();

  // إضافة Controllers لسهولة التعامل مع البيانات لو حبيت
  final _nameController = TextEditingController();
  final _bioController = TextEditingController();
  final _aboutController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _bioController.dispose();
    _aboutController.dispose();
    super.dispose();
  }

  // دالة مساعدة لعمل تصميم موحد للحقول
  InputDecoration _buildInputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon, color: AppColors.primary),
      filled: true,
      fillColor: Colors.grey.shade50,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.primary, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.red),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          // حقل الاسم
          TextFormField(
            controller: _nameController,
            decoration: _buildInputDecoration(
              "Organization Name",
              Icons.business,
            ),
            validator: (v) {
              if (v == null || v.trim().isEmpty) {
                return "Please enter the organization name";
              }
              return null;
            },
          ),
          const SizedBox(height: 20),

          // حقل الـ Bio
          TextFormField(
            controller: _bioController,
            decoration: _buildInputDecoration(
              "Bio / Slogan",
              Icons.info_outline,
            ),
            validator: (v) {
              if (v == null || v.trim().isEmpty) {
                return "Please enter a short bio";
              }
              return null;
            },
          ),
          const SizedBox(height: 20),

          // حقل About & Location
          TextFormField(
            controller: _aboutController,
            maxLines: 3,
            decoration: _buildInputDecoration(
              "About us & Location & Tracks",
              Icons.description_outlined,
            ),
            validator: (v) {
              if (v == null || v.trim().isEmpty) {
                return "Please provide some details";
              }
              return null;
            },
          ),

          const SizedBox(height: 40),

          // زرار الحفظ
          SizedBox(
            width: double.infinity,
            height: 55,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(
                  0xFF34D399,
                ), // لون أخضر مناسب للـ Save
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 2,
              ),
              onPressed: () {
                // لو البيانات كلها صح (Validate)
                if (formKey.currentState!.validate()) {
                  // إظهار الـ SnackBar بتاعك
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor:
                          Colors.transparent, // شفاف عشان الديزاين بتاعك يبان
                      elevation: 0,
                      behavior: SnackBarBehavior.floating,
                      padding: const EdgeInsets.only(
                        bottom: 20,
                        left: 20,
                        right: 20,
                      ),
                      content: AppSnackBar(
                        message: "Profile Updated Successfully!",
                        color: AppColors.lightGreen,
                        // color: const Color(
                        //   0xFF34D399,
                        // ), // لون أخضر بدل الأحمر لأنه نجاح
                        icon: Icons
                            .check_circle_outline, // أيقونة نجاح بدل الـ Error
                      ),
                    ),
                  );

                  // هنا ممكن تعمل Navigator.pop(context); لو حابب تقفل الشاشة بعد الحفظ
                }
              },
              child: const Text(
                "Save Changes",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
