class OrganizationModel {
  final String id;
  final String name;
  final String description;
  final String? logo;
  final String? status;

  OrganizationModel({
    required this.id,
    required this.name,
    required this.description,
    this.logo,
    required this.status,
  });

  factory OrganizationModel.fromJson(Map<String, dynamic> json) {
    return OrganizationModel(
      id: json['OrganizationId'] ?? '',
      name: json['OrganizationName'] ?? '',
      description: json['OrganizationDescription'] ?? '',
      logo: json['OrganizationLogo'],
      status: json['Status'] ?? '',
    );  
  }
}
