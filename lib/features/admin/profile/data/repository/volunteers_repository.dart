import 'package:mosahem/features/admin/profile/data/api/volunteers_api_service.dart';
import 'package:mosahem/features/admin/profile/data/models/volunteer_model.dart';

class VolunteersRepository {
  final VolunteersApiService apiService;

  VolunteersRepository(this.apiService);

  Future<List<VolunteerModel>> getVolunteers() async {
    return await apiService.getVolunteers();
  }
}
