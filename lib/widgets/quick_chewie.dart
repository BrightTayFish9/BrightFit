import 'package:bright_fit/controllers/singleton.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

///Wrapper class to contain the Chewie Video Player
class QuickChewie extends StatelessWidget {
  bool _network;
  String _location;

  QuickChewie(this._network, this._location);

  VideoPlayerController controller;
  ChewieController chewieController;

  @override
  Widget build(BuildContext context) {
    controller = _network
        ? VideoPlayerController.network(_location)
        : VideoPlayerController.asset(_location);

    chewieController = ChewieController(
        videoPlayerController: controller,
        aspectRatio: 1 / 1,
        autoInitialize: true,
        looping: false,
        materialProgressColors: ChewieProgressColors(
          bufferedColor: Singleton().model.color,
          handleColor: Singleton().model.color,
        ),
        errorBuilder: (context, errorMessage) {
          return Center(
            child: Text(
              errorMessage,
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          );
        });

    return Chewie(controller: chewieController);
  }

  void dispose(){
    controller.dispose();
    chewieController.dispose();
  }
}
