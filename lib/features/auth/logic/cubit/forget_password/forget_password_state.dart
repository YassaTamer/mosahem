part of 'forget_password_cubit.dart';

sealed class ForgetPasswordState {}

class ForgetPasswordInitial extends ForgetPasswordState {}

class ForgetPasswordLoading extends ForgetPasswordState {}

class ForgetPasswordOtpSent extends ForgetPasswordState {}

class ForgetPasswordOtpVerified extends ForgetPasswordState {}

class ForgetPasswordResetSuccess extends ForgetPasswordState {}

class ForgetPasswordError extends ForgetPasswordState {
  final String message;

  ForgetPasswordError(this.message);
}