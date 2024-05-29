// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:emart_fyp/Auth/LoginScreen.dart';

// class ForgetPasswordScreen extends StatefulWidget {
//   const ForgetPasswordScreen({Key? key});

//   @override
//   _ForgetPasswordScreenState createState() => _ForgetPasswordScreenState();
// }

// class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _newPasswordController =
//       TextEditingController(); // Added new password controller
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   String _errorMessage = '';

//   @override
//   Widget build(BuildContext context) {
//     final Size size = MediaQuery.of(context).size;
//     final orientation = MediaQuery.of(context).orientation;

//     return Scaffold(
//       body: Column(
//         children: [
//           Row(
//             children: [
//               Image.asset(
//                 'Images/LOGO1.png',
//                 height: orientation == Orientation.portrait
//                     ? size.height * 0.1
//                     : size.height * 0.2,
//               ),
//               const Text(
//                 'zwap',
//                 style: TextStyle(
//                   fontSize: 36.0,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.blue,
//                 ),
//               ),
//             ],
//           ),
//           Padding(
//             padding: EdgeInsets.all(size.width * 0.1),
//             child: Form(
//               key: _formKey,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   SizedBox(height: size.height * 0.05),
//                   TextFormField(
//                     controller: _emailController,
//                     decoration: const InputDecoration(
//                       labelText: 'Email',
//                       hintText: 'Enter your email',
//                     ),
//                     keyboardType: TextInputType.emailAddress,
//                     validator: (value) {
//                       if (value!.isEmpty) {
//                         return 'Please enter your email';
//                       }
//                       return null;
//                     },
//                   ),
//                   SizedBox(height: size.height * 0.02), // Adjusted spacing
//                   TextFormField(
//                     controller: _newPasswordController,
//                     obscureText: true,
//                     decoration: const InputDecoration(
//                       labelText: 'New Password',
//                       hintText: 'Enter your new password',
//                     ),
//                     validator: (value) {
//                       if (value!.isEmpty) {
//                         return 'Please enter your new password';
//                       }
//                       if (value.length < 6) {
//                         return 'Password must be at least 6 characters';
//                       }
//                       return null;
//                     },
//                   ),
//                   SizedBox(height: size.height * 0.05),
//                   ElevatedButton(
//                     onPressed: () async {
//                       if (_formKey.currentState!.validate()) {
//                         try {
//                           // Reset password
//                           await _auth.sendPasswordResetEmail(
//                             email: _emailController.text,
//                           );
//                           // Display success message to user
//                           setState(() {
//                             _errorMessage =
//                                 'Password reset email sent. Check your email.';
//                           });
//                         } on FirebaseAuthException catch (e) {
//                           // Handle errors
//                           setState(() {
//                             _errorMessage = e.message ?? 'An error occurred';
//                           });
//                         }
//                       }
//                     },
//                     child: const Text('Reset Password'),
//                   ),
//                   SizedBox(height: size.height * 0.02),
//                   Text(
//                     _errorMessage,
//                     style: const TextStyle(color: Colors.red),
//                   ),
//                   ElevatedButton(
//                     onPressed: () async {
//                       try {
//                         // Reset password and log in with new password
//                         await _auth.confirmPasswordReset(
//                           _newPasswordController.text,
//                           _auth.currentUser!.uid,code: 
//                         );
//                         // Display success message to user
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           const SnackBar(
//                             content: Text('Password updated successfully'),
//                           ),
//                         );
//                         // Navigate to the login screen
//                         Navigator.pushReplacement(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => const LoginScreen()),
//                         );
//                       } on FirebaseAuthException catch (e) {
//                         // Handle errors
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           SnackBar(
//                             content: Text(e.message ?? 'An error occurred'),
//                           ),
//                         );
//                       }
//                     },
//                     child: const Text('Update Password'),
//                   ),
//                   TextButton(
//                     onPressed: () {
//                       Navigator.pushReplacement(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => const LoginScreen()),
//                       );
//                     },
//                     child: const Text('Back to Login'),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _emailController.dispose();
//     _newPasswordController.dispose(); // Dispose new password controller
//     super.dispose();
//   }
// }
