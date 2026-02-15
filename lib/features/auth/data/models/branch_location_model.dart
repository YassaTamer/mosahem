class BranchLocationModel {
  final String governorate;
  final String city;
  final String address;
  final String? description;

  BranchLocationModel({
    required this.governorate,
    required this.city,
    required this.address,
     this.description,
  });

  Map<String, dynamic> toJson() {
    return {
      "governorate": governorate,
      "city": city,
      "address": address,
      "description": description,
    };
  }
}
