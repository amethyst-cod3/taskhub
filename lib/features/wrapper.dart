import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskhub/features/home/home_page.dart';
import 'package:taskhub/features/onboard/welcome_page.dart';
import 'package:taskhub/models/user_model.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel?>(context);

    if (user == null) {
      return const WelcomePage();
    } else {
      return HomePage();
    }
  }
}
