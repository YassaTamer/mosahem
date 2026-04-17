import '../api/organizations_api_service.dart';
import '../models/organization_model.dart';

class OrganizationsRepository {
  final OrganizationsApiService apiService;

  OrganizationsRepository(this.apiService);

  Future<List<OrganizationModel>> getOrganizations() async {
    return await apiService.getOrganizations();
  }
}