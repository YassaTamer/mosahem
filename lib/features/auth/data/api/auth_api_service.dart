import 'package:dio/dio.dart';
import 'package:mosahem/features/auth/data/models/branch_location_model.dart';
import 'package:mosahem/features/auth/data/models/login_response_model.dart';
import 'package:mosahem/features/auth/data/models/validation_exception.dart';

class AuthApiService {
  final Dio _dio;

  AuthApiService(this._dio);
  static const String _baseUrl = 'https://mosahemapi.runasp.net/api/v1/auth';

  Future<LoginResponseModel> login({
    required String emailOrPhone,
    required String password,
  }) async {
    try {
      final response = await _dio.post(
        '$_baseUrl/login',
        data: {'emailOrPhone': emailOrPhone, 'password': password},
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      print("📩 FULL LOGIN RESPONSE: ${response.data}");

      final data = response.data;

      if (data['Succeeded'] == true) {
        return LoginResponseModel.fromJson(data);
      } else {
        throw Exception(data['Message'] ?? 'Login failed');
      }
    } on DioException catch (e) {
      // print("❌ DIO LOGIN ERROR: ${e.response?.data}");

      final responseData = e.response?.data;

      if (responseData is Map) {
        if (responseData['Errors'] != null &&
            responseData['Errors'] is Map &&
            (responseData['Errors'] as Map).isNotEmpty) {
          final errorsMap = responseData['Errors'] as Map;
          final firstErrorList = errorsMap.values.first;

          if (firstErrorList is List && firstErrorList.isNotEmpty) {
            throw Exception(firstErrorList.first);
          }
        }

        if (responseData['Message'] != null) {
          throw Exception(responseData['Message']);
        }
      }

      throw Exception('Network error');
    }
  }

  Future<void> registerOrganization({
    required String organizationName,
    required String email,
    required String phoneNumber,
    required String password,
    required String confirmPassword,
    required List<String> fieldIds,
    required List<BranchLocationModel> locations,
    String? licenseUrl, // 👈 أضف دي
  }) async {
    try {
      final response = await _dio.post(
        "$_baseUrl/organization/register-organization",
        data: {
          "OrganizationName": organizationName,
          "Email": email,
          "PhoneNumber": phoneNumber,
          "Password": password,
          "ConfirmPassword": confirmPassword,
          "LicenseUrl": "",
          "Locations": locations.map((e) => e.toJson()).toList(),
          "FieldIds": fieldIds,
          "Description": "",
          "LicenseUrl": licenseUrl,
        },
      );

      final data = response.data;

      if (data["Succeeded"] != true) {
        final errors = data["Errors"];

        if (errors != null && errors is Map) {
          Map<String, String> fieldErrors = {};
          errors.forEach((key, value) {
            fieldErrors[key] = (value as List).join("\n");
          });

          throw ExceptionWithFields(
            message: data["Message"] ?? "Registration failed",
            fieldErrors: fieldErrors,
          );
        }

        throw Exception(data["Message"] ?? "Registration failed");
      }
    } on DioException catch (e) {
      final responseData = e.response?.data;

      if (responseData is Map && responseData["Errors"] != null) {
        Map<String, String> fieldErrors = {};
        responseData["Errors"].forEach((key, value) {
          fieldErrors[key] = (value as List).join("\n");
        });

        throw ExceptionWithFields(
          message: responseData["Message"] ?? "Validation error",
          fieldErrors: fieldErrors,
        );
      }

      throw Exception(responseData?["Message"] ?? "Network error");
    }
  }

  Future<void> forgotPassword({required String email}) async {
    try {
      final response = await _dio.post(
        '$_baseUrl/forgot-password',
        data: {"Email": email},
      );
      final data = response.data;
      if (data["Succeeded"] == false) {
        // لو فيه errors راجعة
        if (data["Errors"] != null && data["Errors"]["Email"] != null) {
          throw Exception(data["Errors"]["Email"][0]);
        }

        throw Exception(data["Message"] ?? "Request failed");
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 422) {
        final errors = e.response?.data["Errors"];

        if (errors != null && errors["Email"] != null) {
          throw Exception(errors["Email"][0]);
        }
      }

      throw Exception(e.response?.data["Message"] ?? "Network error");
    }
  }

  Future<void> verifyOtp({required String email, required String code}) async {
    try {
      final response = await _dio.post(
        '$_baseUrl/verify-otp',
        data: {"Email": email, "Code": code},
      );

      final data = response.data;

      if (data["Succeeded"] != true) {
        throw Exception(data["Message"] ?? "OTP verification failed");
      }
    } on DioException catch (e) {
      final data = e.response?.data;

      if (data?["Errors"] != null && data["Errors"].isNotEmpty) {
        final errors = data["Errors"];
        final firstError = errors.values.first[0];
        throw Exception(firstError);
      }

      throw Exception(data?["Message"] ?? "Network error");
    }
  }

  Future<void> resetPassword({
    required String email,
    required String code,
    required String newPassword,
    required String confirmPassword,
  }) async {
    try {
      final response = await _dio.post(
        '$_baseUrl/reset-password',
        data: {
          "Email": email,
          "Code": code,
          "NewPassword": newPassword,
          "ConfirmPassword": confirmPassword,
        },
      );

      final data = response.data;

      if (data["Succeeded"] != true) {
        final errors = data["Errors"];

        if (errors != null && errors is Map && errors.isNotEmpty) {
          final firstError = errors.values.first[0];
          throw Exception(firstError);
        }

        throw Exception(data["Message"] ?? "Reset password failed");
      }
    } on DioException catch (e) {
      final data = e.response?.data;

      if (data?["Errors"] != null && data["Errors"].isNotEmpty) {
        final firstError = data["Errors"].values.first[0];
        throw Exception(firstError);
      }

      throw Exception(data?["Message"] ?? "Network error");
    }
  }

  Future<void> sendEmailVerification({required String email}) async {
    try {
      final response = await _dio.post(
        '$_baseUrl/send-email-verification',
        data: {"Email": email.trim()},
      );

      final data = response.data;

      print("📩 OTP RESPONSE: $data");

      final succeeded = data["Succeeded"] ?? data["succeeded"];

      if (succeeded != true) {
        throw Exception(
          data["Message"] ??
              data["message"] ??
              "Failed to send verification email",
        );
      }
    } on DioException catch (e) {
      final data = e.response?.data;

      print("❌ OTP ERROR RESPONSE: $data");

      if (data?["Errors"] != null && data["Errors"]["Email"] != null) {
        throw Exception(data["Errors"]["Email"][0]);
      }

      throw Exception(data?["Message"] ?? data?["message"] ?? "Network error");
    }
  }

  Future<void> verifyEmail({
    required String email,
    required String code,
  }) async {
    try {
      final response = await _dio.post(
        '$_baseUrl/verify-email',
        data: {"Email": email, "Code": code},
      );

      final data = response.data;

      if (data["Succeeded"] != true) {
        throw Exception(data["Message"] ?? "Verification failed");
      }
    } on DioException catch (e) {
      final data = e.response?.data;

      if (data?["Errors"] != null) {
        final errors = data["Errors"];
        final firstError = errors.values.first[0];
        throw Exception(firstError);
      }

      throw Exception(data?["Message"] ?? "Network error");
    }
  }

  Future<void> validateBasicInfo({
    required String organizationName,
    required String email,
    required String phoneNumber,
    required String password,
    required String confirmPassword,
  }) async {
    try {
      final response = await _dio.post(
        "$_baseUrl/organization/validate-basic-info",
        data: {
          "OrganizationName": organizationName,
          "Email": email,
          "PhoneNumber": phoneNumber,
          "Password": password,
          "ConfirmPassword": confirmPassword,
        },
      );

      final data = response.data;

      if (data["Succeeded"] != true) {
        final errors = data["Errors"];

        if (errors != null && errors is Map) {
          Map<String, String> fieldErrors = {};
          errors.forEach((key, value) {
            fieldErrors[key] = (value as List).join("\n");
          });

          throw ExceptionWithFields(
            message: data["Message"] ?? "Validation failed",
            fieldErrors: fieldErrors,
          );
        }

        throw Exception(data["Message"] ?? "Validation failed");
      }
    } on DioException catch (e) {
      final responseData = e.response?.data;

      if (responseData is Map && responseData["Errors"] != null) {
        Map<String, String> fieldErrors = {};
        responseData["Errors"].forEach((key, value) {
          fieldErrors[key] = (value as List).join("\n");
        });

        throw ExceptionWithFields(
          message: responseData["Message"] ?? "Validation error",
          fieldErrors: fieldErrors,
        );
      }

      throw Exception(responseData?["Message"] ?? "Network error");
    }
  }
}
