import 'package:dio/dio.dart';
import 'package:mosahem/features/auth/data/models/user_model.dart';

class ProfileApiService {
  final Dio dio;

  ProfileApiService(this.dio);

  Future<UserModel> getMyProfile() async {
    final response = await dio.get('/api/v1/users/me');

    return UserModel.fromJson(response.data);
  }
}
