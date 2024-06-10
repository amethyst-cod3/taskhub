import 'package:flutter/material.dart';
import 'package:taskhub/styles/colors.dart';
import 'package:taskhub/styles/text_styles.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    required this.textStyle,
    required this.color,
    required this.borderColor,
    this.borderRadius,
    required this.onTap,
    required this.pressed,
    this.width,
  });

  final String text;
  final TextStyle textStyle;
  final Color color;
  final Color borderColor;
  final double? borderRadius;
  final VoidCallback onTap;
  final bool pressed;
  final double? width;

  factory CustomButton.primary({
    required String text,
    Color? color,
    required VoidCallback onTap,
    bool pressed = false,
    double? width,
  }) =>
      CustomButton(
        text: text,
        textStyle: CustomTextStyle.primaryButtonRegular,
        color: color ?? CustomColor.darkblue,
        borderColor: color ?? Colors.transparent,
        borderRadius: 12,
        onTap: onTap,
        pressed: pressed,
        width: width,
      );

  factory CustomButton.secondary({
    required String text,
    Color? color,
    required VoidCallback onTap,
    bool pressed = false,
    double? width,
  }) =>
      CustomButton(
        text: text,
        textStyle: CustomTextStyle.secondaryButtonRegular,
        color: color ?? CustomColor.customwhite,
        //borderColor: color ?? CustomColor.darkblue,
        borderColor: Colors.transparent,
        borderRadius: 12,
        onTap: onTap,
        pressed: pressed,
        width: width,
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      child: TextButton(
        style: ButtonStyle(
          fixedSize: WidgetStateProperty.all(
            Size(
              width ?? MediaQuery.of(context).size.width * 0.8,
              48,
            ),
          ),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.all(Radius.circular(borderRadius ?? 0)),
              // side: BorderSide(
              //   color: borderColor.withOpacity(pressed ? 0.5 : 1),
              //   width: 0.5,
              // ),
            ),
          ),
          backgroundColor: WidgetStateProperty.all(
            color.withOpacity(pressed ? .5 : 1),
          ),
          alignment: Alignment.center,
        ),
        onPressed: pressed
            ? null
            : () {
                onTap();
              },
        child: Text(
          text,
          style: textStyle,
        ),
      ),
    );
  }
}
