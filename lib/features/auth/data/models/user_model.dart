class UserModel {
  final String id;
  final String email;
  final String fullName;
  final String phoneNumber;
  final String role;
  final DateTime createdAt;

  UserModel({
    required this.id,
    required this.email,
    required this.fullName,
    required this.phoneNumber,
    required this.role,
    required this.createdAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final data = json['Data'];

    return UserModel(
      id: data['Id'],
      email: data['Email'],
      fullName: data['FullName'],
      phoneNumber: data['PhoneNumber'],
      role: data['Role'],
      createdAt: DateTime.parse(data['CreatedAt']),
    );
  }
}
