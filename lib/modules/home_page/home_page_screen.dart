import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmes_app/app_theme/app_colors.dart';
import '../../widgets/bottom_tab_Item.dart';
import '../../widgets/drawer_home.dart';
import '../bills/bills_screen.dart';
import '../cart/cart_screen.dart';
import '../inventory_management/inventory_management_screen.dart';
import '../qr_code/qr_code_screen.dart';
import 'home_content.dart';
import 'home_controller.dart';

class HomeScreen extends StatelessWidget {
  final BottomNavController controller = Get.put(BottomNavController());
  HomeScreen({super.key});

  final List<Widget> pages = [
    HomeContent(),
    InventoryManagementScreen(),
    QrCodeScreen(),
    CartScreen(),
    BillsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerHome(),
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        actions: [
          Text("Home_Screen".tr,
            style: TextStyle(
                color: Colors.white,
                fontSize: 19,
              ),
            ),
          SizedBox(width: MediaQuery.of(context).size.width * 0.15,),
          IconButton(
            icon: const Text('🔎', style: TextStyle(fontSize: 25)),
            onPressed: () => Get.toNamed('/searchScreen'),
          ),

          SizedBox(width: MediaQuery.of(context).size.width * 0.01,),
          IconButton(
            icon: const Text('🔔', style: TextStyle(fontSize: 20)),
            onPressed: () => Get.toNamed('/notificationsScreen'),
          ),
          SizedBox(width:MediaQuery.of(context).size.width * 0.08,),

        ],
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Padding(
              padding: EdgeInsets.only(left: 10),
              child: Icon(Icons.menu, color: Colors.white, size: 28),
            ),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      ),

      body: Obx(() => IndexedStack(
        index: controller.currentIndex.value,
        children: pages,
      )),

      floatingActionButton: Transform.translate(
        offset: const Offset(0, 10),
        child: SizedBox(
          height: MediaQuery.of(context).size.width * 0.17,
          width: MediaQuery.of(context).size.width * 0.17,
          child: FloatingActionButton(
            backgroundColor: AppColors.primaryColor,
            elevation: 8,
            shape: const CircleBorder(),
            onPressed: () => controller.changeTabIndex(2),
            child: const Icon(Icons.qr_code, size: 35,color: Colors.grey,),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
         notchMargin: 6.0,
        child: Container(
          //color: Colors.cyanAccent,
          height: MediaQuery.of(context).size.height*0.08,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(child: BottomTabItem(index: 0, icon: Icons.home, label: 'Home'.tr)),
              SizedBox(width: MediaQuery.of(context).size.width * 0.01,),
              Expanded(child: BottomTabItem(index: 1, icon: Icons.inventory, label: 'Inventory'.tr)),
              SizedBox(width: MediaQuery.of(context).size.width * 0.20,),
              Expanded(child: BottomTabItem(index: 3, icon: Icons.shopping_cart_outlined, label: 'Cart'.tr)),
              SizedBox(width: MediaQuery.of(context).size.width * 0.01,),
              Expanded(child: BottomTabItem(index: 4, icon: Icons.receipt_long, label: 'Bills'.tr)),
            ],
          ),
        ),
      ),
    );
  }
}




