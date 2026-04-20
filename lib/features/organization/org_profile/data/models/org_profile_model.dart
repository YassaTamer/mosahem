class OrgProfileModel {
  final String organizationId;
  final String organizationName;
  final String organizationDescription;
  final String? organizationLogo;
  final String verificationStatus;
  final String? verificationComment;
  final List<FieldModel> fields;
  final List<LocationModel> locations;

  OrgProfileModel({
    required this.organizationId,
    required this.organizationName,
    required this.organizationDescription,
    required this.organizationLogo,
    required this.verificationStatus,
    required this.verificationComment,
    required this.fields,
    required this.locations,
  });

  factory OrgProfileModel.fromJson(Map<String, dynamic> json) {
    final data = json['Data'];

    return OrgProfileModel(
      organizationId: data['OrganizationId'],
      organizationName: data['OrganizationName'],
      organizationDescription: data['OrganizationDescription'],
      organizationLogo: data['OrganizationLogo'],
      verificationStatus: data['VerificationStatus'],
      verificationComment: data['VerificationComment'],
      fields: (data['Fields'] as List)
          .map((e) => FieldModel.fromJson(e))
          .toList(),
      locations: (data['Locations'] as List)
          .map((e) => LocationModel.fromJson(e))
          .toList(),
    );
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

class LocationModel {
  final String id;
  final String description;
  final String cityId;
  final String cityName;
  final String governorateId;
  final String governorateName;

  LocationModel({
    required this.id,
    required this.description,
    required this.cityId,
    required this.cityName,
    required this.governorateId,
    required this.governorateName,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      id: json['Id'],
      description: json['Description'],
      cityId: json['CityId'],
      cityName: json['CityName'],
      governorateId: json['GovernorateId'],
      governorateName: json['GovernorateName'],
    );
  }
}
