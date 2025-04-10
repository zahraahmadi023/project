import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          context.go('/home');
        }, icon: Icon(Icons.arrow_back_ios)),
        backgroundColor: Colors.lightBlue,
        title: const Text('AboutScreen '),
      ),
      body: const Center(child: Text("AboutScreen")),
    );
  }
}
