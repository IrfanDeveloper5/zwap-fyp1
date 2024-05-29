
import 'package:flutter/material.dart';

import '../Auth/LoginScreen.dart';

class OnboardingScreen1 extends StatefulWidget {
  const OnboardingScreen1({super.key});

  @override
  _OnboardingScreen1State createState() => _OnboardingScreen1State();
}

class _OnboardingScreen1State extends State<OnboardingScreen1> {
  int _currentIndex = 0;

  final List<String> _images = [
    'Images/LOGO1.png',
    'Images/LOGO1.png',
    'Images/LOGO1.png',
    'Images/LOGO1.png',
    'Images/LOGO.jpeg',
  ];

  final List<String> _titles = [
    'Meet someone new',
    'UOG',
    '20011556-099',
    '20011556-104',
    '20011556-113',
  ];

  final List<String> _subtitles = [
    'Dil Dil Pakistan',
    'Pakistan Zindabad',
    'GulRaiz',
    'Shoaib',
    'Irfan',
  ];

  void _nextScreen() {
    setState(() {
      if (_currentIndex < 4) {
        _currentIndex++;
      } else {
        // Navigate to login screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const SignInScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Image.asset(
            _images[_currentIndex],
            width: screenSize.width * 0.95,
            height: screenSize.height * 1.1,
            fit: BoxFit.contain,
          ),

          // Content
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Title
              Text(
                _titles[_currentIndex],
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20),
              // Subtitle
              Text(
                _subtitles[_currentIndex],
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              // Next button
              ElevatedButton(
                onPressed: _nextScreen,
                child: Text(
                  _currentIndex < 4 ? 'Next' : 'Continue',
                  style: const TextStyle(fontSize: 18),
                ),
              ),
              const SizedBox(height: 20),
              // Dot indicator
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _buildPageIndicator(),
              ),
              const SizedBox(height: 20),
              // Already have an account
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Already have an account?',
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                  TextButton(
                    onPressed: () {
                      // Navigate to login screen
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const SignInScreen()),
                      );
                    },
                    child: const Text(
                      'Sign in',
                      style: TextStyle(fontSize: 16, color: Colors.purple),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<Widget> _buildPageIndicator() {
    List<Widget> indicators = [];
    for (int i = 0; i < 5; i++) {
      indicators.add(
        Container(
          width: _currentIndex == i
              ? 12.0
              : 8.0, // Increase size for current screen
          height: 8.0,
          margin: const EdgeInsets.symmetric(horizontal: 5.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _currentIndex == i ? Colors.blue : Colors.grey,
          ),
        ),
      );
    }
    return indicators;
  }
}
