part of 'home_bloc.dart';

sealed class HomeEvent {
  final BuildContext context;
  HomeEvent(this.context);
}

final class FetchRecordedFiles extends HomeEvent {
  FetchRecordedFiles(super.context);
}

final class OnPressedCameraBtn extends HomeEvent {
  OnPressedCameraBtn(super.context);
}
