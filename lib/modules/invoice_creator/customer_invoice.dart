import 'package:get/get.dart';

import '../bills/medicine.dart';

class CustomerInvoice extends GetxController {
  var customerName = "".obs;
  var invoiceNumber = 0.obs;
  var isPsychotropic = false.obs;
  var customerNameEditing = "".obs;
  var nationalId = "".obs;
  var medicines = <Medicine>[].obs;

  double get total =>
      medicines.fold(0.0, (sum, item) => sum + item.quantity * item.price);
}
