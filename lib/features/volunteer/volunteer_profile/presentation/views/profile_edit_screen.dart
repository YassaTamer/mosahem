import 'package:flutter/material.dart';
import 'package:mosahem/core/constants/app_assets.dart';
import 'package:mosahem/features/organization/org_profile/presentation/views/edit_location_screen.dart';
import 'package:mosahem/features/volunteer/volunteer_profile/presentation/views/edit_location_screen_vol.dart';

class ProfileEditScreen extends StatefulWidget {
  const ProfileEditScreen({super.key});

  @override
  State<ProfileEditScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<ProfileEditScreen> {
  final nameController = TextEditingController(text: "Zad Solutions");
  final phoneController = TextEditingController(text: "010123456789");
  final nidController = TextEditingController(text: "30105069485348");

  String dateOfBirth = "15/5/1995";
  String location = "Sohag - Akhmim";
  bool isMale = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // صورة الغلاف
            Stack(
              children: [
                Image(
                  image: AssetImage(AppAssets.postImage),
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  bottom: 10,
                  right: 10,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text("Edit"),
                  ),
                ),
              ],
            ),

            // Container البيانات الأبيض
            Transform.translate(
              offset: const Offset(0, -30),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  children: [
                    // Stack للتحكم في مكان الكاميرا وكلمة Edit
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Column(
                          children: [
                            const CircleAvatar(
                              radius: 40,
                              backgroundColor: Colors.grey,
                              child: Icon(
                                Icons.camera_alt,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 5),
                            const Text(
                              "Edit",
                              style: TextStyle(color: Colors.blue),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    _buildEditableField("Name:", nameController),
                    _buildEditableField("Phone Number:", phoneController),
                    _buildEditableField("National ID :", nidController),

                    _buildPressableField(
                      "Date of Birth:",
                      dateOfBirth,
                      () async {
                        DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime.now(),
                        );
                        if (picked != null)
                          setState(
                            () => dateOfBirth =
                                "${picked.day}/${picked.month}/${picked.year}",
                          );
                      },
                    ),
                    _buildPressableField("Location:", location, () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditLocationScreen(),
                        ),
                      );
                    }),

                    const SizedBox(height: 20),
                    _buildGenderToggle(),
                    const SizedBox(height: 30),

                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        onPressed: () {},
                        child: const Text(
                          "Save edit",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEditableField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: controller,
              decoration: const InputDecoration(
                border: InputBorder.none,
                isDense: true,
              ),
            ),
          ),
          const Icon(Icons.edit, size: 14, color: Colors.grey),
        ],
      ),
    );
  }

  Widget _buildPressableField(String label, String value, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
            Row(
              children: [
                Text(value, style: const TextStyle(color: Colors.black54)),
                const SizedBox(width: 10),
                const Icon(
                  Icons.arrow_forward_ios,
                  size: 14,
                  color: Colors.grey,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGenderToggle() {
    return Row(
      children: [
        const Text(
          "Gender:",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
        ),
        const Spacer(),
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              GestureDetector(
                onTap: () => setState(() => isMale = false),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: !isMale ? Colors.blue : Colors.transparent,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    "Female",
                    style: TextStyle(
                      color: !isMale ? Colors.white : Colors.grey,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => setState(() => isMale = true),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: isMale ? Colors.blue : Colors.transparent,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    "Male",
                    style: TextStyle(
                      color: isMale ? Colors.white : Colors.grey,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
