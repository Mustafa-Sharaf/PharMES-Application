/*
import 'package:flutter/material.dart';

class InventoryManagementScreen extends StatelessWidget {
  const InventoryManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Inventory Management"),
      ),
    );
  }
}
*/
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmes_app/app_theme/app_colors.dart';

import '../../widgets/bottom_tab_Item.dart';

class InventoryManagementScreen extends StatelessWidget {
  const InventoryManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primaryColor,
          foregroundColor: Colors.white,
          title: const Text(
            "Inventory Management",
            style: TextStyle(
                color: Colors.white
            ),
          ),
          bottom: const TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.white,
            tabs: [
              Tab(text: "Missing medications"),
              Tab(text: "Expired medicines"),
            ],
          ),
        ),
        body: const TabBarView(
          children: [

            Center(child: Text("Missing medications")),

            Center(child: Text("Expired medicines")),
          ],
        ),

      ),
    );
  }
}
