import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmes_app/widgets/drawer_home/share_Controller.dart';
import '../../app_theme/app_colors.dart';
import '../../modules/profile/profile_controller.dart';
import '../../modules/profile/update_profile_controller.dart';
import 'distress_Controller.dart';

class DrawerHome extends StatelessWidget {
  const DrawerHome({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileController controller = Get.find();
    final DistressController distressController = Get.put(DistressController());
    //final ShareController shareController = Get.put(ShareController());

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
              decoration: const BoxDecoration(color: Colors.cyan),
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
                      controller.name.value,
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                  Obx(
                    () => Text(
                      controller.email.value,
                      style: TextStyle(color: Colors.grey, fontSize: 15),
                    ),
                  ),
                  Text("Mustafa Sharaf", style: TextStyle(color: Colors.white, fontSize: 18)),
                ],
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
    );
  }
}
