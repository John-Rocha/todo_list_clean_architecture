import 'package:flutter/material.dart';

enum CustomButtonType { elevated, text }

class CustomButton extends StatelessWidget {
  final CustomButtonType type;
  final Widget child;
  final VoidCallback? onPressed;
  final double? width;
  final double? height;

  const CustomButton({
    super.key,
    required this.type,
    required this.child,
    required this.onPressed,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return type == CustomButtonType.elevated
        ? SizedBox(
            width: width,
            height: height,
            child: ElevatedButton(onPressed: onPressed, child: child),
          )
        : TextButton(onPressed: onPressed, child: child);
  }
}
