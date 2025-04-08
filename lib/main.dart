import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project/Login.dart';
import 'package:project/password.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final GoRouter _router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => Login(),
      ),
      GoRoute(
        path: '/second/:code',
        builder: (context, state) {
          final code = state.pathParameters['code'] ?? '';
          return Pass(number: code);
        },
      ),
    ],
  );

  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      title: 'مثال go_router',
      debugShowCheckedModeBanner: false,
    );
  }
}
