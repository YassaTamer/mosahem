class VolunteerModel {
  final String fullName;
  final String? profileImage;
  final String? bio;

  VolunteerModel({required this.fullName, this.profileImage, this.bio});

  factory VolunteerModel.fromJson(Map<String, dynamic> json) {
    return VolunteerModel(
      fullName: json['FullName'] ?? '',
      profileImage: json['ProfileImage'],
      bio: json['Bio'],
    );
  }
}
