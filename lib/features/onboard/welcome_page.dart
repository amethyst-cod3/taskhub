import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:taskhub/components/buttons.dart';
import 'package:taskhub/styles/colors.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.lightwhite,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.34,
                decoration: const BoxDecoration(
                  color: CustomColor.transparentCustomwhite,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Button.primary(
                      text: 'Sign in',
                      onTap: () {
                        context.push('/signinPage');
                      },
                    ),
                    const Text(
                      'or',
                      style: TextStyle(
                        color: CustomColor.darkblue),
                      ),
                    Button.secondary(
                      text: 'Sign up',
                      onTap: () {
                        context.push('/signupPage');
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
