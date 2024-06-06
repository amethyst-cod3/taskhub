import 'package:flutter/material.dart';
import 'package:taskhub/styles/colors.dart';

class Button extends StatelessWidget {
  const Button({
    super.key,
    required this.text,
    required this.textStyle,
    required this.color,
    required this.borderColor,
    this.borderRadius,
    required this.onTap,
    required this.pressed,
  });

  final String text;
  final TextStyle textStyle;
  final Color color;
  final Color borderColor;
  final double? borderRadius;
  final VoidCallback onTap;
  final bool pressed;

  factory Button.primary({
    required String text,
    Color? color,
    required VoidCallback onTap,
    bool pressed = false,
  }) =>
      Button(
        text: text,
        textStyle: const TextStyle(
          color: CustomColor.lightwhite,
        ),
        color: color ?? CustomColor.darkblue,
        borderColor: color ?? Colors.transparent,
        borderRadius: 12,
        onTap: onTap,
        pressed: pressed,
      );

  factory Button.secondary({
    required String text,
    Color? color,
    required VoidCallback onTap,
    bool pressed = false,
  }) =>
      Button(
        text: text,
        textStyle: const TextStyle(
          color: CustomColor.darkblue,
        ),
        color: color ?? CustomColor.lightwhite,
        //borderColor: color ?? CustomColor.darkblue,
        borderColor: Colors.transparent,
        borderRadius: 12,
        onTap: onTap,
        pressed: pressed,
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      child: TextButton(
        style: ButtonStyle(
          fixedSize: WidgetStateProperty.all(
            Size(
              MediaQuery.of(context).size.width * 0.67,
              36,
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
