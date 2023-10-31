class UserModel {
  UserModel({
    required this.id,
    required this.user,
    required this.email,
    required this.password,
  });

  final String id;
  final String user;
  final String email;
  final String password;

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json["id"],
      user: json["user"],
      email: json["email"],
      password: json["password"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "user": user,
        "email": email,
        "password": password,
      };
}
