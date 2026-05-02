import 'package:mosahem/features/admin/profile/data/api/volunteers_api_service.dart';
import 'package:mosahem/features/admin/profile/data/models/volunteer_model.dart';
import 'package:mosahem/features/volunteer/volunteer_profile/data/models/volunteer_profile_model.dart';

class VolunteersRepository {
  final VolunteersApiService apiService;

  VolunteersRepository(this.apiService);

  Future<List<VolunteerModel>> getVolunteers() async {
    return await apiService.getVolunteers();
  }

  Future<VolunteerProfileModel> getVolunteerProfile(String id) async {
    final data = await apiService.getVolunteerProfile(id);
    return VolunteerProfileModel.fromJson(data);
  }
}
