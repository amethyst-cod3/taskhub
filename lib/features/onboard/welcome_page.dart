import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:taskhub/components/buttons.dart';
import 'package:taskhub/styles/colors.dart';
import 'package:taskhub/styles/text_styles.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: CustomColor.darkblue,
      body: SafeArea(
        child: SizedBox(
          width: w,
          height: h,
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(24),
                    child: Text(
                      'Welcome to TaskHub',
                      style: CustomTextStyle.welcomePageTitle,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(24),
                    child: const Text(
                      'Your task management app.\n\nShare them with your friends and co-operate together.',
                      style: CustomTextStyle.welcomePageSubtitle,
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    alignment: Alignment.bottomCenter,
                    padding: const EdgeInsets.all(24),
                    child: CustomButton.secondary(
                      text: 'Get started',
                      onTap: () {
                        context.push('/signinPage');
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
