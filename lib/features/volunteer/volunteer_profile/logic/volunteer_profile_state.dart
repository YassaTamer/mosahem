import 'package:mosahem/features/volunteer/volunteer_profile/data/models/volunteer_profile_model.dart';

abstract class VolunteerProfileState {}

class VolunteerProfileInitial extends VolunteerProfileState {}

class VolunteerProfileLoading extends VolunteerProfileState {}

class VolunteerProfileError extends VolunteerProfileState {
  final String message;
  VolunteerProfileError(this.message);
}

class VolunteerProfileSuccess extends VolunteerProfileState {
  final VolunteerProfileModel profile;

  VolunteerProfileSuccess(this.profile);
}
