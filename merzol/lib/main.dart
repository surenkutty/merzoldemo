//import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:merzol/AudioPage.dart';
import 'ChatBubble-Model.dart';
import 'ChatBubble-Widget.dart';
import 'VideoPage.dart';
//import 'ChatBubble-Widget.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Chatbubble> chatbubbles = [
    Chatbubble(
      content: "Hello there!",
      type: MessageType.Text,
      isMe: true,
      audio_url: '',
    ),
    Chatbubble(
      content: "Hi! How can I help you?",
      type: MessageType.Text,
      isMe: false,
      audio_url: '',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            title: Text("ChatApp"),
          ),
          body: ListView.builder(
            itemCount: chatbubbles.length,
            itemBuilder: (BuildContext context, index) {
              return ChatbubbleWidget(chatbubble: chatbubbles[index]);
            },
          ),
          floatingActionButton: Stack(
            children: [
              Positioned(
                bottom: 50.0,
                right: 16.0,
                child: FloatingActionButton(
                  backgroundColor: Colors.redAccent,
                  onPressed: () async {
                    List<FilePickerResult>? result = await Pickfile.pickFile();
                    if (result == null) return;
                    //  List<FilePickerResult?> file = result.paths.map((path) => File(path!)).toList();

                    //Pickfile.pickFile((file) => null);
                    setState(() {
                      for (FilePickerResult result in result) {
                        chatbubbles.add(Chatbubble(
                          content: "https://example.com/audio.mp3",
                          type: MessageType.Audio,
                          isMe: true,
                          // audio_url:result.paths
                          //     .map((Path) => File(Path!))
                          //     .toString()),

                          audio_url: result.files.first.path!,
                        ));
                      }

                      debugPrint("$chatbubbles");
                      chatbubbles = [...chatbubbles];
                    });
                    //Pickfile.pickFile(''//(file) => null);
                  },
                  tooltip: 'Pick Audio',
                  child: Icon(Icons.library_music),
                ),
              ),
              Positioned(
                bottom: 50.0,
                right: 80.0,
                child: FloatingActionButton(
                  onPressed: () async {
                    FilePickerResult? result = await VideoPickFile.pickFile();
                    if (result == null) return;

                    //Pickfile.pickFile((file) => null);
                    setState(() {
                      chatbubbles.add(
                        Chatbubble(
                          content: "https://example.com/video.mp4",
                          type: MessageType.Video,
                          isMe: true,

                          //videoUrl: 'assets/videos/video.mp4',
                          audio_url: result.files.first.path!,
                        ),
                      );
                      // debugPrint("$chatbubbles");
                      //chatbubbles = [...chatbubbles];
                    });
                    //Pickfile.pickFile((file) => null);
                  },

                  //     playAudio();b
                  tooltip: 'Pick video',
                  child: Icon(Icons.video_collection),
                ),
              ),
              // Add more Positioned FABs as needed
            ],
          ),
        ));
  }
}
