import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mosahem/features/admin/profile/data/models/opportunity_model.dart';
import 'org_profile_state.dart';
import '../../data/repository/org_profile_repository.dart';

class OrgProfileCubit extends Cubit<OrgProfileState> {
  final OrgProfileRepository repository;
  List<OpportunityModel> opportunities = [];
  OrgProfileCubit(this.repository) : super(OrgProfileInitial());

  Future<void> getMyOrganization() async {
    emit(OrgProfileLoading());

    try {
      final data = await repository.getMyOrganization();

      final status = data.verificationStatus;

      if (status == "Approved") {
        emit(OrgProfileApproved(data));
      } else if (status == "Pending") {
        emit(OrgProfilePending(data));
      } else if (status == "Rejected") {
        emit(OrgProfileRejected(data, data.verificationComment));
      } else {
        emit(OrgProfileError("Unknown status"));
      }
    } catch (e) {
      emit(OrgProfileError(e.toString()));
    }
  }

  Future<void> getOpportunities({required String organizationId}) async {
    emit(OrgOpportunitiesLoading());

    try {
      final result = await repository.getOpportunitiesByStatus(
        organizationId: organizationId,
        status: "Active",
      );

      opportunities = result;

      emit(OrgOpportunitiesSuccess());
    } catch (e) {
      //    print("🔥🔥 Error Fetching Data: $e");
      emit(OrgOpportunitiesError(e.toString()));
    }
  }
}
