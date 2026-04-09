import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mosahem/features/admin/profile/data/models/organization_model.dart';
import 'package:mosahem/features/admin/profile/data/repository/organizations_repository.dart';

import 'organization_state.dart';

class OrganizationCubit extends Cubit<OrganizationState> {
  final OrganizationsRepository repository;

  OrganizationCubit(this.repository) : super(OrganizationInitial());

  List<OrganizationModel> organizations = [];

  Future<void> getOrganizations() async {
    try {
      emit(OrganizationLoading());

      final result = await repository.getOrganizations();

      organizations = result;

      emit(OrganizationSuccess(organizations));
    } catch (e) {
      emit(OrganizationError(e.toString()));
    }
  }
}