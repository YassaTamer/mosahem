import 'package:dio/dio.dart';
import 'package:mosahem/core/network/dio_helper.dart';
import 'package:mosahem/features/admin/profile/data/models/opportunity_model.dart';

class OrgProfileApiService {
  Future<Response> getMyOrganization() async {
    return await DioHelper.instance.client.get('/api/v1/organizations/me');
  }

  Future<List<OpportunityModel>> getOrgOpportunitiesByStatus({
    required String organizationId,
    required String status,
    int page = 1,
    int pageSize = 6,
  }) async {
    final response = await DioHelper.instance.client.get(
      '/api/v1/organizations/$organizationId/opportunities/by-status',
      queryParameters: {
        "OpportunityStatus": status,
        "Page": page,
        "PageSize": pageSize,
      },
    );

    final items = response.data['Data']['Items'];

    return items
        .map<OpportunityModel>((e) => OpportunityModel.fromJson(e))
        .toList();
  }

  Future<List<OpportunityModel>> getOpportunitiesByVerificationStatus({
    required String organizationId,
    required String verificationStatus,
    int page = 1,
    int pageSize = 10,
  }) async {
    final response = await DioHelper.instance.client.get(
      '/api/v1/organizations/$organizationId/opportunities/by-verification-status',
      queryParameters: {
        "OpportunityVerificationStatus": verificationStatus,
        "Page": page,
        "PageSize": pageSize,
      },
    );

    final items = response.data['Data']['Items'];

    return items
        .map<OpportunityModel>((e) => OpportunityModel.fromJson(e))
        .toList();
  }
}
