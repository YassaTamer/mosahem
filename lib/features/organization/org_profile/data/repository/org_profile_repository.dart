import 'package:mosahem/features/admin/profile/data/models/opportunity_model.dart';
import 'package:mosahem/features/organization/org_profile/data/api/org_profile_api_service.dart';
import 'package:mosahem/features/organization/org_profile/data/models/org_profile_model.dart';

class OrgProfileRepository {
  final OrgProfileApiService apiService;

  OrgProfileRepository(this.apiService);

  Future<OrgProfileModel> getMyOrganization() async {
    final response = await apiService.getMyOrganization();
    return OrgProfileModel.fromJson(response.data);
  }

  // 👇 الجديد
  Future<List<OpportunityModel>> getOpportunitiesByStatus({
    required String organizationId,
    required String status,
  }) async {
    return await apiService.getOrgOpportunitiesByStatus(
      organizationId: organizationId,
      status: status,
    );
  }
}
