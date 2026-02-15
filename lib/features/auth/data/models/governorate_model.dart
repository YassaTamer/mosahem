class GovernorateModel {
  final String id;
  final String name;

  GovernorateModel({required this.id, required this.name});

  factory GovernorateModel.fromJson(Map<String, dynamic> json) {
    return GovernorateModel(id: json['Id'], name: json['Name']);
  }
}
