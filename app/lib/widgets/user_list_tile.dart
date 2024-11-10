import 'package:flutter/material.dart';

import '../models/user.dart';
import '../pages/user_details_page.dart';

class UserListTile extends StatelessWidget {
  const UserListTile({
    super.key,
    required this.user,
  });

  final User user;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('${user.firstName} ${user.lastName}'),
      leading: Hero(
        tag: 'user-avatar-${user.id}',
        child: CircleAvatar(
          radius: 30.0,
          backgroundImage: NetworkImage(user.avatar),
          backgroundColor: Colors.transparent,
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => UserDetailsPage(userId: user.id),
          ),
        );
      },
    );
  }
}
