import 'package:mosahem/features/auth/data/api/auth_api_service.dart';
import 'package:mosahem/features/auth/data/models/branch_location_model.dart';
import 'package:mosahem/features/auth/data/models/login_response_model.dart';

class AuthRepository {
  final AuthApiService _authApiService;

  AuthRepository(this._authApiService);
  Future<LoginResponseModel> login({
    required String emailOrPhone,
    required String password,
  }) async {
    try {
      return await _authApiService.login(
        emailOrPhone: emailOrPhone,
        password: password,
      );
    } catch (e) {
      throw Exception(e.toString().replaceAll('Exception: ', ''));
    }
  }

  Future<void> registerOrganization({
    required String organizationName,
    required String email,
    required String phoneNumber,
    required String password,
    // required String confirmPassword,
    required List<BranchLocationModel> locations,
    required List<String> fieldIds,
    String? licenseUrl,
    String? description,
  }) async {
    try {
      await _authApiService.registerOrganization(
        organizationName: organizationName,
        email: email,
        phoneNumber: phoneNumber,
        password: password,
        // confirmPassword: confirmPassword,
        locations: locations,
        fieldIds: fieldIds,
        licenseUrl: licenseUrl,
        description: description,
      );
    } catch (e) {
      throw Exception(e.toString().replaceAll('Exception: ', ''));
    }
  }

  Future<void> forgotPassword({required String email}) async {
    try {
      await _authApiService.forgotPassword(email: email);
    } catch (e) {
      throw Exception(e.toString().replaceAll('Exception: ', ''));
    }
  }

  Future<void> verifyOtp({required String email, required String code}) async {
    try {
      await _authApiService.verifyOtp(email: email, code: code);
    } catch (e) {
      throw Exception(e.toString().replaceAll('Exception: ', ''));
    }
  }

  Future<void> resetPassword({
    required String email,
    required String code,
    required String newPassword,
    required String confirmPassword,
  }) async {
    try {
      await _authApiService.resetPassword(
        email: email,
        code: code,
        newPassword: newPassword,
        confirmPassword: confirmPassword,
      );
    } catch (e) {
      throw Exception(e.toString().replaceAll('Exception: ', ''));
    }
  }

  Future<void> sendEmailVerification(String email) async {
    await _authApiService.sendEmailVerification(email: email);
  }

  Future<void> verifyEmail(String email, String code) async {
    await _authApiService.verifyEmail(email: email, code: code);
  }

  Future<void> validateBasicInfo({
    required String organizationName,
    required String email,
    required String phoneNumber,
    required String password,
    required String confirmPassword,
  }) async {
    try {
      await _authApiService.validateBasicInfo(
        organizationName: organizationName,
        email: email,
        phoneNumber: phoneNumber,
        password: password,
        confirmPassword: confirmPassword,
      );
    } catch (e) {
      rethrow;
    }
  }
}
