import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmes_app/modules/setting/setting_screen.dart';
import 'modules/email_verification/email_verification_screen.dart';
import 'modules/forget_password/forget_password_screen.dart';
import 'modules/home_page/home_page_screen.dart';
import 'modules/logout/logout_screen.dart';
import 'modules/my_pharmacy_management/pharmacy_management_screen.dart';
import 'modules/notifications/notifications.dart';
import 'modules/onboarding/onboarding_screen.dart';
import 'modules/reset_password/reset_password_screen.dart';
import 'modules/search/search_screen.dart';
import 'modules/sign_in/sign_in_bindings.dart';
import 'modules/sign_in/sign_in_screen.dart';
import 'modules/sign_up/sign_up_screen.dart';
import 'modules/splash/splash_screen.dart';
import 'notifications.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Notifications().initNotifications();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
    initialRoute:'/home' ,
    debugShowCheckedModeBanner: false,
    getPages: [
      GetPage(name: '/signIn', page: ()=>SignInScreen(),binding: SignInBindings()),
      GetPage(name: '/signUp', page: ()=>SignUpScreen()),
      GetPage(name: '/splash', page: ()=>SplashScreen()),
      GetPage(name: '/Onboarding', page: ()=>OnboardingScreen()),
      GetPage(name: '/forgetpass', page: ()=>ForgetPasswordScreen()),
      GetPage(name: '/emailverify', page: ()=>EmailVerificationScreen()),
      GetPage(name: '/resetpass', page: ()=>ResetPasswordScreen()),
      GetPage(name: '/home', page: ()=>HomeScreen()),
      GetPage(name: '/searchScreen', page: ()=>SearchScreen()),
      GetPage(name: '/notificationsScreen', page: ()=>NotificationsScreen()),
      GetPage(name: '/settingScreen', page: ()=>SettingScreen()),
      GetPage(name: '/pharmacyManagementScreen', page: ()=>PharmacyManagementScreen()),
      GetPage(name: '/logoutScreen', page: ()=>LogoutScreen()),

    ],
    );
  }
}


