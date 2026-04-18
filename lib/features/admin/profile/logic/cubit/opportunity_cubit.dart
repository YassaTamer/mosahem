import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mosahem/features/admin/profile/data/repository/opportunities_repository.dart';

import 'opportunity_state.dart';

class OpportunityCubit extends Cubit<OpportunityState> {
  final OpportunitiesRepository repository;

  OpportunityCubit(this.repository) : super(OpportunityInitial());

  Future<void> getOpportunities(String status) async {
    emit(OpportunityLoading());

    try {
      final opportunities = await repository.getOpportunities(status);
      emit(OpportunitySuccess(opportunities));
    } catch (e) {
      emit(OpportunityError(e.toString()));
    }
  }
}
