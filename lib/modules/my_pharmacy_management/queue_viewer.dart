import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import '../../app_theme/app_colors.dart';

class QueueViewer extends StatelessWidget {
  final box = GetStorage();

  final ValueNotifier<List<Map<String, dynamic>>> requestList = ValueNotifier(
    [],
  );

  QueueViewer({super.key}) {
    _loadQueue();

    Timer.periodic(const Duration(seconds: 3), (timer) {
      _loadQueue();
    });
  }

  void _loadQueue() {
    final log = List<Map<String, dynamic>>.from(box.read('request_log') ?? []);
    final queue = List<Map<String, dynamic>>.from(
      box.read('request_queue') ?? [],
    );

    final combined = [...log];
    for (var qItem in queue) {
      final exists = combined.any(
        (lItem) =>
            lItem['url'] == qItem['url'] &&
            jsonEncode(lItem['body']) == jsonEncode(qItem['body']),
      );
      if (!exists) {
        combined.add(qItem);
      }
    }

    requestList.value = combined;
  }

  void removeItem(int index) {
    final updated = [...requestList.value];
    updated.removeAt(index);
    box.write('request_log', updated);
    requestList.value = updated;
  }

  void clearAll() {
    box.write('request_log', []);
    requestList.value = [];
  }

  Icon getStatusIcon(String? status) {
    switch (status) {
      case 'done':
        return const Icon(Icons.check_circle, color: Colors.green);
      case 'failed':
        return const Icon(Icons.cancel, color: Colors.red);
      case 'pending':
      default:
        return const Icon(Icons.error_outline, color: Colors.orange);
    }
  }

  String getStatusText(Map<String, dynamic> item) {
    final userName = item['userName'] ?? 'user';
    final permissions = item['body']?['permissions_id']?.join(', ') ?? '';
    switch (item['status']) {
      case 'done':
        return ' permissions $permissions assigned to "$userName"';
      case 'failed':
        return ' Failed assigning permissions to "$userName"';
      case 'pending':
      default:
        return ' Waiting to assign permissions to "$userName"';
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<Map<String, dynamic>>>(
      valueListenable: requestList,
      builder: (context, queue, _) {
        return Scaffold(
          backgroundColor: AppColors.white,
          appBar: AppBar(
            title: const Text(
              'Request Queue Viewer',
              style: TextStyle(color: AppColors.white),
            ),
            backgroundColor: AppColors.primaryColor,
            foregroundColor: AppColors.white,
          ),
          body: queue.isEmpty
              ? const Center(child: Text('No requests in queue.'))
              : ListView.builder(
                  itemCount: queue.length,
                  itemBuilder: (context, index) {
                    final item = queue[index];
                    return ListTile(
                      leading: getStatusIcon(item['status']),
                      title: Text(getStatusText(item)),
                      trailing: IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () => removeItem(index),
                      ),
                    );
                  },
                ),
          bottomNavigationBar: queue.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ElevatedButton.icon(
                    onPressed: clearAll,
                    icon: const Icon(Icons.delete_forever, color: Colors.white),
                    label: const Text(
                      'Clear All',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red.shade600,
                    ),
                  ),
                )
              : null,
        );
      },
    );
  }
}
