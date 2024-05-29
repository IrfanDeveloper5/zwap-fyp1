import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:zwap_fyp1/Models/postsModel.dart';

import 'Raff-Screen/imageshow.dart';
import 'chats/screens/splash_screen.dart';
import 'firebase_options.dart';

var mq;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  //  var result = await FlutterNotificationChannel.registerNotificationChannel(
  //   description: 'For Showing Message Notification',
  //   id: 'G-chats',
  //   importance: NotificationImportance.IMPORTANCE_HIGH,
  //   name: 'G-Chats',

  // );
  // PlatformDispatcher.instance.onError = (error, stack) {
  //   var myBackend;
  //   myBackend.sendError(error, stack);
  //   return true;
  // };
  // FlutterError.onError = (details) {
  //   FlutterError.presentError(details);
  //   if (kReleaseMode) exit(1);
  // };
  // try {
  //   // Firebase operation that might throw an exception
  //   await Firebase.initializeApp();
  // } catch (e) {
  //   // Handle the exception
  //   print('Error initializing Firebase: $e');
  // }
  // mq = MediaQuery.of(context).size;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'G-Exchanges',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:const SplashScreen(),
    );
  }
}

// Future<void> _initializeFirebase() async {
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );

//   var result = await FlutterNotificationChannel.registerNotificationChannel(
//     description: 'For Showing Message Notification',
//     id: 'G-chats',
//     importance: NotificationImportance.IMPORTANCE_HIGH,
//     name: 'G-Chats',

//   );
//  print('\n Notification Channel Result: $result');
// }
