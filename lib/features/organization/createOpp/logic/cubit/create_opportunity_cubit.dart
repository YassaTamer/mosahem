import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mosahem/core/helpers/cache_helper.dart';
import 'package:mosahem/features/auth/data/models/branch_location_model.dart';
import 'package:mosahem/features/organization/createOpp/data/models/create_opportunity_request_model.dart';
import 'package:mosahem/features/organization/createOpp/data/repository/create_opportunity_repository.dart';

part 'create_opportunity_state.dart';

class CreateOpportunityCubit extends Cubit<CreateOpportunityState> {
  final CreateOpportunityRepository repository;
  CreateOpportunityRequestModel opportunity = CreateOpportunityRequestModel();

  CreateOpportunityCubit(this.repository) : super(CreateOpportunityInitial());
  Future<void> createOpportunity() async {
    final organizationId = await CacheHelper.getOrganizationId();
    if (organizationId == null || organizationId.isEmpty) {
      emit(
        CreateOpportunityError(
          'Organization ID is missing. Please log in again.',
        ),
      );
      return;
    }

    opportunity.organizationId = organizationId;

    print(repository);
    // opportunity.addresses = [
    //   AddressModel(
    //     governorateId: "c3b97f8f-5601-4741-a31f-089e2960161f",
    //     cityId: "2e3e1371-ceb7-419a-a000-1cbf5c4b825d",
    //     description: "Test Address",
    //   ),
    // ];

    // opportunity.title = "Test Opportunity";
    // opportunity.description = "Test Description";

    // opportunity.workType = 1;
    // opportunity.locationType = 1;

    // opportunity.startDate = "2026-03-19T00:00:00.000";
    // opportunity.endDate = "2026-03-27T00:00:00.000";

    // opportunity.numberOfVolunteers = 10;
    print(opportunity.toJson());
    try {
      emit(CreateOpportunityLoading());
      final response = await repository.createOpportunity(opportunity);

      print(response.statusCode);
      print(response.data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        emit(CreateOpportunitySuccess());
      } else {
        emit(CreateOpportunityError("Unexpected error"));
      }
    } catch (e) {
      print("ERROR START 🔴");

      // if (e is DioException) {
      //   print("StatusCode: ${e.response?.statusCode}");
      //   print("Data: ${e.response?.data}");
      // } else {
      //   print(e.toString());
      // }

      // print("ERROR END 🔴");

      emit(CreateOpportunityError(e.toString()));
    }
  }

  void addAddress(BranchLocationModel address) {
    opportunity.addresses ??= [];

    opportunity.addresses!.add(
      AddressModel(
        governorateId: address.governorateId,
        cityId: address.cityId,
        description: address.details,
      ),
    );
  }
}
