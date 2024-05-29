import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zwap_fyp1/Models/postsModel.dart';
import 'package:zwap_fyp1/chats/api/apis.dart';
import 'package:zwap_fyp1/screens/FollowingScreen.dart';
import 'package:zwap_fyp1/screens/HomeScreenCard.dart';

import '../Chatbot/ChatbootScreen.dart';
import '../Models/bottomSheet.dart';
import '../Profile/profileScreen.dart';
import '../chats/models/chat_user.dart';
import '../screens/DrawerScreen.dart';

class HomeScreenMain extends StatefulWidget {
  final ChatUser user;

  HomeScreenMain({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<HomeScreenMain> createState() => _HomeScreenMainState();
}

class _HomeScreenMainState extends State<HomeScreenMain> {
  bool _showForYou = true;
  List<PostModel> list = [];
  String? _image;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          flexibleSpace: _buildAppBar(context),
        ),
        drawer: DrawerWidget(),
        body: StreamBuilder(
          stream: APIs.firestore.collection('posts').snapshots(), // Assuming 'posts' collection
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
              case ConnectionState.none:
                return const Center(child: CircularProgressIndicator());

              case ConnectionState.active:
              case ConnectionState.done:
                final data = snapshot.data?.docs;
                list = data?.map((e) => PostModel.fromJson(e.data())).toList() ?? [];
                break;
            }
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _showForYou = true;
                        });
                      },
                      child: _showForYou
                          ? Column(
                              children: [
                                const Text(
                                  "For You",
                                  style: TextStyle(
                                    color: Colors.red,
                                    decorationStyle: TextDecorationStyle.solid,
                                  ),
                                ),
                                Container(
                                  width: 47,
                                  height: 3,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            )
                          : const Text("For You"),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _showForYou = false;
                        });
                      },
                      child: !_showForYou
                          ? Column(
                              children: [
                                const Text(
                                  "Following",
                                  style: TextStyle(
                                    color: Colors.red,
                                    decorationStyle: TextDecorationStyle.solid,
                                  ),
                                ),
                                Container(
                                  width: 50,
                                  height: 3,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            )
                          : const Text("Following"),
                    )
                  ],
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return _showForYou
                          ? HomeScreenCard() // Assuming HomeScreenCard takes PostModel
                          : FollowingScreenCard(postModel: list[index]); // Assuming FollowingScreenCard takes PostModel
                    },
                  ),
                ),
              ],
            );
          },
        ),
        bottomNavigationBar: bottomSheet(context),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => ChatbotScreen0()),
            );
          },
          child: const Icon(CupertinoIcons.rays),
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 0,
              shape: const CircleBorder(),
              fixedSize: const Size(87, 40),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => UserProfileScreen(user: APIs.me),
                ),
              );
            },
            child: _buildProfilePicture(screenWidth),
          ),
        ),
        SizedBox(width: screenWidth * 0.2),
        Center(
          child: Row(
            children: [
              Image.asset('Images/LOGO1.png'),
              const Text('zwap'),
            ],
          ),
        ),
        SizedBox(width: screenWidth * 0.3),
        const Icon(Icons.notifications),
      ],
    );
  }

  Widget _buildProfilePicture(double screenWidth) {
    return _image != null
        ? ClipRRect(
            borderRadius: BorderRadius.circular(screenWidth * 0.06),
            child: Image.file(
              File(_image!),
              width: screenWidth * 0.15,
              height: screenWidth * 0.15,
              fit: BoxFit.cover,
            ),
          )
        : ClipRRect(
            borderRadius: BorderRadius.circular(screenWidth * 0.23),
            child: CachedNetworkImage(
              width: screenWidth * 0.15,
              height: screenWidth * 0.15,
              fit: BoxFit.cover,
              imageUrl: widget.user.image,
              errorWidget: (context, url, error) => const CircleAvatar(
                child: Icon(CupertinoIcons.person),
              ),
            ),
          );
  }
}
