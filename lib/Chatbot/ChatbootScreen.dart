import 'dart:async';
import 'package:flutter/material.dart';
import 'package:ikchatbot/ikchatbot.dart';
import 'package:intl/intl.dart';

import 'keywords&responseScreen.dart';


class ChatbotScreen0 extends StatefulWidget {
  @override
  State<ChatbotScreen0> createState() => _ChatbotScreen0State();
}

class _ChatbotScreen0State extends State<ChatbotScreen0> {
  late Timer _timer;
  late String _currentTime;

  @override
  void initState() {
    super.initState();
    // Initialize the current time
    _currentTime = DateFormat('Hm').format(DateTime.now());
    // Start a timer to update the time every minute
    _timer = Timer.periodic(const Duration(minutes: 1), (Timer timer) {
      setState(() {
        _currentTime = DateFormat('Hm').format(DateTime.now());
      });
    });
  }

  @override
  void dispose() {
    // Cancel the timer when the widget is disposed to prevent memory leaks
    _timer.cancel();
    super.dispose();
  }

  final chatBotConfig = IkChatBotConfig(
    //SMTP Rating to your mail Settings
    ratingIconYes: const Icon(Icons.star),
    ratingIconNo: const Icon(Icons.star_border),
    ratingIconColor: Colors.black,
    ratingBackgroundColor: Colors.white,
    ratingButtonText: 'Submit Rating',
    thankyouText: 'Thanks for your rating!',
    ratingText: 'Rate your experience:',
    ratingTitle: 'Thank you for using the chatbot!',
    body: 'This is a test email sent from Flutter and Dart.',
    subject: 'Test Rating',
    recipient: 'recipient@example.com',
    isSecure: false,
    senderName: 'Your Name',
    smtpUsername: 'Your Email',
    smtpPassword: 'your password',
    smtpServer: 'stmp.gmail.com',
    smtpPort: 587,
    //Settings to your system Configurations
    sendIcon: const Icon(Icons.send, color: Colors.black),
    userIcon: const Icon(Icons.person, color: Colors.white),
    botIcon: const Icon(Icons.android, color: Colors.white),
    botChatColor: const Color.fromARGB(255, 81, 80, 80),
    delayBot: 100,
    closingTime: 1,
    delayResponse: 1,
    userChatColor: Colors.blue,
    waitingTime: 1,
    keywords: keywords,
    responses: responses,
    backgroundColor: Colors.white,
    backgroundImage: 'https://cdn.wallpapersafari.com/54/0/HluF7g.jpg',
    initialGreeting: "👋 Hello! \nWelcome to ZWAP\nHow can I assist you today?",
    defaultResponse: "Sorry, I didn't understand your response.",
    inactivityMessage: "Is there anything else you need help with?",
    closingMessage: "This conversation will now close.",
    inputHint: 'Send a message',
    waitingText: 'Please wait...',
    backgroundAssetimage: 'Images/BG1.png',
    useAsset: true,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Today, $_currentTime",
          style: const TextStyle(fontSize: 20.0),
        ),
      ),
      body: ikchatbot(config: chatBotConfig),
    );
  }
}
