import 'package:dio/dio.dart';
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

      final data = response.data;
      if (data['succeeded'] == true) {
        return LoginResponseModel.fromJson(data);
      } else {
        throw Exception(data['message'] ?? 'Login failed');
      }
    } on DioException catch (e) {
      final responseData = e.response?.data;

      if (responseData is Map) {
        // لو فيه errors
        if (responseData['errors'] != null &&
            responseData['errors'] is Map &&
            (responseData['errors'] as Map).isNotEmpty) {
          final errorsMap = responseData['errors'] as Map;
          final firstErrorList = errorsMap.values.first;

          if (firstErrorList is List && firstErrorList.isNotEmpty) {
            throw Exception(firstErrorList.first);
          }
        }

        // fallback على message
        if (responseData['message'] != null) {
          throw Exception(responseData['message']);
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
  }) async {
    try {
      await _dio
          .post(
            "$_baseUrl/organization/validate-basic-info",
            data: {
              "organizationName": organizationName,
              "email": email,
              "phoneNumber": phoneNumber,
              "password": password,
              "confirmPassword": confirmPassword,
            },
          )
          .then((response) {
            final data = response.data;

            if (data["succeeded"] == false) {
              final errors = data["errors"];

              Map<String, String> fieldErrors = {};

              errors.forEach((key, value) {
                fieldErrors[key] = (value as List).join("\n");
              });

              throw ExceptionWithFields(
                message: data["message"],
                fieldErrors: fieldErrors,
              );
            }
          });
    } on DioException catch (e) {
      if (e.response?.statusCode == 422) {
        final errors = e.response?.data["Errors"];

        Map<String, String> fieldErrors = {};
        errors.forEach((key, value) {
          fieldErrors[key] = value.join("\n");
        });

        throw ExceptionWithFields(
          message: "Validation errors occurred",
          fieldErrors: fieldErrors,
        );
      }

      throw Exception(e.response?.data["Message"] ?? "Something went wrong");
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
}
