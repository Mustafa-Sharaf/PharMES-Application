class Users {
  final int id;
  final String name;
  final String phoneNumber;
  final String email;
  final int roleId;

  Users({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.email,
    required this.roleId,
  });

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      phoneNumber: json['phone_number'] ?? '',
      email: json['email'] ?? '',
      roleId: json['role_id'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phone_number': phoneNumber,
      'email': email,
      'role_id': roleId,
    };
  }
}
