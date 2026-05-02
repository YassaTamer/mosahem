import 'package:mosahem/features/admin/profile/data/models/opportunity_model.dart';

class VolunteerProfileModel {
  final String id;
  final String name;
  final String? profilePhoto;
  final String? coverPhoto;
  final String? bio;
  final String? phone;
  final String? location;
  final String? gender;
  final String? dateOfBirth;
  final int totalHours;
  final int completedCount;

  final List<SkillModel> skills;
  final List<FieldModel> fields;
  final List<OpportunityModel> completedOpportunities;
  final List<OpportunityModel> savedOpportunities;

  VolunteerProfileModel({
    required this.id,
    required this.name,
    this.profilePhoto,
    this.coverPhoto,
    this.bio,
    this.phone,
    this.location,
    this.gender,
    this.dateOfBirth,
    required this.totalHours,
    required this.completedCount,
    required this.skills,
    required this.fields,
    required this.completedOpportunities,
    required this.savedOpportunities,
  });

  factory VolunteerProfileModel.fromJson(Map<String, dynamic> json) {
    final data = json['Data'];

    return VolunteerProfileModel(
      id: data['VolunteerId'],
      name: data['Name'],
      profilePhoto: data['ProfilePhoto'],
      coverPhoto: data['CoverPhoto'],
      bio: data['Bio'],
      phone: data['PhoneNumber'],
      location: data['Location'],
      gender: data['Gender'],
      dateOfBirth: data['DateOfBirth'],
      totalHours: data['TotalHours'] ?? 0,
      completedCount: data['CompletedOpportunitiesCount'] ?? 0,

      skills: (data['Skills'] as List? ?? [])
          .map((e) => SkillModel.fromJson(e))
          .toList(),

      fields: (data['Fields'] as List? ?? [])
          .map((e) => FieldModel.fromJson(e))
          .toList(),

      completedOpportunities: (data['CompletedOpportunities'] as List? ?? [])
          .map((e) => OpportunityModel.fromJson(e))
          .toList(),

      savedOpportunities: (data['SavedOpportunities'] as List? ?? [])
          .map((e) => OpportunityModel.fromJson(e))
          .toList(),
    );
  }
}

class SkillModel {
  final String id;
  final String name;

  SkillModel({required this.id, required this.name});

  factory SkillModel.fromJson(Map<String, dynamic> json) {
    return SkillModel(id: json['Id'], name: json['Name']);
  }
}

class FieldModel {
  final String id;
  final String name;

  FieldModel({required this.id, required this.name});

  factory FieldModel.fromJson(Map<String, dynamic> json) {
    return FieldModel(id: json['Id'], name: json['Name']);
  }
}
