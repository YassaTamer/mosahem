class TrackModel {
  final String id;
  final String name;

  TrackModel({
    required this.id,
    required this.name,
  });

  factory TrackModel.fromJson(Map<String, dynamic> json) {
    return TrackModel(
      id: json['Id'],
      name: json['Name'],
    );
  }
}
