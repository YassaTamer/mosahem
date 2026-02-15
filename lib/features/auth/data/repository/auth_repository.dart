import 'package:mosahem/features/auth/data/api/auth_api_service.dart';
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
    required String confirmPassword,
  }) async {
    try {
      await _authApiService.registerOrganization(
        organizationName: organizationName,
        email: email,
        phoneNumber: phoneNumber,
        password: password,
        confirmPassword: confirmPassword,
      );
    } catch (e) {
      // throw Exception(e.toString().replaceAll('Exception: ', ''));

      rethrow;
    }
  }

  Future<void> forgotPassword({required String email}) async {
    try {
      await _authApiService.forgotPassword(email: email);
    } catch (e) {
      throw Exception(e.toString().replaceAll('Exception: ', ''));
    }
  }
}
