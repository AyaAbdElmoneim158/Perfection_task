import 'package:dio/dio.dart';
import '../models/user.dart';
import '../models/user_details.dart';

class ApiService {
  final Dio _dio = Dio();

  Future<List<User>> fetchUsers() async {
    List<User> allUsers = [];
    for (int page = 1; page <= 2; page++) {
      final response = await _dio.get(
        'https://reqres.in/api/users',
        queryParameters: {'page': page},
      );
      allUsers.addAll(
        (response.data['data'] as List)
            .map((user) => User.fromJson(user))
            .toList(),
      );
    }

    return allUsers;
  }

  Future<UserDetails> fetchUserDetails(int id) async {
    final response = await _dio.get('https://reqres.in/api/users/$id');
    return UserDetails.fromJson(response.data['data']);
  }
}
