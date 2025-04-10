import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project/about_screen.dart';
import 'package:project/articls_screen.dart';
import 'package:project/calculator_screen.dart';
import 'package:project/setting_screen.dart';

import '../home_screen.dart';
import '../login_otp/login_screen.dart';
import '../login_otp/otp_screen.dart';


class AppRouter {
  static final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => LoginScreen(),
      ),
      GoRoute(
        path: '/otp/:code',
        builder: (context, state) {
          final code = state.pathParameters['code'] ?? '';
          return OtpScreen(number: code);
        },
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => ResponsiveLayout(),
      ),
      GoRoute(
        path: '/calc',
        builder: (context, state) => CalculatorScreen(),
      ),
      GoRoute(
        path: '/setting',
        builder: (context, state) => SettingScreen(),
      ),
      GoRoute(
        path: '/article',
        builder: (context, state) => ArticlsScreen(),
      ),
      GoRoute(
        path: '/about',
        builder: (context, state) => AboutScreen(),
      ),
    ],
  );
}
