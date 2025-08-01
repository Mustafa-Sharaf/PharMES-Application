class Forms {
  final int id;
  final String nameEn;
  final String nameAr;
  final String image;

  Forms({
    required this.id,
    required this.nameEn,
    required this.nameAr,
    required this.image,
  });

  factory Forms.fromJson(Map<String, dynamic> json) {
    return Forms(
      id: json['id'],
      nameEn: json['name_en'],
      nameAr: json['name_ar'],
      image: json['image_path'],
    );
  }
}
