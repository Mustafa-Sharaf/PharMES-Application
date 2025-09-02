class MedicineStock {
  final int medicineId;
  final String tradeName;
  //final String scientificName;
  //final String pharmaceuticalForm;
  final String dosage;
  int quantity;
  final double price;
  final String batch;

  MedicineStock({
    required this.medicineId,
    required this.tradeName,
   // required this.scientificName,
   // required this.pharmaceuticalForm,
    required this.dosage,
    required this.quantity,
    required this.price,
    required this.batch,
  });

  Map<String, dynamic> toApiMap() {
    return {
      "medicine_id": medicineId,
      "quantity": quantity,
      "batch": batch,
    };
  }
}
