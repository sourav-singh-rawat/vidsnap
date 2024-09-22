import 'dart:math';

import 'package:flutter/material.dart';
import 'package:vidsnap/modules/domain/video_player/video_player.dart';
import 'package:vidsnap/presentation/core_widgets/buttons/clickable.dart';
import 'package:vidsnap/presentation/core_widgets/video/video_thumbnail.dart';

class AppVidSnapPlayer extends StatefulWidget {
  final Uri? dataSource;
  final double width;
  final double height;
  final VoidCallback? onTap;
  final AppVideoPlayer? player;
  const AppVidSnapPlayer({
    super.key,
    this.dataSource,
    required this.width,
    required this.height,
    this.onTap,
    this.player,
  });

  @override
  State<AppVidSnapPlayer> createState() => _AppVidSnapPlayerState();
}

class _AppVidSnapPlayerState extends State<AppVidSnapPlayer> {
  late AppVideoPlayer player;
  bool isCompleted = false;
  bool isPlaying = false;

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

    player.addListener(() {
      if (!player.isPlaying &&
          player.position > Duration.zero &&
          player.position.inSeconds >= player.duration.inSeconds) {
        if (!isCompleted) {
          setState(() {
            isPlaying = false;
            isCompleted = true;
          });
        }
      } else if (isPlaying != player.isPlaying) {
        setState(() {
          isPlaying = player.isPlaying;
          isCompleted = false;
        });
      }
    });
  }

  void onTap() async {
    if (!player.isPlaying || isCompleted || player.isCompleted) {
      await player.play();
    } else {
      await player.pause();
    }

    widget.onTap?.call();
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
    final iconSize = min(widget.width, widget.height) / 4;

    final videoHeight = min(widget.height, player.size.height);

    return AppClickable(
      key: ValueKey(player.hashCode),
      onPressed: onTap,
      child: Stack(
        children: [
          AppVideoThumbnail(
            width: widget.width,
            height: videoHeight,
            player: player,
            alignment: Alignment.center,
          ),
          if (!isPlaying || isCompleted) ...{
            Positioned.fill(
              child: Container(
                width: double.maxFinite,
                height: double.maxFinite,
                color: Colors.white.withOpacity(0.15),
                alignment: Alignment.center,
                child: Icon(
                  Icons.play_arrow,
                  size: iconSize,
                  color: Colors.white,
                ),
              ),
            ),
          }
        ],
      ),
    );
  }
}
