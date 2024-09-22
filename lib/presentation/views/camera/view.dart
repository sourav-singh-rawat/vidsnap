import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vidsnap/presentation/core_widgets/buttons/clickable.dart';
import 'package:vidsnap/presentation/core_widgets/scaffold.dart';
import 'package:vidsnap/presentation/views/camera/controller/camera_bloc.dart';
import 'package:vidsnap/repository/repository.dart';
import 'package:vidsnap/utils/portrait_mixin.dart';

part 'widgets/action_bar.dart';
part 'widgets/back_button.dart';
part 'widgets/camera_preview.dart';
part 'widgets/timer.dart';

class CameraView extends StatefulWidget {
  const CameraView({super.key});

  @override
  State<CameraView> createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> with WidgetsBindingObserver, AppPortraitStatefulModeMixin<CameraView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    context.read<CameraBloc>().add(InitializeCamera(context));
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (!mounted) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      if (!AppRepository.camera.isInitialized) {
        return;
      }

      context.read<CameraBloc>().add(DisposeCamera(context));
    } else if (state == AppLifecycleState.resumed) {
      context.read<CameraBloc>().add(InitializeCamera(context));
    }
  }

  @override
  void deactivate() {
    context.read<CameraBloc>().add(DisposeCamera(context));
    super.deactivate();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return AppScaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: const _BackButton(),
        title: const _Timer(),
        centerTitle: true,
      ),
      body: const _CameraPreview(),
      bottomSheet: const _ActionBar(),
    );
  }
}
