import 'package:flutter/material.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        height: 110,
        width: 120,
        padding: const EdgeInsets.all(10),
        child: Image.asset('Images/LOGO1.png'),
      ),
    );
  }
}
