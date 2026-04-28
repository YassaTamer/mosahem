import 'package:mosahem/features/organization/org_profile/data/models/org_profile_model.dart';

sealed class OrgProfileState {}

abstract class OrgProfileDataState extends OrgProfileState {
  OrgProfileModel get data;
}

class OrgProfileInitial extends OrgProfileState {}

class OrgProfileLoading extends OrgProfileState {}

class OrgProfileApproved extends OrgProfileDataState {
  final OrgProfileModel data;
  OrgProfileApproved(this.data);
}

class OrgProfilePending extends OrgProfileDataState {
  final OrgProfileModel data;

  OrgProfilePending(this.data);
}

class OrgProfileRejected extends OrgProfileDataState {
  final OrgProfileModel data;
  final String? reason;

  OrgProfileRejected(this.data, this.reason);
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
