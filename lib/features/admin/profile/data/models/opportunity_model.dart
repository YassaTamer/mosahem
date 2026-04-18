class OpportunityModel {
  final String id;
  final String name;
  final String organizationName;
  final String startDate;
  final String endDate;
  final String? logoUrl;
  final String? status;

  OpportunityModel({
    required this.id,
    required this.name,
    required this.organizationName,
    required this.startDate,
    required this.endDate,
    this.logoUrl,
    this.status,
  });

  factory OpportunityModel.fromJson(Map<String, dynamic> json) {
    return OpportunityModel(
      id: json['OpportunityId'] ?? '',
      name: json['OpportunityName'] ?? '',
      organizationName: json['OrganizationName'] ?? '',
      startDate: json['StartDate'] ?? '',
      endDate: json['EndDate'] ?? '',
      logoUrl: json['OrganizationLogoUrl'],
      status: json['VerificationStatus'],
    );
  }
}