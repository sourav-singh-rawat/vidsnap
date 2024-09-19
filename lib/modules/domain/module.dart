import 'dart:collection';

import 'package:vidsnap/modules/data/module.dart';
import 'package:vidsnap/utils/app_booter/app_booter_bloc.dart';

abstract class AppModule<T> implements Booter<T> {
  static final AppModule instance = AppModuleImpl();

  static final coreModules = UnmodifiableListView([]);

  static final amenityModules = UnmodifiableListView([]);

  static final bootUpSequence = [...coreModules, ...amenityModules];
}
