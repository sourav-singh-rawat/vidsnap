import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:vidsnap/modules/domain/router/router.dart';

class AppRouterImpl implements AppRouter {
  @override
  Future<void> bootUp() async {
    log('[AppRouter]:[bootUp]');
  }

  @override
  void onBootUp() {
    // TODO: implement onBootUp
  }

  @override
  void bootDown() {
    // TODO: implement bootDown
  }

  @override
  bool canPop(BuildContext context) {
    return Navigator.canPop(context);
  }

  @override
  void pop<T extends Object?>(BuildContext context, [T? result]) {
    Navigator.pop(context, result);
  }

  @override
  Future<T?> push<T extends Object?>(BuildContext context, Route<T> route) {
    return Navigator.push(context, route);
  }
}
