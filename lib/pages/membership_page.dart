import 'package:flutter/material.dart';

class MembershipPage extends StatelessWidget {
  const MembershipPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Join Membership'),
      ),
      body: const Center(
        child: Text('Membership Page - Content goes here'),
      ),
    );
  }
}
