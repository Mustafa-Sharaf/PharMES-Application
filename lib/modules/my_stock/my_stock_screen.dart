import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../app_theme/app_colors.dart';
import '../../app_theme/theme_controller.dart';
import '../../widgets/medicine_card.dart';
import '../my_permissions/my_permissions_controller.dart';
import 'my_stock_controller.dart';

class MyStockScreen extends StatelessWidget {
  const MyStockScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final MyStockController controller = Get.find();
    final ThemeController themeController = Get.find();
    final GetStorage box = GetStorage();
    final MyPermissionsController permController = Get.find();
    int role = box.read('role_id') ?? 0;
    return Scaffold(
      backgroundColor: themeController.isDarkMode.value?AppColors.backgroundDark : AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        foregroundColor:AppColors.white,
        actions: [
          Text("MyStock".tr,
            style: TextStyle(
              color: Colors.white,
              fontSize: MediaQuery.of(context).size.width*0.055,
            ),
          ),
          SizedBox(width: MediaQuery.of(context).size.width * 0.45,),
          if (role == 1 || role == 2 || permController.hasPermission(5))
          IconButton(
            icon: Icon(Icons.add_circle,color: AppColors.white,),
            onPressed: () => Get.toNamed('/addMedicineInMyStock'),
          ),

          SizedBox(width: MediaQuery.of(context).size.width * 0.01,),


        ],

      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (controller.errorMessage.value != null) {
          return Center(child: Text(controller.errorMessage.value!));
        }
        if (controller.stocks.isEmpty) {
          return  Center(child: Text('No_data'.tr));
        }

        return ListView.separated(
          padding: const EdgeInsets.all(8),
          itemCount: controller.stocks.length,
          separatorBuilder: (_, __) =>
              SizedBox(height: MediaQuery.of(context).size.width * 0.001),
          itemBuilder: (context, index) {
            final stock = controller.stocks[index];
            final medicine = stock['medicine'] as Map<String, dynamic>? ?? {};

            return MedicineCard(
              stock: stock,
              medicine: medicine,
              showButton: false,
            );
          },
        );
      }),
    );
  }
}
