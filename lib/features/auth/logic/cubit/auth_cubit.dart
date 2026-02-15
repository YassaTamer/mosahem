import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mosahem/core/helpers/cache_helper.dart';
import 'package:mosahem/features/auth/data/models/validation_exception.dart';
import 'package:mosahem/features/auth/data/repository/auth_repository.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _authRepository;
  AuthCubit(this._authRepository) : super(AuthInitial());

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
      emit(
        AuthSuccess(
          isVerified: response.data.isVerified,
          role: response.data.role,
        ),
      );
    } catch (e) {
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
  }) async {
    emit(AuthLoading());

    try {
      await _authRepository.registerOrganization(
        organizationName: organizationName,
        email: email,
        phoneNumber: phoneNumber,
        password: password,
        confirmPassword: confirmPassword,
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


}
