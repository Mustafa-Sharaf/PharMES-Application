
class MyPharmacistsPermission {
  final int id;
  final int userId;
  final int pharmacyId;
  final String role;
  final List<Permission> permissions;

  MyPharmacistsPermission({
    required this.id,
    required this.userId,
    required this.pharmacyId,
    required this.role,
    required this.permissions,
  });

  factory MyPharmacistsPermission.fromJson(Map<String, dynamic> json) {
    return MyPharmacistsPermission(
      id: json['id'],
      userId: json['user_id'],
      pharmacyId: json['pharmacy_id'],
      role: json['role'],
      permissions: (json['user_pharmacy_permissions'] as List)
          .map((p) => Permission.fromJson(p))
          .toList(),
    );
  }
}

class Permission {
  final int id;
  final String nameEn;
  final String nameAr;

  Permission({
    required this.id,
    required this.nameEn,
    required this.nameAr,
  });

  factory Permission.fromJson(Map<String, dynamic> json) {
    return Permission(
      id: json['id'],
      nameEn: json['name_en'],
      nameAr: json['name_ar'],
    );
  }
}
