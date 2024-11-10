class UserDetails {
  final int id;
  final String email;
  final String avatar;

  UserDetails({required this.id, required this.email, required this.avatar});

  factory UserDetails.fromJson(Map<String, dynamic> json) {
    return UserDetails(
      id: json['id'],
      email: json['email'],
      avatar: json['avatar'],
    );
  }
}
