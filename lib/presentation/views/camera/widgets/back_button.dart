part of '../view.dart';

class _BackButton extends StatelessWidget {
  const _BackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => AppRouter.instance.pop(context),
      icon: const Icon(
        Icons.arrow_back_ios,
        size: 24,
        color: Colors.white,
      ),
    );
  }
}
