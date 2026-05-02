import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mosahem/features/volunteer/volunteer_profile/data/models/volunteer_profile_model.dart';
import 'package:mosahem/features/volunteer/volunteer_profile/data/repository/volunteers_profile_repository.dart';
import 'package:mosahem/features/volunteer/volunteer_profile/logic/volunteer_profile_state.dart';

class VolunteerProfileCubit extends Cubit<VolunteerProfileState> {
  final VolunteerProfileRepository repository;
  VolunteerProfileCubit(this.repository) : super(VolunteerProfileInitial());

  VolunteerProfileModel? profile;

  Future<void> getVolunteerProfile(String id) async {
    emit(VolunteerProfileLoading());

    try {
      profile = await repository.getVolunteerProfile(id);
      emit(VolunteerProfileSuccess(profile!));
    } catch (e) {
      emit(VolunteerProfileError(e.toString()));
    }
  }
}
