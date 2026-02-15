import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:mosahem/core/constants/app_assets.dart';
import 'package:mosahem/core/constants/app_colors.dart';
import 'package:mosahem/core/widgets/custom_button.dart';
import 'package:mosahem/core/widgets/custom_text.dart';
import 'package:mosahem/features/auth/presentation/views/add_branch_location_view.dart';

class UploadOrganizationDocumentView extends StatefulWidget {
  const UploadOrganizationDocumentView({super.key});

  @override
  State<UploadOrganizationDocumentView> createState() =>
      _UploadOrganizationDocumentViewState();
}

class _UploadOrganizationDocumentViewState
    extends State<UploadOrganizationDocumentView> {
  PlatformFile? _pickedFile;
  Future<void> _pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'docx', 'doc', 'jpg', 'png'],
      withData: true,
    );

    if (result != null) {
      setState(() {
        _pickedFile = result.files.single;
      });
    }
  }

  bool _isLoading = false;
  String? _uploadError;
  Future<void> _uploadFile() async {
    if (_pickedFile == null) {
      setState(() {
        _uploadError = "Please select a file first";
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _uploadError = null;
    });

    try {
      final dio = Dio();

      final formData = FormData.fromMap({
        "file": MultipartFile.fromBytes(
          _pickedFile!.bytes!,
          filename: _pickedFile!.name,
        ),
        "folderName": "images",
      });

      final response = await dio.post(
        "https://mosahemapi.runasp.net/api/v1/files/upload",
        data: formData,
      );
      print("UPLOAD RESPONSE: ${response.data}");

      final data = response.data;

      if (data["Succeeded"] == false || data["succeeded"] == false) {
        setState(() {
          _uploadError = data["Message"] ?? "Upload failed";
        });
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => AddBranchLocationView()),
        );
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 422) {
        final data = e.response?.data;

        print("422 DATA: $data");

        if (data != null && data["Errors"] != null) {
          final errors = data["Errors"];

          if (errors["File"] != null) {
            setState(() {
              _uploadError = errors["File"].first;
            });
          } else if (errors["FolderName"] != null) {
            setState(() {
              _uploadError = errors["FolderName"].first;
            });
          } else {
            setState(() {
              _uploadError = data["Message"] ?? "Validation error";
            });
          }
        }
      } else {
        setState(() {
          _uploadError = "Something went wrong";
        });
      }
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, size: 32),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: SvgPicture.asset(AppAssets.splashLogo, width: 36),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              Gap(64),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(24),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.primary, width: 1.4),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Gap(12),
                    SvgPicture.asset('assets/logos/upload_icon.svg'),
                    CustomText(
                      'Upload File',
                      color: AppColors.primaryDark,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    CustomText(
                      'PDF,JPG,PNG (50MB Max)',
                      color: AppColors.primary,
                      fontSize: 18,
                    ),
                    Gap(12),
                    SizedBox(
                      width: 160,
                      child: CustomButton(
                        text: 'Browse',
                        height: 32,
                        onTap: _pickFile,
                      ),
                    ),
                  ],
                ),
              ),
              Gap(12),
              if (_pickedFile != null) ...[
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.primary),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.document_scanner_outlined, size: 28),
                        Gap(8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                maxLines: 1,
                                overflow: TextOverflow.clip,
                                _pickedFile!.name,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                              CustomText(
                                '${(_pickedFile!.size / 1024).toStringAsFixed(0)} KB',
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                        ),

                        IconButton(
                          onPressed: () {
                            setState(() {
                              _pickedFile = null;
                            });
                          },
                          icon: Icon(Icons.clear_outlined, color: Colors.red),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
              if (_pickedFile == null)
                CustomText(
                  'Please upload any documentation proving that you are an organization.',
                  fontSize: 16,
                  color: Colors.red,
                ),
              Spacer(),
              Gap(4),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
        child: Row(
          children: [
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => AddBranchLocationView()),
                );
              },
              child: const CustomText(
                'Skip',
                color: Color(0xffD8B50C),
                fontSize: 18,
              ),
            ),
            const Gap(12),
            Expanded(
              child: CustomButton(
                text: _isLoading ? 'Uploading...' : 'Continue',
                color: _pickedFile == null
                    ? AppColors.disabledButton
                    : AppColors.primaryDark,

                onTap: _pickedFile == null || _isLoading ? null : _uploadFile,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
