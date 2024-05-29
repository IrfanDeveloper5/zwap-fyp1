// // import 'package:flutter/material.dart';
// // import 'package:firebase_core/firebase_core.dart';
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:cached_network_image/cached_network_image.dart';




// // Future<List<String>> fetchImageUrls() async {
// //   List<String> imageUrls = [];
// //   try {
// //     QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('posts').get();
    
// //     for (var doc in snapshot.docs) {
// //       List<dynamic> urls = doc['imageUrls'];
// //       imageUrls.addAll(urls.cast<String>());
// //     }
// //   } catch (e) {
// //     print("Error fetching image URLs: $e");
// //   }
// //   return imageUrls;
// // }

// // class ImageListScreen extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Image List'),
// //       ),
// //       body: FutureBuilder<List<String>>(
// //         future: fetchImageUrls(),
// //         builder: (context, snapshot) {
// //           if (snapshot.connectionState == ConnectionState.waiting) {
// //             return Center(child: CircularProgressIndicator());
// //           }
// //           if (snapshot.hasError) {
// //             return Center(child: Text('Error fetching images'));
// //           }
// //           if (!snapshot.hasData || snapshot.data!.isEmpty) {
// //             return Center(child: Text('No images found'));
// //           }

// //           List<String> imageUrls = snapshot.data!;
// //           return ListView.builder(
// //             itemCount: imageUrls.length,
// //             itemBuilder: (context, index) {
// //               return Padding(
// //                 padding: const EdgeInsets.all(8.0),
// //                 child: CachedNetworkImage(
// //                   imageUrl: imageUrls[index],
// //                   placeholder: (context, url) => CircularProgressIndicator(),
// //                   errorWidget: (context, url, error) => Icon(Icons.error),
// //                 ),
// //               );
// //             },
// //           );
// //         },
// //       ),
// //     );
// //   }
// // }
















// import 'dart:io';

// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// import '../Models/postsModel.dart';
// import '../chats/models/chat_user.dart';



// class MainScreen extends StatefulWidget {
//   @override
//   State<MainScreen> createState() => _MainScreenState();
// }

// class _MainScreenState extends State<MainScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Main Screen'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => HomeScreenCard(postModel: PostModel(
//                     condition: '',
//                     imageUrls: [],
//                     description: '',
//                     location: '',
//                     title: '',
//                     items: [],
//                     timestamp: '',
//                     userId: '',
//                   ))
//                   ),
//                 );
//               },
//               child: Text('Go to Home Screen Card'),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => ImageListScreen()),
//                 );
//               },
//               child: Text('Go to Image List Screen'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class HomeScreenCard extends StatefulWidget {
//   final PostModel postModel;
//   HomeScreenCard({Key? key, required this.postModel}) : super(key: key);

//   @override
//   State<HomeScreenCard> createState() => _HomeScreenCardState();
// }

// class _HomeScreenCardState extends State<HomeScreenCard> {
//   late String? _image;

//   @override
//   Widget build(BuildContext context) {
//     final mq = MediaQuery.of(context);
//     final cardHeight = mq.size.height * 0.5;
//     final cardWidth = mq.size.width * 0.3;

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Home Screen Card'),
//       ),
//       body: StreamBuilder<QuerySnapshot>(
//         stream: FirebaseFirestore.instance.collection('posts').snapshots(),
//         builder: (context, snapshot) {
//           if (!snapshot.hasData) {
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           }
//           if (snapshot.hasData) {
//             final data = snapshot.data?.docs;
//             return SizedBox(
//               height: cardHeight,
//               child: ListView.builder(
//                 itemCount: data?.length ?? 0,
//                 itemBuilder: (context, index) {
//                   final posts = data![index];
//                   List<dynamic> imageUrls = posts['imageUrls'];
//                   List<dynamic> items = posts['items'];
//                   return InkWell(
//                     onTap: () {},
//                     child: Padding(
//                       padding: EdgeInsets.only(bottom: mq.size.height * 0.03),
//                       child: Container(
//                         height: cardHeight,
//                         color: Colors.black,
//                         child: Card(
//                           color: Colors.white,
//                           child: SizedBox(
//                             height: cardHeight * 0.2,
//                             width: cardWidth,
//                             child: Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   ListTile(
//                                     leading: Text(posts['condition'] as String),
//                                     title: Text(
//                                       posts['title'] as String,
//                                       style: const TextStyle(fontSize: 16),
//                                     ),
//                                     subtitle: Text(
//                                       posts['description'] as String,
//                                       style: const TextStyle(fontSize: 16),
//                                     ),
//                                     trailing: IconButton(
//                                       onPressed: () {},
//                                       icon: const Icon(Icons.more_horiz),
//                                     ),
//                                   ),
//                                   Text(
//                                     posts['timestamp'],
//                                     style: const TextStyle(fontSize: 14),
//                                   ),
//                                   ListTile(
//                                     title: Text(
//                                       posts['location'] as String,
//                                     ),
//                                     trailing: Text(
//                                       posts['title'] as String,
//                                       style: const TextStyle(
//                                           color: Colors.black38, fontSize: 14),
//                                     ),
//                                   ),
//                                   SizedBox(
//                                     height: cardHeight * 0.2,
//                                     child: ListView.builder(
//                                       scrollDirection: Axis.horizontal,
//                                       itemCount: imageUrls.length,
//                                       itemBuilder: (context, index) {
//                                         return CachedNetworkImage(
//                                           imageUrl: imageUrls[index],
//                                           placeholder: (context, url) =>
//                                               CircularProgressIndicator(),
//                                           errorWidget: (context, url, error) =>
//                                               Icon(Icons.error),
//                                         );
//                                       },
//                                     ),
//                                   ),
//                                   SizedBox(
//                                     height: cardHeight * 0.2,
//                                     child: ListView.builder(
//                                       scrollDirection: Axis.horizontal,
//                                       itemCount: items.length,
//                                       itemBuilder: (context, index) {
//                                         return Text(items[index]);
//                                       },
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             );
//           }
//           return Container();
//         },
//       ),
//     );
//   }
// }

// Future<List<String>> fetchImageUrls() async {
//   List<String> imageUrls = [];
//   try {
//     QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('posts').get();

//     for (var doc in snapshot.docs) {
//       List<dynamic> urls = doc['imageUrls'];
//       imageUrls.addAll(urls.cast<String>());
//     }
//   } catch (e) {
//     print("Error fetching image URLs: $e");
//   }
//   return imageUrls;
// }

// class ImageListScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Image List'),
//       ),
//       body: FutureBuilder<List<String>>(
//         future: fetchImageUrls(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           }
//           if (snapshot.hasError) {
//             return Center(child: Text('Error fetching images'));
//           }
//           if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return Center(child: Text('No images found'));
//           }

//           List<String> imageUrls = snapshot.data!;
//           return ListView.builder(
//             itemCount: imageUrls.length,
//             itemBuilder: (context, index) {
//               return Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: CachedNetworkImage(
//                   imageUrl: imageUrls[index],
//                   placeholder: (context, url) => CircularProgressIndicator(),
//                   errorWidget: (context, url, error) => Icon(Icons.error),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
