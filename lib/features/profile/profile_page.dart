import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:taskhub/components/buttons.dart';
import 'package:taskhub/components/textfields.dart';
import 'package:taskhub/services/auth_service.dart';
import 'package:taskhub/services/database_service.dart';
import 'package:taskhub/styles/colors.dart';
import 'package:taskhub/styles/text_styles.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<StatefulWidget> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final AuthService _authService = AuthService();
  String avatar = '';
  late TextEditingController usernameController;
  late TextEditingController emailController;
  late String uid;
  bool isEditing = false;

  @override
  void initState() {
    super.initState();
    usernameController = TextEditingController();
    emailController = TextEditingController();
    _loadUserInfo();
  }

  @override
  void dispose() {
    usernameController.dispose();
    super.dispose();
  }

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
                      'Profile',
                      style: CustomTextStyle.menuTitle,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: const BoxDecoration(
                    color: CustomColor.lightwhite,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                  ),
                  child: Column(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.all(12),
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                                color: CustomColor.customwhite,
                                image: DecorationImage(
                                    fit: BoxFit.scaleDown,
                                    image:
                                        AssetImage('assets/user/$avatar.png')),
                                borderRadius: BorderRadius.circular(24)),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomTextField.primary(
                                textController: usernameController,
                                isTaskField: true,
                                width: MediaQuery.of(context).size.width * 0.5,
                                readOnly: !isEditing,
                              ),
                              CustomButton.secondary(
                                text: isEditing ? 'Save' : 'Change',
                                width: MediaQuery.of(context).size.width * 0.25,
                                onTap: () async {
                                  if (isEditing) {
                                    await _updateUsername();
                                  } else {
                                    setState(() {
                                      isEditing = true;
                                    });
                                  }
                                },
                              ),
                            ],
                          ),
                          CustomTextField.primary(
                            textController: emailController,
                            isTaskField: true,
                            width: MediaQuery.of(context).size.width * 0.8,
                            readOnly: true,
                          ),
                        ],
                      ),
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

  Future<void> _loadUserInfo() async {
    final user = _authService.currentUser;
    if (user != null) {
      final userInfo = await _authService.getUserInfo(user.uid);
      if (userInfo != null) {
        setState(() {
          avatar = userInfo['avatar'];
          usernameController.text = userInfo['username'];
          emailController.text = userInfo['email'];
        });
      }
    }
  }

  Future<void> _updateUsername() async {
    final user = _authService.currentUser;
    if (user != null) {
      await DatabaseService(uid: user.uid)
          .updateUsername(user.uid, usernameController.text.trim());
      setState(() {
        isEditing = false;
      });
    }
  }
}
