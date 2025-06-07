// class LoginResponse {
//   final String status;
//   final String token;
//   final User user;
//
//   LoginResponse({required this.status, required this.token, required this.user});
//
//   factory LoginResponse.fromJson(Map<String, dynamic> json) {
//     return LoginResponse(
//       status: json['status'],
//       token: json['data']['authorization']['token'],
//       user: User.fromJson(json['data']['user']),
//     );
//   }
// }
//
// class User {
//   final String email;
//   final String password;
//   final String password_confirmation;
//
//   User({required this.email, required this.password, required this.password_confirmation});
//
//   factory User.fromJson(Map<String, dynamic> json) {
//     return User(
//       email: json['email'],
//       password: json['password'],
//       password_confirmation: json['password_confirmation'],
//     );
//   }
// }
