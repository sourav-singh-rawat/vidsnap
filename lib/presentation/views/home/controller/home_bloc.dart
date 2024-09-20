import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vidsnap/modules/domain/router/router.dart';
import 'package:vidsnap/presentation/views/camera/view.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeState.init()) {
    on<OnPressedCameraBtn>(_onPressedCameraBtn);
  }

  void _onPressedCameraBtn(OnPressedCameraBtn event, Emitter<HomeState> emit) {
    AppRouter.instance.push(event.context, const CameraView());
  }
}
