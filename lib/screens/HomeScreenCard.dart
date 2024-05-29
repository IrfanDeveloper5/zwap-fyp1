import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zwap_fyp1/Posts/postScreen.dart';
import 'package:zwap_fyp1/Raff-Screen/streamScreen.dart';
import 'package:zwap_fyp1/chats/screens/home_screen.dart';
import 'package:zwap_fyp1/chats/screens/profile_screen.dart';

import '../Models/postsModel.dart';
import '../chats/api/apis.dart';
import '../chats/models/chat_user.dart';
import '../screens/DrawerScreen.dart';

class HomeScreenCard extends StatefulWidget {
 // final PostModel postModel;
  HomeScreenCard({Key? key, }) : super(key: key);

  @override
  State<HomeScreenCard> createState() => _HomeScreenCardState();
}

class _HomeScreenCardState extends State<HomeScreenCard> {
  String? _image;
  ChatUser? user;

  @override
  Widget build(BuildContext context) {
    //final mq = MediaQuery.of(context);

    return Scaffold(
        appBar: AppBar(
          title: const Center(child: Text('zwap')),
        ),
        body: Card(
          margin: const EdgeInsets.all(10.0),
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                        // backgroundImage:Image.asset('Images/LOGO1.png'),
                        // CachedNetworkImageProvider(profileImageUrl),
                        ),
                          Text(
                            'Irfan',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          Text(
                            '12:00 PM',
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                    
                  ],
                ),
                const SizedBox(height: 10),
                Image.asset('Images/LOGO1.png'
                    // placeholder: (context, url) => CircularProgressIndicator(),
                    // errorWidget: (context, url, error) => Icon(Icons.error),
                    // width: double.infinity,
                    // fit: BoxFit.cover,
                    ),
                const SizedBox(height: 10),
                const Text(
                  'Gujranwala',
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
                const Text(
                  'Donation',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.favorite_border),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.comment),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.share),
                    ),
                  ],
                ),
              ],
            ),
          ),
        )
        // drawer: DrawerWidget(),
//       body: StreamBuilder<QuerySnapshot>(
//         stream: APIs.getAllPosts(),
//         builder: (context, snapshot) {
//           if (!snapshot.hasData) {
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           }
//           final data = snapshot.data?.docs;
//           return ListView.builder(
//             itemCount: data?.length ?? 0,
//             itemBuilder: (context, index) {
//               final posts = data![index];
//               List<dynamic> imageUrls = posts['imageUrls'];
//               List<dynamic> items = posts['items'];
//               return InkWell(
//                 onTap: () {},
//                 child: Padding(
//                   padding: EdgeInsets.only(bottom: 10
//                   //mq.size.height * 0.02
//                   ),
//                   child: Card(
//                     margin: EdgeInsets.symmetric(horizontal: 5),
//                     color: Colors.white,
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           ListTile(
//                             leading: Text(widget.postModel.title),
//                             title: const Text(
//                              'Hello',
//                              // posts['title'] as String,
//                               style: TextStyle(fontSize: 16),
//                             ),
//                             subtitle: const Text(
// 'Hello',
//                               //posts['description'] as String,
//                               style: TextStyle(fontSize: 16),
//                             ),
//                             trailing: Row(
//                               mainAxisSize: MainAxisSize.min,
//                               children: [
//                                 IconButton(
//                                   onPressed: () {
//                                     FirebaseFirestore.instance
//                                         .collection('posts')
//                                         .doc(posts.id)
//                                         .update({
//                                       'likes': FieldValue.increment(1)
//                                     });
//                                   },
//                                   icon: const Icon(Icons.favorite_border),
//                                 ),
//                                 IconButton(
//                                   onPressed: () {
//                                     //  _navigateToCommentsPage(posts.id);
//                                   },
//                                   icon: const Icon(Icons.comment),
//                                 ),
//                                 IconButton(
//                                   onPressed: () {
//                                     //   _sharePost(posts);
//                                   },
//                                   icon: const Icon(Icons.share),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           const Text(
//                             'Hello',
//                            // posts['timestamp'],
//                             style: TextStyle(fontSize: 14),
//                           ),
//                           const ListTile(
//                             title: Text('Hello',
//                               //posts['location'] as String
//                               ),
//                             trailing: Text(
//                               'Hello',
//                             //  posts['title'] as String,
//                               style: TextStyle(
//                                   color: Colors.black38, fontSize: 14),
//                             ),
//                           ),
//                           Center(
//                             child: SizedBox(
//                               height: 15,
//                               child: ListView.builder(
//                                 scrollDirection: Axis.horizontal,
//                                 itemCount: imageUrls.length,
//                                 itemBuilder: (context, index) {
//                                   return CachedNetworkImage(
//                                     imageUrl: imageUrls[index],
//                                     placeholder: (context, url) =>
//                                         const CircularProgressIndicator(),
//                                     errorWidget: (context, url, error) =>
//                                         const Icon(Icons.error),
//                                     width: 4,
//                                   );
//                                 },
//                               ),
//                             ),
//                           ),
//                           SizedBox(
//                             height: 5,
//                             child: ListView.builder(
//                               scrollDirection: Axis.horizontal,
//                               itemCount: items.length,
//                               itemBuilder: (context, index) {
//                                 return Padding(
//                                   padding: const EdgeInsets.only(right: 8.0),
//                                   child: Chip(
//                                     label: Text(items[index]),
//                                   ),
//                                 );
//                               },
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//       ),
        );
  }
}

class CommentsPage extends StatelessWidget {
  final String postId;

  const CommentsPage({Key? key, required this.postId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Comments'),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('posts')
                  .doc(postId)
                  .collection('comments')
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                final comments = snapshot.data?.docs;
                return ListView.builder(
                  itemCount: comments?.length ?? 0,
                  itemBuilder: (context, index) {
                    final comment = comments![index];
                    return ListTile(
                      title: Text(comment['text']),
                      subtitle: Text('User: ${comment['user']}'),
                    );
                  },
                );
              },
            ),
          ),
          // Add comment input field and button here
        ],
      ),
    );
  }
}
