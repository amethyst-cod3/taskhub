import 'package:flutter/material.dart';
import 'package:taskhub/styles/colors.dart';

class CustomTextStyle {
  /// Titles
  static final welcomePageTitle = TextStyle(
    fontSize: 36,
    fontWeight: FontWeight.w700,
    fontFamily: 'Kanit',
    foreground: Paint()..shader = CustomColor.mainGradient,
  );
  static const welcomePageSubtitle = TextStyle(
    color: CustomColor.lightwhite,
    fontSize: 20,
    fontWeight: FontWeight.w200,
    fontFamily: 'Kanit',
  );
  static const onboardingTitle = TextStyle(
    color: CustomColor.lightwhite,
    fontSize: 32,
    fontWeight: FontWeight.w700,
    fontFamily: 'Kanit',
  );
  static const menuTitle = TextStyle(
    color: CustomColor.lightwhite,
    fontSize: 20,
    fontWeight: FontWeight.w400,
    fontFamily: 'Kanit',
  );
  static const menuSecondaryTitle = TextStyle(
    color: CustomColor.darkblue,
    fontSize: 20,
    fontWeight: FontWeight.w400,
    fontFamily: 'Kanit',
  );
  static const taskTileTitle = TextStyle(
    color: CustomColor.darkblue,
    fontSize: 20,
    fontWeight: FontWeight.w700,
    fontFamily: 'Kanit',
  );
  static const completedTaskTileTitle = TextStyle(
    color: CustomColor.lightwhite,
    fontSize: 20,
    fontWeight: FontWeight.w700,
    fontFamily: 'Kanit',
  );

  /// Texts
  static const primaryTextRegular = TextStyle(
    color: CustomColor.darkblue,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    fontFamily: 'Kanit',
  );
  static const secondaryTextRegular = TextStyle(
    color: CustomColor.customwhite,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    fontFamily: 'Kanit',
  );
  static const onboardingTextRegular = TextStyle(
    color: CustomColor.lightwhite,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    fontFamily: 'Kanit',
  );
  static const onboardingTextBold = TextStyle(
    color: CustomColor.customwhite,
    fontSize: 16,
    fontWeight: FontWeight.w700,
    fontFamily: 'Kanit',
  );
  static const taskTileDescription = TextStyle(
    color: CustomColor.darkblue,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    fontFamily: 'Kanit',
  );
  static const completedTaskTileDescription = TextStyle(
    color: CustomColor.lightwhite,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    fontFamily: 'Kanit',
  );

  /// Buttons
  static const primaryButtonRegular = TextStyle(
    color: CustomColor.customwhite,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    fontFamily: 'Kanit',
  );
  static const secondaryButtonRegular = TextStyle(
    color: CustomColor.darkblue,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    fontFamily: 'Kanit',
  );
}
