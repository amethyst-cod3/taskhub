import 'package:flutter/material.dart';

class CustomColor {
  static const Color customwhite = Color(0xFFFBFFF4);
  static const Color transparentCustomwhite = Color(0x80FBFFF4);

  static const Color darkblue = Color(0xFF413B6B);
  static const Color lightwhite = Color(0xFFE7EBFD);

  static const Color blue = Color(0xFF605DFF);
  static const Color lightblue = Color(0xFF5DA8FF);
  static const Color purple = Color(0xFFAD63F6);

  static Shader mainGradient = const LinearGradient(
      // begin: Alignment.topLeft,
      // end: Alignment.bottomRight,
      colors: [
        blue,
        lightblue,
        purple,
      ]).createShader(
    const Rect.fromLTRB(0, 0, 250, 0),
  );
}
