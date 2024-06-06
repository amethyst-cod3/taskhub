import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:taskhub/features/welcome/welcome_page.dart';

/// App navigation routes system

final GoRouter appRouter = GoRouter(
  initialLocation: '/welcomePage',
  routes: <RouteBase>[
    GoRoute(
      path: '/welcomePage',
      builder: (context, state) {
        return const WelcomePage();
      }
    )
  ],
  errorBuilder: (context, state) => const Scaffold(
    body: Center(
      child: Text('Page not found'),
    ),
  ),
);