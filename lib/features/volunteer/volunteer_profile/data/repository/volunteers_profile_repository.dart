import 'package:mosahem/features/volunteer/volunteer_profile/data/api/volunteers_profile_api_service.dart';

import '../models/volunteer_profile_model.dart';

class VolunteerProfileRepository {
  final VolunteerProfileApiService apiService;

  VolunteerProfileRepository(this.apiService);

  Future<VolunteerProfileModel> getVolunteerProfile(String id) async {
    final data = await apiService.getVolunteerProfile(id);
    return VolunteerProfileModel.fromJson(data);
  }
}