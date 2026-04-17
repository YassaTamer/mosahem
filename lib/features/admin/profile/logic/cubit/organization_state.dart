sealed class OrganizationState {}

class OrganizationInitial extends OrganizationState {}

class OrganizationLoading extends OrganizationState {}

class OrganizationSuccess extends OrganizationState {
  final List organizations;

  OrganizationSuccess(this.organizations);
}

class OrganizationError extends OrganizationState {
  final String message;

  OrganizationError(this.message);
}