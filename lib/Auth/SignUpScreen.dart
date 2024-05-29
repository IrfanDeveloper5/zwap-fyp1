import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zwap_fyp1/Auth/LoginScreen.dart';
import 'package:zwap_fyp1/chats/models/chat_user.dart';
import 'package:zwap_fyp1/view/HomeScreen.dart';

import '../chats/api/apis.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  File? _image;
  String? _verificationId;
  late final List<ChatUser> user;

  Future<void> _signUp() async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      // Upload image to Firebase Storage
      String imageUrl = await _uploadImageToFirebaseStorage();

      // Store user data in Firestore
      await _firestore.collection('users').add({
        'name': _nameController.text,
        'email': _emailController.text,
        'city': _cityController.text,
        'image_url': imageUrl,
        'uid': userCredential.user!.uid,
        'active': '',
        'password': _passwordController.text,
        'about': 'Hey, I,m using G-Exchange',
        'created_at': '',
        'push_token': '',
        'is_online': '',
      });
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const SignInScreen()),
      );
    } on FirebaseAuthException catch (e) {
      print('Sign-up error: $e');
      String errorMessage = 'An error occurred. Please try again later.';
      if (e.code == 'weak-password') {
        errorMessage = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        errorMessage = 'The account already exists for that email.';
      }
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Sign up successful!')),
      );
    } catch (e) {
      print('Sign-up error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Error signing up. Please try again later.')),
      );
    }
  }

  Future<void> _pickImage() async {
    final pickedImage = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 70);

    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  Future<String> _uploadImageToFirebaseStorage() async {
    try {
      Reference ref = FirebaseStorage.instance
          .ref()
          .child('user_images/${DateTime.now()}.jpg');
      await ref.putFile(_image!);
      return await ref.getDownloadURL();
    } catch (e) {
      print('Error uploading image to Firebase Storage: $e');
      return '';
    }
  }

  Future<void> _sendVerificationCode() async {
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: _emailController.text,
        verificationCompleted: (PhoneAuthCredential credential) {},
        verificationFailed: (FirebaseAuthException e) {
          print('Verification failed: $e');
        },
        codeSent: (String verificationId, int? resendToken) {
          setState(() {
            _verificationId = verificationId;
          });
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } catch (e) {
      print('Error sending verification code: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign Up')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            GestureDetector(
              onTap: _pickImage,
              child: CircleAvatar(
                radius: 50,
                backgroundImage: _image != null ? FileImage(_image!) : null,
                child:
                    _image == null ? const Icon(Icons.person, size: 50) : null,
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            const SizedBox(height: 8.0),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 8.0),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 8.0),
            TextField(
              controller: _cityController,
              decoration: const InputDecoration(labelText: 'City'),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _sendVerificationCode,
              child: Text(_verificationId != null
                  ? 'Verify Code'
                  : 'Send Verification Code'),
            ),
            const SizedBox(height: 8.0),
            if (_verificationId != null)
              TextField(
                decoration:
                    const InputDecoration(labelText: 'Enter Verification Code'),
                onChanged: (value) {
                  // Verify code and sign up
                  // You can implement this part according to your requirement
                },
              ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                _signUp();
                // .then((user) async {
                //   if ((await APIs.userExists())) {
                //     Navigator.pushReplacement(
                //         context,
                //         MaterialPageRoute(
                //             builder: (_) => const HomeScreen()));
                //   } else {
                //     await APIs.createUser().then((value) {
                //       Navigator.pushReplacement(context,
                //           MaterialPageRoute(builder: (_) => HomeScreen()));
                //     });
                //   }
                // });
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) =>  HomeScreenMain(user:APIs.me)));
              },
              child: const Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}


















// import 'dart:io';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:zwap_fyp1/Auth/LoginScreen.dart';

// import '../APIs/APIs.dart';
// import '../chats/helper/dialogs.dart';

// class SignUpPage extends StatefulWidget {
//   @override
//   _SignUpPageState createState() => _SignUpPageState();
// }

// class _SignUpPageState extends State<SignUpPage> {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   final TextEditingController name = TextEditingController();
//   final TextEditingController address = TextEditingController();
//   final ImagePicker _picker = ImagePicker();
//   File? _image;
//   bool _isPasswordVisible = false;
//   bool _isLoading = false;

