import 'package:dio/dio.dart';
import 'package:mosahem/core/helpers/cache_helper.dart';
import '../models/organization_model.dart';

class OrganizationsApiService {
  final Dio dio;

  OrganizationsApiService(this.dio);

  // Future<List<OrganizationModel>> getOrganizations() async {
  //   final response = await dio.get('/api/v1/organizations');

  //   final List data = response.data['Data'];

  //   return data.map((e) => OrganizationModel.fromJson(e)).toList();
  // }

  Future<List<OrganizationModel>> getOrganizations() async {
    final token = await CacheHelper.getToken(); 

    final response = await dio.get(
      '/api/v1/organizations',
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );

    final List data = response.data['Data'];

    return data.map((e) => OrganizationModel.fromJson(e)).toList();
  }
}
