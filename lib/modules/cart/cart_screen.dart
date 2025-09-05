import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app_theme/app_colors.dart';
import 'cart_controller.dart';

class CartScreen extends StatelessWidget {
  CartScreen({super.key});

  final CartController controller = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: controller.repositories.length,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primaryColor,
          foregroundColor: Colors.white,
          title: const Text("Cart"),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(48),
            child: Obx(
              () => Container(
                color: Colors.white,
                child: TabBar(
                  isScrollable: true,
                  indicator: UnderlineTabIndicator(
                    borderSide: BorderSide(
                      width: 3,
                      color: AppColors.primaryColor,
                    ),
                    insets: EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
                  ),
                  labelColor: AppColors.primaryColor,
                  unselectedLabelColor:
                      Colors.black54,
                  tabs: controller.repositories
                      .map((repo) => Tab(text: repo.name))
                      .toList(),
                  onTap: (index) {
                    final repo = controller.repositories[index];
                    controller.selectRepository(repo.id);
                  },
                ),
              ),
            ),
          ),
        ),

        body: Obx(
          () => TabBarView(
            children: controller.repositories.map((repo) {
              return Center(
                child: Text(
                  "محتوى المستودع: ${repo.name}",
                  style: const TextStyle(fontSize: 18),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
