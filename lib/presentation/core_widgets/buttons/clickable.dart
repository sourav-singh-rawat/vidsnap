import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppClickable extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;
  final bool isFeedbackEnabled;
  final EdgeInsets? padding;
  const AppClickable({
    super.key,
    required this.child,
    required this.onPressed,
    this.isFeedbackEnabled = true,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (isFeedbackEnabled) {
          HapticFeedback.mediumImpact();
        }
        onPressed.call();
      },
      child: Padding(
        padding: padding ?? EdgeInsets.zero,
        child: child,
      ),
    );
  }
}
