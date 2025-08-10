import 'package:flutter/material.dart';

class MedicineInfoCard extends StatelessWidget {
  final Map<String, dynamic> medicine;
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;
  final double widthFactor;

  const MedicineInfoCard({
    super.key,
    required this.medicine,
    required this.onIncrease,
    required this.onDecrease,
    this.widthFactor = 0.2,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    medicine["trade_name"],
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text("الاسم العلمي: ${medicine["scientific_name"]}"),
                  Text("الشكل الصيدلاني: ${medicine["pharmaceutical_form"]}"),
                  Row(
                    children: [
                      Text("الجرعة: ${medicine["dosage"]}"),
                      SizedBox(width: MediaQuery.of(context).size.width * widthFactor),
                      Text("السعر: ${medicine["price"]}"),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              width: 40,
              padding: const EdgeInsets.symmetric(vertical: 2),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: onIncrease,
                    child: const Icon(Icons.add_circle, color: Colors.green, size: 20),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    "${medicine["quantity"]}",
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 3),
                  GestureDetector(
                    onTap: onDecrease,
                    child: const Icon(Icons.remove_circle, color: Colors.red, size: 20),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
