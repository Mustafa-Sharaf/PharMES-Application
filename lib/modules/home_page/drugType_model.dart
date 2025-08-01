class DrugTypeMedicine {
  final int id;
  final String tradeName;
  final String composition;
  final String titer;
  final int pharmaceuticalFormId;
  final Laboratory laboratory;

  DrugTypeMedicine({
    required this.id,
    required this.tradeName,
    required this.composition,
    required this.titer,
    required this.pharmaceuticalFormId,
    required this.laboratory,
  });

  factory DrugTypeMedicine.fromJson(Map<String, dynamic> json) {
    return DrugTypeMedicine(
      id: json['id'],
      tradeName: json['trade_name'],
      composition: json['composition'],
      titer: json['titer'],
      pharmaceuticalFormId: int.parse(json['pharmaceutical_form_id'].toString()),
      laboratory: Laboratory.fromJson(json['laboratory']),
    );
  }
}
class Laboratory {
  final int id;
  final String nameEn;
  final String nameAr;
  final String imagePath;

  Laboratory({
    required this.id,
    required this.nameEn,
    required this.nameAr,
    required this.imagePath,
  });

  factory Laboratory.fromJson(Map<String, dynamic> json) {
    return Laboratory(
      id: json['id'],
      nameEn: json['name_en'],
      nameAr: json['name_ar'],
      imagePath: json['image_path'],
    );
  }
}
