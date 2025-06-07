import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmes_app/app_theme/app_colors.dart';
import 'package:pharmes_app/modules/sign_in/sign_in_controller.dart';
import 'package:pharmes_app/modules/sign_up/sign_up_screen.dart';
import '../../helpers/custom_clipper.dart';
import '../../widgets/custom_text_field.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SignInController controller = Get.put(SignInController());
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        body: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: EdgeInsets.zero,
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Stack(
                    children: [
                      ClipPath(
                        clipper: DiagonalClipper(),
                        child: Container(
                          height: 300,
                          color: AppColors.primaryColor,
                          child: Align(
                            alignment: const Alignment(-0.3, -0.3),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset('assets/images/logo.jpg', height: 75, width: 75),
                                const Text('PharMES',
                                    style: TextStyle(fontSize: 32, color: Colors.white, fontStyle: FontStyle.italic)),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 180,
                        left: 0,
                        right: 0,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 35),
                          child: Material(
                            elevation: 8,
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                children: [
                                  const TabBar(
                                    labelColor: AppColors.primaryColor,
                                    unselectedLabelColor: Colors.grey,
                                    labelStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                    indicatorColor: Color(0xFF1E62F2),
                                    indicatorWeight: 2,
                                    tabs: [
                                      Tab(text: 'Sign in'),
                                      Tab(text: 'Sign Up'),
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                  SizedBox(
                                    height: 428,
                                    child: TabBarView(
                                      children: [
                                        GetBuilder<SignInController>(
                                          builder: (controller) {
                                            return Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                CustomTextField(
                                                  label: 'Email',
                                                  controller: controller.emailController,
                                                  icon: Icons.email,
                                                ),
                                                Obx(() => CustomTextField(
                                                  label: 'Password',
                                                  controller: controller.passwordController,
                                                  icon: Icons.lock,
                                                  obscure: controller.obscurePassword.value,
                                                  suffixIcon: IconButton(
                                                    icon: Icon(
                                                      controller.obscurePassword.value
                                                          ? Icons.visibility_off
                                                          : Icons.visibility,
                                                      color: Colors.grey[700],
                                                      size: 22,
                                                    ),
                                                    onPressed: controller.togglePasswordVisibility,
                                                  ),
                                                )),

                                                Align(
                                                  alignment: Alignment.bottomRight,
                                                  child: TextButton(
                                                    onPressed: () {Get.toNamed('/forgetPass');},
                                                    child: const Text(
                                                      'Forget Password?',
                                                      style: TextStyle(color: AppColors.primaryColor, fontSize: 14),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(height: 20),
                                                SizedBox(
                                                  width: double.infinity,
                                                  height: 45,
                                                  child: ElevatedButton(
                                                    onPressed: controller.signIn,
                                                    style: ElevatedButton.styleFrom(
                                                      backgroundColor: const Color(0xFF245FD5),
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(25),
                                                      ),
                                                    ),
                                                    child: const Text('Sign In',
                                                        style: TextStyle(fontSize: 16, color: Colors.white)),
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                        ),
                                        const SignUpScreen(),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

