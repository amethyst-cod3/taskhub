import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:taskhub/features/home/home_page.dart';
import 'package:taskhub/features/onboard/sign_in_page.dart';
import 'package:taskhub/features/onboard/sign_up_page.dart';
import 'package:taskhub/features/onboard/welcome_page.dart';

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
        return SignInPage();
      },
    ),
    GoRoute(
      path: '/signupPage',
      builder: (context, state) {
        return SignUpPage();
      },
    ),
    GoRoute(
      path: '/homePage',
      builder: (context, state) {
        return const HomePage();
      },
    ),
  ],
  errorBuilder: (context, state) => const Scaffold(
    body: Center(
      child: Text('Page not found'),
    ),
  ),
);
