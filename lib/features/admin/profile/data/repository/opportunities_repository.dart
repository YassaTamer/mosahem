import 'package:mosahem/core/helpers/cache_helper.dart';
import 'package:mosahem/features/admin/profile/data/api/opportunities_api_service.dart';
import 'package:mosahem/features/admin/profile/data/models/apply_request.dart';
import 'package:mosahem/features/admin/profile/data/models/opportunity_model.dart';

class OpportunitiesRepository {
  final OpportunitiesApiService apiService;

  OpportunitiesRepository(this.apiService);

  Future<List<OpportunityModel>> getOpportunities(String status) async {
    final opportunities = await apiService.getOpportunities(status);
    return _mergeAppliedState(opportunities);
  }

  Future<List<OpportunityModel>> getAllOpportunities() async {
    final opportunities = await apiService.getAllOpportunities();
    return _mergeAppliedState(opportunities);
  } 

  Future<OpportunityModel> getOpportunityById(String id) async {
    final opportunity = await apiService.getOpportunityById(id);
    final opportunities = await _mergeAppliedState([opportunity]);
    return opportunities.first;
  }

  Future<String> applyToOpportunity(String opportunityId) async {
    final isAlreadyApplied = await CacheHelper.isOpportunityApplied(
      opportunityId,
    );
    if (isAlreadyApplied) return 'Already applied';

    final message = await apiService.applyToOpportunity(opportunityId);
    await CacheHelper.saveAppliedOpportunityId(opportunityId);
    return message;
  }

  Future<String> applyWithAnswers(
    String opportunityId,
    ApplyRequest request,
  ) async {
    final isAlreadyApplied = await CacheHelper.isOpportunityApplied(
      opportunityId,
    );
    if (isAlreadyApplied) return 'Already applied';

    final message = await apiService.applyWithAnswers(opportunityId, request);
    await CacheHelper.saveAppliedOpportunityId(opportunityId);
    return message;
  }

  Future<List<OpportunityModel>> _mergeAppliedState(
    List<OpportunityModel> opportunities,
  ) async {
    final appliedIds = await CacheHelper.getAppliedOpportunityIds();

    return opportunities
        .map(
          (opportunity) => opportunity.copyWith(
            isApplied:
                opportunity.isApplied || appliedIds.contains(opportunity.id),
          ),
        )
        .toList();
  }
}
