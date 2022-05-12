import 'package:audio_service/audio_service.dart';
import 'package:injectable/injectable.dart';
import 'package:stk_radio/src/notifiers/play_button_notifier.dart';

import '../locator/locator.dart';
import 'audio_handler_service.dart';

@lazySingleton
class ButtonService {
  final PlayButtonNotifier playButtonNotifier = PlayButtonNotifier();
  final AudioHandler _audioHandler = getIt<AudioHandlerService>().audioHandler!;

  void init() async {
    _listenToPlaybackState();
  }

  void _listenToPlaybackState() {
    _audioHandler.playbackState.listen((PlaybackState playbackState) {
      final isPlaying = playbackState.playing;
      final processingState = playbackState.processingState;
      if (processingState == AudioProcessingState.loading ||
          processingState == AudioProcessingState.buffering) {
        playButtonNotifier.value = ButtonState.loading;
      } else if (!isPlaying) {
        playButtonNotifier.value = ButtonState.paused;
      } else if (processingState != AudioProcessingState.completed) {
        playButtonNotifier.value = ButtonState.playing;
      } else {
        _audioHandler.seek(Duration.zero);
        _audioHandler.pause();
      }
    });
  }

  void play() => _audioHandler.play();

  void pause() => _audioHandler.pause();

  void seek(Duration position) => _audioHandler.seek(position);

  void dispose() {
    _audioHandler.customAction('dispose');
  }

  void stop() {
    _audioHandler.stop();
  }
}
