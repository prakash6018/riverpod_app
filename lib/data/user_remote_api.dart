import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'user_data_model.dart';

class UserApi {
  final Dio _dio;
  UserApi(this._dio);

  Future<List<User>> fetchUsers() async {
    final response = await _dio.get(
      'https://reqres.in/api/users',
      options: Options(headers: {'x-api-key': dotenv.env['API_KEY']}),
    );
    final List data = response.data['data'];
    return data.map((json) => User.fromJson(json)).toList();
  }

  Future<Map<String, dynamic>> postUser(String name, String job) async {
    final response = await _dio.post(
      'https://reqres.in/api/users',
      data: {
        'name': name,
        'job': job,
      },
      options: Options(headers: {'x-api-key': dotenv.env['API_KEY']}),
    );
    return response.data;
  }
}
