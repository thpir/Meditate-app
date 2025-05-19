import 'package:just_audio/just_audio.dart';
import 'package:meditate_app/data/services/logging_service.dart';

class AudioService {
  late AudioPlayer _audioPlayer;
  final LoggingService _loggingService = LoggingService();

  AudioService() {
    _audioPlayer = AudioPlayer();
  }

  Future<void> initiateAudio(String path) async {
    _loggingService.d("Initiating audio with path: $path");
    try {
      AudioSource audioSource = AudioSource.uri(Uri.parse('asset:///$path'));
      await _audioPlayer.setAudioSource(audioSource);
      await _audioPlayer.setLoopMode(LoopMode.all);
    } catch (e) {
      _loggingService.e("Failed to initiate audio: $e");
    }
  }

  void playAudio() {
    _loggingService.d("Playing audio");
    try {
      _audioPlayer.play();
    } catch (e) {
      _loggingService.e("Failed to play audio: $e");
    }
  }

  void pauseAudio() {
    _loggingService.d("Pausing audio");
    try {
      _audioPlayer.pause();
    } catch (e) {
      _loggingService.e("Failed to stop audio: $e");
    }
  }

  void stopAudio() {
    _loggingService.d("Stopping audio");
    try {
      _audioPlayer.stop();
    } catch (e) {
      _loggingService.e("Failed to stop audio: $e");
    }
  }

  Future<void> dispose() async {
    _loggingService.d("Disposing audio player");
    try {
      await _audioPlayer.dispose();
    } catch (e) {
      _loggingService.e("Failed to dispose audio player: $e");
    }
  }
}