class Medicine {
  final int id;
  final String tradeName;
  final String laboratory;
  final String composition;
  final String titer;
  final String pharmaceuticalForm;

  Medicine({
    required this.id,
    required this.tradeName,
    required this.laboratory,
    required this.composition,
    required this.titer,
    required this.pharmaceuticalForm,
  });

  factory Medicine.fromJson(Map<String, dynamic> json) {
    return Medicine(
      id: json['id'],
      tradeName: json['trade_name'],
      laboratory: json['laboratory_en'],
      composition: json['composition'],
      titer: json['titer'],
      pharmaceuticalForm: json['pharmaceutical_form_en'],
    );
  }
}
