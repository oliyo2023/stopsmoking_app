import 'package:flutter/material.dart';

class PlanPage extends StatelessWidget {
  const PlanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('计划页')),
      body: const Center(child: Text('Plan Page Content')),
    );
  }
}
