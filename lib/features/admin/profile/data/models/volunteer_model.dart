class VolunteerModel {
  final String id;
  final String name;
  final String? image;
  final String? bio;
  final int age;
  final int totalHours;

  VolunteerModel({
    required this.id,
    required this.name,
    this.image,
    this.bio,
    this.age = 0,
    this.totalHours = 0,
  });

  factory VolunteerModel.fromJson(Map<String, dynamic> json) {
    return VolunteerModel(
      id: json['VolunteerId']?.toString() ?? '',
      name: json['FullName']?.toString() ?? json['Name']?.toString() ?? '',
      image:
          json['ProfileImage']?.toString() ?? json['ProfileImgUrl']?.toString(),
      bio: json['Bio']?.toString(),
      age: json['Age'] ?? 0,
      totalHours: json['TotalHours'] ?? 0,
    );
  }
}
