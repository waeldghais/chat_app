import 'package:flutter/material.dart';

import 'package:video_player/video_player.dart';

class ShowVideo extends StatefulWidget {
  const ShowVideo({
    Key key,
    this.text,
  }) : super(key: key);

  final String text;
  @override
  _Video createState() => _Video(
        text: text,
      );
}

class _Video extends State<ShowVideo> {
  _Video({Key key, this.text});

  final String text;
  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;
  @override
  void initState() {
    _controller = VideoPlayerController.network(text);
    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.play();

    _controller.setLooping(true);
    _controller.setVolume(10.0);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
      ),
      body: Center(
        child: FutureBuilder(
          future: _initializeVideoPlayerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
