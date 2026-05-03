import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mosahem/features/admin/profile/data/models/apply_request.dart';
import 'package:mosahem/features/admin/profile/data/models/opportunity_model.dart';
import 'package:mosahem/features/admin/profile/data/repository/opportunities_repository.dart';
import 'opportunity_state.dart';

class OpportunityCubit extends Cubit<OpportunityState> {
  final OpportunitiesRepository repository;

  OpportunityCubit(this.repository) : super(OpportunityInitial());

  OpportunityModel? selectedOpportunity;
  List<OpportunityModel> _currentOpportunities = const [];
  List<OpportunityModel> get currentOpportunities =>
      List.unmodifiable(_currentOpportunities);

  /// علشان نمنع duplicate request
  final Set<String> _applyingOpportunityIds = {};

  // ==============================
  // 📥 GET ALL
  // ==============================

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

  // ==============================
  // 📄 DETAILS
  // ==============================

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

  // ==============================
  // 🚀 APPLY (بدون أسئلة)
  // ==============================

  Future<void> applyToOpportunity(String opportunityId) async {
    // ...
    try {
      emit(ApplyLoading());
      final message = await repository.applyToOpportunity(opportunityId);
      _markOpportunityAsApplied(opportunityId);
      emit(ApplySuccess(message));

      // ← أضف ده
      if (selectedOpportunity != null) {
        emit(
          OpportunityDetailsLoaded(
            selectedOpportunity!,
            _currentOpportunities.toList(),
          ),
        );
      }
    } on DioException catch (e) {
      final msg = e.response?.data["Message"];
      if (msg == "Already applied for this opportunity") {
        _markOpportunityAsApplied(opportunityId);
        emit(ApplySuccess(msg));
        if (selectedOpportunity != null) {
          emit(
            OpportunityDetailsLoaded(
              selectedOpportunity!,
              _currentOpportunities.toList(),
            ),
          );
        }
      } else {
        emit(ApplyError(msg ?? "Something went wrong"));
      }
    } finally {
      _applyingOpportunityIds.remove(opportunityId);
    }
  }

  Future<void> applyWithAnswers(
    String opportunityId,
    ApplyRequest request,
  ) async {
    // ...
    try {
      emit(ApplyWithAnswersLoading());
      final message = await repository.applyWithAnswers(opportunityId, request);
      _markOpportunityAsApplied(opportunityId);
      emit(ApplyWithAnswersSuccess(message));

      // ← أضف ده
      if (selectedOpportunity != null) {
        emit(
          OpportunityDetailsLoaded(
            selectedOpportunity!,
            _currentOpportunities.toList(),
          ),
        );
      }
    } on DioException catch (e) {
      final msg = e.response?.data["Message"];
      if (msg == "Already applied for this opportunity") {
        _markOpportunityAsApplied(opportunityId);
        emit(ApplyWithAnswersSuccess(msg));
        if (selectedOpportunity != null) {
          emit(
            OpportunityDetailsLoaded(
              selectedOpportunity!,
              _currentOpportunities.toList(),
            ),
          );
        }
      } else {
        emit(ApplyWithAnswersError(msg ?? "Something went wrong"));
      }
    } finally {
      _applyingOpportunityIds.remove(opportunityId);
    }
  }
  // ==============================
  // 🧩 UPDATE LOCAL STATE
  // ==============================

  void _markOpportunityAsApplied(String opportunityId) {
    print('opportunityId: $opportunityId');
    print('selectedOpportunity?.id: ${selectedOpportunity?.id}');
    print('match: ${selectedOpportunity?.id == opportunityId}');

    selectedOpportunity = selectedOpportunity?.id == opportunityId
        ? selectedOpportunity!.copyWith(isApplied: true)
        : selectedOpportunity;

    _currentOpportunities = List.unmodifiable(
      _currentOpportunities.map((opportunity) {
        if (opportunity.id != opportunityId) return opportunity;
        return opportunity.copyWith(isApplied: true);
      }),
    );
  }
}
