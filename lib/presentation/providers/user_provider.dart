import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import '../../data/user_remote_api.dart';
import '../../repository/user_data_repository.dart';
import '../../data/user_data_model.dart';

final dioProvider = Provider<Dio>((ref) => Dio());
final userApiProvider = Provider<UserApi>((ref) => UserApi(ref.watch(dioProvider)));
final userRepositoryProvider = Provider<UserRepository>((ref) => UserRepository(ref.watch(userApiProvider)));

class UserListNotifier extends AsyncNotifier<List<User>> {
  @override
  Future<List<User>> build() async {
    return ref.watch(userRepositoryProvider).getUsers();
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => ref.watch(userRepositoryProvider).getUsers());
  }
}

final userListProvider = AsyncNotifierProvider<UserListNotifier, List<User>>(() => UserListNotifier());

class PostUserNotifier extends AsyncNotifier<Map<String, dynamic>> {
  @override
  Future<Map<String, dynamic>> build() async {
    return {};
  }

  Future<void> postUser(String name, String job) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => ref.watch(userRepositoryProvider).postUser(name, job));
  }
}

final postUserProvider = AsyncNotifierProvider<PostUserNotifier, Map<String, dynamic>>(() => PostUserNotifier());
