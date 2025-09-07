class DemandOrderModel {
  final int id;
  final int pharmacyId;
  final int repositoryId;
  final String tradeName;
  final String titer;
  final int quantity;

  DemandOrderModel({
    required this.pharmacyId,
    required this.repositoryId,
    required this.tradeName,
    required this.titer,
    required this.quantity,
    required this.id,
  });

  factory DemandOrderModel.fromJson(Map<String, dynamic> json) {
    return DemandOrderModel(
      id: json['id'] ?? 0,
      pharmacyId: json['pharmacy_id'] ?? 0,
      repositoryId: json['repository_id'] ?? 0,
      tradeName: json['trade_name'] ?? "",
      titer: json['titer'] ?? "",
      quantity: json['quantity'] ?? 0,
    );
  }



  Map<String, dynamic> toJson() {
    return {
      'id':id,
      'pharmacy_id': pharmacyId,
      'repository_id': repositoryId,
      'trade_name': tradeName,
      'titer': titer,
      'quantity': quantity,
    };
  }

  @override
  String toString() =>
      "Order: $tradeName ($titer) x $quantity for Repo $repositoryId";
}
