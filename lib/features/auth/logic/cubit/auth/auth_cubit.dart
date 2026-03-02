import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mosahem/core/constants/user_role.dart';
import 'package:mosahem/core/helpers/cache_helper.dart';
import 'package:mosahem/features/auth/data/models/branch_location_model.dart';
import 'package:mosahem/features/auth/data/models/validation_exception.dart';
import 'package:mosahem/features/auth/data/repository/auth_repository.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _authRepository;
  AuthCubit(this._authRepository) : super(AuthInitial());
  // ===== Registration Temp Data =====
  String? organizationName;
  String? email;
  String? phoneNumber;
  String? password;
  String? confirmPassword;
  String? licenseUrl;
  BranchLocationModel? branchLocation;
  List<String> selectedFieldIds = [];

  List<BranchLocationModel> locations = [];
  List<String> fieldIds = [];

  Future<void> login({required String email, required String password}) async {
    if (email.isEmpty || password.isEmpty) {
      emit(AuthError('Please enter email and password'));
      return;
    }
    emit(AuthLoading());

    try {
      final response = await _authRepository.login(
        emailOrPhone: email,
        password: password,
      );

      await CacheHelper.saveToken(response.data.accessToken);
      final savedToken = await CacheHelper.getToken();
      final userRole = parseUserRole(response.data.role);

      emit(AuthSuccess(isVerified: response.data.isVerified, role: userRole));
      // print("📩 LOGIN RESPONSE: ${response.data}");
    } catch (e) {
      // print("❌ LOGIN ERROR: $e");

      final message = e.toString().replaceAll('Exception: ', '');
      emit(AuthError(message));
    }
  }

  Future<void> registerOrganization({
    required String organizationName,
    required String email,
    required String phoneNumber,
    required String password,
    required String confirmPassword,
    required List<BranchLocationModel> locations,
    required List<String> fieldIds,
  }) async {
    emit(AuthLoading());

    try {
      await _authRepository.registerOrganization(
        organizationName: organizationName,
        email: email,
        phoneNumber: phoneNumber,
        password: password,
        confirmPassword: confirmPassword,
        locations: locations,
        fieldIds: fieldIds,
        licenseUrl: licenseUrl, // 👈 هنا
      );

      emit(AuthRegistered());
    } catch (e) {
      if (e is ExceptionWithFields) {
        emit(AuthError(e.message, fieldErrors: e.fieldErrors));
      } else {
        emit(AuthError(e.toString()));
      }
    }
  }

  Future<void> forgotPassword({required String email}) async {
    if (email.isEmpty) {
      emit(AuthError('Email is required'));
      return;
    }

    emit(AuthLoading());

    try {
      await _authRepository.forgotPassword(email: email);

      emit(AuthSuccessMessage('OTP sent successfully'));
    } catch (e) {
      final message = e.toString().replaceAll('Exception: ', '');
      emit(AuthError(message));
    }
  }

  Future<void> sendRegisterOtp(String email) async {
    emit(AuthLoading());

    try {
      await _authRepository.sendEmailVerification(email);
      emit(AuthOtpSent()); // غيرها لكده
    } catch (e) {
      emit(AuthError(e.toString().replaceAll("Exception: ", "")));
    }
  }

  Future<void> verifyRegisterOtp(String email, String code) async {
    emit(AuthLoading());

    try {
      await _authRepository.verifyEmail(email, code);
      emit(AuthOtpVerified());
    } catch (e) {
      emit(AuthError(e.toString().replaceAll("Exception: ", "")));
    }
  }

  Future<void> validateBasicInfo({
    required String organizationName,
    required String email,
    required String phoneNumber,
    required String password,
    required String confirmPassword,
  }) async {
    emit(AuthLoading());

    try {
      await _authRepository.validateBasicInfo(
        organizationName: organizationName,
        email: email,
        phoneNumber: phoneNumber,
        password: password,
        confirmPassword: confirmPassword,
      );

      // 🔥 خزّن البيانات
      this.organizationName = organizationName;
      this.email = email;
      this.phoneNumber = phoneNumber;
      this.password = password;
      this.confirmPassword = confirmPassword;

      await _authRepository.sendEmailVerification(email);

      emit(AuthOtpSent());
    } catch (e) {
      if (e is ExceptionWithFields) {
        emit(AuthError(e.message, fieldErrors: e.fieldErrors));
      } else {
        emit(AuthError(e.toString()));
      }
    }
  }

  void setLicenseUrl(String url) {
    licenseUrl = url;
  }
}
