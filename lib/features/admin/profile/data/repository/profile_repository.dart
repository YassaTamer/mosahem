import 'package:mosahem/features/admin/profile/data/api/profile_api_service.dart';
import 'package:mosahem/features/auth/data/models/user_model.dart';

class ProfileRepository {
  final ProfileApiService apiService;

  ProfileRepository(this.apiService);

  Future<UserModel> getMyProfile() async {
    return await apiService.getMyProfile();
  }
}
