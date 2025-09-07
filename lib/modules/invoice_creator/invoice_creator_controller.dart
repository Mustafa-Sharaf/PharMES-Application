import 'dart:convert';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart%20' as http;
import 'package:printing/printing.dart';
import '../../configurations/http_helpers.dart';
import '../bills/medicine.dart';
import '../profile/profile_controller.dart';
import 'customer_invoice.dart';


import 'dart:typed_data';


class InvoiceCreatorController extends GetxController {
  final ProfileController profileController = Get.find();
  var selectedTab = 0.obs;
  var invoiceNumber = 1001.obs;
  var customerName = "زبون 1".obs;
  var isPsychotropic = false.obs;
  var customerNameEditing = "".obs;
  var nationalId = "".obs;
  var medicines = <MedicineStock>[].obs;



  var invoices = List.generate(
      7, (i) => CustomerInvoice(
      customerName: "زبون ${i + 1}",
      isPsychotropic: false,
      customerNameEditing: "",
      nationalId: "",
      medicines: [])).obs;

  CustomerInvoice get currentInvoice => invoices[selectedTab.value];

  void changeTab(int index) {
    selectedTab.value = index;
  }

  double get total => medicines.fold(0.0,
          (sum, item) => sum + item.quantity * item.price);
  void increaseQuantity(CustomerInvoice invoice,int index) {
    invoice.medicines[index].quantity++;
    invoice.medicines.refresh();
  }
  void decreaseQuantity(CustomerInvoice invoice,int index) {
    if (invoice.medicines[index].quantity > 1) {
      invoice.medicines[index].quantity--;
    } else {
      invoice.medicines.removeAt(index);
    }
    invoice.medicines.refresh();
  }
  void addMedicine(CustomerInvoice invoice,MedicineStock newMedicine) {
    final existingIndex = invoice.medicines.indexWhere(
          (med) => med.medicineId == newMedicine.medicineId,
    );
    if (existingIndex != -1) {
      invoice.medicines[existingIndex].quantity += newMedicine.quantity;
      invoice.medicines.refresh();
    } else {
      invoice.medicines.add(newMedicine);
    }
  }


  bool validateSave(CustomerInvoice invoice) {
    String name = invoice.customerNameEditing.value.trim();
    List<String> parts = name.split(RegExp(r"\s+"));

    if (invoice.isPsychotropic.value) {
      if (parts.length < 3) {
        Get.snackbar(
            "خطأ",
            "الرجاء إدخال اسم ثلاثي",
            backgroundColor: Colors.red
        );
        return false;
      }

      String nationalIdClean = invoice.nationalId.value.replaceAll(' ', '').trim();
      if (nationalIdClean.isEmpty) {
        Get.snackbar(
            "خطأ",
            "يرجى ادخال الرقم الوطني",
            backgroundColor: Colors.red
        );
        return false;
      }

      if (nationalIdClean.length != 11 || !RegExp(r'^\d+$').hasMatch(nationalIdClean)) {
        Get.snackbar(
            "خطأ",
            "الرجاء إدخال رقم صحيح.. مؤلف من 11 رقمًا",
            backgroundColor: Colors.red
        );
        return false;
      }
    }

    return true;
  }

  bool validatePrint(CustomerInvoice invoice) {
    if (invoice.medicines.isEmpty) {
      Get.snackbar("خطأ", "لا يمكن الطباعة بدون أدوية");
      return false;
    }
    return true;
  }

  void saveInvoice(CustomerInvoice invoice) async {
    if (!validateSave(invoice)) return;

    Map<String, dynamic> body = {
      "invoice_num": invoice.invoiceNumber.value,
      "items": invoice.medicines.map((m) => m.toApiMap()).toList(),
    };

    print("Request Body: ${jsonEncode(body)}");

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
        Get.snackbar(
            "Success",
            "Saved successfully",
            backgroundColor: Colors.green
        );
      } else {
        Get.snackbar(
            "Error",
            "Failed to save invoice",
            backgroundColor: Colors.red

        );
        print("فشل حفظ الفاتورة: ${response.body}");
      }
    } catch (e) {
      Get.snackbar("Error", "حدث خطأ أثناء الاتصال: $e");
    }
  }

  void cancelInvoice(CustomerInvoice invoice) {
    invoice.customerNameEditing.value = "";
    invoice.nationalId.value = "";
    invoice.medicines.clear();
    invoice.isPsychotropic.value = false;
    Get.snackbar(
        "cancelled",
        "The invoice has been cancelled",
         backgroundColor: Colors.red
    );
  }


  void printInvoice(CustomerInvoice invoice) async {
    if (!validatePrint(invoice)) return;
    saveInvoice(invoice);
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Center(
                child:  pw.Text(
                  profileController.otherInfo[0].values.first,
                  style: pw.TextStyle(fontSize: 20),
                ),
              ),

              pw.Text(
                "Invoice Number: ${invoice.invoiceNumber.value}",
                style: pw.TextStyle(fontSize: 20),
              ),
              pw.Text(
                "Patient's name: ${invoice.customerName.value}",
                style: pw.TextStyle(fontSize: 20),
              ),
              pw.SizedBox(height: 20),
              pw.Table.fromTextArray(
                headers: ["Medicine", "Quantity", "Price"],
                data: invoice.medicines.map((m) => [
                  m.tradeName,
                  m.quantity.toString(),
                  "${m.price} S.P",
                ]).toList(),
              ),
              pw.SizedBox(height: 20),
              pw.Text(
                "Total: ${invoice.total.toStringAsFixed(2)} S.p",
                style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold),
              ),
              pw.SizedBox(height: 20),
              pw.Text("Thank you for your business.", style: pw.TextStyle(fontSize: 14)),
            ],
          );
        },
      ),
    );
    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
    );
  }



}
