import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class Pickfile {
  static Future<FilePickerResult?> pickFile() async {
    return await FilePicker.platform.pickFiles(
      type: FileType.audio,
      allowMultiple: true,
    );
  }
}

class AudioPlayerPage extends StatefulWidget {
  final String audioUrl;

  const AudioPlayerPage({required this.audioUrl});
  @override
  _AudioPlayerPageState createState() => _AudioPlayerPageState();
}

class _AudioPlayerPageState extends State<AudioPlayerPage> {
  // final String audioUrl;
  late AudioPlayer audioPlayer;

  bool isPlaying = false;
  double sliderValue = 0.0;
  Duration duration = Duration();
  Duration position = Duration();

  @override
  void initState() {
    super.initState();
    audioPlayer = AudioPlayer();
    audioPlayer.onAudioPositionChanged.listen((Duration p) {
      setState(() {
        position = p;
      });
    });
    audioPlayer.onDurationChanged.listen((Duration d) {
      setState(() {
        duration = d;
      });
    });
  }

  void playAudio() async {
    await audioPlayer.stop();
    await audioPlayer.play(widget.audioUrl, isLocal: true);
    setState(() {
      isPlaying = true;
    });
  }

  void pauseAudio() {
    audioPlayer.pause();
    setState(() {
      isPlaying = false;
    });
  }

  void stopAudio() {
    audioPlayer.stop();
    setState(() {
      isPlaying = false;
    });
  }

  String formatDuration(Duration d) {
    String minutes = (d.inMinutes % 60).toString().padLeft(2, '0');
    String seconds = (d.inSeconds % 60).toString().padLeft(2, '0');
    return "$minutes:$seconds";
  }

  @override
  void dispose() {
    audioPlayer.release();
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240,
      height: 64,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              IconButton(
                icon: isPlaying ? Icon(Icons.pause) : Icon(Icons.play_arrow),
                iconSize: 35.0,
                onPressed: () {
                  if (isPlaying) {
                    pauseAudio();
                  } else {
                    playAudio();
                  }
                },
              ),
              Expanded(
                child: Slider(
                  value: position.inSeconds.toDouble(),
                  min: 0.0,
                  max: duration.inSeconds.toDouble(),
                  onChanged: (double value) {
                    setState(() {
                      audioPlayer.seek(Duration(seconds: value.toInt()));
                    });
                  },
                  activeColor: Colors.black,
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 19.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(formatDuration(position)),
                Text(formatDuration(duration)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
