import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
class Test extends StatelessWidget {
  const Test({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ssss')
      ),
      body: ElevatedButton(onPressed: (){
        Get.toNamed('/home');
      }, child: Text('Go')),
    );
  }
}
