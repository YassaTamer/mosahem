import 'package:dio/dio.dart';
import 'package:mosahem/features/organization/createOpp/data/api/create_opportunity_api_service.dart';
import 'package:mosahem/features/organization/createOpp/data/models/create_opportunity_request_model.dart';
import 'package:mosahem/features/organization/createOpp/data/models/skill_model.dart';

class CreateOpportunityRepository {
  final CreateOpportunityApiService api;

  CreateOpportunityRepository(this.api);

  Future<List<SkillModel>> getSkills() async {
    try {
      final response = await api.getSkills();
      final data = (response.data as Map<String, dynamic>?) ?? {};

      if (data['Succeeded'] == true) {
        final List list = (data['Data'] as List?) ?? [];
        return list
            .map(
              (item) =>
                  SkillModel.fromJson((item as Map<String, dynamic>?) ?? {}),
            )
            .toList();
      }

      throw Exception(
        data['Message']?.toString() ?? 'Failed to load skills.',
      );
    } on DioException catch (error) {
      final responseData = error.response?.data;

      if (responseData is Map && responseData['Message'] != null) {
        throw Exception(responseData['Message'].toString());
      }

      throw Exception('Failed to load skills.');
    }
  }

  Future<Response> createOpportunity(
    CreateOpportunityRequestModel model,
  ) async {
    final response = await api.createOpportunity(model);
    return response;
  }
}
