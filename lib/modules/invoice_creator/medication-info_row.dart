import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class MedicationInfoRow extends StatelessWidget {
  final RxBool isPsychotropic;
  final RxString customerNameEditing;
  final RxString nationalId;
  final double total;
  final ValueChanged<bool?> onPsychotropicChanged;

  const MedicationInfoRow({
    super.key,
    required this.isPsychotropic,
    required this.customerNameEditing,
    required this.nationalId,
    required this.total,
    required this.onPsychotropicChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const SizedBox(width: 4),
            const Tooltip(
              message: "دواء يحتاج وصفة طبية خاصة",
              child: Text("؟", style: TextStyle(fontSize: 18)),
            ),
            const Text("دواء نفسي"),
            Obx(() => Checkbox(
              value: isPsychotropic.value,
              onChanged: onPsychotropicChanged,
            )),
          ],
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            "المجموع الكلي: \$${total.toStringAsFixed(2)}",
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
