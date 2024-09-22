part of '../view.dart';

class _Timer extends StatefulWidget {
  const _Timer({super.key});

  @override
  State<_Timer> createState() => _TimerState();
}

class _TimerState extends State<_Timer> with SingleTickerProviderStateMixin {
  Duration _elapsed = Duration.zero;
  late final Ticker _ticker;
  @override
  void initState() {
    super.initState();
    debugPrint("initState called");
    _ticker = createTicker((elapsed) {
      if (!mounted) {
        return;
      }

      setState(() {
        _elapsed = elapsed;
      });
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

  String get _formattedTimeText {
    final hours = _elapsed.inHours.toString().padLeft(2, '0');
    final min = _elapsed.inMinutes.toString().padLeft(2, '0');
    final sec = _elapsed.inSeconds.toString().padLeft(2, '0');
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
          child: Text(
            _formattedTimeText,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }
}
