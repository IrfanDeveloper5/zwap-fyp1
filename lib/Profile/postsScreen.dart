import 'package:flutter/material.dart';

class PostsScreen extends StatelessWidget {
  const PostsScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final List<String> imagePaths = [
      'Images/Google.png',
      'Images/Google.png',
      'Images/Google.png',
      'Images/Google.png',
      'Images/Google.png',
      'Images/Google.png',
      'Images/Google.png',
      'Images/Google.png',
      'Images/Google.png',
      'Images/Google.png',
      'Images/Google.png',
      'Images/Google.png',
      'Images/Google.png',
    ];
    return SizedBox(
      height: 100,
      width: 100,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: imagePaths.length,
        itemBuilder: (context, index) {
          return InkWell(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: SizedBox(
                height: 90,
                width: 90,
                child: Image.asset(imagePaths[index]),
              ),
            ),
          );
        },
      ),
    );
  }
}
