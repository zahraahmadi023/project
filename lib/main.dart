import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project/home_screen.dart';
import 'package:project/login_otp/login_screen.dart';
import 'package:project/login_otp/otp_screen.dart';
import 'package:project/widgets/go_router.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: AppRouter.router,
      debugShowCheckedModeBanner: false,
    );
  }
}
