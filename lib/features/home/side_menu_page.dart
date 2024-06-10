import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:taskhub/components/buttons.dart';
import 'package:taskhub/styles/colors.dart';
import 'package:taskhub/styles/text_styles.dart';

class SideMenuPage extends StatefulWidget {
  const SideMenuPage({super.key});

  @override
  State<StatefulWidget> createState() => _SideMenuPageState();
}

class _SideMenuPageState extends State<SideMenuPage> {
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
          child: Column(
            children: [
              SizedBox(
                width: w,
                height: h * 0.10,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios_new),
                      color: CustomColor.lightwhite,
                      onPressed: () => context.pop(),
                    ),
                    const Text(
                      'Menu',
                      style: CustomTextStyle.menuTitle,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: const BoxDecoration(
                    color: CustomColor.darkblue,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                  ),
                  child: Column(
                    children: [
                      CustomButton.secondary(
                        text: 'Profile',
                        onTap: () => context.push('/profilePage'),
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
