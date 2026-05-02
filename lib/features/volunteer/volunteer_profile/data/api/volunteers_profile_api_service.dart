import 'package:mosahem/core/network/dio_helper.dart';

class VolunteerProfileApiService {
  Future<Map<String, dynamic>> getVolunteerProfile(String id) async {
    final response = await DioHelper.instance.client.get(
      '/api/v1/volunteers/$id/profile',
    );

    return response.data;
  }
}
