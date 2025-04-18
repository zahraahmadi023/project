import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ArticlsScreen extends StatelessWidget {
  const ArticlsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              context.go('/home');
            },
            icon: Icon(Icons.arrow_back_ios)),
        backgroundColor: Colors.lightBlue,
        title: const Text('ArticelScreen '),
      ),
      body: Center(child: Text("ArticelScreen")),
    );
  }
}
