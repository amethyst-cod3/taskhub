import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskhub/features/app/routes/routes.dart';
import 'package:taskhub/firebase/firebase_options.dart';
import 'package:taskhub/firebase/services/firebase_auth_controller.dart';
import 'package:taskhub/storage/auth_local_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  String? userId = await AuthLocalStorage.getCurrentUser();
  final authController = FirebaseAuthController();
  if (userId != null) {
    await authController.signInWithStoredUserId(userId);
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => FirebaseAuthController(),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: appRouter,
      ),
    );
  }
}
