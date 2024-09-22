import 'dart:math';

import 'package:flutter/material.dart';
import 'package:vidsnap/modules/domain/video_player/video_player.dart';

class AppVideoThumbnail extends StatefulWidget {
  final Uri? dataSource;
  final double width;
  final double height;
  final double? borderRadius;
  final AppVideoPlayer? player;
  final Alignment? alignment;
  const AppVideoThumbnail({
    super.key,
    this.dataSource,
    required this.width,
    required this.height,
    this.borderRadius,
    this.player,
    this.alignment,
  });

  @override
  State<AppVideoThumbnail> createState() => _AppVideoThumbnailState();
}

class _AppVideoThumbnailState extends State<AppVideoThumbnail> {
  late AppVideoPlayer player;
  @override
  void initState() {
    super.initState();
    if (widget.player != null) {
      player = widget.player!;
    } else {
      player = AppVideoPlayer.asset(widget.dataSource!);
    }

    if (!player.isInitialized) {
      player.initialize().then((_) => setState(() {}));
    }
  }

  @override
  void dispose() {
    if (widget.player == null) {
      player.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final progressBarSize = min(widget.width, widget.height) / 4;

    final child = Container(
      width: widget.width,
      height: widget.height,
      color: Colors.black,
      alignment: widget.alignment,
      child: player.isInitialized
          ? AspectRatio(
              aspectRatio: player.aspectRatio,
              child: player.playerPreview(),
            )
          : Center(
              child: SizedBox(
                width: progressBarSize,
                height: progressBarSize,
                child: const CircularProgressIndicator(
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
