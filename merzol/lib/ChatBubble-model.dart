//import 'package:flutter/material.dart';

enum MessageType {
  Text,
  Image,
  Video,
  Audio,
  Document,
  SecureFile,
  GIF,
  TextWithAudio,
}

class Chatbubble {
  final String content;
  final MessageType type;
  final bool isMe;
  final String audio_url;
  // final String video_url;

  Chatbubble({
    required this.content,
    required this.type,
    required this.isMe,
    //required String videoUrl,
    required this.audio_url,
    //required this.video_url,
  });
}
