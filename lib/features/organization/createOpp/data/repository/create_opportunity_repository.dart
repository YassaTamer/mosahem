import 'package:dio/dio.dart';
import 'package:mosahem/features/organization/createOpp/data/api/create_opportunity_api_service.dart';
import 'package:mosahem/features/organization/createOpp/data/models/create_opportunity_request_model.dart';

class CreateOpportunityRepository {
  final CreateOpportunityApiService api;

  CreateOpportunityRepository(this.api);

  Future<Response> createOpportunity(
    CreateOpportunityRequestModel model,
  ) async {
    final response = await api.createOpportunity(model);
    return response;
  }
}
