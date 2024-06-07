import 'package:flutter/material.dart';
import 'package:taskhub/services/auth_service.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ElevatedButton(
            onPressed: () async {
              await _authService.signOut(context);
            },
            child: const Text('HomePage'),
          ),
        ),
      ),
    );
  }
}
