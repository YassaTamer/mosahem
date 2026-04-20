import 'package:mosahem/features/organization/org_profile/data/api/org_profile_api_service.dart';
import 'package:mosahem/features/organization/org_profile/data/models/org_profile_model.dart';

class OrgProfileRepository {
  final OrgProfileApiService apiService;

  OrgProfileRepository(this.apiService);

  Future<OrgProfileModel> getMyOrganization() async {
    final response = await apiService.getMyOrganization();

    return OrgProfileModel.fromJson(response.data);
  }
}
