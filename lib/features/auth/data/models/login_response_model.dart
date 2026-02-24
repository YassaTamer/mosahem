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
      succeeded: json['Succeeded'],
      message: json['Message'],
      data: LoginUserData.fromJson(json['Data']),
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
      id: json['Id'],
      email: json['Email'],
      fullName: json['FullName'],
      role: json['Role'],
      isVerified: json['IsVerified'],
      accessToken: json['AccessToken'],
      refreshToken: json['RefreshToken'],
      accessTokenExpiration: json['AccessTokenExpiration'],
    );
  }
}
