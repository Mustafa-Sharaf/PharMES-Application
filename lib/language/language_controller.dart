/*
import 'dart:ui';
import 'package:get/get.dart';
import '../main.dart';

class MyLanguageController extends GetxController{

  Locale intiaLanguage = sharedPreferences!.getString("lang") == "ar" ? Locale("ar") : Locale("en");

  void changeLanguage(String codeLang){
    Locale locale=Locale(codeLang);
    sharedPreferences!.setString("lang",codeLang);
    Get.updateLocale(locale);

  }

}
*/

import 'dart:ui';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
/*

class MyLanguageController extends GetxController {
  final GetStorage box = GetStorage();

  late Locale intiaLanguage;

  @override
  void onInit() {
    super.onInit();
    String? langCode = box.read("lang");
    intiaLanguage = (langCode == "ar") ? const Locale("ar") : const Locale("en");
  }

  void changeLanguage(String codeLang) {
    Locale locale = Locale(codeLang);
    box.write("lang", codeLang);
    Get.updateLocale(locale);
  }
}
*/
class MyLanguageController extends GetxController {
  final GetStorage box = GetStorage();

  late Rx<Locale> intiaLanguage;

  @override
  void onInit() {
    super.onInit();
    String? langCode = box.read("lang");
    intiaLanguage = Rx((langCode == "ar") ? const Locale("ar") : const Locale("en"));
  }

  void changeLanguage(String codeLang) {
    Locale locale = Locale(codeLang);
    box.write("lang", codeLang);
    intiaLanguage.value = locale;   // هنا يمكن استخدام .value
    Get.updateLocale(locale);
  }
}
