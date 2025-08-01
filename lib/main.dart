import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pharmes_app/language/language.dart';
import 'package:pharmes_app/modules/customer_debts/customer_debts.dart';
import 'app_theme/app_theme.dart';
import 'app_theme/theme_controller.dart';
import 'helpers/connectivity_service_controller.dart';
import 'language/language_controller.dart';
import 'modules/electronic_inventory_pictures/electronic_inventory_pictures.dart';
import 'modules/email_verification/email_verification_screen.dart';
import 'modules/forget_password/forget_password_screen.dart';
import 'modules/home_page/home_screen.dart';
import 'modules/inventory_by_name/inventory_by_name.dart';
import 'modules/medicine_inventory_management/medicine_inventory_management.dart';
import 'modules/medicine_requests/medicine_requests.dart';
import 'modules/my_pharmacy_management/pharmacy_management_screen.dart';
import 'modules/notifications/notifications.dart';
import 'modules/onboarding/onboarding_screen.dart';
import 'modules/permissions/permissions_bindings.dart';
import 'modules/permissions/permissions_screen.dart';
import 'modules/profile/profile_screen.dart';
import 'modules/profile/update_profile _screen.dart';
import 'modules/reset_password/reset_password_screen.dart';
import 'modules/search/search_screen.dart';
import 'modules/sign_in/sign_in_bindings.dart';
import 'modules/sign_in/sign_in_screen.dart';
import 'modules/sign_up/sign_up_screen.dart';
import 'modules/special_requests/create_special_requests.dart';
import 'modules/special_requests/edit_special_requests.dart';
import 'modules/special_requests/special_requests.dart';
import 'modules/splash/splash_screen.dart';
import 'modules/test.dart';
import 'notifications.dart';


void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  final box = GetStorage();
  Get.put(ConnectivityService());
  Get.put(MyLanguageController());
  final themeController =Get.put(ThemeController());
  themeController.loadThemeFromStorage();
  final token = box.read<String>('token');
  print('[main] Token from storage: $token');
  await Firebase.initializeApp();
  await Notifications().initNotifications();
  runApp(MyApp(initialRoute: token == null ? '/splash' : '/home'));


}

class MyApp extends StatelessWidget {
  final String initialRoute;
  const MyApp({Key? key, required this.initialRoute}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final myLanguageController = Get.find<MyLanguageController>();
    final ThemeController themeController = Get.find();
    return GetMaterialApp(
      initialRoute:initialRoute,
      debugShowCheckedModeBanner: false,
      theme: AppThemes.lightTheme,
      darkTheme: AppThemes.darkTheme,
      themeMode: themeController.isDarkMode.value ? ThemeMode.dark : ThemeMode.light,
      locale:myLanguageController.intiaLanguage.value,
      translations: MyLanguage(),
      getPages: [
        GetPage(name: '/signIn', page: ()=>SignInScreen(),binding: SignInBindings()),
        GetPage(name: '/signUp', page: ()=>SignUpScreen()),
        GetPage(name: '/splash', page: ()=>SplashScreen()),
        GetPage(name: '/Onboarding', page: ()=>OnboardingScreen()),
        GetPage(name: '/forgetPass', page: ()=>ForgetPasswordScreen()),
        GetPage(name: '/emailVerify', page: ()=>EmailVerificationScreen()),
        GetPage(name: '/resetPass', page: ()=>ResetPasswordScreen()),
        GetPage(name: '/home', page: ()=>HomeScreen()),
        GetPage(name: '/searchScreen', page: ()=>SearchScreen()),
        GetPage(name: '/test', page: ()=>Test()),
        GetPage(name: '/permissionScreen', page: ()=>PermissionsScreen(),binding: PermissionsBindings()),
        GetPage(name: '/notificationsScreen', page: ()=>NotificationsScreen()),
        GetPage(name: '/profileScreen', page: ()=>ProfileScreen()),
        GetPage(name: '/pharmacyManagementScreen', page: ()=>PharmacyManagementScreen()),
        GetPage(name: '/medicineInventoryManagement', page: ()=>MedicineInventoryManagement()),
        GetPage(name: '/updateProfile', page: ()=>UpdateProfileScreen()),
        GetPage(name: '/specialRequests', page: ()=>SpecialRequests()),
        GetPage(name: '/createSpecialRequests', page: ()=>CreateSpecialRequests()),
        GetPage(name: '/editSpecialRequests', page: ()=>EditSpecialRequests()),
        GetPage(name: '/customerDebts', page: ()=>CustomerDebts()),
        GetPage(name: '/medicineRequests', page: ()=>MedicineRequests()),
        GetPage(name: '/electronicInventoryPictures', page: ()=>ElectronicInventoryPictures()),
        GetPage(name: '/inventoryByName', page: ()=>InventoryByName()),
      ],
    );
  }
}


