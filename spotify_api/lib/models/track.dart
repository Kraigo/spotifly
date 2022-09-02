import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'album.dart';
import 'artist.dart';
import 'external_url.dart';
import 'restrictions.dart';

class Track {
  final Album album;
  final List<Artist> artists;
  final List<String> available_markets;
  final int disc_number;
  final int duration_ms;
  final bool explicit;
  final ExternalUrl external_urls;
  final String href;
  final String id;
  final bool is_playable;
  final Restrictions restrictions;
  final String name;
  final int popularity;
  final String preview_url;
  final int track_number;
  final String type;
  final String uri;
  final bool is_local;
  Track({
    required this.album,
    required this.artists,
    required this.available_markets,
    required this.disc_number,
    required this.duration_ms,
    required this.explicit,
    required this.external_urls,
    required this.href,
    required this.id,
    required this.is_playable,
    required this.restrictions,
    required this.name,
    required this.popularity,
    required this.preview_url,
    required this.track_number,
    required this.type,
    required this.uri,
    required this.is_local,
  });

  Map<String, dynamic> toMap() {
    return {
      'album': album.toMap(),
      'artists': artists.map((x) => x.toMap()).toList(),
      'available_markets': available_markets,
      'disc_number': disc_number,
      'duration_ms': duration_ms,
      'explicit': explicit,
      'external_urls': external_urls.toMap(),
      'href': href,
      'id': id,
      'is_playable': is_playable,
      'restrictions': restrictions.toMap(),
      'name': name,
      'popularity': popularity,
      'preview_url': preview_url,
      'track_number': track_number,
      'type': type,
      'uri': uri,
      'is_local': is_local,
    };
  }

  factory Track.fromMap(Map<String, dynamic> map) {
    return Track(
      album: Album.fromMap(map['album']),
      artists: List<Artist>.from(map['artists']?.map((x) => Artist.fromMap(x))),
      available_markets: List<String>.from(map['available_markets']),
      disc_number: map['disc_number']?.toInt() ?? 0,
      duration_ms: map['duration_ms']?.toInt() ?? 0,
      explicit: map['explicit'] ?? false,
      external_urls: ExternalUrl.fromMap(map['external_urls']),
      href: map['href'] ?? '',
      id: map['id'] ?? '',
      is_playable: map['is_playable'] ?? false,
      restrictions: Restrictions.fromMap(map['restrictions']),
      name: map['name'] ?? '',
      popularity: map['popularity']?.toInt() ?? 0,
      preview_url: map['preview_url'] ?? '',
      track_number: map['track_number']?.toInt() ?? 0,
      type: map['type'] ?? '',
      uri: map['uri'] ?? '',
      is_local: map['is_local'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory Track.fromJson(String source) => Track.fromMap(json.decode(source));
}











