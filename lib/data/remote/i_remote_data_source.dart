import '../models/auth/auth_model.dart';

abstract class IRemoteDataSource {
  Future<String?> login(AuthModel login);
}
