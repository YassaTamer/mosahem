import 'package:dio/dio.dart';
import 'package:mosahem/core/network/dio_helper.dart';

class OrgProfileApiService {
  Future<Response> getMyOrganization() async {
    return await DioHelper.instance.client.get('/api/v1/organizations/me');
  }
}
