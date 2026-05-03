import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mosahem/features/admin/profile/data/models/opportunity_model.dart';
import 'package:mosahem/features/admin/profile/data/models/volunteer_model.dart';
import 'package:mosahem/features/organization/org_profile/data/models/org_profile_model.dart';
import 'org_profile_state.dart';
import '../../data/repository/org_profile_repository.dart';

class OrgProfileCubit extends Cubit<OrgProfileState> {
  final OrgProfileRepository repository;
  OrgProfileModel? orgData;

  // ── Opportunities ──
  final Map<String, List<OpportunityModel>> opportunitiesMap = {};
  final Set<String> _loadingStatuses = {};
  final Map<String, String> _errorsByStatus = {};

  // ── Volunteers ──
  final Map<String, List<VolunteerModel>> volunteersMap = {};
  final Set<String> _loadingVolunteerStatuses = {};

  OrgProfileCubit(this.repository) : super(OrgProfileInitial());

  // ── Opportunities helpers ──
  String normalizeOpportunityStatus(String status) {
    final normalized = status.trim().toLowerCase();
    if (normalized == 'active') return 'Active';
    if (normalized == 'ended') return 'Ended';
    if (normalized == 'pending') return 'Pending';
    if (normalized == 'rejected') return 'Rejected';
    return status.trim();
  }

  List<OpportunityModel> opportunitiesFor(String status) =>
      opportunitiesMap[normalizeOpportunityStatus(status)] ?? const [];

  bool hasLoadedOpportunities(String status) =>
      opportunitiesMap.containsKey(normalizeOpportunityStatus(status));

  bool isLoadingOpportunities(String status) =>
      _loadingStatuses.contains(normalizeOpportunityStatus(status));

  String? opportunitiesErrorFor(String status) =>
      _errorsByStatus[normalizeOpportunityStatus(status)];

  // ── Volunteers helpers ──
  List<VolunteerModel> volunteersFor(String status) =>
      volunteersMap[status.toLowerCase()] ?? const [];

  bool isLoadingVolunteers(String status) =>
      _loadingVolunteerStatuses.contains(status.toLowerCase());

  // ── API calls ──
  Future<void> getMyOrganization() async {
    emit(OrgProfileLoading());
    try {
      final data = await repository.getMyOrganization();
      orgData = data;
      final status = data.verificationStatus;
      if (status == "Approved") {
        emit(OrgProfileApproved(data));
      } else if (status == "Pending") {
        emit(OrgProfilePending(data));
      } else if (status == "Rejected") {
        emit(OrgProfileRejected(data, data.verificationComment));
      } else {
        emit(OrgProfileError("Unknown status"));
      }
    } catch (e) {
      emit(OrgProfileError(e.toString()));
    }
  }

  Future<void> getOpportunities({
    required String organizationId,
    required String status,
  }) async {
    final normalizedStatus = normalizeOpportunityStatus(status);
    if (hasLoadedOpportunities(normalizedStatus) ||
        isLoadingOpportunities(normalizedStatus))
      return;

    _loadingStatuses.add(normalizedStatus);
    _errorsByStatus.remove(normalizedStatus);
    emit(OrgOpportunitiesLoading(normalizedStatus));

    try {
      final result = await repository.getOpportunitiesByStatus(
        organizationId: organizationId,
        status: normalizedStatus,
      );
      opportunitiesMap[normalizedStatus] = result;
      _loadingStatuses.remove(normalizedStatus);
      emit(OrgOpportunitiesSuccess(normalizedStatus));
    } catch (e) {
      _loadingStatuses.remove(normalizedStatus);
      _errorsByStatus[normalizedStatus] = e.toString();
      emit(OrgOpportunitiesError(normalizedStatus, e.toString()));
    }
  }

  Future<void> getOpportunitiesByVerificationStatus({
    required String organizationId,
    required String status,
  }) async {
    final normalizedStatus = normalizeOpportunityStatus(status);
    if (hasLoadedOpportunities(normalizedStatus) ||
        isLoadingOpportunities(normalizedStatus))
      return;

    _loadingStatuses.add(normalizedStatus);
    _errorsByStatus.remove(normalizedStatus);
    emit(OrgOpportunitiesLoading(normalizedStatus));

    try {
      final result = await repository.getOpportunitiesByVerificationStatus(
        organizationId: organizationId,
        verificationStatus: normalizedStatus.toLowerCase(),
      );
      opportunitiesMap[normalizedStatus] = result;
      _loadingStatuses.remove(normalizedStatus);
      emit(OrgOpportunitiesSuccess(normalizedStatus));
    } catch (e) {
      _loadingStatuses.remove(normalizedStatus);
      _errorsByStatus[normalizedStatus] = e.toString();
      emit(OrgOpportunitiesError(normalizedStatus, e.toString()));
    }
  }

  Future<void> getVolunteers(String status) async {
    final normalized = status.toLowerCase();
    if (volunteersMap.containsKey(normalized) ||
        _loadingVolunteerStatuses.contains(normalized))
      return;

    _loadingVolunteerStatuses.add(normalized);
    emit(OrgVolunteersLoading());

    try {
      final result = await repository.getVolunteersByStatus(status: status);
      volunteersMap[normalized] = result;
      _loadingVolunteerStatuses.remove(normalized);
      emit(OrgVolunteersSuccess());
    } catch (e) {
      _loadingVolunteerStatuses.remove(normalized);
      emit(OrgVolunteersError(e.toString()));
    }
  }

  void refreshVolunteers(String status) {
    final normalized = status.toLowerCase();
    volunteersMap.remove(normalized);
    _loadingVolunteerStatuses.remove(normalized);
    getVolunteers(status);
  }
}
