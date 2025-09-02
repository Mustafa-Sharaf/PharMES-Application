import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart%20' as http;
import '../../configurations/http_helpers.dart';
import '../bills/medicine.dart';
class InvoiceCreatorController extends GetxController {
  var selectedTab = 0.obs;
  var invoiceNumber = 1001.obs;
  var customerName = "زبون 1".obs;
  var isPsychotropic = false.obs;
  var customerNameEditing = "".obs;
  var nationalId = "".obs;
  var medicines = <MedicineStock>[].obs;
  double get total => medicines.fold(0.0,
          (sum, item) => sum + item.quantity * item.price);
  void increaseQuantity(int index) {
    medicines[index].quantity++;
    medicines.refresh();
  }
  void decreaseQuantity(int index) {
    if (medicines[index].quantity > 1) {
      medicines[index].quantity--;
    } else {
      medicines.removeAt(index);
    }
    medicines.refresh();
  }
  void addMedicine(MedicineStock newMedicine) {
    final existingIndex = medicines.indexWhere(
          (med) => med.medicineId == newMedicine.medicineId,
    );
    if (existingIndex != -1) {
      medicines[existingIndex].quantity += newMedicine.quantity;
      medicines.refresh();
    } else {
      medicines.add(newMedicine);
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
  void save() async {
    if (!validateSave()) return;

    Map<String, dynamic> body = {
      "items": medicines.map((m) => m.toApiMap()).toList(),
    };

    print(" Request Body: ${jsonEncode(body)}");
    try {
      final response = await http.post(
        Uri.parse('${baseurl}Pharmacy/sell/bulkStore'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${GetStorage().read<String>('token')}'
        },
        body: jsonEncode(body),
      );
      print(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.snackbar("Success", "saved successfully");
      } else {
        print(response.statusCode);
        Get.snackbar("error", "failed to save invoice: ${response.body}");
        print(response.body);
      }
    } catch (e) {
      Get.snackbar("error", "An error occurred while connecting: $e");
    }
  }
  void cancel() {
    print("Cancelled");
  }
  void printInvoice() {
    if (!validatePrint()) return;
    print("Printing invoice...");
  }
}
