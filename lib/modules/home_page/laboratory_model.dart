
class LaboratoryModel {
  final int id;
  final String tradeName;
  final String composition;
  final String titer;
  final int pharmaceuticalFormId;
  final PharmaceuticalForm pharmaceuticalForm;

  LaboratoryModel({
    required this.id,
    required this.tradeName,
    required this.composition,
    required this.titer,
    required this.pharmaceuticalFormId,
    required this.pharmaceuticalForm,
  });

  factory LaboratoryModel.fromJson(Map<String, dynamic> json) {
    return LaboratoryModel(
      id: json['id'],
      tradeName: json['trade_name'],
      composition: json['composition'],
      titer: json['titer'],
      pharmaceuticalFormId: int.parse(json['pharmaceutical_form_id'].toString()),
      pharmaceuticalForm: PharmaceuticalForm.fromJson(json['pharmaceutical_form']),
    );
  }
}
class PharmaceuticalForm {
  final int id;
  final String nameEn;
  final String nameAr;
  final String imagePath;

  PharmaceuticalForm({
    required this.id,
    required this.nameEn,
    required this.nameAr,
    required this.imagePath,
  });

  factory PharmaceuticalForm.fromJson(Map<String, dynamic> json) {
    return PharmaceuticalForm(
      id: json['id'],
      nameEn: json['name_en'],
      nameAr: json['name_ar'],
      imagePath: json['image_path'],
    );
  }
}
