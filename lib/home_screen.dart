import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: const Text('Tank'),
      ),
      body: const Center(
        child: Text(
          'Main Screen',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
