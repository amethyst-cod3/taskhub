import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskhub/components/buttons.dart';
import 'package:taskhub/firebase/services/firebase_auth_controller.dart';
import 'package:taskhub/styles/colors.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authController = Provider.of<FirebaseAuthController>(context);
    return Scaffold(
      backgroundColor: CustomColor.lightwhite,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                margin: const EdgeInsets.all(8),
                width: MediaQuery.of(context).size.width * 0.8,
                height: 48,
                decoration: BoxDecoration(
                  color: CustomColor.customwhite,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextField(
                  controller: emailController,
                  style: const TextStyle(
                    color: CustomColor.darkblue,
                    fontSize: 16,
                  ),
                  decoration: const InputDecoration(
                    hintText: 'Email',
                    contentPadding: EdgeInsets.all(8),
                    prefixIcon: Icon(Icons.email_outlined),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      borderSide: BorderSide(
                        color: Colors.transparent,
                        width: 2,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      borderSide: BorderSide(
                        color: CustomColor.darkblue,
                        width: 2,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(8),
                width: MediaQuery.of(context).size.width * 0.8,
                height: 48,
                decoration: BoxDecoration(
                  color: CustomColor.customwhite,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextField(
                  controller: passwordController,
                  style: const TextStyle(
                    color: CustomColor.darkblue,
                    fontSize: 16,
                  ),
                  decoration: const InputDecoration(
                    hintText: 'Password',
                    contentPadding: EdgeInsets.all(8),
                    prefixIcon: Icon(Icons.password_outlined),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      borderSide: BorderSide(
                        color: Colors.transparent,
                        width: 2,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      borderSide: BorderSide(
                        color: CustomColor.darkblue,
                        width: 2,
                      ),
                    ),
                  ),
                  obscureText: true,
                ),
              ),
              Button.primary(
                text: 'Create account',
                onTap: () async {
                  await authController.signUp(emailController.text, passwordController.text);
                  if (authController.user != null) {
                    // Navega a la siguiente pantalla después de registrarse exitosamente
                    // Por ejemplo: Navigator.pushReplacementNamed(context, '/homePage');
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
