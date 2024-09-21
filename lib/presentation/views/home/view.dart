import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vidsnap/modules/data/file_manager/file_manager.dart';
import 'package:vidsnap/presentation/core_widgets/buttons/clickable.dart';
import 'package:vidsnap/presentation/core_widgets/scaffold.dart';
import 'package:vidsnap/presentation/core_widgets/video/video_thumbnail.dart';
import 'package:vidsnap/presentation/views/home/controller/home_bloc.dart';

part 'widgets/camera_button.dart';
part 'widgets/recorded_video_header.dart';
part 'widgets/recorded_videos/recorded_videos.dart';
part 'widgets/recorded_videos/video_tile.dart';
part 'widgets/video_player.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    context.read<HomeBloc>().add(FetchRecordedFiles(context));
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.resumed) {
    } else if (state == AppLifecycleState.paused || state == AppLifecycleState.detached) {}
  }

  @override
  Widget build(BuildContext context) {
    return const AppScaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _VideoPlayer(),
          SizedBox(height: 16),
          _RecordedVideosHeader(),
          SizedBox(height: 16),
          _RecordedVideos(),
        ],
      ),
      floatingActionButton: _CameraButton(),
    );
  }
}
