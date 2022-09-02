import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

class WindowProvider extends ChangeNotifier {

  bool _pinned = false;
  bool get isPinned => _pinned;

  late Size _size;
  late Offset _position;

  WindowProvider() {
    updateCurrentState();
  }

  updateCurrentState() async {
    _pinned = await windowManager.isAlwaysOnTop();
    _size = await windowManager.getSize();
    _position = await windowManager.getPosition();

    notifyListeners();
  }

  pin() async {
    windowManager.setResizable(false);
    await Future.wait([
      windowManager.setAlwaysOnTop(true),
      windowManager.setHasShadow(false),
      windowManager.setSize(const Size(400, 200), animate: false),
      windowManager.setTitleBarStyle(TitleBarStyle.hidden,
          windowButtonVisibility: false),
      windowManager.setPosition(const Offset(100, 100), animate: true),
    ]);

    _pinned = true;
    notifyListeners();
  }

  unpin() async {
    windowManager.setResizable(true);
    await Future.wait([
      windowManager.setAlwaysOnTop(false),
      windowManager.setHasShadow(true),
      windowManager.setSize(_size, animate: false),
      windowManager.setPosition(_position, animate: true),
      windowManager.setTitleBarStyle(TitleBarStyle.hidden,
          windowButtonVisibility: true),
    ]);

    _pinned = false;
    notifyListeners();
  }
}