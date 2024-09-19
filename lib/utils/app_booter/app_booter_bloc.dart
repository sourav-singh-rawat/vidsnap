import 'dart:collection';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vidsnap/modules/domain/module.dart';

part 'app_booter_event.dart';
part 'app_booter_state.dart';
part 'booter_abstract.dart';

class AppBooterBloc extends Bloc<AppBooterEvent, AppBooterState> {
  AppBooterBloc() : super(AppBooterState.init()) {
    on<BootUpEvent>(_bootUp);
    on<BootDownEvent>(_bootDown);
  }

  void _bootUp(BootUpEvent event, Emitter<AppBooterState> emit) async {
    final bootUpProcesses = UnmodifiableListView<Future<dynamic>>([
      AppModule.instance.bootUp(),
    ]);
    await Future.wait(bootUpProcesses);

    emit(
      state.copyWith(
        bootStatus: AppBooterStatus.booted,
      ),
    );

    _onBootUp.call();
  }

  void _onBootUp() async {
    AppModule.instance.onBootUp();

    // AppRouter.instance
  }

  void _bootDown(BootDownEvent event, Emitter<AppBooterState> emit) {
    AppModule.instance.bootDown();
  }
}
