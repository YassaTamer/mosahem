import 'package:dio/dio.dart';
import 'package:mosahem/core/helpers/cache_helper.dart';
import 'package:mosahem/core/network/dio_helper.dart';
import 'package:mosahem/features/admin/profile/data/models/volunteer_model.dart';

class VolunteersApiService {
  final Dio dio;

  VolunteersApiService(this.dio);

  Future<List<VolunteerModel>> getVolunteers() async {
    final token = await CacheHelper.getToken();

    final response = await dio.get(
      '/api/v1/volunteers',
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );

    final data = response.data['Data'];

    return data.map<VolunteerModel>((e) => VolunteerModel.fromJson(e)).toList();
  }

  Future<Map<String, dynamic>> getVolunteerProfile(String id) async {
    final response = await DioHelper.instance.client.get(
      '/api/v1/volunteers/$id/profile',
    );

    return response.data;
  }
}
