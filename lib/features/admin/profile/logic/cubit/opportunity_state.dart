import 'package:mosahem/features/admin/profile/data/models/opportunity_model.dart';

sealed class OpportunityState {}

class OpportunityInitial extends OpportunityState {}

class OpportunityLoading extends OpportunityState {}

class OpportunitySuccess extends OpportunityState {
  final List<OpportunityModel> opportunities;
  OpportunitySuccess(this.opportunities);
}

class OpportunityError extends OpportunityState {
  final String message;

  OpportunityError(this.message);
}
