import 'dart:async';
import 'dart:convert';
import 'dart:developer' as dv;
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:screenshot/screenshot.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class EmotionCubit extends Cubit<String> {
  EmotionCubit() : super("") {
    dv.log("Emotion Created");
  }

  void initEmotion() {
    Timer.periodic(const Duration(seconds: 10), (timer) {
      dv.log("Started Timer");
      detectEmotion();
      dv.log("Detected Emotion");
    });
  }

  Future<void> detectEmotion() async {
    List<String> emotions = [
      "Boredom",
      "Engagement",
      "Confusion",
      "Frustration",
      "Delight"
    ];
    int rand = Random().nextInt(emotions.length);
    dv.log("Raaaaaaaaaand: $rand");
    emit(emotions[rand]);
  }
}
