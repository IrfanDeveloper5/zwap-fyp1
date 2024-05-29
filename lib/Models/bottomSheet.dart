
import 'package:flutter/material.dart';

import 'package:zwap_fyp1/Explore/exploreScreen.dart';
import 'package:zwap_fyp1/Posts/postScreen.dart';
import 'package:zwap_fyp1/Raff-Screen/streamScreen.dart';
import 'package:zwap_fyp1/chats/screens/home_screen.dart';
import 'package:zwap_fyp1/view/HomeScreen.dart';

import '../chats/api/apis.dart';

Widget bottomSheet(BuildContext context) {
  return BottomNavigationBar(
    items: [
      BottomNavigationBarItem(
        icon: IconButton(
          icon: const Icon(Icons.home_filled, color: Colors.red),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => HomeScreenMain (user: APIs.me)));
          },
        ),
        label: 'Home',
      ),
      BottomNavigationBarItem(
        icon: IconButton(
          icon: const Icon(Icons.manage_search_rounded, color: Colors.red),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ExploreScreen()));
          },
        ),
        label: 'Explore',
      ),
      BottomNavigationBarItem(
        icon: IconButton(
          icon: const Icon(Icons.add, color: Colors.red),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => PostScreenUser()));
          },
        ),
        label: 'Post',
      ),
      BottomNavigationBarItem(
        icon: IconButton(
          icon: const Icon(Icons.badge_outlined, color: Colors.red),
          onPressed: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const StreamScreen()));
          },
        ),
        label: 'Requests',
      ),
      BottomNavigationBarItem(
          icon: IconButton(
            icon:
                const Icon(Icons.chat_bubble_outline_sharp, color: Colors.red),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const HomeScreen()));
            },
          ),
          label: 'Chat'),
    ],
  );
}
