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
      id: json['id'] ??0,
      nameEn: json['name_en'] ??"",
      nameAr: json['name_ar'] ??"",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name_en': nameEn,
      'name_ar': nameAr,
    };
  }
}
