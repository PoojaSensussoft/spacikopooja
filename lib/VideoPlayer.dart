import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class MainVideoPlayer extends StatelessWidget {
  List<String> videos = [
    'https://archive.org/download/SampleVideo1280x7205mb/SampleVideo_1280x720_5mb.mp4',
    'https://file-examples-com.github.io/uploads/2017/04/file_example_MP4_640_3MG.mp4',
    'https://filesamples.com/samples/video/mp4/sample_640x360.mp4'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: ListView(
        padding: EdgeInsets.all(10),
        children: [
          VideoPlayerRemote(
            url: videos[0],
          ),
          Container(
            height: 100,
            color: Colors.red[600],
            child: const Center(child: Text('Item A')),
          ),
          VideoPlayerRemote(
            url: videos[1],
          ),
          Container(
            height: 100,
            color: Colors.greenAccent[500],
            child: const Center(child: Text('Item B')),
          ),
          VideoPlayerRemote(
            url: videos[2],
          ),
        ],
      )),
    );
  }
}

class VideoPlayerRemote extends StatefulWidget {
  final String url;

  VideoPlayerRemote({this.url});

  @override
  _VideoPlayerRemoteState createState() => _VideoPlayerRemoteState();
}

class _VideoPlayerRemoteState extends State<VideoPlayerRemote> {
  VideoPlayerController controller;

  @override
  void initState() {
    super.initState();
    controller = VideoPlayerController.network(widget.url);

    controller.addListener(() {
      setState(() {});
    });
    controller.setLooping(true);
    controller.initialize();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(padding: const EdgeInsets.only(top: 20.0)),
          Container(
            padding: const EdgeInsets.all(20),
            child: AspectRatio(
              aspectRatio: controller.value.aspectRatio,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: <Widget>[
                  VideoPlayer(controller),
                  _PlayPauseOverlay(controller: controller),
                  VideoProgressIndicator(controller, allowScrubbing: true),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class _PlayPauseOverlay extends StatelessWidget {
  const _PlayPauseOverlay({Key key, this.controller}) : super(key: key);

  final VideoPlayerController controller;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedSwitcher(
          duration: Duration(milliseconds: 50),
          reverseDuration: Duration(milliseconds: 200),

          child: controller.value.isPlaying
              ? SizedBox.shrink()
              : Container(
            color: Colors.black26,
            child: Center(
              child: Icon(
                Icons.play_arrow,
                color: Colors.white,
                size: 100.0,
              ),
            ),
          ),
        ),

        GestureDetector(
          onTap: () {
            controller.play();
          },
        ),
      ],
    );
  }


}
