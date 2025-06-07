import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmes_app/app_theme/app_colors.dart';
import 'modules/email_verification/email_verification_screen.dart';
import 'modules/forget_password/forget_password_screen.dart';
import 'modules/onboarding/onboarding_screen.dart';
import 'modules/reset_password/reset_password_screen.dart';
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
    initialRoute:'/splash' ,
    debugShowCheckedModeBanner: false,
    theme: ThemeData( colorScheme: ColorScheme.fromSeed(seedColor:AppColors.primaryColor),),
    getPages: [
      GetPage(name: '/signIn', page: ()=>SignInScreen()),
      GetPage(name: '/signUp', page: ()=>SignUpScreen()),
      GetPage(name: '/splash', page: ()=>SplashScreen()),
      GetPage(name: '/Onboarding', page: ()=>OnboardingScreen()),
      GetPage(name: '/forgetPass', page: ()=>ForgetPasswordScreen()),
      GetPage(name: '/emailVerify', page: ()=>EmailVerificationScreen()),
      GetPage(name: '/resetPass', page: ()=>ResetPasswordScreen()),

    ],
    );
  }
}

//mustafa sharaf
