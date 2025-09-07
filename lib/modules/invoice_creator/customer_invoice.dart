import 'package:get/get.dart';

import '../bills/medicine.dart';

class CustomerInvoice extends GetxController {
  var customerName = "".obs;
  var invoiceNumber = 0.obs;
  var isPsychotropic = false.obs;
  var customerNameEditing = "".obs;
  var nationalId = "".obs;
  var medicines = <MedicineStock>[].obs;

  double get total =>
      medicines.fold(0.0, (sum, item) => sum + item.quantity * item.price);

  CustomerInvoice({
    String? customerName,
    int? invoiceNumber,
    bool? isPsychotropic,
    String?customerNameEditing,
    String ?nationalId,
    List<MedicineStock>? medicines,
  }) {
    if (customerName != null) this.customerName.value = customerName;
    if (invoiceNumber != null) this.invoiceNumber.value = invoiceNumber;
    if (isPsychotropic != null) this.isPsychotropic.value = isPsychotropic;
    if (customerNameEditing != null) this.customerNameEditing.value = customerNameEditing;
    if (nationalId != null) this.nationalId.value = nationalId;
    if (medicines != null) this.medicines.assignAll(medicines);
  }
}
