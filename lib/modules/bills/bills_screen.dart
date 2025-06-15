import 'package:flutter/material.dart';
import '../../app_theme/app_colors.dart';

class BillsScreen extends StatelessWidget {
  const BillsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primaryColor,
          foregroundColor: Colors.white,
          title: const Text(
            "Bills Management",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Column(
          children: [
            Container(
              color: Colors.white,
              child: const TabBar(
                labelColor: AppColors.primaryColor,
                unselectedLabelColor: Colors.grey,
                indicatorColor: AppColors.primaryColor,
                tabs: [
                  Tab(text: "Create a bill"),
                  Tab(text: "Bills"),
                ],
              ),
            ),
            const Expanded(
              child: TabBarView(
                children: [
                  Center(child: Text("Create a bill")),
                  Center(child: Text("Bills")),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
