import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mosahem/features/admin/profile/data/repository/volunteers_repository.dart';
import 'package:mosahem/features/admin/profile/logic/cubit/volunteer_state.dart';

class VolunteerCubit extends Cubit<VolunteerState> {
  final VolunteersRepository repository;

  VolunteerCubit(this.repository) : super(VolunteerInitial());

  Future<void> getVolunteers() async {
    emit(VolunteerLoading());

    try {
      final volunteers = await repository.getVolunteers();
      emit(VolunteerSuccess(volunteers));
    } catch (e) {
      emit(VolunteerError(e.toString()));
    }
  }
}
