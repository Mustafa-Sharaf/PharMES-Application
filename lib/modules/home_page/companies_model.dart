class Company {
  final int id;
  final String nameEn;
  final String nameAr;
  final String image;

  Company({
    required this.id,
    required this.nameEn,
    required this.nameAr,
    required this.image,
  });

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      id: json['id'],
      nameEn: json['name_en'],
      nameAr: json['name_ar'],
      image: json['image_path'],
    );
  }
}
