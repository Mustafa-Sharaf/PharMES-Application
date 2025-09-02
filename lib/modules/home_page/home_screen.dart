import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmes_app/app_theme/app_colors.dart';
import '../../widgets/bottom_tab_Item.dart';
import '../../widgets/drawer_home.dart';
import '../../widgets/drawer_home/distress_Controller.dart';
import '../bills/bills_screen.dart';
import '../cart/cart_screen.dart';
import '../inventory_management/inventory_management_screen.dart';
import '../profile/profile_controller.dart';
import '../qr_code/qr_code_screen.dart';
import 'home_content.dart';
import 'home_controller.dart';

class HomeScreen extends StatelessWidget {
  final BottomNavController controller = Get.put(BottomNavController());
  final ProfileController profileController = Get.find();
  final DistressController distressController = Get.put(DistressController());
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
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            SizedBox(
              height:MediaQuery.of(context).size.height*0.25,
              child: DrawerHeader(
                decoration:  BoxDecoration(color: AppColors.primaryColor),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'PharMes'.tr,
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage('assets/images/logodrawer.jpg'),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                    Obx(
                          () => Text(
                            profileController.name.value,
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                    Obx(
                          () => Text(
                            profileController.email.value,
                        style: TextStyle(color: Colors.grey, fontSize: 15),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            ListTile(
              leading: Icon(Icons.person),
              title: Text('My_Profile'.tr),
              onTap: () {
                Get.toNamed('/profileScreen');
              },
            ),
            ListTile(
              leading: Icon(Icons.inventory_2),
              title: Text('My_Pharmacy_Management'.tr),
              onTap: () {
                Get.toNamed('/pharmacyManagementScreen');
              },
            ),
            ListTile(
              leading: Icon(Icons.group),
              title: Text('All_Users'.tr),
              onTap: () {
                Get.toNamed('/allUsers');
              },
            ),
            ListTile(
              leading: Icon(Icons.sos),
              title: Text('Distress_Call'.tr),
              onTap: () {
                distressController.sendDistressMessage();
              },
            ),
            ListTile(leading: Icon(Icons.support), title: Text('Support'.tr)),
            ListTile(
              leading: Icon(Icons.share),
              title: Text('Share_Application'.tr),
              //onTap: shareController.shareApp,
            ),
            ListTile(
              leading: Icon(Icons.privacy_tip),
              title: Text('Privacy_Policy'.tr),
            ),
          ],
        ),
      ),

      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        actions: [
          Text("Home_Screen".tr,
            style: TextStyle(
                color: Colors.white,
                fontSize: MediaQuery.of(context).size.width*0.055,
              ),
            ),
          SizedBox(width: MediaQuery.of(context).size.width * 0.25,),
          IconButton(
            icon: const Text('🔎', style: TextStyle(fontSize: 25)),
            onPressed: () => Get.toNamed('/searchScreen'),
          ),

          SizedBox(width: MediaQuery.of(context).size.width * 0.01,),
          IconButton(
            icon: const Text('🔔', style: TextStyle(fontSize: 20)),
            onPressed: () => Get.toNamed('/notificationsScreen'),
          ),
          SizedBox(width:MediaQuery.of(context).size.width * 0.01,),

        ],
        leading: Builder(
          builder: (context) => IconButton(
            icon:  Padding(
              padding: EdgeInsets.only(left: 10),
              child: Icon(Icons.menu, color: Colors.white, size: MediaQuery.of(context).size.width*0.055),
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
          height: MediaQuery.of(context).size.width * 0.14,
          width: MediaQuery.of(context).size.width * 0.14,
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

      bottomNavigationBar: SizedBox(
        height:MediaQuery.of(context).size.height * 0.0805,
        child: BottomAppBar(
          //color:  Color(0xFF111111),
          shape: const CircularNotchedRectangle(),
           notchMargin: 6.0,
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





