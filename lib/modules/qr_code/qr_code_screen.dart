import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:pharmes_app/app_theme/app_colors.dart';
import '../my_stock/my_stock_controller.dart';

class QrCodeScreen extends StatefulWidget {
  const QrCodeScreen({super.key});

  @override
  State<QrCodeScreen> createState() => _QrCodeScreenState();
}

class _QrCodeScreenState extends State<QrCodeScreen> {
  Map<String, dynamic>? foundMedicine;
  bool scanning = true;
  String? scannedCode;

  void onBarcodeDetected(String code) {
    if (!scanning) return;
    scanning = false;

    final controller = Get.find<MyStockController>();

    final found = controller.stocks.firstWhereOrNull((stock) {
      final medicine = stock['medicine'] ?? {};
      final stockBarcode = medicine['code']?.toString().trim();
      debugPrint("📦 From stock: $stockBarcode");
      debugPrint("📷 From scanner: ${code.trim()}");
      return stockBarcode == code.trim();
    });

    setState(() {
      foundMedicine = found;
      scannedCode = code;
    });
    Future.delayed(const Duration(seconds: 2), () {
      scanning = true;
    });

    if (found == null) {
      debugPrint("Medicine with barcode ${code.trim()} not found in stock");
      Get.snackbar(
        "Not Found",
        "No medicine with this barcode in stock",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red
      );
    } else {
      debugPrint("Medicine found: ${found['medicine']['trade_name']}");
      Get.snackbar(
        "Medicine Found",
        "Name: ${found['medicine']['trade_name']}",
        snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        foregroundColor: AppColors.white,
        title: const Text("Scan Medicine"),
      ),
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.35,
            child: MobileScanner(
              onDetect: (capture) {
                final barcodes = capture.barcodes;
                for (final barcode in barcodes) {
                  final code = barcode.rawValue;
                  if (code != null) {
                    onBarcodeDetected(code);
                    break;
                  }
                }
              },
            ),
          ),

          const SizedBox(height: 12),

          Flexible(
            fit: FlexFit.loose,
            child: foundMedicine == null
                ? const Center(
                    child: Text(
                      "Scan a medicine to see details",
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  )
                : Center(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxHeight: 180),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          margin: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 4,
                          ),
                          elevation: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: ListTile(
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 8,
                              ),
                              leading: Icon(
                                Icons.medication,
                                color: AppColors.primaryColor,
                              ),
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "Trade Name: ${foundMedicine!['medicine']['trade_name']}",
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    "Titer: ${foundMedicine!['medicine']['titer']}",
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    "Quantity: ${foundMedicine!['quantity']}",
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
