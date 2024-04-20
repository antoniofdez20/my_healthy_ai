import 'package:flutter/material.dart';
import 'package:my_healthy_ai/widgets/widgets.dart';

class InitialScreen extends StatelessWidget {
  const InitialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Healthy AI'),
      ),
      body: const Center(
        child: Text('Initial Screen'),
      ),
      bottomNavigationBar: const CustomNavigationBar(),
    );
  }
}
