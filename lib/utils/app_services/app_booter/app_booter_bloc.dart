part of '../app_services.dart';

class AppBooterBloc extends Bloc<AppBooterEvent, AppBooterState> {
  AppBooterBloc() : super(AppBooterState.init()) {
    on<BootUpEvent>(_bootUp);
    on<BootDownEvent>(_bootDown);
  }

  void _bootUp(BootUpEvent event, Emitter<AppBooterState> emit) async {
    await AppModule.instance.bootUp();

    emit(
      state.copyWith(
        bootStatus: AppBooterStatus.booted,
      ),
    );

    _onBootUp.call();
  }

  void _onBootUp() async {
    AppModule.instance.onBootUp();
  }

  void _bootDown(BootDownEvent event, Emitter<AppBooterState> emit) {
    AppModule.instance.bootDown();
  }
}
