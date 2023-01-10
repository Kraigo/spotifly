import 'dart:convert';

import 'track.dart';

class TracksItems {
  final String primaryColor;
  final Track? track;

  TracksItems({
    required this.primaryColor,
    required this.track,
  });

  Map<String, dynamic> toMap() {
    return {
      'primary_color': primaryColor,
      'track': track?.toMap(),
    };
  }

  factory TracksItems.fromMap(Map<String, dynamic> map) {
    return TracksItems(
      primaryColor: map['primary_color'] ?? '',
      track: map['track'] != null ? Track.fromMap(map['track']): null,
    );
  }

  String toJson() => json.encode(toMap());

  factory TracksItems.fromJson(String source) =>
      TracksItems.fromMap(json.decode(source));
}
