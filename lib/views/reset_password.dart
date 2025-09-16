// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';

// class ResetPassword extends StatefulWidget {
//   const ResetPassword({super.key});

//   @override
//   State<ResetPassword> createState() => _ResetPasswordState();
// }

// class _ResetPasswordState extends State<ResetPassword> {
//   final formkey = GlobalKey<FormState>();
//   final emailController = TextEditingController();
//   final otpController = TextEditingController();
//   final newPasswordController = TextEditingController();
//   final confirmPasswordController = TextEditingController();

//   bool obscureNewPassword = true;
//   bool obscureConfirmPassword = true;

//   @override
//   void disposed() {
//     emailController.dispose();
//     otpController.dispose();
//     newPasswordController.dispose();
//     confirmPasswordController.dispose();
//     super.dispose();

//     void submit() {
//       if (formkey.currentState!.validate()) {
//         // Proses reset password di sini
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Password berhasil direset!')),
//         );
//           Navigator.pop(context);

//       }
//     }
//   }
//  @override
//  Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Reset Password'),
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () => Navigator.pop(context),
//         ),
//         ),
//          body: SingleChildScrollView(
//         padding: const EdgeInsets.all(20.0),
//         child: Form(
//           key: formkey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               const SizedBox(height: 40),
//               const Text(
//                 'Reset Password',
//                 style: TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.blue,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//               const SizedBox(height: 30);
//               // email failed
