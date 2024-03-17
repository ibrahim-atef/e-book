import 'package:flutter/material.dart';

import '../utils/styles.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.title,
    required this.textColor,
    required this.onPressed,
    required this.backgroundColor,
    this.borderRadius,
    this.fontSize, this.width,
  });
  final String title;
  final Color textColor;
  final void Function()? onPressed;
  final Color backgroundColor;
  final BorderRadius? borderRadius;
  final double? fontSize;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      width: width,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
              borderRadius: borderRadius ?? BorderRadius.circular(12)),
        ),
        child: Text(
          title,
          style: Styles.textStyle18.copyWith(
              color: textColor,
              fontWeight: FontWeight.w900,
              fontSize: fontSize),
        ),
      ),
    );
  }
}
