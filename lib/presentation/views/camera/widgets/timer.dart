part of '../view.dart';

class _Timer extends StatefulWidget {
  const _Timer({super.key});

  @override
  State<_Timer> createState() => _TimerState();
}

class _TimerState extends State<_Timer> with SingleTickerProviderStateMixin {
  late final Ticker _ticker;
  ValueNotifier<Duration> _elapsed = ValueNotifier(Duration.zero);

  @override
  void initState() {
    super.initState();
    debugPrint("initState called");
    _ticker = createTicker((elapsed) {
      if (!mounted) {
        return;
      }

      _elapsed.value = elapsed;
    });
  }

  void _onStateChange(BuildContext context, CameraState state) {
    if (state.isRecording) {
      _ticker.start();
    } else if (!state.isRecording && _ticker.isActive) {
      _ticker.stop();
    }
  }

  @override
  void deactivate() {
    if (_ticker.isActive) {
      _ticker.stop();
    }
    super.deactivate();
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  String _formattedTimeText(Duration value) {
    final hours = value.inHours.toString().padLeft(2, '0');
    final min = value.inMinutes.toString().padLeft(2, '0');
    final sec = value.inSeconds.toString().padLeft(2, '0');
    return '$hours:$min:$sec';
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CameraBloc, CameraState>(
      listener: _onStateChange,
      builder: (context, state) {
        if (!state.isRecording) {
          return const Offstage();
        }

        return Container(
          decoration: const ShapeDecoration(
            shape: StadiumBorder(),
            color: Colors.redAccent,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          child: ValueListenableBuilder(
            valueListenable: _elapsed,
            builder: (context, value, child) {
              return Text(
                _formattedTimeText(value),
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              );
            },
          ),
        );
      },
    );
  }
}
