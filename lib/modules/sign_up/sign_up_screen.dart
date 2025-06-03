import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../widgets/custom_text_field.dart';
import 'sign_up_controller.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignUpController>(
      init: SignUpController(),
      builder: (controller) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextField(
                label: 'Name',
                controller: controller.nameController,
                icon: Icons.person,
              ),
              CustomTextField(
                label: 'Phone Number',
                controller: controller.phoneController,
                icon: Icons.phone,
              ),
              CustomTextField(
                label: 'Email',
                controller: controller.emailController,
                icon: Icons.email,
              ),
              CustomTextField(
                label: 'Password',
                controller: controller.passwordController,
                icon: Icons.lock,
                obscure: controller.obscurePassword,
                suffixIcon: IconButton(
                  icon: Icon(controller.obscurePassword ? Icons.visibility_off : Icons.visibility),
                  onPressed: controller.togglePasswordVisibility,
                ),
              ),
              CustomTextField(
                label: 'Confirm Password',
                controller: controller.confirmPasswordController,
                icon: Icons.lock,
                obscure: controller.obscureConfirmPassword,
                suffixIcon: IconButton(
                  icon: Icon(controller.obscureConfirmPassword ? Icons.visibility_off : Icons.visibility),
                  onPressed: controller.toggleConfirmPasswordVisibility,
                ),
              ),
              const SizedBox(height: 10),
              const Text('Role', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
              const SizedBox(height: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F1F1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: DropdownButtonFormField<String>(
                  value: controller.selectedRole,
                  hint: const Text("Select Role"),
                  decoration: const InputDecoration(border: InputBorder.none),
                  items: controller.roles.map((role) {
                    return DropdownMenuItem(value: role, child: Text(role));
                  }).toList(),
                  onChanged: controller.changeRole,
                ),
              ),
              const SizedBox(height: 10),
              if (controller.selectedRole == 'Repository Owner') ...[
                CustomTextField(
                  label: 'Repository Name',
                  controller: controller.storeNameController,
                  icon: Icons.store,
                ),
                CustomTextField(
                  label: 'Repository Address',
                  controller: controller.storeAddressController,
                  icon: Icons.location_on,
                ),
                CustomTextField(
                  label: 'Repository Phone',
                  controller: controller.storePhoneController,
                  icon: Icons.phone,
                ),
              ] else if (controller.selectedRole == 'Pharmacy Owner') ...[
                CustomTextField(
                  label: 'Pharmacy Name',
                  controller: controller.storeNameController,
                  icon: Icons.local_pharmacy,
                ),
                CustomTextField(
                  label: 'Pharmacy Address',
                  controller: controller.storeAddressController,
                  icon: Icons.location_on,
                ),
                CustomTextField(
                  label: 'Pharmacy Phone',
                  controller: controller.storePhoneController,
                  icon: Icons.phone,
                ),
              ],
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                height: 45,
                child: ElevatedButton(
                  onPressed: controller.signUp,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF245FD5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
