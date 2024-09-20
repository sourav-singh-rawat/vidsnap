part of 'app_booter_bloc.dart';

//A sealed class cannot be extended outside of its library (file).
sealed class AppBooterEvent {
  const AppBooterEvent();
}

final class BootUpEvent extends AppBooterEvent {
  const BootUpEvent();
}

final class BootDownEvent extends AppBooterEvent {
  const BootDownEvent();
}
