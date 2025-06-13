import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pharmes_app/app_theme/app_colors.dart';
import 'package:pharmes_app/language/language.dart';
import 'modules/email_verification/email_verification_screen.dart';
import 'modules/forget_password/forget_password_screen.dart';
import 'modules/home_page/home_page_screen.dart';
import 'modules/my_pharmacy_management/pharmacy_management_screen.dart';
import 'modules/notifications/notifications.dart';
import 'modules/onboarding/onboarding_screen.dart';
import 'modules/profile/connectivity_service_controller.dart';
import 'modules/profile/permissions_bindings.dart';
import 'modules/profile/permissions_screen.dart';
import 'modules/profile/profile_screen.dart';
import 'modules/reset_password/reset_password_screen.dart';
import 'modules/search/search_screen.dart';
import 'modules/sign_in/sign_in_bindings.dart';
import 'modules/sign_in/sign_in_screen.dart';
import 'modules/sign_up/sign_up_screen.dart';
import 'modules/splash/splash_screen.dart';
import 'modules/test.dart';
import 'notifications.dart';



void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  final box = GetStorage();
  Get.put(ConnectivityService());
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
    return GetMaterialApp(
      initialRoute: initialRoute,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: AppColors.primaryColor),
      locale:Get.deviceLocale,
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

      ],
    );
  }
}


//mustafa sharaf