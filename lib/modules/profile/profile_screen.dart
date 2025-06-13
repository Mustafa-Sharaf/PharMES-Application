import 'package:flutter/material.dart';
import 'package:pharmes_app/app_theme/app_colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 1.0),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.05,
                      width: MediaQuery.of(context).size.width * 0.1,
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Icon(Icons.arrow_back_ios, size: 15),
                    ),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.20),
                  const Text('My Profile', style: TextStyle(fontSize: 19)),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.3),
                ],
              ),
              const SizedBox(height: 20),
              Center(
                child: Stack(
                  children: [
                    Container(
                      width: 125,
                      height: 125,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [
                            Colors.blue,
                            Colors.green,
                            Colors.orange,
                            Colors.purple,
                            Colors.red,
                          ],
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: AssetImage('assets/images/logodrawer.jpg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: AppColors.primaryColor,
                        ),
                        child: const Icon(Icons.edit_outlined, size: 15),
                      ),
                    )
                  ],
                ),
              ),

              const SizedBox(height: 10),
              const Text('Eline Faramnd'),
              const Text('elineF12@gmail.com',
              style: TextStyle(color: AppColors.Gray)),

              const SizedBox(height: 10),

              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                margin: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                width: MediaQuery.of(context).size.width * 0.9,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(Icons.person),
                      title: Text('Eline Faramnd',style: TextStyle(fontSize: 15),),
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(Icons.email),
                      title: Text('elineF12@gmail.com',style: TextStyle(fontSize: 15),),
                     // subtitle: Text('elineF12@gmail.com'),
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(Icons.phone),
                      title: Text('+963 936 502 002',style: TextStyle(fontSize: 15),),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                width: MediaQuery.of(context).size.width * 0.9,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.dark_mode),
                        const SizedBox(width: 10),
                        const Expanded(child: Text('Dark Mode')),
                        Switch(
                          activeTrackColor: AppColors.primaryColor,
                          value: true,
                          onChanged: (_) {},
                        ),
                      ],
                    ),
                    const Divider(),
                    Row(
                      children: [
                        const Icon(Icons.language),
                        const SizedBox(width: 10),
                        const Expanded(child: Text('Language')),
                        const Text('English'),
                      ],
                    ),
                    const Divider(),
                    Row(
                      children: [
                        const Icon(Icons.edit),
                        const SizedBox(width: 10),
                        const Expanded(child: Text('Edit Profile')),
                      ],
                    ),
                    const Divider(),
                    Row(
                      children: [
                        const Icon(Icons.logout, color: Colors.red),
                        const SizedBox(width: 10),
                        const Expanded(
                          child: Text(
                            'Log Out',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
