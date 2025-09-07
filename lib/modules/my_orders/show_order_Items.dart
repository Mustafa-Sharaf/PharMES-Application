import 'package:flutter/material.dart';
import '../../app_theme/app_colors.dart';
import '../my_orders/my_orders_model.dart';

class ShowOrderItems extends StatelessWidget {
  final MyOrdersModel order;
  const ShowOrderItems({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        foregroundColor: AppColors.white,
        title: Text("Order #${order.id}"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(8),
              itemCount: order.items.length,
              separatorBuilder: (_, __) => const Divider(), // بدل Divider بخانة فارغة
              itemBuilder: (context, index) {
                final item = order.items[index];
                return Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.blue.shade50,
                        child: const Icon(Icons.medication, color: Colors.blue),
                      ),
                      const SizedBox(width: 12),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(item.medicine.tradeName,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16)),
                            const SizedBox(height: 4),
                            Text("Quantity: ${item.quantity}",
                                style: const TextStyle(fontSize: 14)),
                            Text("Titer: ${item.medicine.titer}",
                                style: const TextStyle(fontSize: 14)),
                            Text("Purchase Price: ${item.purchasePrice}",
                                style: const TextStyle(fontSize: 14)),

                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text("Batch: ${item.batch}",
                              style: const TextStyle(fontSize: 13, color: Colors.grey)),
                          Text("Expiration: ${item.expirationDate}",
                              style: const TextStyle(fontSize: 13, color: Colors.red)),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          )

        ],
      ),
    );
  }
}
