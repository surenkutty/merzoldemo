import 'dart:core';

import 'package:flutter/material.dart';
import 'package:merzol/ChatBubble-Model.dart';
import 'AudioPage.dart';
import 'VideoPage.dart';
//import 'package:audioplayers/audioplayers.dart';
//import 'package:flutter/material.dart';
//import 'package:file_picker/file_picker.dart';

class ChatbubbleWidget extends StatelessWidget {
  final Chatbubble chatbubble;

  const ChatbubbleWidget({super.key, required this.chatbubble});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: chatbubble.isMe ? Alignment.topRight : Alignment.topLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          color: chatbubble.isMe ? Colors.blue : Colors.grey,
        ),
        child: getContentWidget(),
      ),
    );
  }

  Widget getContentWidget() {
    switch (chatbubble.type) {
      case MessageType.Text:
        return Text(chatbubble.content);
      case MessageType.Image:
        return Image.network(chatbubble.content);
      case MessageType.Video:
        return VideoWidget(audioUrl: chatbubble.audio_url);
      case MessageType.Audio:
        return AudioWidget(audioUrl: chatbubble.audio_url);

      case MessageType.Document:
        return DocumentWidget(documentUrl: chatbubble.content);
      case MessageType.SecureFile:
        return SecureFileWidget();
      case MessageType.GIF:
        return GifWidget(gifUrl: chatbubble.content);
      case MessageType.TextWithAudio:
        return Column(
          children: [
            Text(chatbubble.content),
            AudioWidget(audioUrl: chatbubble.content),
          ],
        );
      default:
        return const Text('Unsupported message type');
    }
  }
}

class VideoWidget extends StatelessWidget {
  final String audioUrl;

  const VideoWidget({super.key, required this.audioUrl});

  @override
  Widget build(BuildContext context) {
    // Implement your video widget here

    return VideoPlayer(
      audioUrl: audioUrl,
    );
  }
}

class AudioWidget extends StatelessWidget {
  //final String audioUrl;
  final String audioUrl;

  AudioWidget({super.key, required this.audioUrl});

  @override
  Widget build(BuildContext context) {
    // Implement your audio widget here
    return AudioPlayerPage(
      audioUrl: audioUrl,
    );
  }
}

class DocumentWidget extends StatelessWidget {
  final String documentUrl;

  const DocumentWidget({super.key, required this.documentUrl});

  @override
  Widget build(BuildContext context) {
    // Implement your document widget here
    return Container();
  }
}

class SecureFileWidget extends StatelessWidget {
  const SecureFileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // Implement your secure file widget here
    return Container();
  }
}

class GifWidget extends StatelessWidget {
  final String gifUrl;

  const GifWidget({super.key, required this.gifUrl});

  @override
  Widget build(BuildContext context) {
    // Implement your GIF widget here
    return Container();
  }
}
