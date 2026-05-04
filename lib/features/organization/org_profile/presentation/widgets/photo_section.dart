import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mosahem/core/constants/app_colors.dart';

class PhotoSection extends StatefulWidget {
  const PhotoSection({super.key});

  @override
  State<PhotoSection> createState() => _PhotoSectionState();
}

class _PhotoSectionState extends State<PhotoSection> {
  File? _imageFile; // متغير عشان نشيل فيه الصورة اللي هنختارها
  final ImagePicker _picker = ImagePicker();

  // دالة عشان تفتح المعرض وتختار صورة
  Future<void> _pickImage() async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80, // تقليل الجودة شوية عشان الحجم
      );

      if (pickedFile != null) {
        setState(() {
          _imageFile = File(pickedFile.path); // حفظ الصورة المختارة
        });
      }
    } catch (e) {
      // لو حصل إيرور ممكن تظهر SnackBar هنا
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error picking image: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            // صورة الحساب
            GestureDetector(
              onTap: _pickImage, // لما يدوس على الدائرة نفسها يفتح المعرض
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey.shade200,
                  border: Border.all(
                    color: AppColors.primaryLightBlue,
                    width: 3,
                  ),
                  // لو اليوزر اختار صورة نعرضها، ولو لأ نعرض الأيقونة الرمادي
                  image: _imageFile != null
                      ? DecorationImage(
                          image: FileImage(_imageFile!),
                          fit: BoxFit.cover, // عشان الصورة تملى الدائرة
                        )
                      : null,
                ),
                child: _imageFile == null
                    ? Icon(Icons.person, size: 60, color: Colors.grey.shade400)
                    : null, // لو فيه صورة نشيل الأيقونة
              ),
            ),

            // زرار الكاميرا اللي تحت على اليمين
            GestureDetector(
              onTap: _pickImage, // برضه بيفتح المعرض
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.camera_alt,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        const Text(
          "Change Profile Picture",
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: AppColors.primary,
          ),
        ),
      ],
    );
  }
}
