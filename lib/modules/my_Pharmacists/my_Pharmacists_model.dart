

class MyPharmacists {
  final List<Pharmacist> data;
  final String status;

  MyPharmacists({
    required this.data,
    required this.status,
  });

  factory MyPharmacists.fromJson(Map<String, dynamic> json) {
    return MyPharmacists(
      data: (json['data'] as List)
          .map((e) => Pharmacist.fromJson(e))
          .toList(),
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data.map((e) => e.toJson()).toList(),
      'status': status,
    };
  }
}

class Pharmacist {
  final int id;
  final int userId;
  final int pharmacyId;
  final String role;
  final int isWork;
  final User user;

  Pharmacist({
    required this.id,
    required this.userId,
    required this.pharmacyId,
    required this.role,
    required this.isWork,
    required this.user,
  });

  factory Pharmacist.fromJson(Map<String, dynamic> json) {
    return Pharmacist(
      id: json['id'],
      userId: json['user_id'],
      pharmacyId: json['pharmacy_id'],
      role: json['role'],
      isWork: json['is_work'],
      user: User.fromJson(json['user']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'pharmacy_id': pharmacyId,
      'role': role,
      'is_work': isWork,
      'user': user.toJson(),
    };
  }
}

class User {
  final int id;
  final String name;
  final String phoneNumber;
  final String email;
  final int roleId;
  final String? token;


  User({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.email,
    required this.roleId,
    this.token,

  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      phoneNumber: json['phone_number'],
      email: json['email'],
      roleId: json['role_id'],
      token: json['token'],

    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phone_number': phoneNumber,
      'email': email,
      'role_id': roleId,
      'token': token,

    };
  }
}
