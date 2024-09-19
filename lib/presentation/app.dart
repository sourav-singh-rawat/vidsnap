import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vidsnap/presentation/views/home/view.dart';
import 'package:vidsnap/presentation/views/splash/view.dart';
import 'package:vidsnap/utils/app_booter/app_booter_bloc.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.resumed) {
      log('[AppState] App resumed');
    } else if (state == AppLifecycleState.paused || state == AppLifecycleState.detached) {
      log('[AppState] App in background, $state');
    }
  }

  @override
  Widget build(BuildContext context) {
    return _AppBlocRegistry(
      child: MaterialApp(
        title: 'Vid Snap',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
        ),
        home: BlocSelector<AppBooterBloc, AppBooterState, AppBooterStatus>(
          selector: (state) => state.bootStatus,
          builder: (context, bootStatus) {
            final isBooted = bootStatus == AppBooterStatus.booted;

            return AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              switchOutCurve: Curves.bounceIn,
              child: isBooted ? const HomeView() : const SplashView(),
            );
          },
        ),
      ),
    );
  }
}

class _AppBlocRegistry extends StatelessWidget {
  final Widget child;

  const _AppBlocRegistry({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AppBooterBloc>(
          create: (context) => AppBooterBloc()..add(BootUpEvent()),
          lazy: false,
        ),
      ],
      child: child,
    );
  }
}
