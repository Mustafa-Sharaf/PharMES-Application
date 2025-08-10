import 'package:get/get.dart';
class InvoiceCreatorController extends GetxController {
  var selectedTab = 0.obs;
  var invoiceNumber = 1001.obs;
  var customerName = "زبون 1".obs;
  var isPsychotropic = false.obs;

  var customerNameEditing = "".obs;
  var nationalId = "".obs;
  var medicines = <Map<String, dynamic>>[
    {
      "trade_name": "Paracetamol",
      "scientific_name": "Acetaminophen",
      "pharmaceutical_form": "Tablet",
      "dosage": "500 mg",
      "quantity": 1,
      "price": 5.0
    },
    {
      "trade_name": "Aspirin",
      "scientific_name": "Acetylsalicylic Acid",
      "pharmaceutical_form": "Capsule",
      "dosage": "100 mg",
      "quantity": 2,
      "price": 3.5
    },
  ].obs;

  double get total => medicines.fold(
      0.0,
          (sum, item) =>
      sum + (item["quantity"] as int) * (item["price"] as double));

  void increaseQuantity(int index) {
    medicines[index]["quantity"]++;
    medicines.refresh();
  }
  void decreaseQuantity(int index) {
    if (medicines[index]["quantity"] > 1) {
      medicines[index]["quantity"]--;
      medicines.refresh();
    } else {
      medicines.removeAt(index);
      medicines.refresh();
    }
  }
  bool validateSave() {
    String name = customerNameEditing.value.trim();
    List<String> parts = name.split(RegExp(r"\s+"));
    if (isPsychotropic.value) {
      if (parts.length < 3) {
        Get.snackbar("خطأ", "الرجاء إدخال اسم ثلاثي");
        return false;
      }
      String nationalIdClean = nationalId.value.replaceAll(' ', '').trim();
      if (nationalIdClean.isEmpty) {
        Get.snackbar("خطأ", "يرجى ادخال الرقم الوطني");
        return false;
      }
      if (nationalIdClean.length != 11 || !RegExp(r'^\d+$').hasMatch(nationalIdClean)) {
        Get.snackbar("خطأ", "الرجاء إدخال رقم صحيح.. مؤلف من 11 رقمًا");
        return false;
      }
    }
    return true;
  }
  bool validatePrint() {
    if (medicines.isEmpty) {
      Get.snackbar("خطأ", "لا يمكن الطباعة بدون أدوية");
      return false;
    }
    return true;
  }
  void save() {
    if (!validateSave()) return;
    print("Saving invoice...");
  }

  void cancel() {
    print("Cancelled");
  }
  void printInvoice() {
    if (!validatePrint()) return;
    print("Printing invoice...");
  }

}
