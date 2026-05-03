class VolunteerModel {
  final String id;
  final String name;
  final String? image;
  final int age;
  final int totalHours;
  final String? bio;

  VolunteerModel({
    required this.id,
    required this.name,
    this.image,
    required this.age,
    required this.totalHours,
    this.bio,
  });

  factory VolunteerModel.fromJson(Map<String, dynamic> json) {
    return VolunteerModel(
      id: json['VolunteerId'] ?? '',
      name: json['Name'] ?? '',
      image: json['ProfileImgUrl'],
      age: json['Age'] ?? 0,
      totalHours: json['TotalHours'] ?? 0,
      bio: json['Bio'],
    );
  }
}
