import 'dart:io';
import 'package:record/record.dart';
import 'package:path_provider/path_provider.dart';
import 'package:just_audio/just_audio.dart';

class Sound {
  final AudioRecorder _recorder = AudioRecorder();
  String? audioPath;
  AudioPlayer? _player;

  Future<void> startRecording() async {
    try {
      print("THINGS");
      print(audioPath);
      if (await _recorder.hasPermission()) {
        if (audioPath != null && audioPath!.contains('https://')) {
          final directory = await getApplicationDocumentsDirectory();
          audioPath = '${directory.path}/${audioPath}';
        }
        print("RECORDING");
        await _recorder.start(const RecordConfig(), path: audioPath!);
      }
    } catch (e) {
      print("Error starting recording: $e");
    }
  }

  Future<void> stopRecording() async {
    try {
      audioPath = await _recorder.stop();
      print('AUDIO PATH: $audioPath');
      print("RECORDING STOPPED");
    } catch (e) {
      print("Error stopping recording: $e");
    }
  }

  Future<void> playRecording() async {
    try {
      if (audioPath != null) {
        _player = AudioPlayer();
        if (audioPath!.startsWith('https://')) {
          await _player!.setUrl(audioPath!);
        } else {
          await _player!.setFilePath(audioPath!);
        }
        _player!.play();
      } else {
        print("Audio path is null.");
      }
    } catch (e) {
      print("Error playing recording: $e");
    }
  }

  Future<void> stopPlaying() async {
    try {
      if (_player != null) {
        await _player!.stop();
        _player!.dispose(); // Optionally release resources
        _player = null;
      } else {
        print("No audio is currently playing.");
      }
    } catch (e) {
      print("Error stopping playback: $e");
    }
  }
}
