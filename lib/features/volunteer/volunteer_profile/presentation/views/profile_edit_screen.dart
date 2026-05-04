import 'package:flutter/material.dart';
import 'package:mosahem/core/constants/app_assets.dart';
import 'package:mosahem/core/constants/app_colors.dart';
import 'package:mosahem/features/organization/org_profile/presentation/views/edit_location_screen.dart';

class ProfileEditScreen extends StatefulWidget {
  const ProfileEditScreen({super.key});

  @override
  State<ProfileEditScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<ProfileEditScreen> {
  // الحقول الابتدائية
  final nameController = TextEditingController(text: "Yassa Shahat");
  final phoneController = TextEditingController(text: "010123456789");
  final nidController = TextEditingController(text: "30105069485348");

  String dateOfBirth = "25/9/2004";
  String location = "Sohag - Akhmim";
  bool isMale = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Edit Profile",
          style: TextStyle(
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 30), // مسافة من فوق
            // صورة الحساب الشخصي (Profile Photo) فقط
            Center(
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: CircleAvatar(
                      radius: 55,
                      backgroundColor: Colors.grey.shade200,
                      backgroundImage: AssetImage(
                        AppAssets.postImage,
                      ), // استبدلها بصورة اليوزر الحقيقية
                    ),
                  ),

                  // زرار تعديل صورة البروفايل
                  GestureDetector(
                    onTap: () {
                      // منطق اختيار الصورة من المعرض هنا
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      child: const Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),

            // قسم البيانات
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTextField(
                    "Full Name",
                    Icons.person_outline,
                    nameController,
                  ),
                  const SizedBox(height: 16),

                  _buildTextField(
                    "Phone Number",
                    Icons.phone_outlined,
                    phoneController,
                    isPhone: true,
                  ),
                  const SizedBox(height: 16),

                  _buildTextField(
                    "National ID",
                    Icons.badge_outlined,
                    nidController,
                    isNumber: true,
                  ),
                  const SizedBox(height: 16),

                  _buildActionField(
                    "Date of Birth",
                    Icons.calendar_today_outlined,
                    dateOfBirth,
                    () async {
                      DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime.now(),
                      );
                      if (picked != null) {
                        setState(() {
                          dateOfBirth =
                              "${picked.day}/${picked.month}/${picked.year}";
                        });
                      }
                    },
                  ),
                  const SizedBox(height: 16),

                  _buildActionField(
                    "Location",
                    Icons.location_on_outlined,
                    location,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const EditLocationScreen(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 20),

                  // نوع الجنس (Gender)
                  const Text(
                    "Gender",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 10),
                  _buildGenderToggle(),

                  const SizedBox(height: 40),

                  // زرار Save
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF34D399), // أخضر
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 0,
                      ),
                      onPressed: () {
                        // لوجيك الحفظ هنا
                        Navigator.pop(context);
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
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // دالة مساعدة لرسم الـ TextFields
  Widget _buildTextField(
    String label,
    IconData icon,
    TextEditingController controller, {
    bool isPhone = false,
    bool isNumber = false,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: isPhone
          ? TextInputType.phone
          : (isNumber ? TextInputType.number : TextInputType.name),
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: AppColors.primary),
        filled: true,
        fillColor: Colors.grey.shade50,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
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
      ),
    );
  }

  // دالة مساعدة للحقول اللي بتنضغط (تاريخ، موقع)
  Widget _buildActionField(
    String label,
    IconData icon,
    String value,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          children: [
            Icon(icon, color: AppColors.primary),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const Spacer(),
            const Icon(Icons.chevron_right, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  // دالة اختيار الجنس
  Widget _buildGenderToggle() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => isMale = true),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: isMale ? AppColors.primary : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  "Male",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: isMale ? Colors.white : Colors.grey.shade600,
                    fontWeight: isMale ? FontWeight.bold : FontWeight.w500,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => isMale = false),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: !isMale ? AppColors.primary : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  "Female",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: !isMale ? Colors.white : Colors.grey.shade600,
                    fontWeight: !isMale ? FontWeight.bold : FontWeight.w500,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
