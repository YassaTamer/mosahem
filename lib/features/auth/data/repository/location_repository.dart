import 'package:dio/dio.dart';
import 'package:mosahem/features/auth/data/models/city_model.dart';
import 'package:mosahem/features/auth/data/models/governorate_model.dart';

class LocationRepository {
  final Dio _dio;

  LocationRepository(this._dio);

  Future<List<GovernorateModel>> getGovernorates() async {
    final response = await _dio.get(
      "https://mosahemapi.runasp.net/api/v1/governates/get-all-governates",
    );

    if (response.data["Succeeded"] == true) {
      final List data = response.data["Data"];

      return data.map((e) => GovernorateModel.fromJson(e)).toList();
    } else {
      throw Exception(response.data["Message"]);
    }
  }

  Future<List<CityModel>> getCities(String governorateId) async {
    final response = await _dio.get(
      'https://mosahemapi.runasp.net/api/v1/cities/get-cities-by-governate/$governorateId',
    );

    final data = response.data;

    if (data['Succeeded'] == true) {
      final List list = data['Data'];

      return list.map((e) => CityModel.fromJson(e)).toList();
    } else {
      throw Exception(data['Message']);
    }
  }
}
