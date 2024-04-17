import 'package:flutter/material.dart';

enum CustomButtonType { elevated, text }

class CustomButton extends StatelessWidget {
  final CustomButtonType type;
  final Widget child;
  final VoidCallback onPressed;

  const CustomButton({
    super.key,
    required this.type,
    required this.child,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return type == CustomButtonType.elevated
        ? ElevatedButton(
            onPressed: onPressed,
            child: child,
          )
        : TextButton(
            onPressed: onPressed,
            child: child,
          );
  }
}
