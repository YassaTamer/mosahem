import 'package:mosahem/features/admin/profile/data/models/opportunity_model.dart';

sealed class OpportunityState {}

class OpportunityInitial extends OpportunityState {}

class OpportunityLoading extends OpportunityState {}

class OpportunitySuccess extends OpportunityState {
  final List<OpportunityModel> opportunities;
  OpportunitySuccess(this.opportunities);
}

class OpportunityDetailsLoaded extends OpportunitySuccess {
  final OpportunityModel opportunity;

  OpportunityDetailsLoaded(
    this.opportunity,
    List<OpportunityModel> opportunities,
  ) : super(opportunities);
}

class OpportunityError extends OpportunityState {
  final String message;

  OpportunityError(this.message);
}

class OpportunityApplySuccess extends OpportunityState {
  final String message;

  OpportunityApplySuccess(this.message);
}

class OpportunityApplyLoading extends OpportunityState {}

class ApplyLoading extends OpportunityApplyLoading {}

class ApplySuccess extends OpportunityApplySuccess {
  ApplySuccess(super.message);
}

class ApplyError extends OpportunityState {
  final String message;

  ApplyError(this.message);
}

class OpportunityApplyError extends ApplyError {
  OpportunityApplyError(super.message);
}

class ApplyWithAnswersLoading extends OpportunityApplyLoading {}

class ApplyWithAnswersSuccess extends OpportunityState {
  final String message;
  ApplyWithAnswersSuccess(this.message);
}

class ApplyWithAnswersError extends OpportunityState {
  final String message;

  ApplyWithAnswersError(this.message);
}
