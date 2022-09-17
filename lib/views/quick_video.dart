import 'package:bright_fit/widgets/weighter.dart';
import 'package:cached_video_player/cached_video_player.dart';
import 'package:flutter/material.dart';

///Wrapper class for the CachedVideoPlayer
class QuickVideo extends StatefulWidget {
  final String _link;
  final bool _play;

  QuickVideo(this._link, this._play);

  @override
  _QuickVideoState createState() => _QuickVideoState();
}

class _QuickVideoState extends State<QuickVideo> {
  CachedVideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = CachedVideoPlayerController.network(widget._link)
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {
          _controller.setVolume(0.0);
          _controller.setLooping(true);
          widget._play ? _controller.play() : print('nothing');
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _controller.value.initialized
          ? AspectRatio(
              aspectRatio: 1 / 1,
              child: CachedVideoPlayer(_controller),
            )
          : Container(
              height: MediaQuery.of(context).size.width - 8,
              child: Weighter(),
            ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
