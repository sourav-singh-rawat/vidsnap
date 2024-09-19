part of 'app_booter_bloc.dart';

sealed class AppBooterEvent {
  const AppBooterEvent();
}

final class BootUpEvent extends AppBooterEvent {}

final class BootDownEvent extends AppBooterEvent {}
