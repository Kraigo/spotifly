import 'dart:convert';

import 'package:spotify_api/models/external_url.dart';
import 'package:spotify_api/models/tracks_pagination.dart';

import 'followers.dart';
import 'image.dart';
import 'owner.dart';

class Playlist {
  final bool collaborative;
  final String description;
  final ExternalUrl external_urls;
  final Followers? followers;
  final String href;
  final String id;
  final List<Image> images;
  final String name;
  final Owner owner;
  final bool public;
  final String snapshot_id;
  // final TracksPagination tracks;
  final String type;
  final String uri;
  Playlist({
    required this.collaborative,
    required this.description,
    required this.external_urls,
    this.followers,
    required this.href,
    required this.id,
    required this.images,
    required this.name,
    required this.owner,
    required this.public,
    required this.snapshot_id,
    // required this.tracks,
    required this.type,
    required this.uri,
  });

  Map<String, dynamic> toMap() {
    return {
      'collaborative': collaborative,
      'description': description,
      'external_urls': external_urls.toMap(),
      'followers': followers?.toMap(),
      'href': href,
      'id': id,
      'images': images.map((x) => x.toMap()).toList(),
      'name': name,
      'owner': owner.toMap(),
      'public': public,
      'snapshot_id': snapshot_id,
      // 'tracks': tracks.toMap(),
      'type': type,
      'uri': uri,
    };
  }

  factory Playlist.fromMap(Map<String, dynamic> map) {
    return Playlist(
      collaborative: map['collaborative'] ?? false,
      description: map['description'] ?? '',
      external_urls: ExternalUrl.fromMap(map['external_urls']),
      followers:
          map['followers'] != null ? Followers.fromMap(map['followers']) : null,
      href: map['href'] ?? '',
      id: map['id'] ?? '',
      images: List<Image>.from(map['images']?.map((x) => Image.fromMap(x))),
      name: map['name'] ?? '',
      owner: Owner.fromMap(map['owner']),
      public: map['public'] ?? false,
      snapshot_id: map['snapshot_id'] ?? '',
      // tracks: TracksPagination.fromMap(map['tracks']),
      type: map['type'] ?? '',
      uri: map['uri'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Playlist.fromJson(String source) =>
      Playlist.fromMap(json.decode(source));
}
