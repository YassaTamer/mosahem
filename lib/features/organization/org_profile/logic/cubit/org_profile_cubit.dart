import 'package:flutter_bloc/flutter_bloc.dart';
import 'org_profile_state.dart';
import '../../data/repository/org_profile_repository.dart';

class OrgProfileCubit extends Cubit<OrgProfileState> {
  final OrgProfileRepository repository;

  OrgProfileCubit(this.repository) : super(OrgProfileInitial());

  Future<void> getMyOrganization() async {
    emit(OrgProfileLoading());

    try {
      final data = await repository.getMyOrganization();

      final status = data.verificationStatus;

      if (status == "Approved") {
        emit(OrgProfileApproved(data));
      } else if (status == "Pending") {
        emit(OrgProfilePending());
      } else if (status == "Rejected") {
        emit(OrgProfileRejected(data.verificationComment));
      } else {
        emit(OrgProfileError("Unknown status"));
      }
    } catch (e) {
      emit(OrgProfileError(e.toString()));
    }
  }
}
