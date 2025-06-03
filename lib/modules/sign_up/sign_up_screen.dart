import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String? selectedRole;
  final List<String> roles = [
    'Repository Owner',
    'Pharmacy Owner',
    'Pharmacist',
    'Employee',
  ];

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController storeNameController = TextEditingController();
  final TextEditingController storeAddressController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirm = true;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildTextField('Name', nameController, icon: Icons.person),
          buildTextField('Phone Number', phoneController, icon: Icons.phone),
          buildTextField('Email', emailController, icon: Icons.email),
          buildTextField(
            'Password',
            passwordController,
            obscure: _obscurePassword,
            icon: Icons.lock,
            suffixIcon: IconButton(
              icon: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility),
              onPressed: () {
                setState(() {
                  _obscurePassword = !_obscurePassword;
                });
              },
            ),
          ),
          buildTextField(
            'Confirm Password',
            confirmPasswordController,
            obscure: _obscureConfirm,
            icon: Icons.lock_outline,
            suffixIcon: IconButton(
              icon: Icon(_obscureConfirm ? Icons.visibility_off : Icons.visibility),
              onPressed: () {
                setState(() {
                  _obscureConfirm = !_obscureConfirm;
                });
              },
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Role',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: const Color(0xFFF1F1F1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: DropdownButtonFormField<String>(
              value: selectedRole,
              hint: const Text("Select Role"),
              decoration: const InputDecoration(border: InputBorder.none),
              items: roles.map((role) {
                return DropdownMenuItem(value: role, child: Text(role));
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedRole = value;
                });
              },
            ),
          ),
          const SizedBox(height: 10),
          if (selectedRole == 'Repository Owner') ...[
            buildTextField('Repository Name', storeNameController, icon: Icons.store),
            buildTextField('Repository Address', storeAddressController, icon: Icons.location_on),
          ] else if (selectedRole == 'Pharmacy Owner') ...[
            buildTextField('Pharmacy Name', storeNameController, icon: Icons.local_pharmacy),
            buildTextField('Pharmacy Address', storeAddressController, icon: Icons.location_on),
          ],
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            height: 45,
            child: ElevatedButton(
              onPressed: () {
                // Action for sign up
              },
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
  }
  Widget buildTextField(
      String label,
      TextEditingController controller, {
        bool obscure = false,
        IconData? icon,
        Widget? suffixIcon,
      }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          const SizedBox(height: 6),
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFFF1F1F1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: TextField(
              controller: controller,
              obscureText: obscure,
              decoration: InputDecoration(
                hintText: "Enter your $label",
                hintStyle: const TextStyle(fontSize: 15,
                    color: Colors.grey),
                border: InputBorder.none,
                prefixIcon: icon != null ? Icon(icon, color: Colors.grey[700],size: 20,) : null,
                suffixIcon: suffixIcon,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
