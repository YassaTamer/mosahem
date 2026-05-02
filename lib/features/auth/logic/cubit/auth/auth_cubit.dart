import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
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
  // ===== Volunteer Temp Data =====
  String? fullName;
  String? volunteerEmail;
  String? volunteerPhone;
  String? volunteerPassword;
  String? volunteerConfirmPassword;
  String? nationalId;
  String? dateOfBirth;
  int? gender;

  List<String> volunteerFieldIds = [];
  List<String> volunteerSkillIds = [];
  String? governorateId;
  String? cityId;
  String? locationDetails;
  String? cvUrl;
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

      await CacheHelper.saveLoginSession(
        token: response.data.accessToken,
        refreshToken: response.data.refreshToken,
        role: response.data.role,
        accessTokenExpiration: response.data.accessTokenExpiration,
        organizationId: response.data.id,
        userId: response.data.id, // 👈 ضيف دي
      );

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
    //required String confirmPassword,
    required List<BranchLocationModel> locations,
    required List<String> fieldIds,
    String? description,
    String? licenseUrl,
  }) async {
    //  print("REGISTER FUNCTION STARTED");
    // print("Locations: ${locations.map((e) => e.toJson()).toList()}");
    // print("FieldIds: $fieldIds");
    emit(AuthLoading());

    try {
      await _authRepository.registerOrganization(
        organizationName: organizationName,
        email: email,
        phoneNumber: phoneNumber,
        password: password,
        //confirmPassword: confirmPassword,
        locations: locations,
        fieldIds: fieldIds,
        licenseUrl: licenseUrl,
        description: description ?? "",
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

  Future<void> logout() async {
    await CacheHelper.clearSession();
    emit(AuthLoggedOut());
  }

  Future<void> validateVolunteerBasicInfo({
    required String fullName,
    required String email,
    required String phoneNumber,
    required String password,
    required String confirmPassword,
    required String dateOfBirth,
    required int gender,
    required String nationalId,
  }) async {
    emit(AuthLoading());

    try {
      await _authRepository.validateVolunteerBasicInfo(
        fullName: fullName,
        email: email,
        phoneNumber: phoneNumber,
        password: password,
        confirmPassword: confirmPassword,
        dateOfBirth: dateOfBirth,
        gender: gender,
        nationalId: nationalId,
      );

      // 🔥 خزّن البيانات
      fullName = fullName;
      volunteerEmail = email;
      volunteerPhone = phoneNumber;
      volunteerPassword = password;
      volunteerConfirmPassword = confirmPassword;
      this.dateOfBirth = dateOfBirth;
      this.gender = gender;
      this.nationalId = nationalId;

      // 🔥 ابعت OTP
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

  Future<void> registerVolunteer() async {
    emit(AuthLoading());

    final Map<String, String> fieldErrors = {};

    if (fullName == null || fullName!.trim().isEmpty) {
      fieldErrors["FullName"] = "Full name is required";
    }
    if (volunteerEmail == null || volunteerEmail!.trim().isEmpty) {
      fieldErrors["Email"] = "Email is required";
    }
    if (volunteerPhone == null || volunteerPhone!.trim().isEmpty) {
      fieldErrors["PhoneNumber"] = "Phone number is required";
    }
    if (volunteerPassword == null || volunteerPassword!.trim().isEmpty) {
      fieldErrors["Password"] = "Password is required";
    }
    if (dateOfBirth == null || dateOfBirth!.trim().isEmpty) {
      fieldErrors["DateOfBirth"] = "Date of birth is required";
    }
    if (gender == null) {
      fieldErrors["Gender"] = "Gender is required";
    }
    if (nationalId == null || nationalId!.trim().isEmpty) {
      fieldErrors["NationalId"] = "National ID is required";
    }
    if (governorateId == null || governorateId!.trim().isEmpty) {
      fieldErrors["Location.GovernorateId"] = "Governorate is required";
    }
    if (cityId == null || cityId!.trim().isEmpty) {
      fieldErrors["Location.CityId"] = "City is required";
    }
    if (locationDetails == null || locationDetails!.trim().isEmpty) {
      fieldErrors["Location.Details"] = "Location details are required";
    }
    if (volunteerFieldIds.isEmpty) {
      fieldErrors["FieldIds"] = "Please select at least one track";
    }
    if (volunteerSkillIds.isEmpty) {
      fieldErrors["SkillIds"] = "Please select at least one skill";
    }

    if (fieldErrors.isNotEmpty) {
      emit(
        AuthError(
          "Please complete all required volunteer registration data",
          fieldErrors: fieldErrors,
        ),
      );
      return;
    }

    try {
      await _authRepository.registerVolunteer(
        fullName: fullName!,
        email: volunteerEmail!,
        phoneNumber: volunteerPhone!,
        password: volunteerPassword!,
        dateOfBirth: dateOfBirth!,
        gender: gender!,
        nationalId: nationalId!,
        governorateId: governorateId!,
        cityId: cityId!,
        details: locationDetails ?? "",
        fieldIds: volunteerFieldIds,
        skillIds: volunteerSkillIds,
        cvUrl: cvUrl,
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
}
