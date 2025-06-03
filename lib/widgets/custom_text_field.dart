// import 'package:flutter/material.dart';
// import '../app_theme/app_colors.dart';
//
// class CustomTextField extends StatelessWidget {
//   final TextEditingController controller;
//   final String label;
//   final bool obscure;
//   final IconData? icon;
//   final Widget? suffixIcon;
//
//   const CustomTextField({
//     Key? key,
//     required this.controller,
//     required this.label,
//     this.obscure = false,
//     this.icon,
//     this.suffixIcon,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 6),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(label,
//               style: const TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w500,
//                   color: AppColors.black)),
//           const SizedBox(height: 6),
//           Container(
//             decoration: BoxDecoration(
//               color: AppColors.backgroundGray,
//               borderRadius: BorderRadius.circular(20),
//             ),
//             child: TextField(
//               controller: controller,
//               obscureText: obscure,
//               decoration: InputDecoration(
//                 hintText: "Enter your $label",
//                 hintStyle: const TextStyle(fontSize: 15, color: Colors.grey),
//                 border: InputBorder.none,
//                 prefixIcon: icon != null
//                     ? Icon(icon, color: Colors.grey[700], size: 20)
//                     : null,
//                 suffixIcon: suffixIcon,
//                 contentPadding:
//                 const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
