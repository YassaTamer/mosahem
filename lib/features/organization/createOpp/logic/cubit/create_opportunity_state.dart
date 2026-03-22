part of 'create_opportunity_cubit.dart';

@immutable
sealed class CreateOpportunityState {}

final class CreateOpportunityInitial extends CreateOpportunityState {}

final class CreateOpportunityLoading extends CreateOpportunityState {}

final class CreateOpportunitySuccess extends CreateOpportunityState {
  
}

final class CreateOpportunityError extends CreateOpportunityState {
  final String message;

  CreateOpportunityError(this.message);
}
