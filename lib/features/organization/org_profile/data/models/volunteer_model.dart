// class VolunteerModel {
//   final String id;
//   final String name;
//   final String? image;
//   final String? bio;

//   VolunteerModel({required this.id, required this.name, this.image, this.bio});

//   factory VolunteerModel.fromJson(Map<String, dynamic> json) {
//     return VolunteerModel(
//       id: json['VolunteerId']?.toString() ?? '',
//       name: json['FullName'] ?? '', // ✅ الصح
//       image: json['ProfileImage'], // ✅ الصح
//       bio: json['Bio'],
//     );
//   }
// }
