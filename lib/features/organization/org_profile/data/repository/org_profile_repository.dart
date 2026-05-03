import 'package:mosahem/features/admin/profile/data/models/opportunity_model.dart';
import 'package:mosahem/features/admin/profile/data/models/volunteer_model.dart';
import 'package:mosahem/features/organization/org_profile/data/api/org_profile_api_service.dart';
import 'package:mosahem/features/organization/org_profile/data/models/org_profile_model.dart';

class OrgProfileRepository {
  final OrgProfileApiService apiService;

  OrgProfileRepository(this.apiService);

  Future<OrgProfileModel> getMyOrganization() async {
    final response = await apiService.getMyOrganization();
    return OrgProfileModel.fromJson(response.data);
  }

  Future<List<OpportunityModel>> getOpportunitiesByStatus({
    required String organizationId,
    required String status,
  }) async {
    return await apiService.getOrgOpportunitiesByStatus(
      organizationId: organizationId,
      status: status,
    );
  }

  Future<List<OpportunityModel>> getOpportunitiesByVerificationStatus({
    required String organizationId,
    required String verificationStatus,
  }) async {
    return await apiService.getOpportunitiesByVerificationStatus(
      organizationId: organizationId,
      verificationStatus: verificationStatus,
    );
  }

  Future<List<VolunteerModel>> getVolunteersByStatus({
    required String status,
    int page = 1,
    int pageSize = 50,
  }) async {
    return await apiService.getVolunteersByStatus(
      status: status,
      page: page,
      pageSize: pageSize,
    );
  }
}
