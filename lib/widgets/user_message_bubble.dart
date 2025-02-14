import 'package:flutter/material.dart';

class UserMessageBubble extends StatelessWidget {
  final String message;

  const UserMessageBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.blue[100],
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Text(message),
      ),
    );
  }
}
