import 'package:flutter/material.dart';
import 'package:taskhub/components/buttons.dart';
import 'package:taskhub/components/textfields.dart';
import 'package:taskhub/services/auth_service.dart';
import 'package:taskhub/styles/colors.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<StatefulWidget> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final AuthService _authService = AuthService();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.lightwhite,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              CustomTextField(
                textController: emailController,
                hintText: 'Email',
                icon: const Icon(Icons.email_outlined),
              ),
              CustomTextField(
                textController: passwordController,
                hintText: 'Password',
                icon: const Icon(Icons.password_outlined),
                obscureText: true,
              ),
              CustomButton.primary(
                text: 'Create account',
                onTap: () async {
                  if (emailController.text.isNotEmpty) {
                    if (passwordController.text.isNotEmpty) {
                      await _authService.signUp(context, emailController.text,
                          passwordController.text);
                    } else {
                      _showErrorSnackBar(context, 'Password field is empty.');
                    }
                  } else {
                    _showErrorSnackBar(context, 'Email field is empty.');
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: CustomColor.purple,
      ),
    );
  }
}
