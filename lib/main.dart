import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'modules/sign_in/sign_in_screen.dart';
import 'modules/sign_up/sign_up_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
    initialRoute:'/signIn' ,
    debugShowCheckedModeBanner: false,
    getPages: [
      GetPage(name: '/signIn', page: ()=>SignInScreen()),
      GetPage(name: '/signUp', page: ()=>SignUpScreen())
    ],
    );
  }
}


