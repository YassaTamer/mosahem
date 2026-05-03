class UnratedVolunteerModel {
  final String volunteerId;
  final String fullName;
  final String? profileImage;
  final String? bio;
  final String opportunityId;

  UnratedVolunteerModel({
    required this.volunteerId,
    required this.fullName,
    this.profileImage,
    this.bio,
    required this.opportunityId,
  });

  factory UnratedVolunteerModel.fromJson(Map<String, dynamic> json) {
    return UnratedVolunteerModel(
      volunteerId: json['VolunteerId'] ?? '',
      fullName: json['FullName'] ?? '',
      profileImage: json['ProfileImage'],
      bio: json['Bio'],
      opportunityId: json['OpportunityId'] ?? '',
    );
  }
}