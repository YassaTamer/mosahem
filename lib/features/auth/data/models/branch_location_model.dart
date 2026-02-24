class BranchLocationModel {
  // 🔹 للباك
  final String governorateId;
  final String cityId;
  final String details;

  // 🔹 للعرض
  final String governorateName;
  final String cityName;
  final String address;

  BranchLocationModel({
    required this.governorateId,
    required this.cityId,
    required this.details,
    required this.governorateName,
    required this.cityName,
    required this.address,
  });

  Map<String, dynamic> toJson() {
    return {
      "GovernorateId": governorateId,
      "CityId": cityId,
      "Details": details,
    };
  }
}
