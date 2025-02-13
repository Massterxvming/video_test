import 'package:flutter_animated_progress_bar/flutter_animated_progress_bar.dart';
import 'package:video_player/video_player.dart';

import '../common/common.dart';

class VideoPlay extends StatefulWidget {
  final String videoUrl;

  const VideoPlay({
    super.key,
    required this.videoUrl,
  });

  @override
  State<VideoPlay> createState() => _VideoPlayState();
}

class _VideoPlayState extends AppPageBase<VideoPlay> with TickerProviderStateMixin {
  late final ProgressBarController _controller;

  late VideoPlayerController videoPlayerController;

  bool _shouldSyncVideoProgress = true;
  Duration _seekPosition = Duration.zero;

  _initData() {
    videoPlayerController = VideoPlayerController.asset(widget.videoUrl);
    videoPlayerController.initialize().then((onValue) {
      videoPlayerController.setVolume(1.0);
      videoPlayerController.setLooping(true);
      videoPlayerController.play();
      setState(() {});
    });

    videoPlayerController.addListener(() {
      if (_shouldSyncVideoProgress) {
        _seekPosition = videoPlayerController.value.position;
        setState(() {});
      }
    });

    _controller = ProgressBarController(vsync: this);
  }

  Timer? _timer;
  bool isAvailable = false;
  void switchAvailable() {
    setState(() {
      isAvailable = !isAvailable;
    });
    if (_timer != null && _timer!.isActive) {
      _timer!.cancel();
    }
    _timer = Timer(const Duration(seconds: 3), () {
      setState(() {
        isAvailable = false;
      });
    });
  }



  @override
  void initState() {
    super.initState();
    _initData();
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double safeBottom = MediaQuery.of(context).padding.bottom;
    double safeTop = MediaQuery.of(context).padding.top;
    Widget videoPlayer = videoPlayerController.value.isInitialized
        ? Container(
            alignment: Alignment.center,
            color: Colors.black,
            child: AspectRatio(
              aspectRatio: videoPlayerController.value.aspectRatio,
              child: VideoPlayer(videoPlayerController),
            ),
          )
        : Center(
            child: CircularProgressIndicator(),
          );

    Widget playButton = Container(
      alignment: Alignment.center,
      height: 124,
      width: 124,
      child: FloatingActionButton(
        elevation: 0,
        backgroundColor: Colors.white12.withValues(alpha: 0.4),
        foregroundColor: Colors.white.withValues(alpha: 0.8),
        shape: const CircleBorder(),
        onPressed: () async {
          if (videoPlayerController.value.isPlaying) {
            await videoPlayerController.pause();
          } else {
            await videoPlayerController.play();
          }
          setState(() {});
        },
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 50),
          reverseDuration: const Duration(milliseconds: 200),
          child: videoPlayerController.value.isPlaying
              ? Center(
                  child: Icon(
                    Icons.pause,
                    size: 48,
                    semanticLabel: 'Pause',
                  ),
                )
              : Center(
                  child: Icon(
                    Icons.play_arrow,
                    size: 48,
                    semanticLabel: 'Play',
                  ),
                ),
        ),
      ),
    );

    Widget videoProgress = ProgressBar(
      progressBarIndicator: ProgressBarIndicator.none,
      collapsedThumbRadius: 0,
      expandedThumbColor: Colors.transparent,
      alignment: ProgressBarAlignment.bottom,
      expandedThumbRadius: 12,
      barCapShape: BarCapShape.round,
      thumbGlowColor: Colors.white.withValues(alpha: 0.5),
      thumbGlowRadius: 10,
      backgroundBarColor: Colors.black12,
      collapsedThumbColor: Colors.white.withValues(alpha: 0.5),
      collapsedProgressBarColor: Colors.white,
      collapsedBufferedBarColor: Colors.black12,
      controller: _controller,
      progress: _seekPosition,
      total: videoPlayerController.value.duration,
      onSeek: (position) async {
        _shouldSyncVideoProgress = true;
        videoPlayerController.seekTo(position);
      },
      onChangeStart: (position) {
        _shouldSyncVideoProgress = false;
        _controller.stopBarAnimation();
        videoPlayerController.pause();
      },
      onChanged: (position) {
        if (_timer != null && _timer!.isActive) {
          _timer?.cancel();
        }
        _shouldSyncVideoProgress = false;
        _seekPosition = position;
        _controller.barValue = position.inMilliseconds.toDouble() / videoPlayerController.value.duration.inMilliseconds.toDouble();
        setState(() {});
      },
      onChangeEnd: (position) async {
        _timer = Timer(const Duration(seconds: 3), () {
          setState(() {
            isAvailable = false;
          });
        });
        await videoPlayerController.seekTo(position);
        videoPlayerController.play();
        _shouldSyncVideoProgress = true;
        setState(() {});
      },
    );

    if(!isAvailable){
      playButton=Container();
      videoProgress=Container();
    }

    return Padding(
      padding: EdgeInsets.only(bottom: safeBottom,),
      child: Stack(
        children: [
          videoPlayer,
          GestureDetector(
            onTap: () {
              switchAvailable();
            },
          ),
          Align(
            alignment: Alignment.center,
            child: playButton,
          ),
          Align(alignment: Alignment.bottomCenter,child: videoProgress),

        ],
      ),
    );
  }
}
