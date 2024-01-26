import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerScreen extends StatelessWidget {
  const VideoPlayerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        // child: VideoPlayerView(
        //   videoPath: "assets/videos/sample_video.mp4",
        //   dataSourceType: DataSourceType.asset,
        // ),
        // SizedBox(
        //   height: 20,
        // ),
        child: VideoPlayerView(
            videoPath:
                "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
            dataSourceType: DataSourceType.network),
      ),
    );
  }
}

/// common widget to handle video from assests, network, photoLibrary
class VideoPlayerView extends StatefulWidget {
  final String videoPath;
  // from which the video is fetched from(assests, network, Library)
  final DataSourceType dataSourceType;
  const VideoPlayerView(
      {super.key, required this.videoPath, required this.dataSourceType});

  @override
  State<VideoPlayerView> createState() => _VideoPlayerViewState();
}

class _VideoPlayerViewState extends State<VideoPlayerView> {
  // state variable
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    // assign _videoPlayerController based on it's dataSourceType
    switch (widget.dataSourceType) {
      case DataSourceType.asset:
        _videoPlayerController = VideoPlayerController.asset(widget.videoPath);
        break;
      case DataSourceType.network:
        _videoPlayerController =
            VideoPlayerController.networkUrl(Uri.parse(widget.videoPath));
        break;
      case DataSourceType.file:
        _videoPlayerController =
            VideoPlayerController.file(File(widget.videoPath));
        break;
      case DataSourceType.contentUri:
        _videoPlayerController =
            VideoPlayerController.contentUri(Uri.parse(widget.videoPath));
        break;
    }

    // set _chewieController equals to _videoPlayerController
    _chewieController = ChewieController(
      looping: true,
      autoPlay: true,
      videoPlayerController: _videoPlayerController,
      aspectRatio: 16 / 9,
      fullScreenByDefault: true,
    );
  }

  /// remember to dispose all the controllers
  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text(
              //   widget.dataSourceType.name.toUpperCase(),
              //   style: GoogleFonts.poppins(
              //       fontSize: 24.0,
              //       fontWeight: FontWeight.bold,
              //       color: Colors.white),
              // ),
              // Divider(),
              AspectRatio(
                aspectRatio: 16 / 9,
                child: Chewie(
                  controller: _chewieController,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
