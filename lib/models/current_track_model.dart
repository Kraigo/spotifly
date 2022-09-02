import 'package:flutter/material.dart';
import 'package:spotify_api/models/track.dart';

class CurrentTrackModel extends ChangeNotifier {
  Track? selected;

  void selectTrack(Track track) {
    selected = track;
    notifyListeners();
  }
}
