import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmes_app/all_users/all_user_Controler.dart';

import '../app_theme/app_colors.dart';

class AllUsers extends StatelessWidget {
  const AllUsers({super.key});

  @override
  Widget build(BuildContext context) {
    final UsersController controller = Get.put(UsersController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        foregroundColor: AppColors.white,
        title: Text(
          "All Users",
          style: TextStyle(
            color: AppColors.white,
            fontSize: MediaQuery.of(context).size.width * 0.05,
          ),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        if (controller.persons.isEmpty) {
          return Center(child: Text('No persons found'));
        }
        return ListView.builder(
          itemCount: controller.persons.length,
          itemBuilder: (context, index) {
            final person = controller.persons[index];
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 3,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 3,
                child: ListTile(
                  leading:Text("👨‍⚕️",style: TextStyle(fontSize: 30),),//+"👩‍⚕️"
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    Text(person.name,style: TextStyle(color: Colors.black,fontSize: 20),),
                    Text(person.email,style: TextStyle(color: Colors.grey,fontSize: 15),),
                  ],),

                  trailing:  CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.white,
                    backgroundImage: AssetImage('assets/images/pharmacy-symbol.png'),
                  ),
                ),

              ),
            );
          },
        );
      }),
    );
  }
}
