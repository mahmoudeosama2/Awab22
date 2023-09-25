import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'back_services.dart';

class RadioPlayerLayout extends StatefulWidget {
  const RadioPlayerLayout({Key? key}) : super(key: key);

  @override
  State<RadioPlayerLayout> createState() => _RadioPlayerLayoutState();
}

class _RadioPlayerLayoutState extends State<RadioPlayerLayout> {
  bool isPlaying = false;
  final audioQuery = OnAudioQuery();
  final audioPlayer = AudioPlayer();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
             ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 150,
                width: 150,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image:
                            AssetImage('asset/images/radio-tower_9421452.png'),
                        fit: BoxFit.fitWidth)),
              ),
              IconButton(
                onPressed: () async {
                  if (isPlaying) {
                    final service = FlutterBackgroundService();
                    bool isRunning = await service.isRunning();
                    isPlaying = false;
                    if (isRunning) {
                      service.invoke('stopService');
                    } else {
                      service.startService();
                    }
                    audioPlayer.stop();
                  } else {
                    playSong("https://stream.radiojar.com/8s5u5tpdtwzuv");
                    await initializeService();
                    FlutterBackgroundService().invoke('setAsForeground');
                  }
                  setState(() {});
                },
                icon: isPlaying
                    ? const CircleAvatar(
                        backgroundColor: Colors.black,
                        child: Icon(
                          Icons.pause,
                          color: Colors.white,
                          size: 25,
                        ),
                      )
                    : const CircleAvatar(
                        radius: 80,
                        backgroundColor: Colors.black,
                        child: Icon(
                          Icons.play_arrow,
                          size: 25,
                          color: Colors.white,
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    setState(() async {
      final service = FlutterBackgroundService();
      service.invoke('stopService');
      audioPlayer.stop();
    });
    super.dispose();
  }

  void playSong(String? url) {
    try {
      audioPlayer.setAudioSource(AudioSource.uri(Uri.parse(url!)));
      audioPlayer.play();

      isPlaying = true;
    } on Exception catch (e) {
      print(e.toString());
    }
  }
}
