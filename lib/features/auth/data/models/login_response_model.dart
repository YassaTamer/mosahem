class LoginResponseModel {
  final bool succeeded;
  final String message;
  final LoginUserData data;

  LoginResponseModel({
    required this.succeeded,
    required this.message,
    required this.data,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      succeeded: json['succeeded'],
      message: json['message'],
      data: LoginUserData.fromJson(json['data']),
    );
  }
}

class LoginUserData {
  final String id;
  final String email;
  final String fullName;
  final String role;
  final bool isVerified;
  final String accessToken;
  final String refreshToken;
  final String accessTokenExpiration;

  LoginUserData({
    required this.id,
    required this.email,
    required this.fullName,
    required this.role,
    required this.isVerified,
    required this.accessToken,
    required this.refreshToken,
    required this.accessTokenExpiration,
  });
  factory LoginUserData.fromJson(Map<String, dynamic> json) {
    return LoginUserData(
      id: json['id'],
      email: json['email'],
      fullName: json['fullName'],
      role: json['role'],
      isVerified: json['isVerified'],
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
      accessTokenExpiration: json['accessTokenExpiration'],
    );
  }
}
