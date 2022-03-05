import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';

class VideoItem extends StatefulWidget {
  const VideoItem({Key? key}) : super(key: key);

  @override
  State<VideoItem> createState() => _VideoItemState();
}

class _VideoItemState extends State<VideoItem> {
  // late VideoPlayerController _controller;
  // late Future<void> _initializeVideoPlayerFuture;

  // @override
  // void initState() {
  //   _controller = VideoPlayerController.network(
  //     'https://firebasestorage.googleapis.com/v0/b/blue-baker.appspot.com/o/videos%2Fbluebaker.mp4?alt=media&token=f05d7eef-9c69-4bb5-bac5-51c72ddf3e4f',
  //   );
  //   _initializeVideoPlayerFuture = _controller.initialize();
  //   _controller.setLooping(true);
  //   _controller.play();
  //   super.initState();
  // }

  // @override
  // void dispose() {
  //   _controller.dispose();
  //   super.dispose();
  // }

  late ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    _chewieController = ChewieController(
      videoPlayerController: VideoPlayerController.network(
        'https://firebasestorage.googleapis.com/v0/b/blue-baker.appspot.com/o/videos%2Fbluebaker.mp4?alt=media&token=f05d7eef-9c69-4bb5-bac5-51c72ddf3e4f',
      ),
      aspectRatio: 16 / 9,
      autoInitialize: true,
      autoPlay: true,
      looping: true,
      allowFullScreen: false,
      showOptions: false,
      materialProgressColors: ChewieProgressColors(
        bufferedColor: Colors.white,
        backgroundColor: Colors.grey.shade200,
      ),

      // placeholder: Container(
      //   height: 240.h,
      //   color: Colors.grey.shade200,
      // ),
      
      errorBuilder: (context, errorMessage) {
        return Center(
          child: Text(
            'We had an error playing the video, please try again later',
            style: GoogleFonts.lato(color: Colors.white),
            textAlign: TextAlign.center,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 240.h,
      child: Chewie(
        controller: _chewieController,
      ),
    );
    // SizedBox(
    //   width: MediaQuery.of(context).size.width.w,
    //   height: 200.h,
    //   child: FutureBuilder(
    //     future: _initializeVideoPlayerFuture,
    //     builder: (context, snapshot) {
    //       if (snapshot.connectionState == ConnectionState.done) {
    //         return AspectRatio(
    //           aspectRatio: _controller.value.aspectRatio,
    //           child: VideoPlayer(_controller),
    //         );
    //       } else {
    //         return Center(
    //           child: CircularProgressIndicator(
    //             color: Theme.of(context).focusColor,
    //           ),
    //         );
    //       }
    //     },
    //   ),
    // );
  }
}
