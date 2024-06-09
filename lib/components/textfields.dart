import 'package:flutter/material.dart';
import 'package:taskhub/styles/colors.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.textController,
    this.hintText,
    this.icon,
    this.obscureText,
  });

  final TextEditingController textController;
  final String? hintText;
  final Icon? icon;
  final bool? obscureText;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      width: MediaQuery.of(context).size.width * 0.8,
      height: 48,
      decoration: BoxDecoration(
        color: CustomColor.lightwhite,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        controller: textController,
        style: const TextStyle(
          color: CustomColor.darkblue,
          fontSize: 16,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          contentPadding: const EdgeInsets.all(8),
          prefixIcon: icon,
          prefixIconColor: CustomColor.darkblue,
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            borderSide: BorderSide(
              color: CustomColor.customwhite,
              width: 2.5,
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            borderSide: BorderSide(
              color: CustomColor.lightblue,
              width: 2.5,
            ),
          ),
        ),
        obscureText: obscureText ?? false,
      ),
    );
  }
}
