import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FirestoreScreen extends StatefulWidget {
  const FirestoreScreen({super.key});

  @override
  State<FirestoreScreen> createState() => _FirestoreScreenState();
}

class _FirestoreScreenState extends State<FirestoreScreen> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FireStore'),
      ),
      body: Column(
        children: [
          TextFormField(
            controller: name,
            decoration: const InputDecoration(labelText: 'Name'),
          ),
          TextFormField(
            controller: email,
            decoration: const InputDecoration(labelText: 'Email'),
          ),
          ElevatedButton(
              onPressed: () {
                String id = DateTime.now().millisecondsSinceEpoch.toString();
                FirebaseFirestore.instance.collection('users').add({
                  'id ':id,
                  'name': name.text,
                  'email': email.text,
                }).then((value) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('User Added'),
                  ));
                }).catchError((error) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(error.message),
                  ));
                });
              },
              child: const Text('Signup'))
        ],
      ),
    );
  }
}
