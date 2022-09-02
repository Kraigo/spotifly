

import 'dart:convert';

import 'artist.dart';
import 'external_url.dart';
import 'image.dart';
import 'restrictions.dart';

class Album {
  final String album_type;
  final int total_tracks;
  final List<String> available_markets;
  final ExternalUrl external_urls;
  final String href;
  final String id;
  final List<Image> images;
  final String name;
  final String release_date;
  final String release_date_precision;
  final Restrictions restrictions;
  final String type;
  final String uri;
  final String album_group;
  final List<Artist> artists;
  Album({
    required this.album_type,
    required this.total_tracks,
    required this.available_markets,
    required this.external_urls,
    required this.href,
    required this.id,
    required this.images,
    required this.name,
    required this.release_date,
    required this.release_date_precision,
    required this.restrictions,
    required this.type,
    required this.uri,
    required this.album_group,
    required this.artists,
  });

  Map<String, dynamic> toMap() {
    return {
      'album_type': album_type,
      'total_tracks': total_tracks,
      'available_markets': available_markets,
      'external_urls': external_urls.toMap(),
      'href': href,
      'id': id,
      'images': images.map((x) => x.toMap()).toList(),
      'name': name,
      'release_date': release_date,
      'release_date_precision': release_date_precision,
      'restrictions': restrictions.toMap(),
      'type': type,
      'uri': uri,
      'album_group': album_group,
      'artists': artists.map((x) => x.toMap()).toList(),
    };
  }

  factory Album.fromMap(Map<String, dynamic> map) {
    return Album(
      album_type: map['album_type'] ?? '',
      total_tracks: map['total_tracks']?.toInt() ?? 0,
      available_markets: List<String>.from(map['available_markets']),
      external_urls: ExternalUrl.fromMap(map['external_urls']),
      href: map['href'] ?? '',
      id: map['id'] ?? '',
      images: List<Image>.from(map['images']?.map((x) => Image.fromMap(x))),
      name: map['name'] ?? '',
      release_date: map['release_date'] ?? '',
      release_date_precision: map['release_date_precision'] ?? '',
      restrictions: Restrictions.fromMap(map['restrictions']),
      type: map['type'] ?? '',
      uri: map['uri'] ?? '',
      album_group: map['album_group'] ?? '',
      artists: List<Artist>.from(map['artists']?.map((x) => Artist.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory Album.fromJson(String source) => Album.fromMap(json.decode(source));
}