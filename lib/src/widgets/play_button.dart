import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../locator/locator.dart';
import '../notifiers/play_button_notifier.dart';
import '../services/button_service.dart';

class PlayButton extends StatelessWidget {
  const PlayButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ButtonState>(
      valueListenable: getIt<ButtonService>().playButtonNotifier,
      builder: (_, value, __) {
        switch (value) {
          case ButtonState.loading:
            return Container(
              margin: const EdgeInsets.all(8.0),
              width: 32.0,
              height: 32.0,
              child: const SpinKitWave(
                color: Colors.blue,
                type: SpinKitWaveType.start,
              ),
            );
          case ButtonState.paused:
            return IconButton(
              icon: const Icon(
                Icons.play_arrow,
                color: Colors.white,
              ),
              color: Colors.deepPurpleAccent[400],
              iconSize: MediaQuery.of(context).size.width * .3,
              onPressed: getIt<ButtonService>().play,
            );
          case ButtonState.playing:
            return IconButton(
              icon: const Icon(
                Icons.pause,
                color: Colors.white,
              ),
              color: Colors.deepPurpleAccent[400],
              iconSize: MediaQuery.of(context).size.width * .3,
              onPressed: getIt<ButtonService>().pause,
            );
        }
      },
    );
  }
}
