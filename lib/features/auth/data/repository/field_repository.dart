import 'package:dio/dio.dart';
import 'package:mosahem/features/auth/data/models/track_model.dart';

class FieldRepository {
  final Dio _dio;

  FieldRepository(this._dio);

  Future<List<TrackModel>> getFields() async {
    final response = await _dio.get(
      'https://mosahemapi.runasp.net/api/v1/fields/get-all-fields',
    );

    final data = (response.data as Map<String, dynamic>?) ?? {};

    if (data["Succeeded"] == true) {
      final List list = (data["Data"] as List?) ?? [];
      return list
          .map((e) => TrackModel.fromJson((e as Map<String, dynamic>? ?? {})))
          .toList();
    } else {
      throw Exception(data["Message"]?.toString() ?? "Failed to load fields.");
    }
  }
}
