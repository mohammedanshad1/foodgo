class LoginModel {
  final String email;
  final String password;

  LoginModel({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }
}

class LoginResponseModel {
  final String access;
  final String refresh;
  final String email;

  LoginResponseModel({
    required this.access,
    required this.refresh,
    required this.email,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      access: json['access'] ?? '',
      refresh: json['refresh'] ?? '',
      email: json['email'] ?? '',
    );
  }
}