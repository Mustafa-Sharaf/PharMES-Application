class DemandOrderRequest {
  final int userId;
  final int pharmacyId;
  final int repositoryId;
  final String status;
  final int orderNum;
  final double totalPrice;
  final double remaining;
  final List<DemandOrderItem> items;

  DemandOrderRequest({
    required this.userId,
    required this.pharmacyId,
    required this.repositoryId,
    this.status = "pending",
    required this.orderNum,
    this.totalPrice = 0,
    this.remaining = 0,
    required this.items,
  });

  Map<String, dynamic> toJson() {
    return {
      "user_id": userId,
      "pharmacy_id": pharmacyId,
      "repository_id": repositoryId,
      "status": status,
      "order_num": orderNum,
      "total_price": totalPrice,
      "remaining": remaining,
      "items": items.map((e) => e.toJson()).toList(),
    };
  }
}

class DemandOrderItem {
  final int medicineId;
  final int quantity;

  DemandOrderItem({
    required this.medicineId,
    required this.quantity,
  });

  Map<String, dynamic> toJson() {
    return {
      "medicine_id": medicineId,
      "quantity": quantity,
    };
  }
}

