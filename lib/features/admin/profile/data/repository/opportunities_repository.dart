import 'package:mosahem/features/admin/profile/data/api/opportunities_api_service.dart';
import 'package:mosahem/features/admin/profile/data/models/opportunity_model.dart';

class OpportunitiesRepository {
  final OpportunitiesApiService apiService;

  OpportunitiesRepository(this.apiService);

  Future<List<OpportunityModel>> getOpportunities(String status) async {
    return await apiService.getOpportunities(status);
  }

  Future<List<OpportunityModel>> getAllOpportunities() async {
    return await apiService.getAllOpportunities();
  }
}
