import 'package:dio/dio.dart';
import 'package:mosahem/features/organization/createOpp/data/models/create_opportunity_request_model.dart';

class CreateOpportunityApiService {
  final Dio _dio;
  static const String _baseUrl = 'https://mosahemapi.runasp.net';

  CreateOpportunityApiService(this._dio);

  Future<Response> getSkills() async {
    return _dio.get('$_baseUrl/api/v1/skills');
  }

  Future<Response> createOpportunity(
    CreateOpportunityRequestModel model,
  ) async {
    return _dio.post('$_baseUrl/api/v1/opportunities', data: model.toJson());
  }
}
