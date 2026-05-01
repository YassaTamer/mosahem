import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mosahem/features/admin/profile/data/models/opportunity_model.dart';
import 'package:mosahem/features/admin/profile/data/repository/opportunities_repository.dart';

import 'opportunity_state.dart';

class OpportunityCubit extends Cubit<OpportunityState> {
  final OpportunitiesRepository repository;

  OpportunityCubit(this.repository) : super(OpportunityInitial());
  OpportunityModel? selectedOpportunity;
  List<OpportunityModel> _currentOpportunities = const [];

  Future<void> getOpportunities(String status) async {
    emit(OpportunityLoading());

    try {
      final opportunities = await repository.getOpportunities(status);
      _currentOpportunities = List.unmodifiable(opportunities);
      emit(OpportunitySuccess(opportunities));
    } catch (e) {
      emit(OpportunityError(e.toString()));
    }
  }

  Future<void> getAllOpportunities() async {
    emit(OpportunityLoading());

    try {
      final opportunities = await repository.getAllOpportunities();
      _currentOpportunities = List.unmodifiable(opportunities);
      emit(OpportunitySuccess(opportunities));
    } catch (e) {
      emit(OpportunityError(e.toString()));
    }
  }

  Future<void> getOpportunityDetails(String id) async {
    emit(OpportunityLoading());

    try {
      final result = await repository.getOpportunityById(id);

      selectedOpportunity = result;

      emit(OpportunityDetailsLoaded(result, _currentOpportunities));
    } catch (e) {
      emit(OpportunityError(e.toString()));
    }
  }
}
