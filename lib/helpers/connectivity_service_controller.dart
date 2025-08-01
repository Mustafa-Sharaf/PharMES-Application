import 'dart:async';
import 'dart:io';
import 'package:get/get.dart';
import 'package:pharmes_app/helpers/request_queue_manager.dart';


class ConnectivityService extends GetxService {
  RxBool isOffline = false.obs;
  RxBool showGreenBanner = false.obs;

  bool _wasOnline = true;
  bool _bannerShown = false;
 // bool _firstCheck = true;

  @override
  void onInit() {
    super.onInit();
    _startMonitoring();
  }

  void _startMonitoring() {
    Timer.periodic(Duration(seconds: 3), (timer) async {
      bool online = await isInternetAvailable();

      if (online && !_wasOnline) {
        isOffline.value = false;
        showGreenBanner.value = true;
        _bannerShown = true;
        await RequestQueueManager.processQueue();
        Future.delayed(Duration(seconds: 3), () {
          showGreenBanner.value = false;
        });
      }
      else if (!online) {
        isOffline.value = true;
        showGreenBanner.value = false;
        _bannerShown = false;
      }

      _wasOnline = online;
    });
  }

  Future<bool> isInternetAvailable() async {
    try {
      final result = await InternetAddress.lookup('google.com').timeout(Duration(seconds: 3));
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } catch (_) {
      return false;
    }
  }

}
