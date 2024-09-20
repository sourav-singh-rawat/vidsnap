import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vidsnap/presentation/core_widgets/scaffold.dart';
import 'package:vidsnap/presentation/views/home/controller/home_bloc.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  void onPressedCameraBtn() {
    context.read<HomeBloc>().add(OnPressedCameraBtn(context: context));
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: const Center(
        child: Text('Home View'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: onPressedCameraBtn,
        child: const Icon(
          Icons.camera_enhance_rounded,
          size: 24,
        ),
      ),
    );
  }
}
