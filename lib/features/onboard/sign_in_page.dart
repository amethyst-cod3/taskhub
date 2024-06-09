import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:taskhub/components/buttons.dart';
import 'package:taskhub/components/textfields.dart';
import 'package:taskhub/services/auth_service.dart';
import 'package:taskhub/styles/colors.dart';
import 'package:taskhub/styles/text_styles.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<StatefulWidget> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final AuthService _authService = AuthService();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: CustomColor.darkblue,
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: SafeArea(
          child: SizedBox(
            width: w,
            height: h,
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new),
                    color: CustomColor.customwhite,
                    onPressed: () => context.pop(),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: [
                          const Text(
                            'Sign in',
                            style: CustomTextStyle.onboardingTitle,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.075,
                          ),
                          CustomTextField.primary(
                            textController: emailController,
                            hintText: 'Email',
                            icon: const Icon(Icons.email_outlined),
                          ),
                          CustomTextField.primary(
                            textController: passwordController,
                            hintText: 'Password',
                            icon: const Icon(Icons.password_outlined),
                            obscureText: true,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.075,
                          ),
                          CustomButton.secondary(
                            text: 'Login',
                            onTap: () async {
                              if (emailController.text.isNotEmpty) {
                                if (passwordController.text.isNotEmpty) {
                                  await _authService.signIn(
                                      context,
                                      emailController.text,
                                      passwordController.text);
                                } else {
                                  _showErrorSnackBar(
                                      context, 'Password field is empty.');
                                }
                              } else {
                                _showErrorSnackBar(
                                    context, 'Email field is empty.');
                              }
                            },
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.075,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Don´t have an account?',
                                style: CustomTextStyle.onboardingTextRegular,
                              ),
                              TextButton(
                                child: const Text(
                                  'Create one',
                                  style: CustomTextStyle.onboardingTextBold,
                                ),
                                onPressed: () => context.push('/signupPage'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
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
