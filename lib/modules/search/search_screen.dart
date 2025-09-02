import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmes_app/app_theme/app_colors.dart';
import '../../widgets/medicine_component.dart';
import '../home_page/medicine_content_controller.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeContentController controller = Get.find<HomeContentController>();
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        foregroundColor: AppColors.white,
        title: Text(
          "Search medicines",
          style: TextStyle(
            color: AppColors.white,
            fontSize: MediaQuery.of(context).size.width * 0.05,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.03),
            child: TextField(
              onChanged: controller.searchMedicines,
              onSubmitted: controller.addRecentSearch,
              decoration: InputDecoration(
                hintText: 'Search medicines...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: AppColors.primaryColor, width: 2),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.03),
            child: Obx(() {
              if (controller.recentSearches.isEmpty) return SizedBox();
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Recent Searches",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, size: 20),
                        onPressed: controller.clearRecentSearches,
                      ),
                    ],
                  ),
                  Wrap(
                    spacing: 6,
                    runSpacing: -8,
                    children: controller.recentSearches.map((search) {
                      return ActionChip(
                        label: Text(search),
                        backgroundColor: Colors.grey[300],
                        onPressed: () {
                          controller.searchMedicines(search);
                        },
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 10),
                ],
              );
            }),
          ),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              }
              if (controller.filteredMedicines.isEmpty) {
                return Center(child: Text("No results found"));
              }
              return ListView.builder(
                itemCount: controller.filteredMedicines.length,
                itemBuilder: (context, index) {
                  final medicines = controller.filteredMedicines[index];
                  return MedicineComponent(med: medicines,);
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