//   Future<void> _signUp() async {
//     setState(() {
//       _isLoading = true;
//     });
//     try {
//       UserCredential userCredential =
//           await _auth.createUserWithEmailAndPassword(
//         email: _emailController.text,
//         password: _passwordController.text,
//       );
//       print('User signed up:');
//       print('Name: ${name.text}');
//       print('Email: ${userCredential.user!.email}');
//       print('Password: ${_passwordController.text}');
//       print('Address: ${address.text}');
//       print('Image Url: ${_image}');
//       // Upload image to Firebase Storage
//       String imageUrl = await uploadImageToStorage();
//       await APIs.firestore.collection('signup').add({
//         'name': name.text,
//         'email': userCredential.user!.email,
//         'password': _passwordController.text,
//         'address': address.text,
//         'uid': userCredential.user!.uid,
//         'image': imageUrl, // Store image URL instead of the file
//         'fromId': ''
//       });
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => const SignInScreen()),
//       );
//     } on FirebaseAuthException catch (e) {
//       print('Sign-up error: $e');
//       String errorMessage = 'An error occurred. Please try again later.';
//       if (e.code == 'weak-password') {
//         errorMessage = 'The password provided is too weak.';
//       } else if (e.code == 'email-already-in-use') {
//         errorMessage = 'The account already exists for that email.';
//       }
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(errorMessage),
//         ),
//       );
//     } catch (e) {
//       print('Unexpected error: $e');
//     }
//     setState(() {
//       _isLoading = false;
//     });
//   }

//   Future<void> _pickImage() async {
//     final pickedImage = await _picker.pickImage(source: ImageSource.gallery);

//     if (pickedImage != null) {
//       setState(() {
//         _image = File(pickedImage.path);
//       });
//     }
//   }

//   Future uploadImageToStorage() async {
//     // Upload image to Firebase Storage and get download URL
//     // Replace 'your_bucket_name' with your actual bucket name
//     String imageName = DateTime.now().millisecondsSinceEpoch.toString();
//     String imagePath = 'images/$imageName.jpg';

//     Reference ref =
//         await APIs.storage.ref().child("/images").child("post_${imageName}");
//     await ref.putFile(_image!);
//     final downloadUrl = await ref.getDownloadURL();
//     print(downloadUrl);
//     // uploading to the cloudFirestore
//     await APIs.firestore
//         .collection('signup')
//         .doc('Images')
//         .collection('photos')
//         .add({'image': downloadUrl}).whenComplete(
//             () => Dialogs.showSnackbar(context, 'Image is uploaded'));
//    // return await APIs.storage.ref().child(imagePath).getDownloadURL();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final Size screenSize = MediaQuery.of(context).size;

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Sign Up'),
//       ),
//       body: _isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: SingleChildScrollView(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.stretch,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: <Widget>[
//                     GestureDetector(
//                       onTap: _pickImage,
//                       child: Container(
//                         width: screenSize.width * 0.3,
//                         height: screenSize.width * 0.3,
//                         decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           image: _image != null
//                               ? DecorationImage(
//                                   image: FileImage(_image!),
//                                   fit: BoxFit.cover,
//                                 )
//                               : null,
//                         ),
//                         child: _image == null ? Icon(Icons.add_a_photo) : null,
//                       ),
//                     ),
//                     const SizedBox(height: 16.0),
//                     TextFormField(
//                       controller: name,
//                       decoration: const InputDecoration(labelText: 'Name'),
//                     ),
//                     const SizedBox(height: 8.0),
//                     TextFormField(
//                       controller: _emailController,
//                       decoration: const InputDecoration(labelText: 'Email'),
//                     ),
//                     const SizedBox(height: 8.0),
//                     TextFormField(
//                       controller: _passwordController,
//                       decoration: InputDecoration(
//                         labelText: 'Password',
//                         suffixIcon: IconButton(
//                           icon: Icon(_isPasswordVisible
//                               ? Icons.visibility
//                               : Icons.visibility_off),
//                           onPressed: () {
//                             setState(() {
//                               _isPasswordVisible = !_isPasswordVisible;
//                             });
//                           },
//                         ),
//                       ),
//                       obscureText: !_isPasswordVisible,
//                     ),
//                     const SizedBox(height: 8.0),
//                     TextFormField(
//                       controller: address,
//                       decoration: const InputDecoration(labelText: 'City'),
//                     ),
//                     const SizedBox(height: 16.0),
//                     ElevatedButton(
//                       onPressed: _signUp,
//                       child: const Text('Sign Up'),
//                     ),
//                     const SizedBox(height: 8.0),
//                     TextButton(
//                       onPressed: () {
//                         Navigator.pushReplacement(
//                           context,
//                           MaterialPageRoute(builder: (_) => SignInScreen()),
//                         );
//                       },
//                       child: const Text('Already have an account? Sign In'),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//     );
//   }
// }
