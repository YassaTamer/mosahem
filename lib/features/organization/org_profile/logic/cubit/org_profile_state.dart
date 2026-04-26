import 'package:mosahem/features/organization/org_profile/data/models/org_profile_model.dart';

sealed class OrgProfileState {}

class OrgProfileInitial extends OrgProfileState {}

class OrgProfileLoading extends OrgProfileState {}

class OrgProfileApproved extends OrgProfileState {
  final OrgProfileModel data;
  OrgProfileApproved(this.data);
}

class OrgProfilePending extends OrgProfileState {}

class OrgProfileRejected extends OrgProfileState {
  final String? reason;

  OrgProfileRejected(this.reason);
}

class OrgProfileError extends OrgProfileState {
  final String message;

  OrgProfileError(this.message);
}

class OrgOpportunitiesLoading extends OrgProfileState {}

class OrgOpportunitiesSuccess extends OrgProfileState {}

class OrgOpportunitiesError extends OrgProfileState {
  final String message;

  OrgOpportunitiesError(this.message);
}
