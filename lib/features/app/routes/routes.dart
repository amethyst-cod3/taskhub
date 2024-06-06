import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:taskhub/features/sign_in/sign_in_page.dart';
import 'package:taskhub/features/sign_up/sign_up_page.dart';
import 'package:taskhub/features/welcome/welcome_page.dart';

/// App navigation routes system

final GoRouter appRouter = GoRouter(
  initialLocation: '/welcomePage',
  routes: <RouteBase>[
    GoRoute(
      path: '/welcomePage',
      builder: (context, state) {
        return const WelcomePage();
      },
    ),
    GoRoute(
      path: '/signinPage',
      builder: (context, state) {
        return const SignInPage();
      },
    ),
    GoRoute(
      path: '/signupPage',
      builder: (context, state) {
        return const SignUpPage();
      },
    ),
  ],
  errorBuilder: (context, state) => const Scaffold(
    body: Center(
      child: Text('Page not found'),
    ),
  ),
);
