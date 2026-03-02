import 'package:bloc/bloc.dart';
import 'package:mosahem/features/auth/data/repository/auth_repository.dart';

part 'forget_password_state.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  final AuthRepository _authRepository;

  ForgetPasswordCubit(this._authRepository) : super(ForgetPasswordInitial());
  String? email;
  String? code;

  Future<void> sendOtp({required String email}) async {
    if (email.isEmpty) {
      emit(ForgetPasswordError('Email is required'));
      return;
    }

    emit(ForgetPasswordLoading());

    try {
      await _authRepository.forgotPassword(email: email);

      this.email = email; // نخزنه للخطوات الجاية

      emit(ForgetPasswordOtpSent());
    } catch (e) {
      emit(ForgetPasswordError(e.toString().replaceAll('Exception: ', '')));
    }
  }

  Future<void> verifyOtp({required String code}) async {
    print("VERIFY OTP CALLED WITH: $code");
    if (code.isEmpty) {
      emit(ForgetPasswordError('OTP is required'));
      return;
    }

    if (email == null) {
      emit(ForgetPasswordError('Email not found. Please try again.'));
      return;
    }

    emit(ForgetPasswordLoading());

    try {
      await _authRepository.verifyOtp(email: email!, code: code);

      this.code = code; // نخزنه للخطوة الأخيرة

      emit(ForgetPasswordOtpVerified());
    } catch (e) {
      emit(ForgetPasswordError(e.toString().replaceAll('Exception: ', '')));
    }
  }

  Future<void> resetPassword({
    required String newPassword,
    required String confirmPassword,
  }) async {
    if (newPassword.isEmpty || confirmPassword.isEmpty) {
      emit(ForgetPasswordError('All fields are required'));
      return;
    }

    if (newPassword != confirmPassword) {
      emit(ForgetPasswordError('Passwords do not match'));
      return;
    }

    if (email == null || code == null) {
      emit(ForgetPasswordError('Session expired. Please try again.'));
      return;
    }

    emit(ForgetPasswordLoading());

    try {
      await _authRepository.resetPassword(
        email: email!,
        code: code!,
        newPassword: newPassword,
        confirmPassword: confirmPassword,
      );

      emit(ForgetPasswordResetSuccess());
    } catch (e) {
      emit(ForgetPasswordError(e.toString().replaceAll('Exception: ', '')));
    }
  }
}
