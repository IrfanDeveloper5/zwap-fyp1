import 'package:flutter/material.dart';

class ExploreScreen extends StatefulWidget {
  @override
  _ExploreScreenState createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  TextEditingController _searchController = TextEditingController();
  List<User> _searchResults = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Explore'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search users by name or email',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    _searchUsers();
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _searchResults.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage:
                        NetworkImage(_searchResults[index].profileImageUrl),
                  ),
                  title: Text(_searchResults[index].name),
                  subtitle: Text(_searchResults[index].email),
                  onTap: () {
                    // Navigate to the user's profile screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            UserProfileScreen(user: _searchResults[index]),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _searchUsers() {
    String searchTerm = _searchController.text.toLowerCase();
    // Perform search logic here, for demonstration purposes, using dummy data
    List<User> users =
        getUsers(); // Assume this function gets users from a database or API
    List<User> searchResults = [];

    for (User user in users) {
      if (user.name.toLowerCase().contains(searchTerm) ||
          user.email.toLowerCase().contains(searchTerm)) {
        searchResults.add(user);
      }
    }

    setState(() {
      _searchResults = searchResults;
    });
  }
}

class UserProfileScreen extends StatelessWidget {
  final User user;

  const UserProfileScreen({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Profile'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(user.profileImageUrl),
            ),
            const SizedBox(height: 20),
            Text(
              user.name,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              user.email,
              style: const TextStyle(fontSize: 16),
            ),
            // Add more user information widgets here as needed
          ],
        ),
      ),
    );
  }
}

class User {
  final String name;
  final String email;
  final String profileImageUrl;

  User(
      {required this.name, required this.email, required this.profileImageUrl});
}

List<User> getUsers() {
  // Dummy user data
  return [
    User(
        name: 'Arfan',
        email: 'john@example.com',
        profileImageUrl: 'Images/LOGO1.png'),
    User(
        name: 'irfan',
        email: 'jane@example.com',
        profileImageUrl: 'Images/LOGO1.png'),
    // Add more dummy users here
  ];
}
















































