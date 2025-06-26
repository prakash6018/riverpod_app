import '../data/user_remote_api.dart';
import '../data/user_data_model.dart';

class UserRepository {
  final UserApi api;
  UserRepository(this.api);

  Future<List<User>> getUsers() => api.fetchUsers();
  Future<Map<String, dynamic>> postUser(String name, String job) => api.postUser(name, job);
}
