import 'package:flutter/material.dart';
import 'package:vidsnap/presentation/core_widgets/scaffold.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppScaffold(
      body: Center(
        child: Text(
          'Loading...',
          textScaler: TextScaler.linear(2.1),
        ),
      ),
    );
  }
}
