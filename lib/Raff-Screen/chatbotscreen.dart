//

import 'package:flutter/material.dart';
import 'dart:math';


class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<String> _chatMessages = [];
  final List<String> _suggestedQuestions = [
    "How can I display a list of products?",
    "What is the recommended way to handle user authentication?",
    "How can I implement a shopping cart functionality?",
    "What are some best practices for designing product pages?",
    "How can I add filters to product listings?",
    "How can I optimize my e-commerce app for performance?",
  ];

  final Random _random = Random();

  void _sendMessage(String message) {
    setState(() {
      _chatMessages.add("User: $message");
      String response = _generateResponse(message);
      _chatMessages.add("Bot: $response");
    });
    _controller.clear();
  }

  String _generateResponse(String message) {
    if (_isGreeting(message)) {
      return "Hello! How can I assist you today?";
    } else {
      return _getRandomResponse();
    }
  }

  bool _isGreeting(String message) {
    return message.toLowerCase().contains("hello") ||
        message.toLowerCase().contains("hi") ||
        message.toLowerCase().contains("hey");
  }

  String _getRandomResponse() {
    return "For ${_suggestedQuestions[_random.nextInt(_suggestedQuestions.length)]}, ${_suggestedQuestions[_random.nextInt(_suggestedQuestions.length)]}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("E-Commerce ChatBot"),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _chatMessages.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_chatMessages[index]),
                );
              },
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: "Type your message...",
                    ),
                    onSubmitted: _sendMessage,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () => _sendMessage(_controller.text),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
