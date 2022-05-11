import 'package:audio_service/audio_service.dart';
import 'package:injectable/injectable.dart';

import '../helpers/audio_player_handler.dart';

@lazySingleton
class AudioHandlerService {
  AudioHandler? audioHandler;

  Future<void> init() async {
    audioHandler = await AudioService.init(
      builder: () => AudioPlayerHandler(),
      config: const AudioServiceConfig(
        androidNotificationChannelId: 'tech.stkservices.stk_radio',
        androidNotificationChannelName: 'STK Radio Play Back',
        androidNotificationOngoing: true,
        androidStopForegroundOnPause: true,
      ),
    );
  }
}
