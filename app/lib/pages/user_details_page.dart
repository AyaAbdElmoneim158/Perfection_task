import 'package:flutter/material.dart';
import '../models/user_details.dart';
import '../services/api_service.dart';
import '../widgets/loading_indicator.dart';

class UserDetailsPage extends StatelessWidget {
  final int userId;

  const UserDetailsPage({Key? key, required this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('User Details')),
      body: FutureBuilder<UserDetails>(
        future: ApiService().fetchUserDetails(userId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: LoadingIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
            );
          }

          final userDetails = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Hero(
                  tag: 'user-avatar-$userId',
                  child: CircleAvatar(
                    radius: MediaQuery.of(context).size.width * 0.35,
                    backgroundImage: NetworkImage(userDetails.avatar),
                    backgroundColor: Colors.transparent,
                  ),
                ),
                const SizedBox(height: 24),
                _buildInfoRow(
                  context,
                  label: 'Email: ',
                  value: userDetails.email,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context,
      {required String label, required String value}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          label,
          style: Theme.of(context)
              .textTheme
              .bodyLarge
              ?.copyWith(fontWeight: FontWeight.w600),
        ),
        Text(
          value,
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(fontWeight: FontWeight.w300),
        ),
      ],
    );
  }
}
