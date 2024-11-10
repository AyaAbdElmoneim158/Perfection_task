import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/user.dart';
import '../widgets/loading_indicator.dart';
import '../widgets/user_list_tile.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final ApiService _apiService = ApiService();
  late Future<List<User>> _userListFuture;

  @override
  void initState() {
    super.initState();
    _userListFuture = _fetchUsers();
  }

  Future<List<User>> _fetchUsers() async {
    try {
      return await _apiService.fetchUsers();
    } catch (e) {
      // Optionally, handle error here
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users'),
        centerTitle: true,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: FutureBuilder<List<User>>(
        future: _userListFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: LoadingIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Failed to load users.'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No users available.'));
          } else {
            return ListView.separated(
              padding: const EdgeInsets.all(4),
              separatorBuilder: (context, index) => const SizedBox(height: 16),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final user = snapshot.data![index];
                return UserListTile(user: user);
              },
            );
          }
        },
      ),
    );
  }
}
