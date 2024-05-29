
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:zwap_fyp1/chats/api/apis.dart';

class StreamScreen extends StatefulWidget {
  const StreamScreen({super.key});

  @override
  State<StreamScreen> createState() => _StreamScreenState();
}

class _StreamScreenState extends State<StreamScreen> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: APIs.firestore.collection('posts').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text("Error"),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const CupertinoActivityIndicator();
          } else if (snapshot.hasData) {
            final data = snapshot.data!.docs;
            for (var i in data!) {
             // print('Data: ${jsonEncode(i.data())}');
            }
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var post = snapshot.data!.docs[index];
                return Text('Hello World'
               //   (post['name']) + " :Email: " + (post['email']),
                );
              },
            );
          } else {
            return const Center(
              child: Text("No Data"),
            );
          }
        });
  }
}
