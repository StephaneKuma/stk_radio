import 'package:flutter/foundation.dart';

class PlayButtonNotifier extends ValueNotifier<ButtonState> {
  PlayButtonNotifier() : super(_initialState);
  
  static const ButtonState _initialState = ButtonState.paused;
}

enum ButtonState {
  paused,
  playing,
  loading,
}
