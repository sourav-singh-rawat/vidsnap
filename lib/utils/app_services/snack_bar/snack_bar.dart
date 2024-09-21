part of '../app_services.dart';

const Duration kSnackBarDisplayDuration = Duration(milliseconds: 3000);

enum AppSnackType { error, message }

class _AppSnack {
  _AppSnack();

  void show({
    required BuildContext context,
    AppSnackType type = AppSnackType.error,
    Widget? leading,
    String? leadingIcon,
    Color? leadingIconTintColor,
    String text = 'Hello! This is Vid Snap, Happy here to serve you.',
    Widget? content,
    Color? backgroundColor,
    double? elevation,
    EdgeInsetsGeometry? margin,
    EdgeInsetsGeometry? padding,
    double? width,
    ShapeBorder? shape,
    SnackBarBehavior? behavior,
    String? actionLabel,
    VoidCallback? onPressedAction,
  }) {
    if (type == AppSnackType.message) {
      backgroundColor = Colors.deepPurpleAccent;
    }

    final snackBar = SnackBar(
      width: width,
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 14,
      ),
      margin: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 12,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      content: () {
        if (content != null) {
          return content;
        }

        final child = Text(
          text,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        );

        return child;
      }(),
      backgroundColor: backgroundColor ?? Colors.redAccent,
      behavior: behavior ?? SnackBarBehavior.floating,
      elevation: elevation ?? 4.0,
      duration: kSnackBarDisplayDuration,
    );

    hide.call(context);

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void hide(BuildContext context) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
  }
}
