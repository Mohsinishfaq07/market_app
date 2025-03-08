class UserDetail {
  String name;
  String email;
  String password;
  String phoneNumber;
  String userId;

  UserDetail({
    required this.name,
    required this.email,
    required this.password,
    required this.phoneNumber,
    required this.userId,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'phoneNumber': phoneNumber,
      'userId': userId,
    };
  }

  factory UserDetail.fromJson(Map<String, dynamic> json) {
    return UserDetail(
      name: json['name'],
      email: json['email'],
      password: json['password'],
      phoneNumber: json['phoneNumber'],
      userId: json['userId'],
    );
  }
}
