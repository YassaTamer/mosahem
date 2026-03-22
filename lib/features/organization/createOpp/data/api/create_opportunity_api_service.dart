import 'package:dio/dio.dart';
import 'package:mosahem/core/helpers/cache_helper.dart';
import 'package:mosahem/features/organization/createOpp/data/models/create_opportunity_request_model.dart';

class CreateOpportunityApiService {
  final Dio _dio;
  static const String _baseUrl = 'https://mosahemapi.runasp.net';

  CreateOpportunityApiService(this._dio);

  Future<Response> createOpportunity(
    CreateOpportunityRequestModel model,
  ) async {
    final token = await CacheHelper.getToken();
    final headers = <String, dynamic>{
      ..._dio.options.headers,
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    if (token != null && token.isNotEmpty) {
      headers['Authorization'] = 'Bearer $token';
    }

    return _dio.post(
      '$_baseUrl/api/v1/opportunities',
      data: model.toJson(),
      options: Options(headers: headers),
    );
  }
}
