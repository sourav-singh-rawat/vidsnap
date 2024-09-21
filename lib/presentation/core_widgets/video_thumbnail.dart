import 'package:flutter/material.dart';
import 'package:vidsnap/modules/domain/video_player/video_player.dart';

class AppVideoThumbnail extends StatefulWidget {
  final Uri dataSource;
  final double width;
  final double height;
  final double? borderRadius;
  const AppVideoThumbnail({
    super.key,
    required this.dataSource,
    required this.width,
    required this.height,
    this.borderRadius,
  });

  @override
  State<AppVideoThumbnail> createState() => _AppVideoThumbnailState();
}

class _AppVideoThumbnailState extends State<AppVideoThumbnail> {
  late AppVideoPlayer player;
  @override
  void initState() {
    super.initState();
    player = AppVideoPlayer.asset(widget.dataSource);
    player.initialize().then((_) => setState(() {}));
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final child = Container(
      width: widget.width,
      height: widget.height,
      color: Colors.black,
      child: player.isInitialized
          ? AspectRatio(
              aspectRatio: widget.width / widget.height,
              child: player.playerPreview(),
            )
          : const Center(
              child: SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(
                  color: Colors.grey,
                ),
              ),
            ),
    );

    if (widget.borderRadius == null) {
      return child;
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(widget.borderRadius!),
      child: child,
    );
  }
}
