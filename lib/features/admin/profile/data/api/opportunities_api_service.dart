import 'package:dio/dio.dart';
import 'package:mosahem/core/helpers/cache_helper.dart';
import 'package:mosahem/features/admin/profile/data/models/opportunity_model.dart';

class OpportunitiesApiService {
  final Dio dio;

  OpportunitiesApiService(this.dio);

  Future<List<OpportunityModel>> getOpportunities(String status) async {
    final token = await CacheHelper.getToken();

    final response = await dio.get(
      // 👈 هنا بيستخدمه صح
      '/api/v1/opportunities/by-verification-status',
      queryParameters: {
        "OpportunityVerificationStatus": status,
        "Page": 1,
        "PageSize": 10,
      },
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
    //  print(response.data);
    final items = response.data['Data']['Items'];

    // if (items.isEmpty) {
    //   return [
    //     OpportunityModel(
    //       id: '1',
    //       name: 'Medical Campaign',
    //       organizationName: 'Resala',
    //       startDate: '2025-01-01',
    //       endDate: '2025-01-10',
    //       logoUrl: '',
    //       status: 'approved',
    //     ),
    //   ];
    // }

    return items
        .map<OpportunityModel>((e) => OpportunityModel.fromJson(e))
        .toList();
  }

  Future<List<OpportunityModel>> getAllOpportunities() async {
    final token = await CacheHelper.getToken();

    final response = await dio.get(
      '/api/v1/opportunities/all',
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );

    final items = response.data['Data']['Items'];

    return items
        .map<OpportunityModel>((e) => OpportunityModel.fromJson(e))
        .toList();
  }

  Future<OpportunityModel> getOpportunityById(String id) async {
    final token = await CacheHelper.getToken();

    final response = await dio.get(
      '/api/v1/opportunities/$id',
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );

    final data = response.data['Data'];

    return OpportunityModel.fromJson(data);
  }
}
