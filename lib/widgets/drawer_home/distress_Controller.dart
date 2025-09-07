import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../modules/profile/profile_controller.dart';

class DistressController extends GetxController {
  final ProfileController controller= Get.find();
  Future<void> sendDistressMessage() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        Get.snackbar("خطأ", "خدمة الموقع غير مفعلة");
        return;
      }
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          Get.snackbar("خطأ", "تم رفض إذن الموقع");
          return;
        }
      }
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      String latitude = position.latitude.toString();
      String longitude = position.longitude.toString();
      String email = "ghinasharaf0@gmail.com,makhoulsham@gmail.com";//elinef12it@gmail.com
      String subject = "نداء استغاثة";
      String body = """
         Pharmacy: ${controller.name.value}
         Phone Number:${controller.phone.value}
          🚨I am in danger!
          📍My current location:
           https://www.google.com/maps?q=$latitude,$longitude""";

      final Uri emailUri = Uri(
        scheme: 'mailto',
        path: email,
        query: 'subject=${Uri.encodeComponent(subject)}&body=${Uri.encodeComponent(body)}',
      );

      if (await canLaunchUrl(emailUri)) {
        await launchUrl(emailUri);
      } else {
        Get.snackbar("خطأ", "لا يمكن فتح تطبيق البريد");
      }
    } catch (e, stack) {
      print("خطأ: $e");
      print(stack);
      Get.snackbar("خطأ", "حدث خطأ أثناء إرسال الرسالة: $e");
    }
  }
}
