import 'package:flutter/material.dart';




class DrawerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  'Images/LOGO1.png', // replace with your logo URL
                  height: 50,
                ),
                const SizedBox(height: 10),
                const Text(
                  'ZSwap',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                  ),
                ),
                const Text(
                  'exchange items wisely',
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          _createDrawerItem(
            icon: Icons.home,
            text: 'Home',
            onTap: () {
              // Handle Home tap
            },
          ),
          _createDrawerItem(
            icon: Icons.chat,
            text: 'Chats',
            onTap: () {
              // Handle Chats tap
            },
          ),
          _createDrawerItem(
            icon: Icons.person,
            text: 'Profile',
            onTap: () {
              // Handle Profile tap
            },
          ),
          _createDrawerItem(
            icon: Icons.people,
            text: 'Users',
            onTap: () {
              // Handle Users tap
            },
          ),
          _createDrawerItem(
            icon: Icons.post_add,
            text: 'My Posts',
            onTap: () {
              // Handle My Posts tap
            },
          ),
          _createDrawerItem(
            icon: Icons.settings,
            text: 'Settings',
            onTap: () {
              // Handle Settings tap
            },
          ),
          _createDrawerItem(
            icon: Icons.logout,
            text: 'Logout',
            onTap: () {
              // Handle Logout tap
            },
          ),
        ],
      ),
    );
  }

  Widget _createDrawerItem({required IconData icon, required String text, required GestureTapCallback onTap}) {
    return ListTile(
      leading: Icon(icon),
      title: Text(text),
      onTap: onTap,
    );
  }
}
