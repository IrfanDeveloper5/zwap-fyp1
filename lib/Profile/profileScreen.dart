import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zwap_fyp1/Profile/editScreen.dart';
import 'package:zwap_fyp1/Profile/favoriteScreen.dart';
import 'package:zwap_fyp1/Profile/postsScreen.dart';

import '../chats/api/apis.dart';
import '../chats/models/chat_user.dart';

class UserProfileScreen extends StatefulWidget {
   final ChatUser user;

  const UserProfileScreen({super.key, required this.user});
  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  bool _showPosts = true;
   String? _image;
  //late final ChatUser user;

  @override
  Widget build(BuildContext context) {
        final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Profile'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: _image != null
        ? ClipRRect(
            borderRadius: BorderRadius.circular(screenWidth * 0.20),
            child: Image.file(
              File(_image!),
              width: screenWidth * 0.15,
              height: screenWidth * 0.30,
              fit: BoxFit.cover,
            ),
          )
        : ClipRRect(
            borderRadius: BorderRadius.circular(screenWidth * 0.20),
            child: CachedNetworkImage(
              width: screenWidth * 0.15,
              height: screenWidth * 0.30,
              fit: BoxFit.cover,
              imageUrl: widget.user.image,
              errorWidget: (context, url, error) => const CircleAvatar(
                child: Icon(CupertinoIcons.person),
              ),
            ),
          ),
            title:  Text(
              widget.user.name,
              style: const TextStyle(fontSize: 20),
            ),
            subtitle:  Text(
              widget.user.email,
              style: const TextStyle(fontSize: 16),
            ),
            trailing: OutlinedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) =>  EditScreen(user: APIs.me)));
                // Add edit profile functionality
              },
              child: const Text(
                'Edit',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
          const SizedBox(height: 10),
           Padding(
             padding:  EdgeInsets.only(left: 14.0),
             child: Text(
              widget.user.about,
              style: const TextStyle(fontSize: 18),
                       ),
           ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildInfoCard('Followers', '10K'),
              _buildInfoCard('Following', '500'),
              _buildInfoCard('Trades', '100'),
            ],
          ),
          const SizedBox(height: 20),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            TextButton(
                onPressed: () {
                  setState(() {
                    _showPosts = true;
                  });
                },
                child: _showPosts
                    ? Column(
                        children: [
                          const Text(
                            "Posts",
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
                    : const Text('Posts')),
            TextButton(
                onPressed: () {
                  setState(() {
                    _showPosts = false;
                  });
                },
                child: _showPosts
                    ? const Text('Favorites')
                    : Column(
                        children: [
                          const Text(
                            "Favorites",
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
                      )),
          ]),
          Expanded(
            child: SingleChildScrollView(
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 10,
                itemBuilder: (context, index) {
                  return _showPosts
                      ? const PostsScreen(
                          key: null,
                        )
                      : const FavoriteScreen();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(String label, String value) {
    return Container(
      height: 110,
      width: 120,
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 16),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildTabItem(String title, bool isSelected) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.red : Colors.black,
          ),
        ),
        if (isSelected)
          Container(
            width: 47,
            height: 3,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.red,
            ),
          ),
      ],
    );
  }
  
  // Widget to display the profile picture
  Widget _buildProfilePicture(double screenWidth) {
    return _image != null
        ? ClipRRect(
            borderRadius: BorderRadius.circular(screenWidth * 0.06),
            child: Image.file(
              File(_image!),
              width: screenWidth * 0.50,
              height: screenWidth * 0.50,
              fit: BoxFit.cover,
            ),
          )
        : ClipRRect(
            borderRadius: BorderRadius.circular(screenWidth * 0.23),
            child: CachedNetworkImage(
              width: screenWidth * 0.50,
              height: screenWidth * 0.50,
              fit: BoxFit.cover,
              imageUrl: widget.user.image,
              errorWidget: (context, url, error) => const CircleAvatar(
                child: Icon(CupertinoIcons.person),
              ),
            ),
          );
  }

}
