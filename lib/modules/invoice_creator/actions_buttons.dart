import 'package:flutter/material.dart';

class ActionsButtons extends StatelessWidget {
  final VoidCallback onSave;
  final VoidCallback onCancel;
  final VoidCallback onPrint;
  const ActionsButtons({
    super.key,
    required this.onSave,
    required this.onCancel,
    required this.onPrint,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ElevatedButton(
          onPressed: onSave,
          style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
          child: const Text("حفظ"),
        ),
        const SizedBox(width: 8),
        ElevatedButton(
          onPressed: onCancel,
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          child: const Text("إلغاء"),
        ),
        const SizedBox(width: 8),
        ElevatedButton(
          onPressed: onPrint,
          style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
          child: const Text("طباعة"),
        ),
      ],
    );
  }
}
