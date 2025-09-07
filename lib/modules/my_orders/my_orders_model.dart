class MyOrdersModel {
  final int id;
  final int repositoryId;
  final int pharmacyId;
  final String status;
  final String totalPrice;
  final String paid;
  final String remaining;
  final List<MyOrderItemModel> items;

  MyOrdersModel({
    required this.id,
    required this.repositoryId,
    required this.pharmacyId,
    required this.status,
    required this.totalPrice,
    required this.items,
    required this.paid,
    required this.remaining,
  });

  factory MyOrdersModel.fromJson(Map<String, dynamic> json) {
    var itemsList = <MyOrderItemModel>[];
    if (json['items'] != null) {
      itemsList = (json['items'] as List)
          .map((e) => MyOrderItemModel.fromJson(e))
          .toList();
    }

    return MyOrdersModel(
      id: json['id'],
      repositoryId: json['repository_id'],
      pharmacyId: json['pharmacy_id'],
      status: json['status'] ?? "",
      totalPrice: json['total_price'] ?? "0.00",
      paid: json['paid'] ?? "0.00",
      remaining: json['remaining'] ?? "0.00",
      items: itemsList,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'repository_id': repositoryId,
    'pharmacy_id': pharmacyId,
    'status': status,
    'total_price': totalPrice,
    'paid': paid,
    'remaining': remaining,
    'items': items.map((e) => e.toJson()).toList(),
  };


  MyOrdersModel copyWith({
    int? id,
    int? repositoryId,
    int? pharmacyId,
    String? status,
    String? totalPrice,
    String? paid,
    String? remaining,
    List<MyOrderItemModel>? items,
  }) {
    return MyOrdersModel(
      id: id ?? this.id,
      repositoryId: repositoryId ?? this.repositoryId,
      pharmacyId: pharmacyId ?? this.pharmacyId,
      status: status ?? this.status,
      totalPrice: totalPrice ?? this.totalPrice,
      paid: paid ?? this.paid,
      remaining: remaining ?? this.remaining,
      items: items ?? this.items,
    );
  }
}

class MyOrderItemModel {
  final int id;
  final int orderId;
  final int medicineId;
  final int quantity;
  final String? batch;
  final String? expirationDate;
  final String? purchasePrice;
  final MedicineModel medicine;

  MyOrderItemModel({
    required this.id,
    required this.orderId,
    required this.medicineId,
    required this.quantity,
    this.batch,
    this.expirationDate,
    this.purchasePrice,
    required this.medicine,
  });

  factory MyOrderItemModel.fromJson(Map<String, dynamic> json) {
    return MyOrderItemModel(
      id: json['id'],
      orderId: json['order_id'],
      medicineId: json['medicine_id'],
      quantity: json['quantity'],
      batch: json['batch'],
      expirationDate: json['expiration_date'],
      purchasePrice: json['Purchase_price'],
      medicine: MedicineModel.fromJson(json['medicine']),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'order_id': orderId,
    'medicine_id': medicineId,
    'quantity': quantity,
    'batch': batch,
    'expiration_date': expirationDate,
    'Purchase_price': purchasePrice,
    'medicine': medicine.toJson(),
  };
}

class MedicineModel {
  final int id;
  final String tradeName;
  final String composition;
  final String titer;
  final String packaging;

  MedicineModel({
    required this.id,
    required this.tradeName,
    required this.composition,
    required this.titer,
    required this.packaging,
  });

  factory MedicineModel.fromJson(Map<String, dynamic> json) {
    return MedicineModel(
      id: json['id'],
      tradeName: json['trade_name'] ?? "",
      composition: json['composition'] ?? "",
      titer: json['titer'] ?? "",
      packaging: json['packaging'] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'trade_name': tradeName,
    'composition': composition,
    'titer': titer,
    'packaging': packaging,
  };
}
