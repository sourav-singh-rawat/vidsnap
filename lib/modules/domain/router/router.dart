import 'package:vidsnap/modules/data/router/router.dart';
import 'package:vidsnap/modules/domain/module.dart';

abstract class AppRouter implements AppModule<void> {
  AppRouter._();

  static final AppRouter instance = AppRouterImpl();

  factory AppRouter() {
    return instance;
  }
}
