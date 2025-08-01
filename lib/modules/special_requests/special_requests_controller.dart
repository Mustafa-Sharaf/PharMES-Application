import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pharmes_app/modules/special_requests/special_requests_model.dart';

class SpecialRequestsController extends GetxController {
  final nameController = TextEditingController();
  final medsController = TextEditingController();
  final totalController = TextEditingController();
  final phoneController = TextEditingController();
  final paidController = TextEditingController();
  final remainingController = TextEditingController();

  final specialRequests = <SpecialRequestModel>[].obs;
  final storage = GetStorage();

  @override
  void onInit() {
    super.onInit();
    final stored = storage.read<List>('specialRequests');
    if (stored != null) {
      specialRequests.assignAll(
        stored.map((e) => SpecialRequestModel.fromMap(e)).toList(),
      );
    }
  }

  void createRequest() {
    if (validateInputs()) {
      final request = SpecialRequestModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: nameController.text.trim(),
        medications: medsController.text.trim(),
        total: totalController.text.trim(),
        phone: phoneController.text.trim(),
        paid: paidController.text.trim(),
        remaining: remainingController.text.trim(),
      );

      specialRequests.add(request);
      saveToStorage();
      Get.back();
      Get.snackbar(
        "Success",
        "The request was created successfully.",
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      clearControllers();
    }
  }

  void updateRequest(String id) {
    final index = specialRequests.indexWhere((e) => e.id == id);
    if (index != -1 && validateInputs()) {
      specialRequests[index] = SpecialRequestModel(
        id: id,
        name: nameController.text.trim(),
        medications: medsController.text.trim(),
        total: totalController.text.trim(),
        phone: phoneController.text.trim(),
        paid: paidController.text.trim(),
        remaining: remainingController.text.trim(),
      );
      saveToStorage();
      Get.back();
      Get.snackbar(
        "Success",
        "The request has been modified successfully.",
        backgroundColor: Colors.blue,
        colorText: Colors.white,
      );
      clearControllers();
    }
  }

  void deleteRequest(String id) {
    specialRequests.removeWhere((e) => e.id == id);
    saveToStorage();
    Get.snackbar(
      "Deleted",
      "The request has been deleted.",
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
  }

  void fillForm(SpecialRequestModel model) {
    nameController.text = model.name;
    medsController.text = model.medications;
    totalController.text = model.total;
    phoneController.text = model.phone;
    paidController.text = model.paid;
    remainingController.text = model.remaining;
  }

  void clearControllers() {
    nameController.clear();
    medsController.clear();
    totalController.clear();
    phoneController.clear();
    paidController.clear();
    remainingController.clear();
  }

  bool validateInputs() {
    if (nameController.text.isEmpty ||
        medsController.text.isEmpty ||
        phoneController.text.isEmpty) {
      Get.snackbar(
        "خطأ",
        "يرجى تعبئة الحقول المطلوبة",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    }
    return true;
  }

  void saveToStorage() {
    storage.write(
      'specialRequests',
      specialRequests.map((e) => e.toMap()).toList(),
    );
  }

  @override
  void onClose() {
    nameController.dispose();
    medsController.dispose();
    totalController.dispose();
    phoneController.dispose();
    paidController.dispose();
    remainingController.dispose();
    super.onClose();
  }
}
