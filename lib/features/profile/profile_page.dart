import 'package:flutter/material.dart';
import 'package:taskhub/components/buttons.dart';
import 'package:taskhub/services/auth_service.dart';
import 'package:taskhub/styles/colors.dart';
import 'package:taskhub/styles/text_styles.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: CustomColor.lightwhite,
      body: SafeArea(
        child: SizedBox(
          width: w,
          height: h,
          child: Column(
            children: [
              SizedBox(
                width: w,
                height: h * 0.10,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 18,
                    ),
                    Text(
                      'Profile',
                      style: CustomTextStyle.menuSecondaryTitle,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: const BoxDecoration(
                    color: CustomColor.customwhite,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                  ),
                  child: Column(
                    children: [
                      const Expanded(child: SizedBox()),
                      Container(
                        padding: const EdgeInsets.all(12),
                        child: CustomButton.primary(
                          text: 'Sign out',
                          color: CustomColor.purple,
                          onTap: () async {
                            await _authService.signOut(context);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
