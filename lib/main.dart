import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'modules/email_verification/email_verification_screen.dart';
import 'modules/forget_password/forget_password_screen.dart';
import 'modules/home_page/home_page_screen.dart';
import 'modules/onboarding/onboarding_screen.dart';
import 'modules/reset_password/reset_password_screen.dart';
import 'modules/setting/permissions_bindings.dart';
import 'modules/setting/permissions_screen.dart';
import 'modules/sign_in/sign_in_bindings.dart';
import 'modules/sign_in/sign_in_screen.dart';
import 'modules/sign_up/sign_up_screen.dart';
import 'modules/splash/splash_screen.dart';
import 'modules/test.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  final box = GetStorage();
  String? token = box.read('token');
  runApp(MyApp(initialRoute: token == null ? '/splash' : '/test'));
}

class MyApp extends StatelessWidget {
  final String initialRoute;
  const MyApp({Key? key, required this.initialRoute}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: initialRoute,
      debugShowCheckedModeBanner: false,
    getPages: [
      GetPage(name: '/signIn', page: ()=>SignInScreen(),binding: SignInBindings()),
      GetPage(name: '/signUp', page: ()=>SignUpScreen()),
      GetPage(name: '/splash', page: ()=>SplashScreen()),
      GetPage(name: '/Onboarding', page: ()=>OnboardingScreen()),
      GetPage(name: '/forgetpass', page: ()=>ForgetPasswordScreen()),
      GetPage(name: '/emailverify', page: ()=>EmailVerificationScreen()),
      GetPage(name: '/resetpass', page: ()=>ResetPasswordScreen()),
      GetPage(name: '/home', page: ()=>HomePageScreen()),
      GetPage(name: '/test', page: ()=>Test()),
      GetPage(name: '/setting', page: ()=>PermissionsScreen(),binding: PermissionsBindings()),


    ],
    );
  }
}
//e

