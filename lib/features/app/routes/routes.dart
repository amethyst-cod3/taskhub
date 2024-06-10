import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:taskhub/features/home/add_task_page.dart';
import 'package:taskhub/features/home/edit_task_page.dart';
import 'package:taskhub/features/home/home_page.dart';
import 'package:taskhub/features/home/side_menu_page.dart';
import 'package:taskhub/features/onboard/sign_in_page.dart';
import 'package:taskhub/features/onboard/sign_up_page.dart';
import 'package:taskhub/features/onboard/welcome_page.dart';
import 'package:taskhub/features/profile/profile_page.dart';
import 'package:taskhub/features/wrapper.dart';
import 'package:taskhub/models/task_model.dart';

/// App navigation routes system

final GoRouter appRouter = GoRouter(
  initialLocation: '/wrapper',
  routes: <RouteBase>[
    GoRoute(
      path: '/wrapper',
      builder: (context, state) {
        return const Wrapper();
      },
    ),
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
    GoRoute(
      path: '/homePage',
      builder: (context, state) {
        return const HomePage();
      },
    ),
    GoRoute(
      path: '/addTaskPage',
      builder: (context, state) {
        return const AddTaskPage();
      },
    ),
    GoRoute(
      path: '/editTaskPage/:id',
      builder: (context, state) {
        final task = state.extra as Task;
        return EditTaskPage(task: task);
      },
    ),
    GoRoute(
      path: '/sideMenuPage',
      builder: (context, state) {
        return const SideMenuPage();
      },
    ),
    GoRoute(
      path: '/profilePage',
      builder: (context, state) {
        return const ProfilePage();
      },
    ),
  ],
  errorBuilder: (context, state) => const Scaffold(
    body: Center(
      child: Text('Page not found'),
    ),
  ),
);
