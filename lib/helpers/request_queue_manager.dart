import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../../configurations/http_helpers.dart';


class RequestQueueManager {
  static final _queueBox = GetStorage();
  static bool _isProcessing = false;

  static Future<void> init() async {
    await GetStorage.init();
  }

  static Future<void> addToQueue(Map<String, dynamic> request) async {
    final box = GetStorage();

    List<Map<String, dynamic>> queue =
    List<Map<String, dynamic>>.from(box.read('request_queue') ?? []);

    List<Map<String, dynamic>> log =
    List<Map<String, dynamic>>.from(box.read('request_log') ?? []);

    final isInQueue = queue.any((existing) =>
    existing['url'] == request['url'] &&
        jsonEncode(existing['body']) == jsonEncode(request['body']));

    final isInLog = log.any((existing) =>
    existing['url'] == request['url'] &&
        jsonEncode(existing['body']) == jsonEncode(request['body']) &&
        existing['status'] == 'done');

    if (!isInQueue && !isInLog) {
      request['status'] = 'pending';
      queue.add(request);
      await box.write('request_queue', queue);
      print('[QUEUE] Request added to queue. Total: ${queue.length}');
    } else {
      print('[QUEUE] Duplicate or already logged request skipped.');
    }
  }

  static Future<void> processQueue() async {
    if (_isProcessing) return;
    _isProcessing = true;

    final box = GetStorage();
    List<Map<String, dynamic>> queue =
    List<Map<String, dynamic>>.from(box.read('request_queue') ?? []);
    List<Map<String, dynamic>> log =
    List<Map<String, dynamic>>.from(box.read('request_log') ?? []);

    if (queue.isEmpty) {
      _isProcessing = false;
      return;
    }

    print('[QUEUE] Trying to send ${queue.length} queued requests...');
    List<Map<String, dynamic>> newQueue = [];

    for (var request in queue) {
      try {

/* final response = await HttpHelper.postData(
          url: request['url'],
          body: request['body'],
        );*/

        http.Response response;

        // إذا body فيه List أو تركيبة معقدة → استعمل postJson
        if (request['body'] is Map<String, dynamic>) {
          response = await HttpHelper.postJson(
            url: request['url'],
            body: request['body'],
          );
        } else {
          // fallback للـ postData (زي ما كنت تستخدم)
          response = await HttpHelper.postData(
            url: request['url'],
            body: request['body'],
          );
        }


        final responseBody = jsonDecode(response.body);
        final userName = request['userName'] ?? 'user';
        print('[QUEUE] Response body: $responseBody');

        if (response.statusCode == 200 &&
            (responseBody.containsKey('added') ||
                responseBody['success'] == true ||
                responseBody['status']?.toString().toLowerCase() == 'success')) {
          print('[QUEUE]  Request sent successfully');
          request['status'] = 'done';
          log.add(request);
          Get.snackbar('Success', 'permissions assigned successfully to "$userName"',
              backgroundColor: Colors.green.withOpacity(0.5), colorText: Colors.white);
        } else {
          print('[QUEUE]  Server responded but not successful');
          request['status'] = 'failed';
          newQueue.insert(0,request);
          log.add(request);
          //Get.toNamed('/signIn');
        }
      } catch (e) {
        print('[QUEUE]  Error sending request: $e');
        request['status'] = 'pending';
        newQueue.insert(0,request);
        log.add(request);
      }
    }

    await box.write('request_queue', newQueue);
    await box.write('request_log', log);

    print('[QUEUE] Remaining in queue: ${newQueue.length}');
    _isProcessing = false;
  }


}

