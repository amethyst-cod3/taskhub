import 'package:flutter/material.dart';
import 'package:taskhub/styles/colors.dart';
import 'package:taskhub/styles/text_styles.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.textController,
    this.maxLength,
    this.hintText,
    this.icon,
    this.obscureText,
    this.minLines,
    this.maxLines,
    this.expands,
    required this.isPrimary,
    this.isTaskField,
  });

  final TextEditingController textController;
  final int? maxLength;
  final String? hintText;
  final Icon? icon;
  final bool? obscureText;
  final int? minLines;
  final int? maxLines;
  final bool? expands;
  final bool isPrimary;
  final bool? isTaskField;

  factory CustomTextField.primary({
    required TextEditingController textController,
    String? hintText,
    int? maxLength,
    Icon? icon,
    bool? obscureText,
    int? maxLines,
    bool? expands,
    bool? isTaskField,
  }) =>
      CustomTextField(
        textController: textController,
        maxLength: maxLength,
        hintText: hintText,
        icon: icon,
        obscureText: obscureText,
        maxLines: 1,
        expands: false,
        isPrimary: true,
        isTaskField: isTaskField,
      );

  factory CustomTextField.secondary({
    required TextEditingController textController,
    String? hintText,
    int? minLines,
    int? maxLines,
    bool? expands,
    bool? isTaskField,
  }) =>
      CustomTextField(
        textController: textController,
        hintText: hintText,
        minLines: minLines,
        maxLines: maxLines,
        expands: true,
        isPrimary: false,
        isTaskField: isTaskField,
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      width: isTaskField!
          ? MediaQuery.of(context).size.width
          : MediaQuery.of(context).size.width * 0.8,
      height: isPrimary ? 48 : 144,
      child: TextField(
        controller: textController,
        maxLength: maxLength,
        style: CustomTextStyle.primaryTextRegular,
        decoration: InputDecoration(
          hintText: hintText,
          contentPadding: const EdgeInsets.all(8),
          prefixIcon: icon,
          prefixIconColor: CustomColor.darkblue,
          filled: true,
          fillColor:
              isTaskField! ? CustomColor.customwhite : CustomColor.lightwhite,
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
        minLines: minLines,
        maxLines: maxLines,
        expands: expands ?? false,
      ),
    );
  }
}
