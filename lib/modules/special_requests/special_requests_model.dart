
class SpecialRequestModel {
  final String id;
  final String name;
  final String medications;
  final String total;
  final String phone;
  final String paid;
  final String remaining;

  SpecialRequestModel({
    required this.id,
    required this.name,
    required this.medications,
    required this.total,
    required this.phone,
    required this.paid,
    required this.remaining,
  }) ;

  factory SpecialRequestModel.fromMap(Map<String, dynamic> map) {
    return SpecialRequestModel(
      id: map['id'],
      name: map['name'],
      medications: map['medications'],
      total: map['total'],
      phone: map['phone'],
      paid: map['paid'],
      remaining: map['remaining'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'medications': medications,
      'total': total,
      'phone': phone,
      'paid': paid,
      'remaining': remaining,
    };
  }
}
