import 'package:dio/dio.dart';
import 'package:mosahem/core/network/network_request_flags.dart';
import 'package:mosahem/features/auth/data/models/city_model.dart';
import 'package:mosahem/features/auth/data/models/governorate_model.dart';

class LocationRepository {
  final Dio _dio;

  LocationRepository(this._dio);

  Options _publicOptions() {
    return Options(extra: {kSkipAuth: true, kSkipRefresh: true});
  }

  Future<List<GovernorateModel>> getGovernorates() async {
    final response = await _dio.get(
      "https://mosahemapi.runasp.net/api/v1/governates/get-all-governates",
      options: _publicOptions(),
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
      options: _publicOptions(),
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
