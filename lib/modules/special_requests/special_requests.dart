import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmes_app/modules/special_requests/special_requests_controller.dart';
import '../../app_theme/app_colors.dart';

class SpecialRequests extends StatelessWidget {
  const SpecialRequests({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SpecialRequestsController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        foregroundColor: AppColors.white,
        actions: [
          const Text(
            "Special Requests",
            style: TextStyle(color: AppColors.white, fontSize: 25),
          ),
          SizedBox(width: MediaQuery.of(context).size.width * 0.2),
          IconButton(
            onPressed: () => Get.toNamed('/createSpecialRequests'),
            icon: const Icon(Icons.add_circle, size: 25),
          ),
          SizedBox(width: MediaQuery.of(context).size.width * 0.08),
        ],
      ),
      body: Obx(() {
        if (controller.specialRequests.isEmpty) {
          return const Center(child: Text("No special requests"));
        }
        return ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: controller.specialRequests.length,
          itemBuilder: (context, index) {
            final request = controller.specialRequests[index];

            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 3,

              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 3,
                child: ListTile(
                  leading: const Icon(
                    Icons.note_alt,
                    color: AppColors.primaryColor,
                  ),
                  title: Text(
                    request.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Required medications: ${request.medications}"),
                      const SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Total price: ${request.total}"),
                          Text("Phone: ${request.phone}"),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Amount paid: ${request.paid}"),
                          Text("Remaining: ${request.remaining}"),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.orange),
                            onPressed: () {
                              controller.fillForm(request);
                              Get.toNamed(
                                '/editSpecialRequests',
                                arguments: request,
                              );
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () =>
                                controller.deleteRequest(request.id),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
