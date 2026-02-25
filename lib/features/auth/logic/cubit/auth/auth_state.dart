part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthSuccess extends AuthState {
  final bool isVerified;
  final UserRole role;

  AuthSuccess({required this.isVerified, required this.role});
}

class AuthError extends AuthState {
  final String message;
  final Map<String, String>? fieldErrors;

  AuthError(this.message, {this.fieldErrors});
}

class AuthRegistered extends AuthState {}

class AuthSuccessMessage extends AuthState {
  final String message;

  AuthSuccessMessage(this.message);
}

class AuthBasicInfoValidated extends AuthState {}

class AuthOtpVerified extends AuthState {}

class AuthOtpSent extends AuthState {}
