import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vidsnap/modules/domain/module.dart';
import 'package:vidsnap/modules/domain/router/router.dart';

part 'app_booter/app_booter_bloc.dart';
part 'app_booter/app_booter_event.dart';
part 'app_booter/app_booter_state.dart';
part 'app_booter/booter_abstract.dart';
part 'snack_bar/snack_bar.dart';

class AppService {
  AppService._();

  static final router = AppRouter();
  static final snack = _AppSnack();
}
