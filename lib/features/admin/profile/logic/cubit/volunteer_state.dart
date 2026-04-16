import 'package:mosahem/features/admin/profile/data/models/volunteer_model.dart';

sealed class VolunteerState {}

class VolunteerInitial extends VolunteerState {}

class VolunteerLoading extends VolunteerState {}

class VolunteerSuccess extends VolunteerState {
  final List<VolunteerModel> volunteers;

  VolunteerSuccess(this.volunteers);
}

class VolunteerError extends VolunteerState {
  final String message;

  VolunteerError(this.message);
}