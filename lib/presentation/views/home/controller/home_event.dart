part of 'home_bloc.dart';

sealed class HomeEvent {}

final class OnPressedCameraBtn extends HomeEvent {
  final BuildContext context;
  OnPressedCameraBtn({
    required this.context,
  });
}
