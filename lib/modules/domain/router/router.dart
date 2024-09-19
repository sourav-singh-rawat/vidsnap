import 'package:flutter/material.dart';
import 'package:vidsnap/modules/data/router/router.dart';
import 'package:vidsnap/modules/domain/module.dart';

abstract class AppRouter implements AppModule<void> {
  AppRouter._();

  static final AppRouter instance = AppRouterImpl();

  factory AppRouter() {
    return instance;
  }

  Future<T?> push<T extends Object?>(BuildContext context, Route<T> route);
  bool canPop(BuildContext context);
  void pop<T extends Object?>(BuildContext context, [T? result]);
}
