import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              context.go('/home');
            },
            icon: const Icon(Icons.arrow_back_ios)),
        backgroundColor: Colors.lightBlue,
        title: const Text('SettingScreen '),
      ),
      body: Center(child: Text("SettingScreen")),
    );
  }
}
