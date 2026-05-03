import 'package:dio/dio.dart';
import 'package:mosahem/core/helpers/cache_helper.dart';
import 'package:mosahem/features/admin/profile/data/models/apply_request.dart';
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

  Future<String> applyToOpportunity(String opportunityId) async {
    final response = await dio.post(
      '/api/v1/opportunities/$opportunityId/apply',
    );

    return _successMessage(response.data);
  }

  Future<String> applyWithAnswers(
    String opportunityId,
    ApplyRequest request,
  ) async {
    print(request.toJson());
    try {
      final response = await dio.post(
        '/api/v1/opportunities/$opportunityId/apply',
        data: request.toJson(),
      );

      return _successMessage(response.data);
    } on DioException catch (e) {
      print(e.response?.data);

      final statusCode = e.response?.statusCode;
      if (statusCode != 404 && statusCode != 405) rethrow;

      final response = await dio.post(
        '/api/v1/opportunities/$opportunityId/apply-with-answers',
        data: request.toJson(),
      );

      return _successMessage(response.data);
    }
  }

  String _successMessage(dynamic data) {
    if (data is Map<String, dynamic>) {
      return data['Data']?.toString() ??
          data['Message']?.toString() ??
          'Applied successfully';
    }

    return 'Applied successfully';
  }
}
